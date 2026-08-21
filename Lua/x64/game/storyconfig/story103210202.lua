return {
	Play321022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321022001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321022002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L13g"

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
				local var_4_5 = arg_1_1.bgs_.L13g

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
					if iter_4_0 ~= "L13g" then
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

			local var_4_24 = arg_1_1.actors_.ui_story
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffectui_story == nil then
				arg_1_1.var_.characterEffectui_story = var_4_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_26 = 0.200000002980232

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 and not isNil(var_4_24) then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26

				if arg_1_1.var_.characterEffectui_story and not isNil(var_4_24) then
					arg_1_1.var_.characterEffectui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 and not isNil(var_4_24) and arg_1_1.var_.characterEffectui_story then
				arg_1_1.var_.characterEffectui_story.fillFlat = false
			end

			local var_4_28 = 0
			local var_4_29 = 0.2

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_34 = 0.579204597510398
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer")

				if var_4_39 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_39 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_39

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_39
						arg_1_1.bgmTxt2_.text = var_4_39
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

			local var_4_40 = 2
			local var_4_41 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "effect"

				arg_1_1:AudioAction(var_4_42, var_4_43, "se_story_122_03", "se_story_122_03_swordhit", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_44 = 1.999999999999
			local var_4_45 = 1.375

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_47 = arg_1_1:GetWordFromCfg(321022001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 55
				local var_4_50 = utf8.len(var_4_48)
				local var_4_51 = var_4_49 <= 0 and var_4_45 or var_4_45 * (var_4_50 / var_4_49)

				if var_4_51 > 0 and var_4_45 < var_4_51 then
					arg_1_1.talkMaxDuration = var_4_51
					var_4_44 = var_4_44 + 0.3

					if var_4_51 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_44
					end
				end

				arg_1_1.text_.text = var_4_48
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_52 = var_4_44 + 0.3
			local var_4_53 = math.max(var_4_45, arg_1_1.talkMaxDuration)

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_52) / var_4_53

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321022002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321022002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321022003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.1
			local var_12_1 = 1

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_222_00", "se_story_222_00_monster", "")
			end

			local var_12_4 = 0
			local var_12_5 = 1.1

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

				local var_12_6 = arg_9_1:GetWordFromCfg(321022002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 44
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
	Play321022003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321022003
		arg_13_1.duration_ = 2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321022004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1284ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1284ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1284ui_story = var_16_5.localPosition

				local var_16_7 = "1284ui_story"

				arg_13_1:ShowWeapon(arg_13_1.var_[var_16_7 .. "Animator"].transform, false)
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(0, -0.985, -6.22)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1284ui_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_5.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_5.localEulerAngles = var_16_14
			end

			local var_16_15 = arg_13_1.actors_["1284ui_story"]
			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect1284ui_story == nil then
				arg_13_1.var_.characterEffect1284ui_story = var_16_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_17 = 0.200000002980232

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_17 and not isNil(var_16_15) then
				local var_16_18 = (arg_13_1.time_ - var_16_16) / var_16_17

				if arg_13_1.var_.characterEffect1284ui_story and not isNil(var_16_15) then
					arg_13_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect1284ui_story then
				arg_13_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_16_21 = 0
			local var_16_22 = 0.1

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_23 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_24 = arg_13_1:GetWordFromCfg(321022003)
				local var_16_25 = arg_13_1:FormatText(var_16_24.content)

				arg_13_1.text_.text = var_16_25

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_26 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022003", "story_v_out_321022.awb") ~= 0 then
					local var_16_29 = manager.audio:GetVoiceLength("story_v_out_321022", "321022003", "story_v_out_321022.awb") / 1000

					if var_16_29 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_29 + var_16_21
					end

					if var_16_24.prefab_name ~= "" and arg_13_1.actors_[var_16_24.prefab_name] ~= nil then
						local var_16_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_24.prefab_name].transform, "story_v_out_321022", "321022003", "story_v_out_321022.awb")

						arg_13_1:RecordAudio("321022003", var_16_30)
						arg_13_1:RecordAudio("321022003", var_16_30)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321022", "321022003", "story_v_out_321022.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321022", "321022003", "story_v_out_321022.awb")
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
				actorName = "1284ui_story",
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
	Play321022004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321022004
		arg_17_1.duration_ = 5.83

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321022005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1284ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1284ui_story == nil then
				arg_17_1.var_.characterEffect1284ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1284ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1284ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1284ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1284ui_story.fillRatio = var_20_5
			end

			local var_20_6 = arg_17_1.actors_["1284ui_story"].transform
			local var_20_7 = 0

			if var_20_7 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 then
				arg_17_1.var_.moveOldPos1284ui_story = var_20_6.localPosition

				local var_20_8 = "1284ui_story"

				arg_17_1:ShowWeapon(arg_17_1.var_[var_20_8 .. "Animator"].transform, false)
			end

			local var_20_9 = 0.001

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_9 then
				local var_20_10 = (arg_17_1.time_ - var_20_7) / var_20_9
				local var_20_11 = Vector3.New(0, 100, 0)

				var_20_6.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1284ui_story, var_20_11, var_20_10)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_6.position

				var_20_6.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_6.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_6.localEulerAngles = var_20_13
			end

			if arg_17_1.time_ >= var_20_7 + var_20_9 and arg_17_1.time_ < var_20_7 + var_20_9 + arg_20_0 then
				var_20_6.localPosition = Vector3.New(0, 100, 0)

				local var_20_14 = manager.ui.mainCamera.transform.position - var_20_6.position

				var_20_6.forward = Vector3.New(var_20_14.x, var_20_14.y, var_20_14.z)

				local var_20_15 = var_20_6.localEulerAngles

				var_20_15.z = 0
				var_20_15.x = 0
				var_20_6.localEulerAngles = var_20_15
			end

			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = false

				arg_17_1:SetGaussion(false)
			end

			local var_20_17 = 0.4

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_17 then
				local var_20_18 = (arg_17_1.time_ - var_20_16) / var_20_17
				local var_20_19 = Color.New(1, 0.8030638, 0.384167)

				var_20_19.a = Mathf.Lerp(1, 0, var_20_18)
				arg_17_1.mask_.color = var_20_19
			end

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 then
				local var_20_20 = Color.New(1, 0.8030638, 0.384167)
				local var_20_21 = 0

				arg_17_1.mask_.enabled = false
				var_20_20.a = var_20_21
				arg_17_1.mask_.color = var_20_20
			end

			local var_20_22 = manager.ui.mainCamera.transform
			local var_20_23 = 0.2

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 then
				local var_20_24 = arg_17_1.var_.effect498
				local var_20_25
				local var_20_26 = var_20_22

				if not var_20_24 then
					var_20_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_20_26)
					var_20_24.name = "498"
					arg_17_1.var_.effect498 = var_20_24
				else
					var_20_24.transform:SetParent(var_20_26)
				end

				var_20_24.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_20_24.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_20_27 = manager.ui.mainCameraCom_
				local var_20_28 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_20_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_20_29 = var_20_24.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_20_30 = 15
				local var_20_31 = 2 * var_20_30 * Mathf.Tan(var_20_27.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_20_27.aspect
				local var_20_32 = 1
				local var_20_33 = 1.7777777777777777

				if var_20_33 < var_20_27.aspect then
					var_20_32 = var_20_31 / (2 * var_20_30 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_20_33)
				end

				for iter_20_0, iter_20_1 in ipairs(var_20_29) do
					local var_20_34 = iter_20_1.transform.localScale

					iter_20_1.transform.localScale = Vector3.New(var_20_34.x / var_20_28 * var_20_32, var_20_34.y / var_20_28, var_20_34.z)
				end
			end

			local var_20_35 = 0
			local var_20_36 = 1

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				local var_20_37 = "play"
				local var_20_38 = "effect"

				arg_17_1:AudioAction(var_20_37, var_20_38, "se_story_140", "se_story_140_magic", "")
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_39 = 0.833333333333333
			local var_20_40 = 1.225

			if var_20_39 < arg_17_1.time_ and arg_17_1.time_ <= var_20_39 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_41 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_41:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_42 = arg_17_1:GetWordFromCfg(321022004)
				local var_20_43 = arg_17_1:FormatText(var_20_42.content)

				arg_17_1.text_.text = var_20_43

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_44 = 49
				local var_20_45 = utf8.len(var_20_43)
				local var_20_46 = var_20_44 <= 0 and var_20_40 or var_20_40 * (var_20_45 / var_20_44)

				if var_20_46 > 0 and var_20_40 < var_20_46 then
					arg_17_1.talkMaxDuration = var_20_46
					var_20_39 = var_20_39 + 0.3

					if var_20_46 + var_20_39 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_46 + var_20_39
					end
				end

				arg_17_1.text_.text = var_20_43
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_47 = var_20_39 + 0.3
			local var_20_48 = math.max(var_20_40, arg_17_1.talkMaxDuration)

			if var_20_47 <= arg_17_1.time_ and arg_17_1.time_ < var_20_47 + var_20_48 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_47) / var_20_48

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_47 + var_20_48 and arg_17_1.time_ < var_20_47 + var_20_48 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321022005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 321022005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play321022006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 1

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				local var_26_2 = "play"
				local var_26_3 = "effect"

				arg_23_1:AudioAction(var_26_2, var_26_3, "se_story_10", "se_story_10_sword", "")
			end

			local var_26_4 = 0
			local var_26_5 = 1.25

			if var_26_4 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_6 = arg_23_1:GetWordFromCfg(321022005)
				local var_26_7 = arg_23_1:FormatText(var_26_6.content)

				arg_23_1.text_.text = var_26_7

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_8 = 50
				local var_26_9 = utf8.len(var_26_7)
				local var_26_10 = var_26_8 <= 0 and var_26_5 or var_26_5 * (var_26_9 / var_26_8)

				if var_26_10 > 0 and var_26_5 < var_26_10 then
					arg_23_1.talkMaxDuration = var_26_10

					if var_26_10 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_4
					end
				end

				arg_23_1.text_.text = var_26_7
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_11 = math.max(var_26_5, arg_23_1.talkMaxDuration)

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_11 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_4) / var_26_11

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_4 + var_26_11 and arg_23_1.time_ < var_26_4 + var_26_11 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play321022006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 321022006
		arg_27_1.duration_ = 2.3

		local var_27_0 = {
			zh = 2.033,
			ja = 2.3
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play321022007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1284ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos1284ui_story = var_30_0.localPosition
			end

			local var_30_2 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2
				local var_30_4 = Vector3.New(0, -0.985, -6.22)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1284ui_story, var_30_4, var_30_3)

				local var_30_5 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_5.x, var_30_5.y, var_30_5.z)

				local var_30_6 = var_30_0.localEulerAngles

				var_30_6.z = 0
				var_30_6.x = 0
				var_30_0.localEulerAngles = var_30_6
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_30_7 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_7.x, var_30_7.y, var_30_7.z)

				local var_30_8 = var_30_0.localEulerAngles

				var_30_8.z = 0
				var_30_8.x = 0
				var_30_0.localEulerAngles = var_30_8
			end

			local var_30_9 = arg_27_1.actors_["1284ui_story"]
			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect1284ui_story == nil then
				arg_27_1.var_.characterEffect1284ui_story = var_30_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_11 = 0.200000002980232

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 and not isNil(var_30_9) then
				local var_30_12 = (arg_27_1.time_ - var_30_10) / var_30_11

				if arg_27_1.var_.characterEffect1284ui_story and not isNil(var_30_9) then
					arg_27_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect1284ui_story then
				arg_27_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_30_13 = 0

			if var_30_13 < arg_27_1.time_ and arg_27_1.time_ <= var_30_13 + arg_30_0 then
				arg_27_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_2")
			end

			local var_30_14 = 0

			if var_30_14 < arg_27_1.time_ and arg_27_1.time_ <= var_30_14 + arg_30_0 then
				arg_27_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_30_15 = 0
			local var_30_16 = 0.25

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_17 = arg_27_1:FormatText(StoryNameCfg[6].name)

				arg_27_1.leftNameTxt_.text = var_30_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_18 = arg_27_1:GetWordFromCfg(321022006)
				local var_30_19 = arg_27_1:FormatText(var_30_18.content)

				arg_27_1.text_.text = var_30_19

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_20 = 10
				local var_30_21 = utf8.len(var_30_19)
				local var_30_22 = var_30_20 <= 0 and var_30_16 or var_30_16 * (var_30_21 / var_30_20)

				if var_30_22 > 0 and var_30_16 < var_30_22 then
					arg_27_1.talkMaxDuration = var_30_22

					if var_30_22 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_22 + var_30_15
					end
				end

				arg_27_1.text_.text = var_30_19
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022006", "story_v_out_321022.awb") ~= 0 then
					local var_30_23 = manager.audio:GetVoiceLength("story_v_out_321022", "321022006", "story_v_out_321022.awb") / 1000

					if var_30_23 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_23 + var_30_15
					end

					if var_30_18.prefab_name ~= "" and arg_27_1.actors_[var_30_18.prefab_name] ~= nil then
						local var_30_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_18.prefab_name].transform, "story_v_out_321022", "321022006", "story_v_out_321022.awb")

						arg_27_1:RecordAudio("321022006", var_30_24)
						arg_27_1:RecordAudio("321022006", var_30_24)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_321022", "321022006", "story_v_out_321022.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_321022", "321022006", "story_v_out_321022.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_25 = math.max(var_30_16, arg_27_1.talkMaxDuration)

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_25 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_15) / var_30_25

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_15 + var_30_25 and arg_27_1.time_ < var_30_15 + var_30_25 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play321022007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 321022007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play321022008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1284ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1284ui_story = var_34_0.localPosition

				local var_34_2 = "1284ui_story"

				arg_31_1:ShowWeapon(arg_31_1.var_[var_34_2 .. "Animator"].transform, false)
			end

			local var_34_3 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_3 then
				local var_34_4 = (arg_31_1.time_ - var_34_1) / var_34_3
				local var_34_5 = Vector3.New(0, 100, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1284ui_story, var_34_5, var_34_4)

				local var_34_6 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_6.x, var_34_6.y, var_34_6.z)

				local var_34_7 = var_34_0.localEulerAngles

				var_34_7.z = 0
				var_34_7.x = 0
				var_34_0.localEulerAngles = var_34_7
			end

			if arg_31_1.time_ >= var_34_1 + var_34_3 and arg_31_1.time_ < var_34_1 + var_34_3 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, 100, 0)

				local var_34_8 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_8.x, var_34_8.y, var_34_8.z)

				local var_34_9 = var_34_0.localEulerAngles

				var_34_9.z = 0
				var_34_9.x = 0
				var_34_0.localEulerAngles = var_34_9
			end

			local var_34_10 = 0.733333333333333
			local var_34_11 = 1

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				local var_34_12 = "play"
				local var_34_13 = "effect"

				arg_31_1:AudioAction(var_34_12, var_34_13, "se_story_140", "se_story_140_monster_death", "")
			end

			local var_34_14 = 0
			local var_34_15 = 1.6

			if var_34_14 < arg_31_1.time_ and arg_31_1.time_ <= var_34_14 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_16 = arg_31_1:GetWordFromCfg(321022007)
				local var_34_17 = arg_31_1:FormatText(var_34_16.content)

				arg_31_1.text_.text = var_34_17

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_18 = 64
				local var_34_19 = utf8.len(var_34_17)
				local var_34_20 = var_34_18 <= 0 and var_34_15 or var_34_15 * (var_34_19 / var_34_18)

				if var_34_20 > 0 and var_34_15 < var_34_20 then
					arg_31_1.talkMaxDuration = var_34_20

					if var_34_20 + var_34_14 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_20 + var_34_14
					end
				end

				arg_31_1.text_.text = var_34_17
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_21 = math.max(var_34_15, arg_31_1.talkMaxDuration)

			if var_34_14 <= arg_31_1.time_ and arg_31_1.time_ < var_34_14 + var_34_21 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_14) / var_34_21

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_14 + var_34_21 and arg_31_1.time_ < var_34_14 + var_34_21 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play321022008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 321022008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play321022009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 1.025

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_2 = arg_35_1:GetWordFromCfg(321022008)
				local var_38_3 = arg_35_1:FormatText(var_38_2.content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 41
				local var_38_5 = utf8.len(var_38_3)
				local var_38_6 = var_38_4 <= 0 and var_38_1 or var_38_1 * (var_38_5 / var_38_4)

				if var_38_6 > 0 and var_38_1 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_7 and arg_35_1.time_ < var_38_0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play321022009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 321022009
		arg_39_1.duration_ = 2

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play321022010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1284ui_story"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1284ui_story = var_42_0.localPosition
			end

			local var_42_2 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2
				local var_42_4 = Vector3.New(0, -0.985, -6.22)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1284ui_story, var_42_4, var_42_3)

				local var_42_5 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_5.x, var_42_5.y, var_42_5.z)

				local var_42_6 = var_42_0.localEulerAngles

				var_42_6.z = 0
				var_42_6.x = 0
				var_42_0.localEulerAngles = var_42_6
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_42_7 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_7.x, var_42_7.y, var_42_7.z)

				local var_42_8 = var_42_0.localEulerAngles

				var_42_8.z = 0
				var_42_8.x = 0
				var_42_0.localEulerAngles = var_42_8
			end

			local var_42_9 = arg_39_1.actors_["1284ui_story"]
			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1284ui_story == nil then
				arg_39_1.var_.characterEffect1284ui_story = var_42_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_11 = 0.200000002980232

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_11 and not isNil(var_42_9) then
				local var_42_12 = (arg_39_1.time_ - var_42_10) / var_42_11

				if arg_39_1.var_.characterEffect1284ui_story and not isNil(var_42_9) then
					arg_39_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_10 + var_42_11 and arg_39_1.time_ < var_42_10 + var_42_11 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1284ui_story then
				arg_39_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_42_13 = 0

			if var_42_13 < arg_39_1.time_ and arg_39_1.time_ <= var_42_13 + arg_42_0 then
				arg_39_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_42_14 = 0
			local var_42_15 = 0.175

			if var_42_14 < arg_39_1.time_ and arg_39_1.time_ <= var_42_14 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_16 = arg_39_1:FormatText(StoryNameCfg[6].name)

				arg_39_1.leftNameTxt_.text = var_42_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_17 = arg_39_1:GetWordFromCfg(321022009)
				local var_42_18 = arg_39_1:FormatText(var_42_17.content)

				arg_39_1.text_.text = var_42_18

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_19 = 7
				local var_42_20 = utf8.len(var_42_18)
				local var_42_21 = var_42_19 <= 0 and var_42_15 or var_42_15 * (var_42_20 / var_42_19)

				if var_42_21 > 0 and var_42_15 < var_42_21 then
					arg_39_1.talkMaxDuration = var_42_21

					if var_42_21 + var_42_14 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_21 + var_42_14
					end
				end

				arg_39_1.text_.text = var_42_18
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022009", "story_v_out_321022.awb") ~= 0 then
					local var_42_22 = manager.audio:GetVoiceLength("story_v_out_321022", "321022009", "story_v_out_321022.awb") / 1000

					if var_42_22 + var_42_14 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_22 + var_42_14
					end

					if var_42_17.prefab_name ~= "" and arg_39_1.actors_[var_42_17.prefab_name] ~= nil then
						local var_42_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_17.prefab_name].transform, "story_v_out_321022", "321022009", "story_v_out_321022.awb")

						arg_39_1:RecordAudio("321022009", var_42_23)
						arg_39_1:RecordAudio("321022009", var_42_23)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_321022", "321022009", "story_v_out_321022.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_321022", "321022009", "story_v_out_321022.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_24 = math.max(var_42_15, arg_39_1.talkMaxDuration)

			if var_42_14 <= arg_39_1.time_ and arg_39_1.time_ < var_42_14 + var_42_24 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_14) / var_42_24

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_14 + var_42_24 and arg_39_1.time_ < var_42_14 + var_42_24 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play321022010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 321022010
		arg_43_1.duration_ = 2.97

		local var_43_0 = {
			zh = 2.066,
			ja = 2.966
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play321022011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1284ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1284ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, 100, 0)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1284ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, 100, 0)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = "10104ui_story"

			if arg_43_1.actors_[var_46_9] == nil then
				local var_46_10 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_46_10) then
					local var_46_11 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_43_1.stage_.transform)

					var_46_11.name = var_46_9
					var_46_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_43_1.actors_[var_46_9] = var_46_11

					local var_46_12 = var_46_11:GetComponentInChildren(typeof(CharacterEffect))

					var_46_12.enabled = true

					local var_46_13 = GameObjectTools.GetOrAddComponent(var_46_11, typeof(DynamicBoneHelper))

					if var_46_13 then
						var_46_13:EnableDynamicBone(false)
					end

					arg_43_1:ShowWeapon(var_46_12.transform, false)

					arg_43_1.var_[var_46_9 .. "Animator"] = var_46_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_43_1.var_[var_46_9 .. "Animator"].applyRootMotion = true
					arg_43_1.var_[var_46_9 .. "LipSync"] = var_46_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_46_14 = arg_43_1.actors_["10104ui_story"].transform
			local var_46_15 = 0

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.var_.moveOldPos10104ui_story = var_46_14.localPosition
			end

			local var_46_16 = 0.001

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_16 then
				local var_46_17 = (arg_43_1.time_ - var_46_15) / var_46_16
				local var_46_18 = Vector3.New(0.02, -1.12, -5.99)

				var_46_14.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10104ui_story, var_46_18, var_46_17)

				local var_46_19 = manager.ui.mainCamera.transform.position - var_46_14.position

				var_46_14.forward = Vector3.New(var_46_19.x, var_46_19.y, var_46_19.z)

				local var_46_20 = var_46_14.localEulerAngles

				var_46_20.z = 0
				var_46_20.x = 0
				var_46_14.localEulerAngles = var_46_20
			end

			if arg_43_1.time_ >= var_46_15 + var_46_16 and arg_43_1.time_ < var_46_15 + var_46_16 + arg_46_0 then
				var_46_14.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_46_21 = manager.ui.mainCamera.transform.position - var_46_14.position

				var_46_14.forward = Vector3.New(var_46_21.x, var_46_21.y, var_46_21.z)

				local var_46_22 = var_46_14.localEulerAngles

				var_46_22.z = 0
				var_46_22.x = 0
				var_46_14.localEulerAngles = var_46_22
			end

			local var_46_23 = arg_43_1.actors_["10104ui_story"]
			local var_46_24 = 0

			if var_46_24 < arg_43_1.time_ and arg_43_1.time_ <= var_46_24 + arg_46_0 and not isNil(var_46_23) and arg_43_1.var_.characterEffect10104ui_story == nil then
				arg_43_1.var_.characterEffect10104ui_story = var_46_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_25 = 0.200000002980232

			if var_46_24 <= arg_43_1.time_ and arg_43_1.time_ < var_46_24 + var_46_25 and not isNil(var_46_23) then
				local var_46_26 = (arg_43_1.time_ - var_46_24) / var_46_25

				if arg_43_1.var_.characterEffect10104ui_story and not isNil(var_46_23) then
					arg_43_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_24 + var_46_25 and arg_43_1.time_ < var_46_24 + var_46_25 + arg_46_0 and not isNil(var_46_23) and arg_43_1.var_.characterEffect10104ui_story then
				arg_43_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_46_27 = arg_43_1.actors_["1284ui_story"]
			local var_46_28 = 0

			if var_46_28 < arg_43_1.time_ and arg_43_1.time_ <= var_46_28 + arg_46_0 and not isNil(var_46_27) and arg_43_1.var_.characterEffect1284ui_story == nil then
				arg_43_1.var_.characterEffect1284ui_story = var_46_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_29 = 0.200000002980232

			if var_46_28 <= arg_43_1.time_ and arg_43_1.time_ < var_46_28 + var_46_29 and not isNil(var_46_27) then
				local var_46_30 = (arg_43_1.time_ - var_46_28) / var_46_29

				if arg_43_1.var_.characterEffect1284ui_story and not isNil(var_46_27) then
					local var_46_31 = Mathf.Lerp(0, 0.5, var_46_30)

					arg_43_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1284ui_story.fillRatio = var_46_31
				end
			end

			if arg_43_1.time_ >= var_46_28 + var_46_29 and arg_43_1.time_ < var_46_28 + var_46_29 + arg_46_0 and not isNil(var_46_27) and arg_43_1.var_.characterEffect1284ui_story then
				local var_46_32 = 0.5

				arg_43_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1284ui_story.fillRatio = var_46_32
			end

			local var_46_33 = 0

			if var_46_33 < arg_43_1.time_ and arg_43_1.time_ <= var_46_33 + arg_46_0 then
				arg_43_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_46_34 = 0

			if var_46_34 < arg_43_1.time_ and arg_43_1.time_ <= var_46_34 + arg_46_0 then
				arg_43_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_46_35 = 0
			local var_46_36 = 0.225

			if var_46_35 < arg_43_1.time_ and arg_43_1.time_ <= var_46_35 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_37 = arg_43_1:FormatText(StoryNameCfg[1030].name)

				arg_43_1.leftNameTxt_.text = var_46_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_38 = arg_43_1:GetWordFromCfg(321022010)
				local var_46_39 = arg_43_1:FormatText(var_46_38.content)

				arg_43_1.text_.text = var_46_39

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_40 = 9
				local var_46_41 = utf8.len(var_46_39)
				local var_46_42 = var_46_40 <= 0 and var_46_36 or var_46_36 * (var_46_41 / var_46_40)

				if var_46_42 > 0 and var_46_36 < var_46_42 then
					arg_43_1.talkMaxDuration = var_46_42

					if var_46_42 + var_46_35 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_42 + var_46_35
					end
				end

				arg_43_1.text_.text = var_46_39
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022010", "story_v_out_321022.awb") ~= 0 then
					local var_46_43 = manager.audio:GetVoiceLength("story_v_out_321022", "321022010", "story_v_out_321022.awb") / 1000

					if var_46_43 + var_46_35 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_43 + var_46_35
					end

					if var_46_38.prefab_name ~= "" and arg_43_1.actors_[var_46_38.prefab_name] ~= nil then
						local var_46_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_38.prefab_name].transform, "story_v_out_321022", "321022010", "story_v_out_321022.awb")

						arg_43_1:RecordAudio("321022010", var_46_44)
						arg_43_1:RecordAudio("321022010", var_46_44)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_321022", "321022010", "story_v_out_321022.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_321022", "321022010", "story_v_out_321022.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_45 = math.max(var_46_36, arg_43_1.talkMaxDuration)

			if var_46_35 <= arg_43_1.time_ and arg_43_1.time_ < var_46_35 + var_46_45 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_35) / var_46_45

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_35 + var_46_45 and arg_43_1.time_ < var_46_35 + var_46_45 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play321022011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321022011
		arg_47_1.duration_ = 2.47

		local var_47_0 = {
			zh = 2.033,
			ja = 2.466
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play321022012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1284ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1284ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0, -0.985, -6.22)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1284ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = arg_47_1.actors_["10104ui_story"].transform
			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1.var_.moveOldPos10104ui_story = var_50_9.localPosition
			end

			local var_50_11 = 0.001

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_11 then
				local var_50_12 = (arg_47_1.time_ - var_50_10) / var_50_11
				local var_50_13 = Vector3.New(0, 100, 0)

				var_50_9.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10104ui_story, var_50_13, var_50_12)

				local var_50_14 = manager.ui.mainCamera.transform.position - var_50_9.position

				var_50_9.forward = Vector3.New(var_50_14.x, var_50_14.y, var_50_14.z)

				local var_50_15 = var_50_9.localEulerAngles

				var_50_15.z = 0
				var_50_15.x = 0
				var_50_9.localEulerAngles = var_50_15
			end

			if arg_47_1.time_ >= var_50_10 + var_50_11 and arg_47_1.time_ < var_50_10 + var_50_11 + arg_50_0 then
				var_50_9.localPosition = Vector3.New(0, 100, 0)

				local var_50_16 = manager.ui.mainCamera.transform.position - var_50_9.position

				var_50_9.forward = Vector3.New(var_50_16.x, var_50_16.y, var_50_16.z)

				local var_50_17 = var_50_9.localEulerAngles

				var_50_17.z = 0
				var_50_17.x = 0
				var_50_9.localEulerAngles = var_50_17
			end

			local var_50_18 = arg_47_1.actors_["1284ui_story"]
			local var_50_19 = 0

			if var_50_19 < arg_47_1.time_ and arg_47_1.time_ <= var_50_19 + arg_50_0 and not isNil(var_50_18) and arg_47_1.var_.characterEffect1284ui_story == nil then
				arg_47_1.var_.characterEffect1284ui_story = var_50_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_20 = 0.200000002980232

			if var_50_19 <= arg_47_1.time_ and arg_47_1.time_ < var_50_19 + var_50_20 and not isNil(var_50_18) then
				local var_50_21 = (arg_47_1.time_ - var_50_19) / var_50_20

				if arg_47_1.var_.characterEffect1284ui_story and not isNil(var_50_18) then
					arg_47_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_19 + var_50_20 and arg_47_1.time_ < var_50_19 + var_50_20 + arg_50_0 and not isNil(var_50_18) and arg_47_1.var_.characterEffect1284ui_story then
				arg_47_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_50_22 = arg_47_1.actors_["10104ui_story"]
			local var_50_23 = 0

			if var_50_23 < arg_47_1.time_ and arg_47_1.time_ <= var_50_23 + arg_50_0 and not isNil(var_50_22) and arg_47_1.var_.characterEffect10104ui_story == nil then
				arg_47_1.var_.characterEffect10104ui_story = var_50_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_24 = 0.200000002980232

			if var_50_23 <= arg_47_1.time_ and arg_47_1.time_ < var_50_23 + var_50_24 and not isNil(var_50_22) then
				local var_50_25 = (arg_47_1.time_ - var_50_23) / var_50_24

				if arg_47_1.var_.characterEffect10104ui_story and not isNil(var_50_22) then
					local var_50_26 = Mathf.Lerp(0, 0.5, var_50_25)

					arg_47_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10104ui_story.fillRatio = var_50_26
				end
			end

			if arg_47_1.time_ >= var_50_23 + var_50_24 and arg_47_1.time_ < var_50_23 + var_50_24 + arg_50_0 and not isNil(var_50_22) and arg_47_1.var_.characterEffect10104ui_story then
				local var_50_27 = 0.5

				arg_47_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10104ui_story.fillRatio = var_50_27
			end

			local var_50_28 = 0
			local var_50_29 = 0.225

			if var_50_28 < arg_47_1.time_ and arg_47_1.time_ <= var_50_28 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_30 = arg_47_1:FormatText(StoryNameCfg[6].name)

				arg_47_1.leftNameTxt_.text = var_50_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_31 = arg_47_1:GetWordFromCfg(321022011)
				local var_50_32 = arg_47_1:FormatText(var_50_31.content)

				arg_47_1.text_.text = var_50_32

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_33 = 9
				local var_50_34 = utf8.len(var_50_32)
				local var_50_35 = var_50_33 <= 0 and var_50_29 or var_50_29 * (var_50_34 / var_50_33)

				if var_50_35 > 0 and var_50_29 < var_50_35 then
					arg_47_1.talkMaxDuration = var_50_35

					if var_50_35 + var_50_28 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_35 + var_50_28
					end
				end

				arg_47_1.text_.text = var_50_32
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022011", "story_v_out_321022.awb") ~= 0 then
					local var_50_36 = manager.audio:GetVoiceLength("story_v_out_321022", "321022011", "story_v_out_321022.awb") / 1000

					if var_50_36 + var_50_28 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_36 + var_50_28
					end

					if var_50_31.prefab_name ~= "" and arg_47_1.actors_[var_50_31.prefab_name] ~= nil then
						local var_50_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_31.prefab_name].transform, "story_v_out_321022", "321022011", "story_v_out_321022.awb")

						arg_47_1:RecordAudio("321022011", var_50_37)
						arg_47_1:RecordAudio("321022011", var_50_37)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_321022", "321022011", "story_v_out_321022.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_321022", "321022011", "story_v_out_321022.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_38 = math.max(var_50_29, arg_47_1.talkMaxDuration)

			if var_50_28 <= arg_47_1.time_ and arg_47_1.time_ < var_50_28 + var_50_38 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_28) / var_50_38

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_28 + var_50_38 and arg_47_1.time_ < var_50_28 + var_50_38 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play321022012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321022012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play321022013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1284ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1284ui_story == nil then
				arg_51_1.var_.characterEffect1284ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1284ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1284ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1284ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1284ui_story.fillRatio = var_54_5
			end

			local var_54_6 = 0.833333333333333
			local var_54_7 = 1

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				local var_54_8 = "play"
				local var_54_9 = "effect"

				arg_51_1:AudioAction(var_54_8, var_54_9, "se_story_121_04", "se_story_121_04_scan", "")
			end

			local var_54_10 = 0
			local var_54_11 = 1.1

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_12 = arg_51_1:GetWordFromCfg(321022012)
				local var_54_13 = arg_51_1:FormatText(var_54_12.content)

				arg_51_1.text_.text = var_54_13

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_14 = 44
				local var_54_15 = utf8.len(var_54_13)
				local var_54_16 = var_54_14 <= 0 and var_54_11 or var_54_11 * (var_54_15 / var_54_14)

				if var_54_16 > 0 and var_54_11 < var_54_16 then
					arg_51_1.talkMaxDuration = var_54_16

					if var_54_16 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_16 + var_54_10
					end
				end

				arg_51_1.text_.text = var_54_13
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_17 = math.max(var_54_11, arg_51_1.talkMaxDuration)

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_17 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_10) / var_54_17

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_10 + var_54_17 and arg_51_1.time_ < var_54_10 + var_54_17 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play321022013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321022013
		arg_55_1.duration_ = 2.53

		local var_55_0 = {
			zh = 2.466,
			ja = 2.533
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
				arg_55_0:Play321022014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1284ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1284ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0, 100, 0)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1284ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, 100, 0)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = arg_55_1.actors_["10104ui_story"].transform
			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1.var_.moveOldPos10104ui_story = var_58_9.localPosition
			end

			local var_58_11 = 0.001

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11
				local var_58_13 = Vector3.New(0.02, -1.12, -5.99)

				var_58_9.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10104ui_story, var_58_13, var_58_12)

				local var_58_14 = manager.ui.mainCamera.transform.position - var_58_9.position

				var_58_9.forward = Vector3.New(var_58_14.x, var_58_14.y, var_58_14.z)

				local var_58_15 = var_58_9.localEulerAngles

				var_58_15.z = 0
				var_58_15.x = 0
				var_58_9.localEulerAngles = var_58_15
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 then
				var_58_9.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_58_16 = manager.ui.mainCamera.transform.position - var_58_9.position

				var_58_9.forward = Vector3.New(var_58_16.x, var_58_16.y, var_58_16.z)

				local var_58_17 = var_58_9.localEulerAngles

				var_58_17.z = 0
				var_58_17.x = 0
				var_58_9.localEulerAngles = var_58_17
			end

			local var_58_18 = arg_55_1.actors_["10104ui_story"]
			local var_58_19 = 0

			if var_58_19 < arg_55_1.time_ and arg_55_1.time_ <= var_58_19 + arg_58_0 and not isNil(var_58_18) and arg_55_1.var_.characterEffect10104ui_story == nil then
				arg_55_1.var_.characterEffect10104ui_story = var_58_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_20 = 0.200000002980232

			if var_58_19 <= arg_55_1.time_ and arg_55_1.time_ < var_58_19 + var_58_20 and not isNil(var_58_18) then
				local var_58_21 = (arg_55_1.time_ - var_58_19) / var_58_20

				if arg_55_1.var_.characterEffect10104ui_story and not isNil(var_58_18) then
					arg_55_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_19 + var_58_20 and arg_55_1.time_ < var_58_19 + var_58_20 + arg_58_0 and not isNil(var_58_18) and arg_55_1.var_.characterEffect10104ui_story then
				arg_55_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_58_22 = 0
			local var_58_23 = 0.25

			if var_58_22 < arg_55_1.time_ and arg_55_1.time_ <= var_58_22 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_24 = arg_55_1:FormatText(StoryNameCfg[1030].name)

				arg_55_1.leftNameTxt_.text = var_58_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_25 = arg_55_1:GetWordFromCfg(321022013)
				local var_58_26 = arg_55_1:FormatText(var_58_25.content)

				arg_55_1.text_.text = var_58_26

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_27 = 10
				local var_58_28 = utf8.len(var_58_26)
				local var_58_29 = var_58_27 <= 0 and var_58_23 or var_58_23 * (var_58_28 / var_58_27)

				if var_58_29 > 0 and var_58_23 < var_58_29 then
					arg_55_1.talkMaxDuration = var_58_29

					if var_58_29 + var_58_22 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_29 + var_58_22
					end
				end

				arg_55_1.text_.text = var_58_26
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022013", "story_v_out_321022.awb") ~= 0 then
					local var_58_30 = manager.audio:GetVoiceLength("story_v_out_321022", "321022013", "story_v_out_321022.awb") / 1000

					if var_58_30 + var_58_22 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_30 + var_58_22
					end

					if var_58_25.prefab_name ~= "" and arg_55_1.actors_[var_58_25.prefab_name] ~= nil then
						local var_58_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_25.prefab_name].transform, "story_v_out_321022", "321022013", "story_v_out_321022.awb")

						arg_55_1:RecordAudio("321022013", var_58_31)
						arg_55_1:RecordAudio("321022013", var_58_31)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_321022", "321022013", "story_v_out_321022.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_321022", "321022013", "story_v_out_321022.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_32 = math.max(var_58_23, arg_55_1.talkMaxDuration)

			if var_58_22 <= arg_55_1.time_ and arg_55_1.time_ < var_58_22 + var_58_32 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_22) / var_58_32

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_22 + var_58_32 and arg_55_1.time_ < var_58_22 + var_58_32 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play321022014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321022014
		arg_59_1.duration_ = 2.07

		local var_59_0 = {
			zh = 2.066,
			ja = 1.999999999999
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
				arg_59_0:Play321022015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = "1043ui_story"

			if arg_59_1.actors_[var_62_0] == nil then
				local var_62_1 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_62_1) then
					local var_62_2 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_59_1.stage_.transform)

					var_62_2.name = var_62_0
					var_62_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_59_1.actors_[var_62_0] = var_62_2

					local var_62_3 = var_62_2:GetComponentInChildren(typeof(CharacterEffect))

					var_62_3.enabled = true

					local var_62_4 = GameObjectTools.GetOrAddComponent(var_62_2, typeof(DynamicBoneHelper))

					if var_62_4 then
						var_62_4:EnableDynamicBone(false)
					end

					arg_59_1:ShowWeapon(var_62_3.transform, false)

					arg_59_1.var_[var_62_0 .. "Animator"] = var_62_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_59_1.var_[var_62_0 .. "Animator"].applyRootMotion = true
					arg_59_1.var_[var_62_0 .. "LipSync"] = var_62_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_62_5 = arg_59_1.actors_["1043ui_story"].transform
			local var_62_6 = 0

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.var_.moveOldPos1043ui_story = var_62_5.localPosition
			end

			local var_62_7 = 0.001

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_7 then
				local var_62_8 = (arg_59_1.time_ - var_62_6) / var_62_7
				local var_62_9 = Vector3.New(0.01, -1.01, -5.73)

				var_62_5.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1043ui_story, var_62_9, var_62_8)

				local var_62_10 = manager.ui.mainCamera.transform.position - var_62_5.position

				var_62_5.forward = Vector3.New(var_62_10.x, var_62_10.y, var_62_10.z)

				local var_62_11 = var_62_5.localEulerAngles

				var_62_11.z = 0
				var_62_11.x = 0
				var_62_5.localEulerAngles = var_62_11
			end

			if arg_59_1.time_ >= var_62_6 + var_62_7 and arg_59_1.time_ < var_62_6 + var_62_7 + arg_62_0 then
				var_62_5.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_62_12 = manager.ui.mainCamera.transform.position - var_62_5.position

				var_62_5.forward = Vector3.New(var_62_12.x, var_62_12.y, var_62_12.z)

				local var_62_13 = var_62_5.localEulerAngles

				var_62_13.z = 0
				var_62_13.x = 0
				var_62_5.localEulerAngles = var_62_13
			end

			local var_62_14 = arg_59_1.actors_["10104ui_story"].transform
			local var_62_15 = 0

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.var_.moveOldPos10104ui_story = var_62_14.localPosition
			end

			local var_62_16 = 0.001

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_16 then
				local var_62_17 = (arg_59_1.time_ - var_62_15) / var_62_16
				local var_62_18 = Vector3.New(0, 100, 0)

				var_62_14.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10104ui_story, var_62_18, var_62_17)

				local var_62_19 = manager.ui.mainCamera.transform.position - var_62_14.position

				var_62_14.forward = Vector3.New(var_62_19.x, var_62_19.y, var_62_19.z)

				local var_62_20 = var_62_14.localEulerAngles

				var_62_20.z = 0
				var_62_20.x = 0
				var_62_14.localEulerAngles = var_62_20
			end

			if arg_59_1.time_ >= var_62_15 + var_62_16 and arg_59_1.time_ < var_62_15 + var_62_16 + arg_62_0 then
				var_62_14.localPosition = Vector3.New(0, 100, 0)

				local var_62_21 = manager.ui.mainCamera.transform.position - var_62_14.position

				var_62_14.forward = Vector3.New(var_62_21.x, var_62_21.y, var_62_21.z)

				local var_62_22 = var_62_14.localEulerAngles

				var_62_22.z = 0
				var_62_22.x = 0
				var_62_14.localEulerAngles = var_62_22
			end

			local var_62_23 = arg_59_1.actors_["1043ui_story"]
			local var_62_24 = 0

			if var_62_24 < arg_59_1.time_ and arg_59_1.time_ <= var_62_24 + arg_62_0 and not isNil(var_62_23) and arg_59_1.var_.characterEffect1043ui_story == nil then
				arg_59_1.var_.characterEffect1043ui_story = var_62_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_25 = 0.200000002980232

			if var_62_24 <= arg_59_1.time_ and arg_59_1.time_ < var_62_24 + var_62_25 and not isNil(var_62_23) then
				local var_62_26 = (arg_59_1.time_ - var_62_24) / var_62_25

				if arg_59_1.var_.characterEffect1043ui_story and not isNil(var_62_23) then
					arg_59_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_24 + var_62_25 and arg_59_1.time_ < var_62_24 + var_62_25 + arg_62_0 and not isNil(var_62_23) and arg_59_1.var_.characterEffect1043ui_story then
				arg_59_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_62_27 = arg_59_1.actors_["10104ui_story"]
			local var_62_28 = 0

			if var_62_28 < arg_59_1.time_ and arg_59_1.time_ <= var_62_28 + arg_62_0 and not isNil(var_62_27) and arg_59_1.var_.characterEffect10104ui_story == nil then
				arg_59_1.var_.characterEffect10104ui_story = var_62_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_29 = 0.200000002980232

			if var_62_28 <= arg_59_1.time_ and arg_59_1.time_ < var_62_28 + var_62_29 and not isNil(var_62_27) then
				local var_62_30 = (arg_59_1.time_ - var_62_28) / var_62_29

				if arg_59_1.var_.characterEffect10104ui_story and not isNil(var_62_27) then
					local var_62_31 = Mathf.Lerp(0, 0.5, var_62_30)

					arg_59_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10104ui_story.fillRatio = var_62_31
				end
			end

			if arg_59_1.time_ >= var_62_28 + var_62_29 and arg_59_1.time_ < var_62_28 + var_62_29 + arg_62_0 and not isNil(var_62_27) and arg_59_1.var_.characterEffect10104ui_story then
				local var_62_32 = 0.5

				arg_59_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10104ui_story.fillRatio = var_62_32
			end

			local var_62_33 = 0

			if var_62_33 < arg_59_1.time_ and arg_59_1.time_ <= var_62_33 + arg_62_0 then
				arg_59_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			local var_62_34 = 0

			if var_62_34 < arg_59_1.time_ and arg_59_1.time_ <= var_62_34 + arg_62_0 then
				arg_59_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_62_35 = 0
			local var_62_36 = 0.275

			if var_62_35 < arg_59_1.time_ and arg_59_1.time_ <= var_62_35 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_37 = arg_59_1:FormatText(StoryNameCfg[1156].name)

				arg_59_1.leftNameTxt_.text = var_62_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_38 = arg_59_1:GetWordFromCfg(321022014)
				local var_62_39 = arg_59_1:FormatText(var_62_38.content)

				arg_59_1.text_.text = var_62_39

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_40 = 11
				local var_62_41 = utf8.len(var_62_39)
				local var_62_42 = var_62_40 <= 0 and var_62_36 or var_62_36 * (var_62_41 / var_62_40)

				if var_62_42 > 0 and var_62_36 < var_62_42 then
					arg_59_1.talkMaxDuration = var_62_42

					if var_62_42 + var_62_35 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_42 + var_62_35
					end
				end

				arg_59_1.text_.text = var_62_39
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022014", "story_v_out_321022.awb") ~= 0 then
					local var_62_43 = manager.audio:GetVoiceLength("story_v_out_321022", "321022014", "story_v_out_321022.awb") / 1000

					if var_62_43 + var_62_35 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_43 + var_62_35
					end

					if var_62_38.prefab_name ~= "" and arg_59_1.actors_[var_62_38.prefab_name] ~= nil then
						local var_62_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_38.prefab_name].transform, "story_v_out_321022", "321022014", "story_v_out_321022.awb")

						arg_59_1:RecordAudio("321022014", var_62_44)
						arg_59_1:RecordAudio("321022014", var_62_44)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_321022", "321022014", "story_v_out_321022.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_321022", "321022014", "story_v_out_321022.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_45 = math.max(var_62_36, arg_59_1.talkMaxDuration)

			if var_62_35 <= arg_59_1.time_ and arg_59_1.time_ < var_62_35 + var_62_45 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_35) / var_62_45

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_35 + var_62_45 and arg_59_1.time_ < var_62_35 + var_62_45 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play321022015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321022015
		arg_63_1.duration_ = 3.07

		local var_63_0 = {
			zh = 2.3,
			ja = 3.066
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
				arg_63_0:Play321022016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1043ui_story"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos1043ui_story = var_66_0.localPosition
			end

			local var_66_2 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2
				local var_66_4 = Vector3.New(0.81, -1.01, -5.73)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1043ui_story, var_66_4, var_66_3)

				local var_66_5 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_5.x, var_66_5.y, var_66_5.z)

				local var_66_6 = var_66_0.localEulerAngles

				var_66_6.z = 0
				var_66_6.x = 0
				var_66_0.localEulerAngles = var_66_6
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_66_7 = manager.ui.mainCamera.transform.position - var_66_0.position

				var_66_0.forward = Vector3.New(var_66_7.x, var_66_7.y, var_66_7.z)

				local var_66_8 = var_66_0.localEulerAngles

				var_66_8.z = 0
				var_66_8.x = 0
				var_66_0.localEulerAngles = var_66_8
			end

			local var_66_9 = arg_63_1.actors_["10104ui_story"].transform
			local var_66_10 = 0

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 then
				arg_63_1.var_.moveOldPos10104ui_story = var_66_9.localPosition
			end

			local var_66_11 = 0.001

			if var_66_10 <= arg_63_1.time_ and arg_63_1.time_ < var_66_10 + var_66_11 then
				local var_66_12 = (arg_63_1.time_ - var_66_10) / var_66_11
				local var_66_13 = Vector3.New(-0.88, -1.12, -5.99)

				var_66_9.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10104ui_story, var_66_13, var_66_12)

				local var_66_14 = manager.ui.mainCamera.transform.position - var_66_9.position

				var_66_9.forward = Vector3.New(var_66_14.x, var_66_14.y, var_66_14.z)

				local var_66_15 = var_66_9.localEulerAngles

				var_66_15.z = 0
				var_66_15.x = 0
				var_66_9.localEulerAngles = var_66_15
			end

			if arg_63_1.time_ >= var_66_10 + var_66_11 and arg_63_1.time_ < var_66_10 + var_66_11 + arg_66_0 then
				var_66_9.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_66_16 = manager.ui.mainCamera.transform.position - var_66_9.position

				var_66_9.forward = Vector3.New(var_66_16.x, var_66_16.y, var_66_16.z)

				local var_66_17 = var_66_9.localEulerAngles

				var_66_17.z = 0
				var_66_17.x = 0
				var_66_9.localEulerAngles = var_66_17
			end

			local var_66_18 = arg_63_1.actors_["10104ui_story"]
			local var_66_19 = 0

			if var_66_19 < arg_63_1.time_ and arg_63_1.time_ <= var_66_19 + arg_66_0 and not isNil(var_66_18) and arg_63_1.var_.characterEffect10104ui_story == nil then
				arg_63_1.var_.characterEffect10104ui_story = var_66_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_20 = 0.200000002980232

			if var_66_19 <= arg_63_1.time_ and arg_63_1.time_ < var_66_19 + var_66_20 and not isNil(var_66_18) then
				local var_66_21 = (arg_63_1.time_ - var_66_19) / var_66_20

				if arg_63_1.var_.characterEffect10104ui_story and not isNil(var_66_18) then
					arg_63_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_19 + var_66_20 and arg_63_1.time_ < var_66_19 + var_66_20 + arg_66_0 and not isNil(var_66_18) and arg_63_1.var_.characterEffect10104ui_story then
				arg_63_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_66_22 = arg_63_1.actors_["1043ui_story"]
			local var_66_23 = 0

			if var_66_23 < arg_63_1.time_ and arg_63_1.time_ <= var_66_23 + arg_66_0 and not isNil(var_66_22) and arg_63_1.var_.characterEffect1043ui_story == nil then
				arg_63_1.var_.characterEffect1043ui_story = var_66_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_24 = 0.200000002980232

			if var_66_23 <= arg_63_1.time_ and arg_63_1.time_ < var_66_23 + var_66_24 and not isNil(var_66_22) then
				local var_66_25 = (arg_63_1.time_ - var_66_23) / var_66_24

				if arg_63_1.var_.characterEffect1043ui_story and not isNil(var_66_22) then
					local var_66_26 = Mathf.Lerp(0, 0.5, var_66_25)

					arg_63_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1043ui_story.fillRatio = var_66_26
				end
			end

			if arg_63_1.time_ >= var_66_23 + var_66_24 and arg_63_1.time_ < var_66_23 + var_66_24 + arg_66_0 and not isNil(var_66_22) and arg_63_1.var_.characterEffect1043ui_story then
				local var_66_27 = 0.5

				arg_63_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1043ui_story.fillRatio = var_66_27
			end

			local var_66_28 = 0

			if var_66_28 < arg_63_1.time_ and arg_63_1.time_ <= var_66_28 + arg_66_0 then
				arg_63_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			local var_66_29 = 0
			local var_66_30 = 0.325

			if var_66_29 < arg_63_1.time_ and arg_63_1.time_ <= var_66_29 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_31 = arg_63_1:FormatText(StoryNameCfg[1030].name)

				arg_63_1.leftNameTxt_.text = var_66_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_32 = arg_63_1:GetWordFromCfg(321022015)
				local var_66_33 = arg_63_1:FormatText(var_66_32.content)

				arg_63_1.text_.text = var_66_33

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_34 = 13
				local var_66_35 = utf8.len(var_66_33)
				local var_66_36 = var_66_34 <= 0 and var_66_30 or var_66_30 * (var_66_35 / var_66_34)

				if var_66_36 > 0 and var_66_30 < var_66_36 then
					arg_63_1.talkMaxDuration = var_66_36

					if var_66_36 + var_66_29 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_36 + var_66_29
					end
				end

				arg_63_1.text_.text = var_66_33
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022015", "story_v_out_321022.awb") ~= 0 then
					local var_66_37 = manager.audio:GetVoiceLength("story_v_out_321022", "321022015", "story_v_out_321022.awb") / 1000

					if var_66_37 + var_66_29 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_37 + var_66_29
					end

					if var_66_32.prefab_name ~= "" and arg_63_1.actors_[var_66_32.prefab_name] ~= nil then
						local var_66_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_32.prefab_name].transform, "story_v_out_321022", "321022015", "story_v_out_321022.awb")

						arg_63_1:RecordAudio("321022015", var_66_38)
						arg_63_1:RecordAudio("321022015", var_66_38)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_321022", "321022015", "story_v_out_321022.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_321022", "321022015", "story_v_out_321022.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_39 = math.max(var_66_30, arg_63_1.talkMaxDuration)

			if var_66_29 <= arg_63_1.time_ and arg_63_1.time_ < var_66_29 + var_66_39 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_29) / var_66_39

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_29 + var_66_39 and arg_63_1.time_ < var_66_29 + var_66_39 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play321022016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321022016
		arg_67_1.duration_ = 5.1

		local var_67_0 = {
			zh = 3.666,
			ja = 5.1
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play321022017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1043ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1043ui_story == nil then
				arg_67_1.var_.characterEffect1043ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1043ui_story and not isNil(var_70_0) then
					arg_67_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1043ui_story then
				arg_67_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_70_4 = arg_67_1.actors_["10104ui_story"]
			local var_70_5 = 0

			if var_70_5 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect10104ui_story == nil then
				arg_67_1.var_.characterEffect10104ui_story = var_70_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_6 = 0.200000002980232

			if var_70_5 <= arg_67_1.time_ and arg_67_1.time_ < var_70_5 + var_70_6 and not isNil(var_70_4) then
				local var_70_7 = (arg_67_1.time_ - var_70_5) / var_70_6

				if arg_67_1.var_.characterEffect10104ui_story and not isNil(var_70_4) then
					local var_70_8 = Mathf.Lerp(0, 0.5, var_70_7)

					arg_67_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_67_1.var_.characterEffect10104ui_story.fillRatio = var_70_8
				end
			end

			if arg_67_1.time_ >= var_70_5 + var_70_6 and arg_67_1.time_ < var_70_5 + var_70_6 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect10104ui_story then
				local var_70_9 = 0.5

				arg_67_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_67_1.var_.characterEffect10104ui_story.fillRatio = var_70_9
			end

			local var_70_10 = 0
			local var_70_11 = 0.45

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_12 = arg_67_1:FormatText(StoryNameCfg[1156].name)

				arg_67_1.leftNameTxt_.text = var_70_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_13 = arg_67_1:GetWordFromCfg(321022016)
				local var_70_14 = arg_67_1:FormatText(var_70_13.content)

				arg_67_1.text_.text = var_70_14

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_15 = 18
				local var_70_16 = utf8.len(var_70_14)
				local var_70_17 = var_70_15 <= 0 and var_70_11 or var_70_11 * (var_70_16 / var_70_15)

				if var_70_17 > 0 and var_70_11 < var_70_17 then
					arg_67_1.talkMaxDuration = var_70_17

					if var_70_17 + var_70_10 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_17 + var_70_10
					end
				end

				arg_67_1.text_.text = var_70_14
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022016", "story_v_out_321022.awb") ~= 0 then
					local var_70_18 = manager.audio:GetVoiceLength("story_v_out_321022", "321022016", "story_v_out_321022.awb") / 1000

					if var_70_18 + var_70_10 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_18 + var_70_10
					end

					if var_70_13.prefab_name ~= "" and arg_67_1.actors_[var_70_13.prefab_name] ~= nil then
						local var_70_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_13.prefab_name].transform, "story_v_out_321022", "321022016", "story_v_out_321022.awb")

						arg_67_1:RecordAudio("321022016", var_70_19)
						arg_67_1:RecordAudio("321022016", var_70_19)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_321022", "321022016", "story_v_out_321022.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_321022", "321022016", "story_v_out_321022.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_20 = math.max(var_70_11, arg_67_1.talkMaxDuration)

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_20 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_10) / var_70_20

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_10 + var_70_20 and arg_67_1.time_ < var_70_10 + var_70_20 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play321022017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321022017
		arg_71_1.duration_ = 3.4

		local var_71_0 = {
			zh = 1.733,
			ja = 3.4
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
				arg_71_0:Play321022018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10104ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10104ui_story == nil then
				arg_71_1.var_.characterEffect10104ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect10104ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10104ui_story then
				arg_71_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_74_4 = arg_71_1.actors_["1043ui_story"]
			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1043ui_story == nil then
				arg_71_1.var_.characterEffect1043ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_6 = 0.200000002980232

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_6 and not isNil(var_74_4) then
				local var_74_7 = (arg_71_1.time_ - var_74_5) / var_74_6

				if arg_71_1.var_.characterEffect1043ui_story and not isNil(var_74_4) then
					local var_74_8 = Mathf.Lerp(0, 0.5, var_74_7)

					arg_71_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1043ui_story.fillRatio = var_74_8
				end
			end

			if arg_71_1.time_ >= var_74_5 + var_74_6 and arg_71_1.time_ < var_74_5 + var_74_6 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1043ui_story then
				local var_74_9 = 0.5

				arg_71_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1043ui_story.fillRatio = var_74_9
			end

			local var_74_10 = 0
			local var_74_11 = 0.2

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_12 = arg_71_1:FormatText(StoryNameCfg[1030].name)

				arg_71_1.leftNameTxt_.text = var_74_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_13 = arg_71_1:GetWordFromCfg(321022017)
				local var_74_14 = arg_71_1:FormatText(var_74_13.content)

				arg_71_1.text_.text = var_74_14

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_15 = 8
				local var_74_16 = utf8.len(var_74_14)
				local var_74_17 = var_74_15 <= 0 and var_74_11 or var_74_11 * (var_74_16 / var_74_15)

				if var_74_17 > 0 and var_74_11 < var_74_17 then
					arg_71_1.talkMaxDuration = var_74_17

					if var_74_17 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_17 + var_74_10
					end
				end

				arg_71_1.text_.text = var_74_14
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022017", "story_v_out_321022.awb") ~= 0 then
					local var_74_18 = manager.audio:GetVoiceLength("story_v_out_321022", "321022017", "story_v_out_321022.awb") / 1000

					if var_74_18 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_18 + var_74_10
					end

					if var_74_13.prefab_name ~= "" and arg_71_1.actors_[var_74_13.prefab_name] ~= nil then
						local var_74_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_13.prefab_name].transform, "story_v_out_321022", "321022017", "story_v_out_321022.awb")

						arg_71_1:RecordAudio("321022017", var_74_19)
						arg_71_1:RecordAudio("321022017", var_74_19)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_321022", "321022017", "story_v_out_321022.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_321022", "321022017", "story_v_out_321022.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_20 = math.max(var_74_11, arg_71_1.talkMaxDuration)

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_20 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_10) / var_74_20

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_10 + var_74_20 and arg_71_1.time_ < var_74_10 + var_74_20 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play321022018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321022018
		arg_75_1.duration_ = 5.13

		local var_75_0 = {
			zh = 4.2,
			ja = 5.133
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
				arg_75_0:Play321022019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1043ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1043ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0.81, -1.01, -5.73)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1043ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = arg_75_1.actors_["1043ui_story"]
			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1043ui_story == nil then
				arg_75_1.var_.characterEffect1043ui_story = var_78_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_11 and not isNil(var_78_9) then
				local var_78_12 = (arg_75_1.time_ - var_78_10) / var_78_11

				if arg_75_1.var_.characterEffect1043ui_story and not isNil(var_78_9) then
					arg_75_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_10 + var_78_11 and arg_75_1.time_ < var_78_10 + var_78_11 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1043ui_story then
				arg_75_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_78_13 = arg_75_1.actors_["10104ui_story"]
			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 and not isNil(var_78_13) and arg_75_1.var_.characterEffect10104ui_story == nil then
				arg_75_1.var_.characterEffect10104ui_story = var_78_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_15 = 0.200000002980232

			if var_78_14 <= arg_75_1.time_ and arg_75_1.time_ < var_78_14 + var_78_15 and not isNil(var_78_13) then
				local var_78_16 = (arg_75_1.time_ - var_78_14) / var_78_15

				if arg_75_1.var_.characterEffect10104ui_story and not isNil(var_78_13) then
					local var_78_17 = Mathf.Lerp(0, 0.5, var_78_16)

					arg_75_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10104ui_story.fillRatio = var_78_17
				end
			end

			if arg_75_1.time_ >= var_78_14 + var_78_15 and arg_75_1.time_ < var_78_14 + var_78_15 + arg_78_0 and not isNil(var_78_13) and arg_75_1.var_.characterEffect10104ui_story then
				local var_78_18 = 0.5

				arg_75_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10104ui_story.fillRatio = var_78_18
			end

			local var_78_19 = 0

			if var_78_19 < arg_75_1.time_ and arg_75_1.time_ <= var_78_19 + arg_78_0 then
				arg_75_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_2")
			end

			local var_78_20 = 0

			if var_78_20 < arg_75_1.time_ and arg_75_1.time_ <= var_78_20 + arg_78_0 then
				arg_75_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_78_21 = 0
			local var_78_22 = 0.425

			if var_78_21 < arg_75_1.time_ and arg_75_1.time_ <= var_78_21 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_23 = arg_75_1:FormatText(StoryNameCfg[1156].name)

				arg_75_1.leftNameTxt_.text = var_78_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_24 = arg_75_1:GetWordFromCfg(321022018)
				local var_78_25 = arg_75_1:FormatText(var_78_24.content)

				arg_75_1.text_.text = var_78_25

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_26 = 17
				local var_78_27 = utf8.len(var_78_25)
				local var_78_28 = var_78_26 <= 0 and var_78_22 or var_78_22 * (var_78_27 / var_78_26)

				if var_78_28 > 0 and var_78_22 < var_78_28 then
					arg_75_1.talkMaxDuration = var_78_28

					if var_78_28 + var_78_21 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_28 + var_78_21
					end
				end

				arg_75_1.text_.text = var_78_25
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022018", "story_v_out_321022.awb") ~= 0 then
					local var_78_29 = manager.audio:GetVoiceLength("story_v_out_321022", "321022018", "story_v_out_321022.awb") / 1000

					if var_78_29 + var_78_21 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_29 + var_78_21
					end

					if var_78_24.prefab_name ~= "" and arg_75_1.actors_[var_78_24.prefab_name] ~= nil then
						local var_78_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_24.prefab_name].transform, "story_v_out_321022", "321022018", "story_v_out_321022.awb")

						arg_75_1:RecordAudio("321022018", var_78_30)
						arg_75_1:RecordAudio("321022018", var_78_30)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_321022", "321022018", "story_v_out_321022.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_321022", "321022018", "story_v_out_321022.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_31 = math.max(var_78_22, arg_75_1.talkMaxDuration)

			if var_78_21 <= arg_75_1.time_ and arg_75_1.time_ < var_78_21 + var_78_31 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_21) / var_78_31

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_21 + var_78_31 and arg_75_1.time_ < var_78_21 + var_78_31 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play321022019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321022019
		arg_79_1.duration_ = 2.17

		local var_79_0 = {
			zh = 1.266,
			ja = 2.166
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
				arg_79_0:Play321022020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1043ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1043ui_story == nil then
				arg_79_1.var_.characterEffect1043ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1043ui_story and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1043ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1043ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1043ui_story.fillRatio = var_82_5
			end

			local var_82_6 = 0
			local var_82_7 = 0.125

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[1165].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_9 = arg_79_1:GetWordFromCfg(321022019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 5
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022019", "story_v_out_321022.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_321022", "321022019", "story_v_out_321022.awb") / 1000

					if var_82_14 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_6
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_321022", "321022019", "story_v_out_321022.awb")

						arg_79_1:RecordAudio("321022019", var_82_15)
						arg_79_1:RecordAudio("321022019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_321022", "321022019", "story_v_out_321022.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_321022", "321022019", "story_v_out_321022.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_16 and arg_79_1.time_ < var_82_6 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play321022020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321022020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321022021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1043ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1043ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1043ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["10104ui_story"].transform
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1.var_.moveOldPos10104ui_story = var_86_9.localPosition
			end

			local var_86_11 = 0.001

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11
				local var_86_13 = Vector3.New(0, 100, 0)

				var_86_9.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10104ui_story, var_86_13, var_86_12)

				local var_86_14 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_14.x, var_86_14.y, var_86_14.z)

				local var_86_15 = var_86_9.localEulerAngles

				var_86_15.z = 0
				var_86_15.x = 0
				var_86_9.localEulerAngles = var_86_15
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 then
				var_86_9.localPosition = Vector3.New(0, 100, 0)

				local var_86_16 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_16.x, var_86_16.y, var_86_16.z)

				local var_86_17 = var_86_9.localEulerAngles

				var_86_17.z = 0
				var_86_17.x = 0
				var_86_9.localEulerAngles = var_86_17
			end

			local var_86_18 = 0.034000001847744
			local var_86_19 = 1

			if var_86_18 < arg_83_1.time_ and arg_83_1.time_ <= var_86_18 + arg_86_0 then
				local var_86_20 = "play"
				local var_86_21 = "effect"

				arg_83_1:AudioAction(var_86_20, var_86_21, "se_story_120_00", "se_story_120_00_door_wood", "")
			end

			local var_86_22 = 0
			local var_86_23 = 0.95

			if var_86_22 < arg_83_1.time_ and arg_83_1.time_ <= var_86_22 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_24 = arg_83_1:GetWordFromCfg(321022020)
				local var_86_25 = arg_83_1:FormatText(var_86_24.content)

				arg_83_1.text_.text = var_86_25

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_26 = 38
				local var_86_27 = utf8.len(var_86_25)
				local var_86_28 = var_86_26 <= 0 and var_86_23 or var_86_23 * (var_86_27 / var_86_26)

				if var_86_28 > 0 and var_86_23 < var_86_28 then
					arg_83_1.talkMaxDuration = var_86_28

					if var_86_28 + var_86_22 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_28 + var_86_22
					end
				end

				arg_83_1.text_.text = var_86_25
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_29 = math.max(var_86_23, arg_83_1.talkMaxDuration)

			if var_86_22 <= arg_83_1.time_ and arg_83_1.time_ < var_86_22 + var_86_29 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_22) / var_86_29

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_22 + var_86_29 and arg_83_1.time_ < var_86_22 + var_86_29 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play321022021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321022021
		arg_87_1.duration_ = 8.7

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321022022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "ST0506"

			if arg_87_1.bgs_[var_90_0] == nil then
				local var_90_1 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_90_0)
				var_90_1.name = var_90_0
				var_90_1.transform.parent = arg_87_1.stage_.transform
				var_90_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_[var_90_0] = var_90_1
			end

			local var_90_2 = 2

			if var_90_2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				local var_90_3 = manager.ui.mainCamera.transform.localPosition
				local var_90_4 = Vector3.New(0, 0, 10) + Vector3.New(var_90_3.x, var_90_3.y, 0)
				local var_90_5 = arg_87_1.bgs_.ST0506

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
					if iter_90_0 ~= "ST0506" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			local var_90_17 = 0.3

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			local var_90_18 = 0

			if var_90_18 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_19 = 2

			if var_90_18 <= arg_87_1.time_ and arg_87_1.time_ < var_90_18 + var_90_19 then
				local var_90_20 = (arg_87_1.time_ - var_90_18) / var_90_19
				local var_90_21 = Color.New(0, 0, 0)

				var_90_21.a = Mathf.Lerp(0, 1, var_90_20)
				arg_87_1.mask_.color = var_90_21
			end

			if arg_87_1.time_ >= var_90_18 + var_90_19 and arg_87_1.time_ < var_90_18 + var_90_19 + arg_90_0 then
				local var_90_22 = Color.New(0, 0, 0)

				var_90_22.a = 1
				arg_87_1.mask_.color = var_90_22
			end

			local var_90_23 = 2

			if var_90_23 < arg_87_1.time_ and arg_87_1.time_ <= var_90_23 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_24 = 2

			if var_90_23 <= arg_87_1.time_ and arg_87_1.time_ < var_90_23 + var_90_24 then
				local var_90_25 = (arg_87_1.time_ - var_90_23) / var_90_24
				local var_90_26 = Color.New(0, 0, 0)

				var_90_26.a = Mathf.Lerp(1, 0, var_90_25)
				arg_87_1.mask_.color = var_90_26
			end

			if arg_87_1.time_ >= var_90_23 + var_90_24 and arg_87_1.time_ < var_90_23 + var_90_24 + arg_90_0 then
				local var_90_27 = Color.New(0, 0, 0)
				local var_90_28 = 0

				arg_87_1.mask_.enabled = false
				var_90_27.a = var_90_28
				arg_87_1.mask_.color = var_90_27
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_29 = 3.7
			local var_90_30 = 0.95

			if var_90_29 < arg_87_1.time_ and arg_87_1.time_ <= var_90_29 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_31 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_31:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_32 = arg_87_1:GetWordFromCfg(321022021)
				local var_90_33 = arg_87_1:FormatText(var_90_32.content)

				arg_87_1.text_.text = var_90_33

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_34 = 38
				local var_90_35 = utf8.len(var_90_33)
				local var_90_36 = var_90_34 <= 0 and var_90_30 or var_90_30 * (var_90_35 / var_90_34)

				if var_90_36 > 0 and var_90_30 < var_90_36 then
					arg_87_1.talkMaxDuration = var_90_36
					var_90_29 = var_90_29 + 0.3

					if var_90_36 + var_90_29 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_36 + var_90_29
					end
				end

				arg_87_1.text_.text = var_90_33
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_37 = var_90_29 + 0.3
			local var_90_38 = math.max(var_90_30, arg_87_1.talkMaxDuration)

			if var_90_37 <= arg_87_1.time_ and arg_87_1.time_ < var_90_37 + var_90_38 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_37) / var_90_38

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_37 + var_90_38 and arg_87_1.time_ < var_90_37 + var_90_38 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play321022022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321022022
		arg_93_1.duration_ = 2.9

		local var_93_0 = {
			zh = 2.5,
			ja = 2.9
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
				arg_93_0:Play321022023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1284ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1284ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -0.985, -6.22)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1284ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1284ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1284ui_story == nil then
				arg_93_1.var_.characterEffect1284ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1284ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1284ui_story then
				arg_93_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_96_13 = 0

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_96_15 = 0
			local var_96_16 = 0.225

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[6].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(321022022)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 9
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022022", "story_v_out_321022.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_321022", "321022022", "story_v_out_321022.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_321022", "321022022", "story_v_out_321022.awb")

						arg_93_1:RecordAudio("321022022", var_96_24)
						arg_93_1:RecordAudio("321022022", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_321022", "321022022", "story_v_out_321022.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_321022", "321022022", "story_v_out_321022.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play321022023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321022023
		arg_97_1.duration_ = 1.93

		local var_97_0 = {
			zh = 1.066,
			ja = 1.933
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
				arg_97_0:Play321022024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1284ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1284ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -0.985, -6.22)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1284ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10104ui_story"].transform
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1.var_.moveOldPos10104ui_story = var_100_9.localPosition
			end

			local var_100_11 = 0.001

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11
				local var_100_13 = Vector3.New(0, 100, 0)

				var_100_9.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10104ui_story, var_100_13, var_100_12)

				local var_100_14 = manager.ui.mainCamera.transform.position - var_100_9.position

				var_100_9.forward = Vector3.New(var_100_14.x, var_100_14.y, var_100_14.z)

				local var_100_15 = var_100_9.localEulerAngles

				var_100_15.z = 0
				var_100_15.x = 0
				var_100_9.localEulerAngles = var_100_15
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 then
				var_100_9.localPosition = Vector3.New(0, 100, 0)

				local var_100_16 = manager.ui.mainCamera.transform.position - var_100_9.position

				var_100_9.forward = Vector3.New(var_100_16.x, var_100_16.y, var_100_16.z)

				local var_100_17 = var_100_9.localEulerAngles

				var_100_17.z = 0
				var_100_17.x = 0
				var_100_9.localEulerAngles = var_100_17
			end

			local var_100_18 = arg_97_1.actors_["1284ui_story"]
			local var_100_19 = 0

			if var_100_19 < arg_97_1.time_ and arg_97_1.time_ <= var_100_19 + arg_100_0 and not isNil(var_100_18) and arg_97_1.var_.characterEffect1284ui_story == nil then
				arg_97_1.var_.characterEffect1284ui_story = var_100_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_20 = 0.200000002980232

			if var_100_19 <= arg_97_1.time_ and arg_97_1.time_ < var_100_19 + var_100_20 and not isNil(var_100_18) then
				local var_100_21 = (arg_97_1.time_ - var_100_19) / var_100_20

				if arg_97_1.var_.characterEffect1284ui_story and not isNil(var_100_18) then
					local var_100_22 = Mathf.Lerp(0, 0.5, var_100_21)

					arg_97_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1284ui_story.fillRatio = var_100_22
				end
			end

			if arg_97_1.time_ >= var_100_19 + var_100_20 and arg_97_1.time_ < var_100_19 + var_100_20 + arg_100_0 and not isNil(var_100_18) and arg_97_1.var_.characterEffect1284ui_story then
				local var_100_23 = 0.5

				arg_97_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1284ui_story.fillRatio = var_100_23
			end

			local var_100_24 = 0
			local var_100_25 = 0.1

			if var_100_24 < arg_97_1.time_ and arg_97_1.time_ <= var_100_24 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_26 = arg_97_1:FormatText(StoryNameCfg[1030].name)

				arg_97_1.leftNameTxt_.text = var_100_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_27 = arg_97_1:GetWordFromCfg(321022023)
				local var_100_28 = arg_97_1:FormatText(var_100_27.content)

				arg_97_1.text_.text = var_100_28

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_29 = 4
				local var_100_30 = utf8.len(var_100_28)
				local var_100_31 = var_100_29 <= 0 and var_100_25 or var_100_25 * (var_100_30 / var_100_29)

				if var_100_31 > 0 and var_100_25 < var_100_31 then
					arg_97_1.talkMaxDuration = var_100_31

					if var_100_31 + var_100_24 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_31 + var_100_24
					end
				end

				arg_97_1.text_.text = var_100_28
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022023", "story_v_out_321022.awb") ~= 0 then
					local var_100_32 = manager.audio:GetVoiceLength("story_v_out_321022", "321022023", "story_v_out_321022.awb") / 1000

					if var_100_32 + var_100_24 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_32 + var_100_24
					end

					if var_100_27.prefab_name ~= "" and arg_97_1.actors_[var_100_27.prefab_name] ~= nil then
						local var_100_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_27.prefab_name].transform, "story_v_out_321022", "321022023", "story_v_out_321022.awb")

						arg_97_1:RecordAudio("321022023", var_100_33)
						arg_97_1:RecordAudio("321022023", var_100_33)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_321022", "321022023", "story_v_out_321022.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_321022", "321022023", "story_v_out_321022.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_34 = math.max(var_100_25, arg_97_1.talkMaxDuration)

			if var_100_24 <= arg_97_1.time_ and arg_97_1.time_ < var_100_24 + var_100_34 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_24) / var_100_34

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_24 + var_100_34 and arg_97_1.time_ < var_100_24 + var_100_34 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321022024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321022024
		arg_101_1.duration_ = 9.63

		local var_101_0 = {
			zh = 5.7,
			ja = 9.633
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
				arg_101_0:Play321022025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10104ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10104ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, 100, 0)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10104ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, 100, 0)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1284ui_story"].transform
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1.var_.moveOldPos1284ui_story = var_104_9.localPosition
			end

			local var_104_11 = 0.001

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11
				local var_104_13 = Vector3.New(0, -0.985, -6.22)

				var_104_9.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1284ui_story, var_104_13, var_104_12)

				local var_104_14 = manager.ui.mainCamera.transform.position - var_104_9.position

				var_104_9.forward = Vector3.New(var_104_14.x, var_104_14.y, var_104_14.z)

				local var_104_15 = var_104_9.localEulerAngles

				var_104_15.z = 0
				var_104_15.x = 0
				var_104_9.localEulerAngles = var_104_15
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 then
				var_104_9.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_104_16 = manager.ui.mainCamera.transform.position - var_104_9.position

				var_104_9.forward = Vector3.New(var_104_16.x, var_104_16.y, var_104_16.z)

				local var_104_17 = var_104_9.localEulerAngles

				var_104_17.z = 0
				var_104_17.x = 0
				var_104_9.localEulerAngles = var_104_17
			end

			local var_104_18 = arg_101_1.actors_["1284ui_story"]
			local var_104_19 = 0

			if var_104_19 < arg_101_1.time_ and arg_101_1.time_ <= var_104_19 + arg_104_0 and not isNil(var_104_18) and arg_101_1.var_.characterEffect1284ui_story == nil then
				arg_101_1.var_.characterEffect1284ui_story = var_104_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_20 = 0.200000002980232

			if var_104_19 <= arg_101_1.time_ and arg_101_1.time_ < var_104_19 + var_104_20 and not isNil(var_104_18) then
				local var_104_21 = (arg_101_1.time_ - var_104_19) / var_104_20

				if arg_101_1.var_.characterEffect1284ui_story and not isNil(var_104_18) then
					arg_101_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_19 + var_104_20 and arg_101_1.time_ < var_104_19 + var_104_20 + arg_104_0 and not isNil(var_104_18) and arg_101_1.var_.characterEffect1284ui_story then
				arg_101_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_104_22 = arg_101_1.actors_["10104ui_story"]
			local var_104_23 = 0

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 and not isNil(var_104_22) and arg_101_1.var_.characterEffect10104ui_story == nil then
				arg_101_1.var_.characterEffect10104ui_story = var_104_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_24 = 0.200000002980232

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_24 and not isNil(var_104_22) then
				local var_104_25 = (arg_101_1.time_ - var_104_23) / var_104_24

				if arg_101_1.var_.characterEffect10104ui_story and not isNil(var_104_22) then
					local var_104_26 = Mathf.Lerp(0, 0.5, var_104_25)

					arg_101_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10104ui_story.fillRatio = var_104_26
				end
			end

			if arg_101_1.time_ >= var_104_23 + var_104_24 and arg_101_1.time_ < var_104_23 + var_104_24 + arg_104_0 and not isNil(var_104_22) and arg_101_1.var_.characterEffect10104ui_story then
				local var_104_27 = 0.5

				arg_101_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10104ui_story.fillRatio = var_104_27
			end

			local var_104_28 = 0

			if var_104_28 < arg_101_1.time_ and arg_101_1.time_ <= var_104_28 + arg_104_0 then
				arg_101_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			local var_104_29 = 0

			if var_104_29 < arg_101_1.time_ and arg_101_1.time_ <= var_104_29 + arg_104_0 then
				arg_101_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_104_30 = 0
			local var_104_31 = 0.825

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_32 = arg_101_1:FormatText(StoryNameCfg[6].name)

				arg_101_1.leftNameTxt_.text = var_104_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_33 = arg_101_1:GetWordFromCfg(321022024)
				local var_104_34 = arg_101_1:FormatText(var_104_33.content)

				arg_101_1.text_.text = var_104_34

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_35 = 33
				local var_104_36 = utf8.len(var_104_34)
				local var_104_37 = var_104_35 <= 0 and var_104_31 or var_104_31 * (var_104_36 / var_104_35)

				if var_104_37 > 0 and var_104_31 < var_104_37 then
					arg_101_1.talkMaxDuration = var_104_37

					if var_104_37 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_37 + var_104_30
					end
				end

				arg_101_1.text_.text = var_104_34
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022024", "story_v_out_321022.awb") ~= 0 then
					local var_104_38 = manager.audio:GetVoiceLength("story_v_out_321022", "321022024", "story_v_out_321022.awb") / 1000

					if var_104_38 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_38 + var_104_30
					end

					if var_104_33.prefab_name ~= "" and arg_101_1.actors_[var_104_33.prefab_name] ~= nil then
						local var_104_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_33.prefab_name].transform, "story_v_out_321022", "321022024", "story_v_out_321022.awb")

						arg_101_1:RecordAudio("321022024", var_104_39)
						arg_101_1:RecordAudio("321022024", var_104_39)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321022", "321022024", "story_v_out_321022.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321022", "321022024", "story_v_out_321022.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_40 = math.max(var_104_31, arg_101_1.talkMaxDuration)

			if var_104_30 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_40 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_30) / var_104_40

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_30 + var_104_40 and arg_101_1.time_ < var_104_30 + var_104_40 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321022025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321022025
		arg_105_1.duration_ = 17.33

		local var_105_0 = {
			zh = 12.366,
			ja = 17.333
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
				arg_105_0:Play321022026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1284ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1284ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, 100, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1284ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, 100, 0)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = "1011ui_story"

			if arg_105_1.actors_[var_108_9] == nil then
				local var_108_10 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_108_10) then
					local var_108_11 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_105_1.stage_.transform)

					var_108_11.name = var_108_9
					var_108_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_105_1.actors_[var_108_9] = var_108_11

					local var_108_12 = var_108_11:GetComponentInChildren(typeof(CharacterEffect))

					var_108_12.enabled = true

					local var_108_13 = GameObjectTools.GetOrAddComponent(var_108_11, typeof(DynamicBoneHelper))

					if var_108_13 then
						var_108_13:EnableDynamicBone(false)
					end

					arg_105_1:ShowWeapon(var_108_12.transform, false)

					arg_105_1.var_[var_108_9 .. "Animator"] = var_108_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_105_1.var_[var_108_9 .. "Animator"].applyRootMotion = true
					arg_105_1.var_[var_108_9 .. "LipSync"] = var_108_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_108_14 = arg_105_1.actors_["1011ui_story"].transform
			local var_108_15 = 0

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.var_.moveOldPos1011ui_story = var_108_14.localPosition
			end

			local var_108_16 = 0.001

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_16 then
				local var_108_17 = (arg_105_1.time_ - var_108_15) / var_108_16
				local var_108_18 = Vector3.New(0, -0.71, -6)

				var_108_14.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1011ui_story, var_108_18, var_108_17)

				local var_108_19 = manager.ui.mainCamera.transform.position - var_108_14.position

				var_108_14.forward = Vector3.New(var_108_19.x, var_108_19.y, var_108_19.z)

				local var_108_20 = var_108_14.localEulerAngles

				var_108_20.z = 0
				var_108_20.x = 0
				var_108_14.localEulerAngles = var_108_20
			end

			if arg_105_1.time_ >= var_108_15 + var_108_16 and arg_105_1.time_ < var_108_15 + var_108_16 + arg_108_0 then
				var_108_14.localPosition = Vector3.New(0, -0.71, -6)

				local var_108_21 = manager.ui.mainCamera.transform.position - var_108_14.position

				var_108_14.forward = Vector3.New(var_108_21.x, var_108_21.y, var_108_21.z)

				local var_108_22 = var_108_14.localEulerAngles

				var_108_22.z = 0
				var_108_22.x = 0
				var_108_14.localEulerAngles = var_108_22
			end

			local var_108_23 = arg_105_1.actors_["1011ui_story"]
			local var_108_24 = 0

			if var_108_24 < arg_105_1.time_ and arg_105_1.time_ <= var_108_24 + arg_108_0 and not isNil(var_108_23) and arg_105_1.var_.characterEffect1011ui_story == nil then
				arg_105_1.var_.characterEffect1011ui_story = var_108_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_25 = 0.200000002980232

			if var_108_24 <= arg_105_1.time_ and arg_105_1.time_ < var_108_24 + var_108_25 and not isNil(var_108_23) then
				local var_108_26 = (arg_105_1.time_ - var_108_24) / var_108_25

				if arg_105_1.var_.characterEffect1011ui_story and not isNil(var_108_23) then
					arg_105_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_24 + var_108_25 and arg_105_1.time_ < var_108_24 + var_108_25 + arg_108_0 and not isNil(var_108_23) and arg_105_1.var_.characterEffect1011ui_story then
				arg_105_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_108_27 = arg_105_1.actors_["1284ui_story"]
			local var_108_28 = 0

			if var_108_28 < arg_105_1.time_ and arg_105_1.time_ <= var_108_28 + arg_108_0 and not isNil(var_108_27) and arg_105_1.var_.characterEffect1284ui_story == nil then
				arg_105_1.var_.characterEffect1284ui_story = var_108_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_29 = 0.200000002980232

			if var_108_28 <= arg_105_1.time_ and arg_105_1.time_ < var_108_28 + var_108_29 and not isNil(var_108_27) then
				local var_108_30 = (arg_105_1.time_ - var_108_28) / var_108_29

				if arg_105_1.var_.characterEffect1284ui_story and not isNil(var_108_27) then
					local var_108_31 = Mathf.Lerp(0, 0.5, var_108_30)

					arg_105_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1284ui_story.fillRatio = var_108_31
				end
			end

			if arg_105_1.time_ >= var_108_28 + var_108_29 and arg_105_1.time_ < var_108_28 + var_108_29 + arg_108_0 and not isNil(var_108_27) and arg_105_1.var_.characterEffect1284ui_story then
				local var_108_32 = 0.5

				arg_105_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1284ui_story.fillRatio = var_108_32
			end

			local var_108_33 = 0

			if var_108_33 < arg_105_1.time_ and arg_105_1.time_ <= var_108_33 + arg_108_0 then
				arg_105_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_108_34 = 0

			if var_108_34 < arg_105_1.time_ and arg_105_1.time_ <= var_108_34 + arg_108_0 then
				arg_105_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_108_35 = 0
			local var_108_36 = 1.45

			if var_108_35 < arg_105_1.time_ and arg_105_1.time_ <= var_108_35 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_37 = arg_105_1:FormatText(StoryNameCfg[37].name)

				arg_105_1.leftNameTxt_.text = var_108_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_38 = arg_105_1:GetWordFromCfg(321022025)
				local var_108_39 = arg_105_1:FormatText(var_108_38.content)

				arg_105_1.text_.text = var_108_39

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_40 = 58
				local var_108_41 = utf8.len(var_108_39)
				local var_108_42 = var_108_40 <= 0 and var_108_36 or var_108_36 * (var_108_41 / var_108_40)

				if var_108_42 > 0 and var_108_36 < var_108_42 then
					arg_105_1.talkMaxDuration = var_108_42

					if var_108_42 + var_108_35 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_42 + var_108_35
					end
				end

				arg_105_1.text_.text = var_108_39
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022025", "story_v_out_321022.awb") ~= 0 then
					local var_108_43 = manager.audio:GetVoiceLength("story_v_out_321022", "321022025", "story_v_out_321022.awb") / 1000

					if var_108_43 + var_108_35 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_43 + var_108_35
					end

					if var_108_38.prefab_name ~= "" and arg_105_1.actors_[var_108_38.prefab_name] ~= nil then
						local var_108_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_38.prefab_name].transform, "story_v_out_321022", "321022025", "story_v_out_321022.awb")

						arg_105_1:RecordAudio("321022025", var_108_44)
						arg_105_1:RecordAudio("321022025", var_108_44)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_321022", "321022025", "story_v_out_321022.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_321022", "321022025", "story_v_out_321022.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_45 = math.max(var_108_36, arg_105_1.talkMaxDuration)

			if var_108_35 <= arg_105_1.time_ and arg_105_1.time_ < var_108_35 + var_108_45 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_35) / var_108_45

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_35 + var_108_45 and arg_105_1.time_ < var_108_35 + var_108_45 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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

		arg_105_1:InitPlayNodeList()
	end,
	Play321022026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321022026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321022027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1011ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1011ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, 100, 0)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1011ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, 100, 0)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1011ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1011ui_story == nil then
				arg_109_1.var_.characterEffect1011ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1011ui_story and not isNil(var_112_9) then
					local var_112_13 = Mathf.Lerp(0, 0.5, var_112_12)

					arg_109_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1011ui_story.fillRatio = var_112_13
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1011ui_story then
				local var_112_14 = 0.5

				arg_109_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1011ui_story.fillRatio = var_112_14
			end

			local var_112_15 = 0.034000001847744
			local var_112_16 = 1

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				local var_112_17 = "play"
				local var_112_18 = "effect"

				arg_109_1:AudioAction(var_112_17, var_112_18, "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_112_19 = 0
			local var_112_20 = 0.95

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_21 = arg_109_1:GetWordFromCfg(321022026)
				local var_112_22 = arg_109_1:FormatText(var_112_21.content)

				arg_109_1.text_.text = var_112_22

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_23 = 38
				local var_112_24 = utf8.len(var_112_22)
				local var_112_25 = var_112_23 <= 0 and var_112_20 or var_112_20 * (var_112_24 / var_112_23)

				if var_112_25 > 0 and var_112_20 < var_112_25 then
					arg_109_1.talkMaxDuration = var_112_25

					if var_112_25 + var_112_19 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_25 + var_112_19
					end
				end

				arg_109_1.text_.text = var_112_22
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_26 = math.max(var_112_20, arg_109_1.talkMaxDuration)

			if var_112_19 <= arg_109_1.time_ and arg_109_1.time_ < var_112_19 + var_112_26 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_19) / var_112_26

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_19 + var_112_26 and arg_109_1.time_ < var_112_19 + var_112_26 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play321022027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321022027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play321022028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 1.1

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

				local var_116_2 = arg_113_1:GetWordFromCfg(321022027)
				local var_116_3 = arg_113_1:FormatText(var_116_2.content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 44
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
	Play321022028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321022028
		arg_117_1.duration_ = 7.9

		local var_117_0 = {
			zh = 5.633,
			ja = 7.9
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
				arg_117_0:Play321022029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1284ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1284ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1284ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1284ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1284ui_story == nil then
				arg_117_1.var_.characterEffect1284ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1284ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1284ui_story then
				arg_117_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_1")
			end

			local var_120_14 = 0
			local var_120_15 = 0.7

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_16 = arg_117_1:FormatText(StoryNameCfg[6].name)

				arg_117_1.leftNameTxt_.text = var_120_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_17 = arg_117_1:GetWordFromCfg(321022028)
				local var_120_18 = arg_117_1:FormatText(var_120_17.content)

				arg_117_1.text_.text = var_120_18

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_19 = 28
				local var_120_20 = utf8.len(var_120_18)
				local var_120_21 = var_120_19 <= 0 and var_120_15 or var_120_15 * (var_120_20 / var_120_19)

				if var_120_21 > 0 and var_120_15 < var_120_21 then
					arg_117_1.talkMaxDuration = var_120_21

					if var_120_21 + var_120_14 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_21 + var_120_14
					end
				end

				arg_117_1.text_.text = var_120_18
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022028", "story_v_out_321022.awb") ~= 0 then
					local var_120_22 = manager.audio:GetVoiceLength("story_v_out_321022", "321022028", "story_v_out_321022.awb") / 1000

					if var_120_22 + var_120_14 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_14
					end

					if var_120_17.prefab_name ~= "" and arg_117_1.actors_[var_120_17.prefab_name] ~= nil then
						local var_120_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_17.prefab_name].transform, "story_v_out_321022", "321022028", "story_v_out_321022.awb")

						arg_117_1:RecordAudio("321022028", var_120_23)
						arg_117_1:RecordAudio("321022028", var_120_23)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321022", "321022028", "story_v_out_321022.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321022", "321022028", "story_v_out_321022.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_24 = math.max(var_120_15, arg_117_1.talkMaxDuration)

			if var_120_14 <= arg_117_1.time_ and arg_117_1.time_ < var_120_14 + var_120_24 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_14) / var_120_24

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_14 + var_120_24 and arg_117_1.time_ < var_120_14 + var_120_24 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321022029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 321022029
		arg_121_1.duration_ = 14.43

		local var_121_0 = {
			zh = 9.3,
			ja = 14.433
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
				arg_121_0:Play321022030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10104ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10104ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0.99, -1.12, -5.99)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10104ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["10104ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10104ui_story == nil then
				arg_121_1.var_.characterEffect10104ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect10104ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10104ui_story then
				arg_121_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_124_13 = arg_121_1.actors_["1284ui_story"]
			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 and not isNil(var_124_13) and arg_121_1.var_.characterEffect1284ui_story == nil then
				arg_121_1.var_.characterEffect1284ui_story = var_124_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_15 = 0.200000002980232

			if var_124_14 <= arg_121_1.time_ and arg_121_1.time_ < var_124_14 + var_124_15 and not isNil(var_124_13) then
				local var_124_16 = (arg_121_1.time_ - var_124_14) / var_124_15

				if arg_121_1.var_.characterEffect1284ui_story and not isNil(var_124_13) then
					local var_124_17 = Mathf.Lerp(0, 0.5, var_124_16)

					arg_121_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1284ui_story.fillRatio = var_124_17
				end
			end

			if arg_121_1.time_ >= var_124_14 + var_124_15 and arg_121_1.time_ < var_124_14 + var_124_15 + arg_124_0 and not isNil(var_124_13) and arg_121_1.var_.characterEffect1284ui_story then
				local var_124_18 = 0.5

				arg_121_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1284ui_story.fillRatio = var_124_18
			end

			local var_124_19 = 0

			if var_124_19 < arg_121_1.time_ and arg_121_1.time_ <= var_124_19 + arg_124_0 then
				arg_121_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_124_20 = 0

			if var_124_20 < arg_121_1.time_ and arg_121_1.time_ <= var_124_20 + arg_124_0 then
				arg_121_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_124_21 = 0
			local var_124_22 = 1.225

			if var_124_21 < arg_121_1.time_ and arg_121_1.time_ <= var_124_21 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_23 = arg_121_1:FormatText(StoryNameCfg[1030].name)

				arg_121_1.leftNameTxt_.text = var_124_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_24 = arg_121_1:GetWordFromCfg(321022029)
				local var_124_25 = arg_121_1:FormatText(var_124_24.content)

				arg_121_1.text_.text = var_124_25

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_26 = 49
				local var_124_27 = utf8.len(var_124_25)
				local var_124_28 = var_124_26 <= 0 and var_124_22 or var_124_22 * (var_124_27 / var_124_26)

				if var_124_28 > 0 and var_124_22 < var_124_28 then
					arg_121_1.talkMaxDuration = var_124_28

					if var_124_28 + var_124_21 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_28 + var_124_21
					end
				end

				arg_121_1.text_.text = var_124_25
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022029", "story_v_out_321022.awb") ~= 0 then
					local var_124_29 = manager.audio:GetVoiceLength("story_v_out_321022", "321022029", "story_v_out_321022.awb") / 1000

					if var_124_29 + var_124_21 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_29 + var_124_21
					end

					if var_124_24.prefab_name ~= "" and arg_121_1.actors_[var_124_24.prefab_name] ~= nil then
						local var_124_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_24.prefab_name].transform, "story_v_out_321022", "321022029", "story_v_out_321022.awb")

						arg_121_1:RecordAudio("321022029", var_124_30)
						arg_121_1:RecordAudio("321022029", var_124_30)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_321022", "321022029", "story_v_out_321022.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_321022", "321022029", "story_v_out_321022.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_31 = math.max(var_124_22, arg_121_1.talkMaxDuration)

			if var_124_21 <= arg_121_1.time_ and arg_121_1.time_ < var_124_21 + var_124_31 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_21) / var_124_31

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_21 + var_124_31 and arg_121_1.time_ < var_124_21 + var_124_31 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321022030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 321022030
		arg_125_1.duration_ = 7.5

		local var_125_0 = {
			zh = 5.633,
			ja = 7.5
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
				arg_125_0:Play321022031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1284ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1284ui_story == nil then
				arg_125_1.var_.characterEffect1284ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1284ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1284ui_story then
				arg_125_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["10104ui_story"]
			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect10104ui_story == nil then
				arg_125_1.var_.characterEffect10104ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 and not isNil(var_128_4) then
				local var_128_7 = (arg_125_1.time_ - var_128_5) / var_128_6

				if arg_125_1.var_.characterEffect10104ui_story and not isNil(var_128_4) then
					local var_128_8 = Mathf.Lerp(0, 0.5, var_128_7)

					arg_125_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10104ui_story.fillRatio = var_128_8
				end
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect10104ui_story then
				local var_128_9 = 0.5

				arg_125_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10104ui_story.fillRatio = var_128_9
			end

			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284actionlink/1284action445")
			end

			local var_128_11 = 0

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_128_12 = 0
			local var_128_13 = 0.65

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_14 = arg_125_1:FormatText(StoryNameCfg[6].name)

				arg_125_1.leftNameTxt_.text = var_128_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_15 = arg_125_1:GetWordFromCfg(321022030)
				local var_128_16 = arg_125_1:FormatText(var_128_15.content)

				arg_125_1.text_.text = var_128_16

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 26
				local var_128_18 = utf8.len(var_128_16)
				local var_128_19 = var_128_17 <= 0 and var_128_13 or var_128_13 * (var_128_18 / var_128_17)

				if var_128_19 > 0 and var_128_13 < var_128_19 then
					arg_125_1.talkMaxDuration = var_128_19

					if var_128_19 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_16
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022030", "story_v_out_321022.awb") ~= 0 then
					local var_128_20 = manager.audio:GetVoiceLength("story_v_out_321022", "321022030", "story_v_out_321022.awb") / 1000

					if var_128_20 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_12
					end

					if var_128_15.prefab_name ~= "" and arg_125_1.actors_[var_128_15.prefab_name] ~= nil then
						local var_128_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_15.prefab_name].transform, "story_v_out_321022", "321022030", "story_v_out_321022.awb")

						arg_125_1:RecordAudio("321022030", var_128_21)
						arg_125_1:RecordAudio("321022030", var_128_21)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_321022", "321022030", "story_v_out_321022.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_321022", "321022030", "story_v_out_321022.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_12) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_12 + var_128_22 and arg_125_1.time_ < var_128_12 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play321022031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321022031
		arg_129_1.duration_ = 7.2

		local var_129_0 = {
			zh = 5.266,
			ja = 7.2
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
				arg_129_0:Play321022032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10104ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10104ui_story == nil then
				arg_129_1.var_.characterEffect10104ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect10104ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10104ui_story then
				arg_129_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_132_4 = arg_129_1.actors_["1284ui_story"]
			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect1284ui_story == nil then
				arg_129_1.var_.characterEffect1284ui_story = var_132_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_6 = 0.200000002980232

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_6 and not isNil(var_132_4) then
				local var_132_7 = (arg_129_1.time_ - var_132_5) / var_132_6

				if arg_129_1.var_.characterEffect1284ui_story and not isNil(var_132_4) then
					local var_132_8 = Mathf.Lerp(0, 0.5, var_132_7)

					arg_129_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1284ui_story.fillRatio = var_132_8
				end
			end

			if arg_129_1.time_ >= var_132_5 + var_132_6 and arg_129_1.time_ < var_132_5 + var_132_6 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect1284ui_story then
				local var_132_9 = 0.5

				arg_129_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1284ui_story.fillRatio = var_132_9
			end

			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			local var_132_11 = 0
			local var_132_12 = 0.5

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_13 = arg_129_1:FormatText(StoryNameCfg[1030].name)

				arg_129_1.leftNameTxt_.text = var_132_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_14 = arg_129_1:GetWordFromCfg(321022031)
				local var_132_15 = arg_129_1:FormatText(var_132_14.content)

				arg_129_1.text_.text = var_132_15

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 20
				local var_132_17 = utf8.len(var_132_15)
				local var_132_18 = var_132_16 <= 0 and var_132_12 or var_132_12 * (var_132_17 / var_132_16)

				if var_132_18 > 0 and var_132_12 < var_132_18 then
					arg_129_1.talkMaxDuration = var_132_18

					if var_132_18 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_18 + var_132_11
					end
				end

				arg_129_1.text_.text = var_132_15
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022031", "story_v_out_321022.awb") ~= 0 then
					local var_132_19 = manager.audio:GetVoiceLength("story_v_out_321022", "321022031", "story_v_out_321022.awb") / 1000

					if var_132_19 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_11
					end

					if var_132_14.prefab_name ~= "" and arg_129_1.actors_[var_132_14.prefab_name] ~= nil then
						local var_132_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_14.prefab_name].transform, "story_v_out_321022", "321022031", "story_v_out_321022.awb")

						arg_129_1:RecordAudio("321022031", var_132_20)
						arg_129_1:RecordAudio("321022031", var_132_20)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_321022", "321022031", "story_v_out_321022.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_321022", "321022031", "story_v_out_321022.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_21 = math.max(var_132_12, arg_129_1.talkMaxDuration)

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_21 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_11) / var_132_21

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_11 + var_132_21 and arg_129_1.time_ < var_132_11 + var_132_21 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play321022032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321022032
		arg_133_1.duration_ = 16.23

		local var_133_0 = {
			zh = 10.5,
			ja = 16.233
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
				arg_133_0:Play321022033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1.275

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[1030].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(321022032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 51
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022032", "story_v_out_321022.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_321022", "321022032", "story_v_out_321022.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_321022", "321022032", "story_v_out_321022.awb")

						arg_133_1:RecordAudio("321022032", var_136_9)
						arg_133_1:RecordAudio("321022032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_321022", "321022032", "story_v_out_321022.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_321022", "321022032", "story_v_out_321022.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play321022033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321022033
		arg_137_1.duration_ = 5.57

		local var_137_0 = {
			zh = 4.1,
			ja = 5.566
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
				arg_137_0:Play321022034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10104ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10104ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0.99, -1.12, -5.99)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10104ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_140_11 = 0

			if var_140_11 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				arg_137_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_2")
			end

			local var_140_12 = 0
			local var_140_13 = 0.575

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_14 = arg_137_1:FormatText(StoryNameCfg[1030].name)

				arg_137_1.leftNameTxt_.text = var_140_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_15 = arg_137_1:GetWordFromCfg(321022033)
				local var_140_16 = arg_137_1:FormatText(var_140_15.content)

				arg_137_1.text_.text = var_140_16

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 23
				local var_140_18 = utf8.len(var_140_16)
				local var_140_19 = var_140_17 <= 0 and var_140_13 or var_140_13 * (var_140_18 / var_140_17)

				if var_140_19 > 0 and var_140_13 < var_140_19 then
					arg_137_1.talkMaxDuration = var_140_19

					if var_140_19 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_12
					end
				end

				arg_137_1.text_.text = var_140_16
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022033", "story_v_out_321022.awb") ~= 0 then
					local var_140_20 = manager.audio:GetVoiceLength("story_v_out_321022", "321022033", "story_v_out_321022.awb") / 1000

					if var_140_20 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_12
					end

					if var_140_15.prefab_name ~= "" and arg_137_1.actors_[var_140_15.prefab_name] ~= nil then
						local var_140_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_15.prefab_name].transform, "story_v_out_321022", "321022033", "story_v_out_321022.awb")

						arg_137_1:RecordAudio("321022033", var_140_21)
						arg_137_1:RecordAudio("321022033", var_140_21)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_321022", "321022033", "story_v_out_321022.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_321022", "321022033", "story_v_out_321022.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_13, arg_137_1.talkMaxDuration)

			if var_140_12 <= arg_137_1.time_ and arg_137_1.time_ < var_140_12 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_12) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_12 + var_140_22 and arg_137_1.time_ < var_140_12 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321022034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 321022034
		arg_141_1.duration_ = 8.2

		local var_141_0 = {
			zh = 4.8,
			ja = 8.2
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
				arg_141_0:Play321022035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10104ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10104ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, 100, 0)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10104ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, 100, 0)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1011ui_story"].transform
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.var_.moveOldPos1011ui_story = var_144_9.localPosition
			end

			local var_144_11 = 0.001

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11
				local var_144_13 = Vector3.New(0, -0.71, -6)

				var_144_9.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1011ui_story, var_144_13, var_144_12)

				local var_144_14 = manager.ui.mainCamera.transform.position - var_144_9.position

				var_144_9.forward = Vector3.New(var_144_14.x, var_144_14.y, var_144_14.z)

				local var_144_15 = var_144_9.localEulerAngles

				var_144_15.z = 0
				var_144_15.x = 0
				var_144_9.localEulerAngles = var_144_15
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 then
				var_144_9.localPosition = Vector3.New(0, -0.71, -6)

				local var_144_16 = manager.ui.mainCamera.transform.position - var_144_9.position

				var_144_9.forward = Vector3.New(var_144_16.x, var_144_16.y, var_144_16.z)

				local var_144_17 = var_144_9.localEulerAngles

				var_144_17.z = 0
				var_144_17.x = 0
				var_144_9.localEulerAngles = var_144_17
			end

			local var_144_18 = arg_141_1.actors_["1011ui_story"]
			local var_144_19 = 0

			if var_144_19 < arg_141_1.time_ and arg_141_1.time_ <= var_144_19 + arg_144_0 and not isNil(var_144_18) and arg_141_1.var_.characterEffect1011ui_story == nil then
				arg_141_1.var_.characterEffect1011ui_story = var_144_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_20 = 0.200000002980232

			if var_144_19 <= arg_141_1.time_ and arg_141_1.time_ < var_144_19 + var_144_20 and not isNil(var_144_18) then
				local var_144_21 = (arg_141_1.time_ - var_144_19) / var_144_20

				if arg_141_1.var_.characterEffect1011ui_story and not isNil(var_144_18) then
					arg_141_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_19 + var_144_20 and arg_141_1.time_ < var_144_19 + var_144_20 + arg_144_0 and not isNil(var_144_18) and arg_141_1.var_.characterEffect1011ui_story then
				arg_141_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_144_22 = arg_141_1.actors_["10104ui_story"]
			local var_144_23 = 0

			if var_144_23 < arg_141_1.time_ and arg_141_1.time_ <= var_144_23 + arg_144_0 and not isNil(var_144_22) and arg_141_1.var_.characterEffect10104ui_story == nil then
				arg_141_1.var_.characterEffect10104ui_story = var_144_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_24 = 0.200000002980232

			if var_144_23 <= arg_141_1.time_ and arg_141_1.time_ < var_144_23 + var_144_24 and not isNil(var_144_22) then
				local var_144_25 = (arg_141_1.time_ - var_144_23) / var_144_24

				if arg_141_1.var_.characterEffect10104ui_story and not isNil(var_144_22) then
					local var_144_26 = Mathf.Lerp(0, 0.5, var_144_25)

					arg_141_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10104ui_story.fillRatio = var_144_26
				end
			end

			if arg_141_1.time_ >= var_144_23 + var_144_24 and arg_141_1.time_ < var_144_23 + var_144_24 + arg_144_0 and not isNil(var_144_22) and arg_141_1.var_.characterEffect10104ui_story then
				local var_144_27 = 0.5

				arg_141_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10104ui_story.fillRatio = var_144_27
			end

			local var_144_28 = 0

			if var_144_28 < arg_141_1.time_ and arg_141_1.time_ <= var_144_28 + arg_144_0 then
				arg_141_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			local var_144_29 = 0

			if var_144_29 < arg_141_1.time_ and arg_141_1.time_ <= var_144_29 + arg_144_0 then
				arg_141_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_30 = arg_141_1.actors_["1284ui_story"].transform
			local var_144_31 = 0

			if var_144_31 < arg_141_1.time_ and arg_141_1.time_ <= var_144_31 + arg_144_0 then
				arg_141_1.var_.moveOldPos1284ui_story = var_144_30.localPosition
			end

			local var_144_32 = 0.001

			if var_144_31 <= arg_141_1.time_ and arg_141_1.time_ < var_144_31 + var_144_32 then
				local var_144_33 = (arg_141_1.time_ - var_144_31) / var_144_32
				local var_144_34 = Vector3.New(0, 100, 0)

				var_144_30.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1284ui_story, var_144_34, var_144_33)

				local var_144_35 = manager.ui.mainCamera.transform.position - var_144_30.position

				var_144_30.forward = Vector3.New(var_144_35.x, var_144_35.y, var_144_35.z)

				local var_144_36 = var_144_30.localEulerAngles

				var_144_36.z = 0
				var_144_36.x = 0
				var_144_30.localEulerAngles = var_144_36
			end

			if arg_141_1.time_ >= var_144_31 + var_144_32 and arg_141_1.time_ < var_144_31 + var_144_32 + arg_144_0 then
				var_144_30.localPosition = Vector3.New(0, 100, 0)

				local var_144_37 = manager.ui.mainCamera.transform.position - var_144_30.position

				var_144_30.forward = Vector3.New(var_144_37.x, var_144_37.y, var_144_37.z)

				local var_144_38 = var_144_30.localEulerAngles

				var_144_38.z = 0
				var_144_38.x = 0
				var_144_30.localEulerAngles = var_144_38
			end

			local var_144_39 = 0

			if var_144_39 < arg_141_1.time_ and arg_141_1.time_ <= var_144_39 + arg_144_0 then
				arg_141_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_144_40 = 0
			local var_144_41 = 0.6

			if var_144_40 < arg_141_1.time_ and arg_141_1.time_ <= var_144_40 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_42 = arg_141_1:FormatText(StoryNameCfg[37].name)

				arg_141_1.leftNameTxt_.text = var_144_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_43 = arg_141_1:GetWordFromCfg(321022034)
				local var_144_44 = arg_141_1:FormatText(var_144_43.content)

				arg_141_1.text_.text = var_144_44

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_45 = 24
				local var_144_46 = utf8.len(var_144_44)
				local var_144_47 = var_144_45 <= 0 and var_144_41 or var_144_41 * (var_144_46 / var_144_45)

				if var_144_47 > 0 and var_144_41 < var_144_47 then
					arg_141_1.talkMaxDuration = var_144_47

					if var_144_47 + var_144_40 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_47 + var_144_40
					end
				end

				arg_141_1.text_.text = var_144_44
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022034", "story_v_out_321022.awb") ~= 0 then
					local var_144_48 = manager.audio:GetVoiceLength("story_v_out_321022", "321022034", "story_v_out_321022.awb") / 1000

					if var_144_48 + var_144_40 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_48 + var_144_40
					end

					if var_144_43.prefab_name ~= "" and arg_141_1.actors_[var_144_43.prefab_name] ~= nil then
						local var_144_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_43.prefab_name].transform, "story_v_out_321022", "321022034", "story_v_out_321022.awb")

						arg_141_1:RecordAudio("321022034", var_144_49)
						arg_141_1:RecordAudio("321022034", var_144_49)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_321022", "321022034", "story_v_out_321022.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_321022", "321022034", "story_v_out_321022.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_50 = math.max(var_144_41, arg_141_1.talkMaxDuration)

			if var_144_40 <= arg_141_1.time_ and arg_141_1.time_ < var_144_40 + var_144_50 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_40) / var_144_50

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_40 + var_144_50 and arg_141_1.time_ < var_144_40 + var_144_50 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play321022035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 321022035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play321022036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1011ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1011ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, 100, 0)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1011ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, 100, 0)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["1011ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1011ui_story == nil then
				arg_145_1.var_.characterEffect1011ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect1011ui_story and not isNil(var_148_9) then
					local var_148_13 = Mathf.Lerp(0, 0.5, var_148_12)

					arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1011ui_story.fillRatio = var_148_13
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1011ui_story then
				local var_148_14 = 0.5

				arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1011ui_story.fillRatio = var_148_14
			end

			local var_148_15 = 1.66666666666667
			local var_148_16 = 1

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				local var_148_17 = "play"
				local var_148_18 = "effect"

				arg_145_1:AudioAction(var_148_17, var_148_18, "se_story_140", "se_story_140_frame", "")
			end

			local var_148_19 = 0
			local var_148_20 = 1.35

			if var_148_19 < arg_145_1.time_ and arg_145_1.time_ <= var_148_19 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_21 = arg_145_1:GetWordFromCfg(321022035)
				local var_148_22 = arg_145_1:FormatText(var_148_21.content)

				arg_145_1.text_.text = var_148_22

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_23 = 53
				local var_148_24 = utf8.len(var_148_22)
				local var_148_25 = var_148_23 <= 0 and var_148_20 or var_148_20 * (var_148_24 / var_148_23)

				if var_148_25 > 0 and var_148_20 < var_148_25 then
					arg_145_1.talkMaxDuration = var_148_25

					if var_148_25 + var_148_19 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_25 + var_148_19
					end
				end

				arg_145_1.text_.text = var_148_22
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_26 = math.max(var_148_20, arg_145_1.talkMaxDuration)

			if var_148_19 <= arg_145_1.time_ and arg_145_1.time_ < var_148_19 + var_148_26 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_19) / var_148_26

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_19 + var_148_26 and arg_145_1.time_ < var_148_19 + var_148_26 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play321022036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 321022036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play321022037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.05
			local var_152_1 = 1

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				local var_152_2 = "play"
				local var_152_3 = "effect"

				arg_149_1:AudioAction(var_152_2, var_152_3, "se_story_140", "se_story_140_door", "")
			end

			local var_152_4 = 0
			local var_152_5 = 1

			if var_152_4 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(321022036)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_8 = 40
				local var_152_9 = utf8.len(var_152_7)
				local var_152_10 = var_152_8 <= 0 and var_152_5 or var_152_5 * (var_152_9 / var_152_8)

				if var_152_10 > 0 and var_152_5 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_11 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_11 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_11

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_11 and arg_149_1.time_ < var_152_4 + var_152_11 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play321022037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 321022037
		arg_153_1.duration_ = 11.27

		local var_153_0 = {
			zh = 8.033,
			ja = 11.266
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play321022038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1011ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1011ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(0, -0.71, -6)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1011ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1011ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1011ui_story == nil then
				arg_153_1.var_.characterEffect1011ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect1011ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1011ui_story then
				arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_1")
			end

			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_156_15 = 0
			local var_156_16 = 0.75

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[37].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(321022037)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 30
				local var_156_21 = utf8.len(var_156_19)
				local var_156_22 = var_156_20 <= 0 and var_156_16 or var_156_16 * (var_156_21 / var_156_20)

				if var_156_22 > 0 and var_156_16 < var_156_22 then
					arg_153_1.talkMaxDuration = var_156_22

					if var_156_22 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_22 + var_156_15
					end
				end

				arg_153_1.text_.text = var_156_19
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022037", "story_v_out_321022.awb") ~= 0 then
					local var_156_23 = manager.audio:GetVoiceLength("story_v_out_321022", "321022037", "story_v_out_321022.awb") / 1000

					if var_156_23 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_15
					end

					if var_156_18.prefab_name ~= "" and arg_153_1.actors_[var_156_18.prefab_name] ~= nil then
						local var_156_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_18.prefab_name].transform, "story_v_out_321022", "321022037", "story_v_out_321022.awb")

						arg_153_1:RecordAudio("321022037", var_156_24)
						arg_153_1:RecordAudio("321022037", var_156_24)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_321022", "321022037", "story_v_out_321022.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_321022", "321022037", "story_v_out_321022.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_25 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_25 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_25

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_25 and arg_153_1.time_ < var_156_15 + var_156_25 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play321022038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321022038
		arg_157_1.duration_ = 5.73

		local var_157_0 = {
			zh = 4.6,
			ja = 5.733
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play321022039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10104ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10104ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0.02, -1.12, -5.99)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10104ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1011ui_story"].transform
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.var_.moveOldPos1011ui_story = var_160_9.localPosition
			end

			local var_160_11 = 0.001

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11
				local var_160_13 = Vector3.New(0, 100, 0)

				var_160_9.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1011ui_story, var_160_13, var_160_12)

				local var_160_14 = manager.ui.mainCamera.transform.position - var_160_9.position

				var_160_9.forward = Vector3.New(var_160_14.x, var_160_14.y, var_160_14.z)

				local var_160_15 = var_160_9.localEulerAngles

				var_160_15.z = 0
				var_160_15.x = 0
				var_160_9.localEulerAngles = var_160_15
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 then
				var_160_9.localPosition = Vector3.New(0, 100, 0)

				local var_160_16 = manager.ui.mainCamera.transform.position - var_160_9.position

				var_160_9.forward = Vector3.New(var_160_16.x, var_160_16.y, var_160_16.z)

				local var_160_17 = var_160_9.localEulerAngles

				var_160_17.z = 0
				var_160_17.x = 0
				var_160_9.localEulerAngles = var_160_17
			end

			local var_160_18 = arg_157_1.actors_["10104ui_story"]
			local var_160_19 = 0

			if var_160_19 < arg_157_1.time_ and arg_157_1.time_ <= var_160_19 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.characterEffect10104ui_story == nil then
				arg_157_1.var_.characterEffect10104ui_story = var_160_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_20 = 0.200000002980232

			if var_160_19 <= arg_157_1.time_ and arg_157_1.time_ < var_160_19 + var_160_20 and not isNil(var_160_18) then
				local var_160_21 = (arg_157_1.time_ - var_160_19) / var_160_20

				if arg_157_1.var_.characterEffect10104ui_story and not isNil(var_160_18) then
					arg_157_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_19 + var_160_20 and arg_157_1.time_ < var_160_19 + var_160_20 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.characterEffect10104ui_story then
				arg_157_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_160_22 = arg_157_1.actors_["1011ui_story"]
			local var_160_23 = 0

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.characterEffect1011ui_story == nil then
				arg_157_1.var_.characterEffect1011ui_story = var_160_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_24 = 0.200000002980232

			if var_160_23 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_24 and not isNil(var_160_22) then
				local var_160_25 = (arg_157_1.time_ - var_160_23) / var_160_24

				if arg_157_1.var_.characterEffect1011ui_story and not isNil(var_160_22) then
					local var_160_26 = Mathf.Lerp(0, 0.5, var_160_25)

					arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1011ui_story.fillRatio = var_160_26
				end
			end

			if arg_157_1.time_ >= var_160_23 + var_160_24 and arg_157_1.time_ < var_160_23 + var_160_24 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.characterEffect1011ui_story then
				local var_160_27 = 0.5

				arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1011ui_story.fillRatio = var_160_27
			end

			local var_160_28 = 0

			if var_160_28 < arg_157_1.time_ and arg_157_1.time_ <= var_160_28 + arg_160_0 then
				arg_157_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			local var_160_29 = 0

			if var_160_29 < arg_157_1.time_ and arg_157_1.time_ <= var_160_29 + arg_160_0 then
				arg_157_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_160_30 = 0
			local var_160_31 = 0.4

			if var_160_30 < arg_157_1.time_ and arg_157_1.time_ <= var_160_30 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_32 = arg_157_1:FormatText(StoryNameCfg[1030].name)

				arg_157_1.leftNameTxt_.text = var_160_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_33 = arg_157_1:GetWordFromCfg(321022038)
				local var_160_34 = arg_157_1:FormatText(var_160_33.content)

				arg_157_1.text_.text = var_160_34

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_35 = 16
				local var_160_36 = utf8.len(var_160_34)
				local var_160_37 = var_160_35 <= 0 and var_160_31 or var_160_31 * (var_160_36 / var_160_35)

				if var_160_37 > 0 and var_160_31 < var_160_37 then
					arg_157_1.talkMaxDuration = var_160_37

					if var_160_37 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_37 + var_160_30
					end
				end

				arg_157_1.text_.text = var_160_34
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022038", "story_v_out_321022.awb") ~= 0 then
					local var_160_38 = manager.audio:GetVoiceLength("story_v_out_321022", "321022038", "story_v_out_321022.awb") / 1000

					if var_160_38 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_38 + var_160_30
					end

					if var_160_33.prefab_name ~= "" and arg_157_1.actors_[var_160_33.prefab_name] ~= nil then
						local var_160_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_33.prefab_name].transform, "story_v_out_321022", "321022038", "story_v_out_321022.awb")

						arg_157_1:RecordAudio("321022038", var_160_39)
						arg_157_1:RecordAudio("321022038", var_160_39)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_321022", "321022038", "story_v_out_321022.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_321022", "321022038", "story_v_out_321022.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_40 = math.max(var_160_31, arg_157_1.talkMaxDuration)

			if var_160_30 <= arg_157_1.time_ and arg_157_1.time_ < var_160_30 + var_160_40 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_30) / var_160_40

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_30 + var_160_40 and arg_157_1.time_ < var_160_30 + var_160_40 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_157_1:InitPlayNodeList()
	end,
	Play321022039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321022039
		arg_161_1.duration_ = 4.77

		local var_161_0 = {
			zh = 3.266,
			ja = 4.766
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play321022040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1284ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1284ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1284ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = arg_161_1.actors_["10104ui_story"].transform
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.var_.moveOldPos10104ui_story = var_164_9.localPosition
			end

			local var_164_11 = 0.001

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11
				local var_164_13 = Vector3.New(0, 100, 0)

				var_164_9.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10104ui_story, var_164_13, var_164_12)

				local var_164_14 = manager.ui.mainCamera.transform.position - var_164_9.position

				var_164_9.forward = Vector3.New(var_164_14.x, var_164_14.y, var_164_14.z)

				local var_164_15 = var_164_9.localEulerAngles

				var_164_15.z = 0
				var_164_15.x = 0
				var_164_9.localEulerAngles = var_164_15
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 then
				var_164_9.localPosition = Vector3.New(0, 100, 0)

				local var_164_16 = manager.ui.mainCamera.transform.position - var_164_9.position

				var_164_9.forward = Vector3.New(var_164_16.x, var_164_16.y, var_164_16.z)

				local var_164_17 = var_164_9.localEulerAngles

				var_164_17.z = 0
				var_164_17.x = 0
				var_164_9.localEulerAngles = var_164_17
			end

			local var_164_18 = arg_161_1.actors_["1284ui_story"]
			local var_164_19 = 0

			if var_164_19 < arg_161_1.time_ and arg_161_1.time_ <= var_164_19 + arg_164_0 and not isNil(var_164_18) and arg_161_1.var_.characterEffect1284ui_story == nil then
				arg_161_1.var_.characterEffect1284ui_story = var_164_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_20 = 0.200000002980232

			if var_164_19 <= arg_161_1.time_ and arg_161_1.time_ < var_164_19 + var_164_20 and not isNil(var_164_18) then
				local var_164_21 = (arg_161_1.time_ - var_164_19) / var_164_20

				if arg_161_1.var_.characterEffect1284ui_story and not isNil(var_164_18) then
					arg_161_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_19 + var_164_20 and arg_161_1.time_ < var_164_19 + var_164_20 + arg_164_0 and not isNil(var_164_18) and arg_161_1.var_.characterEffect1284ui_story then
				arg_161_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_164_22 = arg_161_1.actors_["10104ui_story"]
			local var_164_23 = 0

			if var_164_23 < arg_161_1.time_ and arg_161_1.time_ <= var_164_23 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.characterEffect10104ui_story == nil then
				arg_161_1.var_.characterEffect10104ui_story = var_164_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_24 = 0.200000002980232

			if var_164_23 <= arg_161_1.time_ and arg_161_1.time_ < var_164_23 + var_164_24 and not isNil(var_164_22) then
				local var_164_25 = (arg_161_1.time_ - var_164_23) / var_164_24

				if arg_161_1.var_.characterEffect10104ui_story and not isNil(var_164_22) then
					local var_164_26 = Mathf.Lerp(0, 0.5, var_164_25)

					arg_161_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10104ui_story.fillRatio = var_164_26
				end
			end

			if arg_161_1.time_ >= var_164_23 + var_164_24 and arg_161_1.time_ < var_164_23 + var_164_24 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.characterEffect10104ui_story then
				local var_164_27 = 0.5

				arg_161_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10104ui_story.fillRatio = var_164_27
			end

			local var_164_28 = 0

			if var_164_28 < arg_161_1.time_ and arg_161_1.time_ <= var_164_28 + arg_164_0 then
				arg_161_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_164_29 = 0
			local var_164_30 = 0.4

			if var_164_29 < arg_161_1.time_ and arg_161_1.time_ <= var_164_29 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_31 = arg_161_1:FormatText(StoryNameCfg[6].name)

				arg_161_1.leftNameTxt_.text = var_164_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_32 = arg_161_1:GetWordFromCfg(321022039)
				local var_164_33 = arg_161_1:FormatText(var_164_32.content)

				arg_161_1.text_.text = var_164_33

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_34 = 16
				local var_164_35 = utf8.len(var_164_33)
				local var_164_36 = var_164_34 <= 0 and var_164_30 or var_164_30 * (var_164_35 / var_164_34)

				if var_164_36 > 0 and var_164_30 < var_164_36 then
					arg_161_1.talkMaxDuration = var_164_36

					if var_164_36 + var_164_29 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_36 + var_164_29
					end
				end

				arg_161_1.text_.text = var_164_33
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022039", "story_v_out_321022.awb") ~= 0 then
					local var_164_37 = manager.audio:GetVoiceLength("story_v_out_321022", "321022039", "story_v_out_321022.awb") / 1000

					if var_164_37 + var_164_29 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_37 + var_164_29
					end

					if var_164_32.prefab_name ~= "" and arg_161_1.actors_[var_164_32.prefab_name] ~= nil then
						local var_164_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_32.prefab_name].transform, "story_v_out_321022", "321022039", "story_v_out_321022.awb")

						arg_161_1:RecordAudio("321022039", var_164_38)
						arg_161_1:RecordAudio("321022039", var_164_38)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_321022", "321022039", "story_v_out_321022.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_321022", "321022039", "story_v_out_321022.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_39 = math.max(var_164_30, arg_161_1.talkMaxDuration)

			if var_164_29 <= arg_161_1.time_ and arg_161_1.time_ < var_164_29 + var_164_39 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_29) / var_164_39

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_29 + var_164_39 and arg_161_1.time_ < var_164_29 + var_164_39 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play321022040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321022040
		arg_165_1.duration_ = 6.9

		local var_165_0 = {
			zh = 5.1,
			ja = 6.9
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play321022041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1011ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1011ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0.7, -0.71, -6)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1011ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1011ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1011ui_story == nil then
				arg_165_1.var_.characterEffect1011ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1011ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1011ui_story then
				arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_168_13 = arg_165_1.actors_["1284ui_story"]
			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 and not isNil(var_168_13) and arg_165_1.var_.characterEffect1284ui_story == nil then
				arg_165_1.var_.characterEffect1284ui_story = var_168_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_15 = 0.200000002980232

			if var_168_14 <= arg_165_1.time_ and arg_165_1.time_ < var_168_14 + var_168_15 and not isNil(var_168_13) then
				local var_168_16 = (arg_165_1.time_ - var_168_14) / var_168_15

				if arg_165_1.var_.characterEffect1284ui_story and not isNil(var_168_13) then
					local var_168_17 = Mathf.Lerp(0, 0.5, var_168_16)

					arg_165_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1284ui_story.fillRatio = var_168_17
				end
			end

			if arg_165_1.time_ >= var_168_14 + var_168_15 and arg_165_1.time_ < var_168_14 + var_168_15 + arg_168_0 and not isNil(var_168_13) and arg_165_1.var_.characterEffect1284ui_story then
				local var_168_18 = 0.5

				arg_165_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1284ui_story.fillRatio = var_168_18
			end

			local var_168_19 = 0

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_2")
			end

			local var_168_20 = 0

			if var_168_20 < arg_165_1.time_ and arg_165_1.time_ <= var_168_20 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_168_21 = 0
			local var_168_22 = 0.65

			if var_168_21 < arg_165_1.time_ and arg_165_1.time_ <= var_168_21 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_23 = arg_165_1:FormatText(StoryNameCfg[37].name)

				arg_165_1.leftNameTxt_.text = var_168_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_24 = arg_165_1:GetWordFromCfg(321022040)
				local var_168_25 = arg_165_1:FormatText(var_168_24.content)

				arg_165_1.text_.text = var_168_25

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_26 = 26
				local var_168_27 = utf8.len(var_168_25)
				local var_168_28 = var_168_26 <= 0 and var_168_22 or var_168_22 * (var_168_27 / var_168_26)

				if var_168_28 > 0 and var_168_22 < var_168_28 then
					arg_165_1.talkMaxDuration = var_168_28

					if var_168_28 + var_168_21 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_28 + var_168_21
					end
				end

				arg_165_1.text_.text = var_168_25
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022040", "story_v_out_321022.awb") ~= 0 then
					local var_168_29 = manager.audio:GetVoiceLength("story_v_out_321022", "321022040", "story_v_out_321022.awb") / 1000

					if var_168_29 + var_168_21 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_29 + var_168_21
					end

					if var_168_24.prefab_name ~= "" and arg_165_1.actors_[var_168_24.prefab_name] ~= nil then
						local var_168_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_24.prefab_name].transform, "story_v_out_321022", "321022040", "story_v_out_321022.awb")

						arg_165_1:RecordAudio("321022040", var_168_30)
						arg_165_1:RecordAudio("321022040", var_168_30)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_321022", "321022040", "story_v_out_321022.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_321022", "321022040", "story_v_out_321022.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_31 = math.max(var_168_22, arg_165_1.talkMaxDuration)

			if var_168_21 <= arg_165_1.time_ and arg_165_1.time_ < var_168_21 + var_168_31 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_21) / var_168_31

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_21 + var_168_31 and arg_165_1.time_ < var_168_21 + var_168_31 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play321022041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321022041
		arg_169_1.duration_ = 20.17

		local var_169_0 = {
			zh = 11.6,
			ja = 20.166
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play321022042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 1.45

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[37].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(321022041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022041", "story_v_out_321022.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_321022", "321022041", "story_v_out_321022.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_321022", "321022041", "story_v_out_321022.awb")

						arg_169_1:RecordAudio("321022041", var_172_9)
						arg_169_1:RecordAudio("321022041", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_321022", "321022041", "story_v_out_321022.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_321022", "321022041", "story_v_out_321022.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play321022042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 321022042
		arg_173_1.duration_ = 9.67

		local var_173_0 = {
			zh = 6.666,
			ja = 9.666
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play321022043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action7_1")
			end

			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_176_2 = 0
			local var_176_3 = 0.825

			if var_176_2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_4 = arg_173_1:FormatText(StoryNameCfg[37].name)

				arg_173_1.leftNameTxt_.text = var_176_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_5 = arg_173_1:GetWordFromCfg(321022042)
				local var_176_6 = arg_173_1:FormatText(var_176_5.content)

				arg_173_1.text_.text = var_176_6

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 33
				local var_176_8 = utf8.len(var_176_6)
				local var_176_9 = var_176_7 <= 0 and var_176_3 or var_176_3 * (var_176_8 / var_176_7)

				if var_176_9 > 0 and var_176_3 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_6
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022042", "story_v_out_321022.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022042", "story_v_out_321022.awb") / 1000

					if var_176_10 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_2
					end

					if var_176_5.prefab_name ~= "" and arg_173_1.actors_[var_176_5.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_5.prefab_name].transform, "story_v_out_321022", "321022042", "story_v_out_321022.awb")

						arg_173_1:RecordAudio("321022042", var_176_11)
						arg_173_1:RecordAudio("321022042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_321022", "321022042", "story_v_out_321022.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_321022", "321022042", "story_v_out_321022.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_12 and arg_173_1.time_ < var_176_2 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play321022043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 321022043
		arg_177_1.duration_ = 3.4

		local var_177_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play321022044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1284ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1284ui_story == nil then
				arg_177_1.var_.characterEffect1284ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1284ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1284ui_story then
				arg_177_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["1011ui_story"]
			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1011ui_story == nil then
				arg_177_1.var_.characterEffect1011ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_6 = 0.200000002980232

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_6 and not isNil(var_180_4) then
				local var_180_7 = (arg_177_1.time_ - var_180_5) / var_180_6

				if arg_177_1.var_.characterEffect1011ui_story and not isNil(var_180_4) then
					local var_180_8 = Mathf.Lerp(0, 0.5, var_180_7)

					arg_177_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1011ui_story.fillRatio = var_180_8
				end
			end

			if arg_177_1.time_ >= var_180_5 + var_180_6 and arg_177_1.time_ < var_180_5 + var_180_6 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1011ui_story then
				local var_180_9 = 0.5

				arg_177_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1011ui_story.fillRatio = var_180_9
			end

			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_180_11 = 0
			local var_180_12 = 0.275

			if var_180_11 < arg_177_1.time_ and arg_177_1.time_ <= var_180_11 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_13 = arg_177_1:FormatText(StoryNameCfg[6].name)

				arg_177_1.leftNameTxt_.text = var_180_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_14 = arg_177_1:GetWordFromCfg(321022043)
				local var_180_15 = arg_177_1:FormatText(var_180_14.content)

				arg_177_1.text_.text = var_180_15

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_16 = 11
				local var_180_17 = utf8.len(var_180_15)
				local var_180_18 = var_180_16 <= 0 and var_180_12 or var_180_12 * (var_180_17 / var_180_16)

				if var_180_18 > 0 and var_180_12 < var_180_18 then
					arg_177_1.talkMaxDuration = var_180_18

					if var_180_18 + var_180_11 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_18 + var_180_11
					end
				end

				arg_177_1.text_.text = var_180_15
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022043", "story_v_out_321022.awb") ~= 0 then
					local var_180_19 = manager.audio:GetVoiceLength("story_v_out_321022", "321022043", "story_v_out_321022.awb") / 1000

					if var_180_19 + var_180_11 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_19 + var_180_11
					end

					if var_180_14.prefab_name ~= "" and arg_177_1.actors_[var_180_14.prefab_name] ~= nil then
						local var_180_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_14.prefab_name].transform, "story_v_out_321022", "321022043", "story_v_out_321022.awb")

						arg_177_1:RecordAudio("321022043", var_180_20)
						arg_177_1:RecordAudio("321022043", var_180_20)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_321022", "321022043", "story_v_out_321022.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_321022", "321022043", "story_v_out_321022.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_21 = math.max(var_180_12, arg_177_1.talkMaxDuration)

			if var_180_11 <= arg_177_1.time_ and arg_177_1.time_ < var_180_11 + var_180_21 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_11) / var_180_21

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_11 + var_180_21 and arg_177_1.time_ < var_180_11 + var_180_21 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play321022044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321022044
		arg_181_1.duration_ = 2.4

		local var_181_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_181_0:Play321022045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10104ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10104ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0.99, -1.12, -5.99)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10104ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1011ui_story"].transform
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1.var_.moveOldPos1011ui_story = var_184_9.localPosition
			end

			local var_184_11 = 0.001

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11
				local var_184_13 = Vector3.New(0, 100, 0)

				var_184_9.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1011ui_story, var_184_13, var_184_12)

				local var_184_14 = manager.ui.mainCamera.transform.position - var_184_9.position

				var_184_9.forward = Vector3.New(var_184_14.x, var_184_14.y, var_184_14.z)

				local var_184_15 = var_184_9.localEulerAngles

				var_184_15.z = 0
				var_184_15.x = 0
				var_184_9.localEulerAngles = var_184_15
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 then
				var_184_9.localPosition = Vector3.New(0, 100, 0)

				local var_184_16 = manager.ui.mainCamera.transform.position - var_184_9.position

				var_184_9.forward = Vector3.New(var_184_16.x, var_184_16.y, var_184_16.z)

				local var_184_17 = var_184_9.localEulerAngles

				var_184_17.z = 0
				var_184_17.x = 0
				var_184_9.localEulerAngles = var_184_17
			end

			local var_184_18 = arg_181_1.actors_["10104ui_story"]
			local var_184_19 = 0

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 and not isNil(var_184_18) and arg_181_1.var_.characterEffect10104ui_story == nil then
				arg_181_1.var_.characterEffect10104ui_story = var_184_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_20 = 0.200000002980232

			if var_184_19 <= arg_181_1.time_ and arg_181_1.time_ < var_184_19 + var_184_20 and not isNil(var_184_18) then
				local var_184_21 = (arg_181_1.time_ - var_184_19) / var_184_20

				if arg_181_1.var_.characterEffect10104ui_story and not isNil(var_184_18) then
					arg_181_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_19 + var_184_20 and arg_181_1.time_ < var_184_19 + var_184_20 + arg_184_0 and not isNil(var_184_18) and arg_181_1.var_.characterEffect10104ui_story then
				arg_181_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_184_22 = arg_181_1.actors_["1284ui_story"]
			local var_184_23 = 0

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.characterEffect1284ui_story == nil then
				arg_181_1.var_.characterEffect1284ui_story = var_184_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_24 = 0.200000002980232

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_24 and not isNil(var_184_22) then
				local var_184_25 = (arg_181_1.time_ - var_184_23) / var_184_24

				if arg_181_1.var_.characterEffect1284ui_story and not isNil(var_184_22) then
					local var_184_26 = Mathf.Lerp(0, 0.5, var_184_25)

					arg_181_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1284ui_story.fillRatio = var_184_26
				end
			end

			if arg_181_1.time_ >= var_184_23 + var_184_24 and arg_181_1.time_ < var_184_23 + var_184_24 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.characterEffect1284ui_story then
				local var_184_27 = 0.5

				arg_181_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1284ui_story.fillRatio = var_184_27
			end

			local var_184_28 = 0

			if var_184_28 < arg_181_1.time_ and arg_181_1.time_ <= var_184_28 + arg_184_0 then
				arg_181_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_184_29 = 0

			if var_184_29 < arg_181_1.time_ and arg_181_1.time_ <= var_184_29 + arg_184_0 then
				arg_181_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_184_30 = 0
			local var_184_31 = 0.075

			if var_184_30 < arg_181_1.time_ and arg_181_1.time_ <= var_184_30 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_32 = arg_181_1:FormatText(StoryNameCfg[1030].name)

				arg_181_1.leftNameTxt_.text = var_184_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_33 = arg_181_1:GetWordFromCfg(321022044)
				local var_184_34 = arg_181_1:FormatText(var_184_33.content)

				arg_181_1.text_.text = var_184_34

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_35 = 3
				local var_184_36 = utf8.len(var_184_34)
				local var_184_37 = var_184_35 <= 0 and var_184_31 or var_184_31 * (var_184_36 / var_184_35)

				if var_184_37 > 0 and var_184_31 < var_184_37 then
					arg_181_1.talkMaxDuration = var_184_37

					if var_184_37 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_37 + var_184_30
					end
				end

				arg_181_1.text_.text = var_184_34
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022044", "story_v_out_321022.awb") ~= 0 then
					local var_184_38 = manager.audio:GetVoiceLength("story_v_out_321022", "321022044", "story_v_out_321022.awb") / 1000

					if var_184_38 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_38 + var_184_30
					end

					if var_184_33.prefab_name ~= "" and arg_181_1.actors_[var_184_33.prefab_name] ~= nil then
						local var_184_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_33.prefab_name].transform, "story_v_out_321022", "321022044", "story_v_out_321022.awb")

						arg_181_1:RecordAudio("321022044", var_184_39)
						arg_181_1:RecordAudio("321022044", var_184_39)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321022", "321022044", "story_v_out_321022.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321022", "321022044", "story_v_out_321022.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_40 = math.max(var_184_31, arg_181_1.talkMaxDuration)

			if var_184_30 <= arg_181_1.time_ and arg_181_1.time_ < var_184_30 + var_184_40 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_30) / var_184_40

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_30 + var_184_40 and arg_181_1.time_ < var_184_30 + var_184_40 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_181_1:InitPlayNodeList()
	end,
	Play321022045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321022045
		arg_185_1.duration_ = 6.03

		local var_185_0 = {
			zh = 3.7,
			ja = 6.033
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play321022046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1284ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1284ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1284ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["1284ui_story"]
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1284ui_story == nil then
				arg_185_1.var_.characterEffect1284ui_story = var_188_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_11 = 0.200000002980232

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 and not isNil(var_188_9) then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11

				if arg_185_1.var_.characterEffect1284ui_story and not isNil(var_188_9) then
					arg_185_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1284ui_story then
				arg_185_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_188_13 = arg_185_1.actors_["10104ui_story"]
			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 and not isNil(var_188_13) and arg_185_1.var_.characterEffect10104ui_story == nil then
				arg_185_1.var_.characterEffect10104ui_story = var_188_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_15 = 0.200000002980232

			if var_188_14 <= arg_185_1.time_ and arg_185_1.time_ < var_188_14 + var_188_15 and not isNil(var_188_13) then
				local var_188_16 = (arg_185_1.time_ - var_188_14) / var_188_15

				if arg_185_1.var_.characterEffect10104ui_story and not isNil(var_188_13) then
					local var_188_17 = Mathf.Lerp(0, 0.5, var_188_16)

					arg_185_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10104ui_story.fillRatio = var_188_17
				end
			end

			if arg_185_1.time_ >= var_188_14 + var_188_15 and arg_185_1.time_ < var_188_14 + var_188_15 + arg_188_0 and not isNil(var_188_13) and arg_185_1.var_.characterEffect10104ui_story then
				local var_188_18 = 0.5

				arg_185_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10104ui_story.fillRatio = var_188_18
			end

			local var_188_19 = 0

			if var_188_19 < arg_185_1.time_ and arg_185_1.time_ <= var_188_19 + arg_188_0 then
				arg_185_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284actionlink/1284action428")
			end

			local var_188_20 = 0

			if var_188_20 < arg_185_1.time_ and arg_185_1.time_ <= var_188_20 + arg_188_0 then
				arg_185_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_188_21 = 0
			local var_188_22 = 0.525

			if var_188_21 < arg_185_1.time_ and arg_185_1.time_ <= var_188_21 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_23 = arg_185_1:FormatText(StoryNameCfg[6].name)

				arg_185_1.leftNameTxt_.text = var_188_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_24 = arg_185_1:GetWordFromCfg(321022045)
				local var_188_25 = arg_185_1:FormatText(var_188_24.content)

				arg_185_1.text_.text = var_188_25

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_26 = 21
				local var_188_27 = utf8.len(var_188_25)
				local var_188_28 = var_188_26 <= 0 and var_188_22 or var_188_22 * (var_188_27 / var_188_26)

				if var_188_28 > 0 and var_188_22 < var_188_28 then
					arg_185_1.talkMaxDuration = var_188_28

					if var_188_28 + var_188_21 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_28 + var_188_21
					end
				end

				arg_185_1.text_.text = var_188_25
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022045", "story_v_out_321022.awb") ~= 0 then
					local var_188_29 = manager.audio:GetVoiceLength("story_v_out_321022", "321022045", "story_v_out_321022.awb") / 1000

					if var_188_29 + var_188_21 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_29 + var_188_21
					end

					if var_188_24.prefab_name ~= "" and arg_185_1.actors_[var_188_24.prefab_name] ~= nil then
						local var_188_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_24.prefab_name].transform, "story_v_out_321022", "321022045", "story_v_out_321022.awb")

						arg_185_1:RecordAudio("321022045", var_188_30)
						arg_185_1:RecordAudio("321022045", var_188_30)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_321022", "321022045", "story_v_out_321022.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_321022", "321022045", "story_v_out_321022.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_31 = math.max(var_188_22, arg_185_1.talkMaxDuration)

			if var_188_21 <= arg_185_1.time_ and arg_185_1.time_ < var_188_21 + var_188_31 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_21) / var_188_31

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_21 + var_188_31 and arg_185_1.time_ < var_188_21 + var_188_31 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play321022046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321022046
		arg_189_1.duration_ = 10.6

		local var_189_0 = {
			zh = 7.833,
			ja = 10.6
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
				arg_189_0:Play321022047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10104ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10104ui_story == nil then
				arg_189_1.var_.characterEffect10104ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect10104ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10104ui_story then
				arg_189_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_192_4 = arg_189_1.actors_["1284ui_story"]
			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1284ui_story == nil then
				arg_189_1.var_.characterEffect1284ui_story = var_192_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.200000002980232

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 and not isNil(var_192_4) then
				local var_192_7 = (arg_189_1.time_ - var_192_5) / var_192_6

				if arg_189_1.var_.characterEffect1284ui_story and not isNil(var_192_4) then
					local var_192_8 = Mathf.Lerp(0, 0.5, var_192_7)

					arg_189_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1284ui_story.fillRatio = var_192_8
				end
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1284ui_story then
				local var_192_9 = 0.5

				arg_189_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1284ui_story.fillRatio = var_192_9
			end

			local var_192_10 = 0
			local var_192_11 = 0.9

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_12 = arg_189_1:FormatText(StoryNameCfg[1030].name)

				arg_189_1.leftNameTxt_.text = var_192_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_13 = arg_189_1:GetWordFromCfg(321022046)
				local var_192_14 = arg_189_1:FormatText(var_192_13.content)

				arg_189_1.text_.text = var_192_14

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_15 = 36
				local var_192_16 = utf8.len(var_192_14)
				local var_192_17 = var_192_15 <= 0 and var_192_11 or var_192_11 * (var_192_16 / var_192_15)

				if var_192_17 > 0 and var_192_11 < var_192_17 then
					arg_189_1.talkMaxDuration = var_192_17

					if var_192_17 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_17 + var_192_10
					end
				end

				arg_189_1.text_.text = var_192_14
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022046", "story_v_out_321022.awb") ~= 0 then
					local var_192_18 = manager.audio:GetVoiceLength("story_v_out_321022", "321022046", "story_v_out_321022.awb") / 1000

					if var_192_18 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_18 + var_192_10
					end

					if var_192_13.prefab_name ~= "" and arg_189_1.actors_[var_192_13.prefab_name] ~= nil then
						local var_192_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_13.prefab_name].transform, "story_v_out_321022", "321022046", "story_v_out_321022.awb")

						arg_189_1:RecordAudio("321022046", var_192_19)
						arg_189_1:RecordAudio("321022046", var_192_19)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321022", "321022046", "story_v_out_321022.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321022", "321022046", "story_v_out_321022.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_20 = math.max(var_192_11, arg_189_1.talkMaxDuration)

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_20 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_10) / var_192_20

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_10 + var_192_20 and arg_189_1.time_ < var_192_10 + var_192_20 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play321022047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321022047
		arg_193_1.duration_ = 9.5

		local var_193_0 = {
			zh = 6.066,
			ja = 9.5
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
				arg_193_0:Play321022048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.775

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[1030].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(321022047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022047", "story_v_out_321022.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_321022", "321022047", "story_v_out_321022.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_321022", "321022047", "story_v_out_321022.awb")

						arg_193_1:RecordAudio("321022047", var_196_9)
						arg_193_1:RecordAudio("321022047", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_321022", "321022047", "story_v_out_321022.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_321022", "321022047", "story_v_out_321022.awb")
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
	Play321022048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321022048
		arg_197_1.duration_ = 10.5

		local var_197_0 = {
			zh = 6.433,
			ja = 10.5
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play321022049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10104ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10104ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0.99, -1.12, -5.99)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10104ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = 0

			if var_200_9 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 then
				arg_197_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 then
				arg_197_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_200_11 = 0
			local var_200_12 = 0.8

			if var_200_11 < arg_197_1.time_ and arg_197_1.time_ <= var_200_11 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_13 = arg_197_1:FormatText(StoryNameCfg[1030].name)

				arg_197_1.leftNameTxt_.text = var_200_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_14 = arg_197_1:GetWordFromCfg(321022048)
				local var_200_15 = arg_197_1:FormatText(var_200_14.content)

				arg_197_1.text_.text = var_200_15

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_16 = 32
				local var_200_17 = utf8.len(var_200_15)
				local var_200_18 = var_200_16 <= 0 and var_200_12 or var_200_12 * (var_200_17 / var_200_16)

				if var_200_18 > 0 and var_200_12 < var_200_18 then
					arg_197_1.talkMaxDuration = var_200_18

					if var_200_18 + var_200_11 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_18 + var_200_11
					end
				end

				arg_197_1.text_.text = var_200_15
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022048", "story_v_out_321022.awb") ~= 0 then
					local var_200_19 = manager.audio:GetVoiceLength("story_v_out_321022", "321022048", "story_v_out_321022.awb") / 1000

					if var_200_19 + var_200_11 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_19 + var_200_11
					end

					if var_200_14.prefab_name ~= "" and arg_197_1.actors_[var_200_14.prefab_name] ~= nil then
						local var_200_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_14.prefab_name].transform, "story_v_out_321022", "321022048", "story_v_out_321022.awb")

						arg_197_1:RecordAudio("321022048", var_200_20)
						arg_197_1:RecordAudio("321022048", var_200_20)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321022", "321022048", "story_v_out_321022.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321022", "321022048", "story_v_out_321022.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_21 = math.max(var_200_12, arg_197_1.talkMaxDuration)

			if var_200_11 <= arg_197_1.time_ and arg_197_1.time_ < var_200_11 + var_200_21 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_11) / var_200_21

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_11 + var_200_21 and arg_197_1.time_ < var_200_11 + var_200_21 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play321022049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321022049
		arg_201_1.duration_ = 2.5

		local var_201_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play321022050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1284ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1284ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1284ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = arg_201_1.actors_["1284ui_story"]
			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect1284ui_story == nil then
				arg_201_1.var_.characterEffect1284ui_story = var_204_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_11 = 0.200000002980232

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 and not isNil(var_204_9) then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11

				if arg_201_1.var_.characterEffect1284ui_story and not isNil(var_204_9) then
					arg_201_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect1284ui_story then
				arg_201_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_204_13 = arg_201_1.actors_["10104ui_story"]
			local var_204_14 = 0

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 and not isNil(var_204_13) and arg_201_1.var_.characterEffect10104ui_story == nil then
				arg_201_1.var_.characterEffect10104ui_story = var_204_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_15 = 0.200000002980232

			if var_204_14 <= arg_201_1.time_ and arg_201_1.time_ < var_204_14 + var_204_15 and not isNil(var_204_13) then
				local var_204_16 = (arg_201_1.time_ - var_204_14) / var_204_15

				if arg_201_1.var_.characterEffect10104ui_story and not isNil(var_204_13) then
					local var_204_17 = Mathf.Lerp(0, 0.5, var_204_16)

					arg_201_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10104ui_story.fillRatio = var_204_17
				end
			end

			if arg_201_1.time_ >= var_204_14 + var_204_15 and arg_201_1.time_ < var_204_14 + var_204_15 + arg_204_0 and not isNil(var_204_13) and arg_201_1.var_.characterEffect10104ui_story then
				local var_204_18 = 0.5

				arg_201_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10104ui_story.fillRatio = var_204_18
			end

			local var_204_19 = 0

			if var_204_19 < arg_201_1.time_ and arg_201_1.time_ <= var_204_19 + arg_204_0 then
				arg_201_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_2")
			end

			local var_204_20 = 0

			if var_204_20 < arg_201_1.time_ and arg_201_1.time_ <= var_204_20 + arg_204_0 then
				arg_201_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_204_21 = 0
			local var_204_22 = 0.15

			if var_204_21 < arg_201_1.time_ and arg_201_1.time_ <= var_204_21 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_23 = arg_201_1:FormatText(StoryNameCfg[6].name)

				arg_201_1.leftNameTxt_.text = var_204_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_24 = arg_201_1:GetWordFromCfg(321022049)
				local var_204_25 = arg_201_1:FormatText(var_204_24.content)

				arg_201_1.text_.text = var_204_25

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_26 = 6
				local var_204_27 = utf8.len(var_204_25)
				local var_204_28 = var_204_26 <= 0 and var_204_22 or var_204_22 * (var_204_27 / var_204_26)

				if var_204_28 > 0 and var_204_22 < var_204_28 then
					arg_201_1.talkMaxDuration = var_204_28

					if var_204_28 + var_204_21 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_28 + var_204_21
					end
				end

				arg_201_1.text_.text = var_204_25
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022049", "story_v_out_321022.awb") ~= 0 then
					local var_204_29 = manager.audio:GetVoiceLength("story_v_out_321022", "321022049", "story_v_out_321022.awb") / 1000

					if var_204_29 + var_204_21 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_29 + var_204_21
					end

					if var_204_24.prefab_name ~= "" and arg_201_1.actors_[var_204_24.prefab_name] ~= nil then
						local var_204_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_24.prefab_name].transform, "story_v_out_321022", "321022049", "story_v_out_321022.awb")

						arg_201_1:RecordAudio("321022049", var_204_30)
						arg_201_1:RecordAudio("321022049", var_204_30)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321022", "321022049", "story_v_out_321022.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321022", "321022049", "story_v_out_321022.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_31 = math.max(var_204_22, arg_201_1.talkMaxDuration)

			if var_204_21 <= arg_201_1.time_ and arg_201_1.time_ < var_204_21 + var_204_31 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_21) / var_204_31

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_21 + var_204_31 and arg_201_1.time_ < var_204_21 + var_204_31 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play321022050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321022050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play321022051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10104ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10104ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, 100, 0)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10104ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, 100, 0)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["1284ui_story"].transform
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 then
				arg_205_1.var_.moveOldPos1284ui_story = var_208_9.localPosition
			end

			local var_208_11 = 0.001

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11
				local var_208_13 = Vector3.New(0, 100, 0)

				var_208_9.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1284ui_story, var_208_13, var_208_12)

				local var_208_14 = manager.ui.mainCamera.transform.position - var_208_9.position

				var_208_9.forward = Vector3.New(var_208_14.x, var_208_14.y, var_208_14.z)

				local var_208_15 = var_208_9.localEulerAngles

				var_208_15.z = 0
				var_208_15.x = 0
				var_208_9.localEulerAngles = var_208_15
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 then
				var_208_9.localPosition = Vector3.New(0, 100, 0)

				local var_208_16 = manager.ui.mainCamera.transform.position - var_208_9.position

				var_208_9.forward = Vector3.New(var_208_16.x, var_208_16.y, var_208_16.z)

				local var_208_17 = var_208_9.localEulerAngles

				var_208_17.z = 0
				var_208_17.x = 0
				var_208_9.localEulerAngles = var_208_17
			end

			local var_208_18 = arg_205_1.actors_["1284ui_story"]
			local var_208_19 = 0

			if var_208_19 < arg_205_1.time_ and arg_205_1.time_ <= var_208_19 + arg_208_0 and not isNil(var_208_18) and arg_205_1.var_.characterEffect1284ui_story == nil then
				arg_205_1.var_.characterEffect1284ui_story = var_208_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_20 = 0.200000002980232

			if var_208_19 <= arg_205_1.time_ and arg_205_1.time_ < var_208_19 + var_208_20 and not isNil(var_208_18) then
				local var_208_21 = (arg_205_1.time_ - var_208_19) / var_208_20

				if arg_205_1.var_.characterEffect1284ui_story and not isNil(var_208_18) then
					local var_208_22 = Mathf.Lerp(0, 0.5, var_208_21)

					arg_205_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1284ui_story.fillRatio = var_208_22
				end
			end

			if arg_205_1.time_ >= var_208_19 + var_208_20 and arg_205_1.time_ < var_208_19 + var_208_20 + arg_208_0 and not isNil(var_208_18) and arg_205_1.var_.characterEffect1284ui_story then
				local var_208_23 = 0.5

				arg_205_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1284ui_story.fillRatio = var_208_23
			end

			local var_208_24 = 0
			local var_208_25 = 1.35

			if var_208_24 < arg_205_1.time_ and arg_205_1.time_ <= var_208_24 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_26 = arg_205_1:GetWordFromCfg(321022050)
				local var_208_27 = arg_205_1:FormatText(var_208_26.content)

				arg_205_1.text_.text = var_208_27

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_28 = 54
				local var_208_29 = utf8.len(var_208_27)
				local var_208_30 = var_208_28 <= 0 and var_208_25 or var_208_25 * (var_208_29 / var_208_28)

				if var_208_30 > 0 and var_208_25 < var_208_30 then
					arg_205_1.talkMaxDuration = var_208_30

					if var_208_30 + var_208_24 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_30 + var_208_24
					end
				end

				arg_205_1.text_.text = var_208_27
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_31 = math.max(var_208_25, arg_205_1.talkMaxDuration)

			if var_208_24 <= arg_205_1.time_ and arg_205_1.time_ < var_208_24 + var_208_31 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_24) / var_208_31

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_24 + var_208_31 and arg_205_1.time_ < var_208_24 + var_208_31 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play321022051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321022051
		arg_209_1.duration_ = 7.68

		local var_209_0 = {
			zh = 7.68266666666667,
			ja = 6.84966666666667
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play321022052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = "L08f"

			if arg_209_1.bgs_[var_212_0] == nil then
				local var_212_1 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_212_0)
				var_212_1.name = var_212_0
				var_212_1.transform.parent = arg_209_1.stage_.transform
				var_212_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_[var_212_0] = var_212_1
			end

			local var_212_2 = 1.76666666666667

			if var_212_2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				local var_212_3 = manager.ui.mainCamera.transform.localPosition
				local var_212_4 = Vector3.New(0, 0, 10) + Vector3.New(var_212_3.x, var_212_3.y, 0)
				local var_212_5 = arg_209_1.bgs_.L08f

				var_212_5.transform.localPosition = var_212_4
				var_212_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_6 = var_212_5:GetComponent("SpriteRenderer")

				if var_212_6 and var_212_6.sprite then
					local var_212_7 = (var_212_5.transform.localPosition - var_212_3).z
					local var_212_8 = manager.ui.mainCameraCom_
					local var_212_9 = 2 * var_212_7 * Mathf.Tan(var_212_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_212_10 = var_212_9 * var_212_8.aspect
					local var_212_11 = var_212_6.sprite.bounds.size.x
					local var_212_12 = var_212_6.sprite.bounds.size.y
					local var_212_13 = var_212_10 / var_212_11
					local var_212_14 = var_212_9 / var_212_12
					local var_212_15 = var_212_14 < var_212_13 and var_212_13 or var_212_14

					var_212_5.transform.localScale = Vector3.New(var_212_15, var_212_15, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "L08f" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			local var_212_17 = 0.3

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_18 = 0

			if var_212_18 < arg_209_1.time_ and arg_209_1.time_ <= var_212_18 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_19 = 1.76666666666667

			if var_212_18 <= arg_209_1.time_ and arg_209_1.time_ < var_212_18 + var_212_19 then
				local var_212_20 = (arg_209_1.time_ - var_212_18) / var_212_19
				local var_212_21 = Color.New(0, 0, 0)

				var_212_21.a = Mathf.Lerp(0, 1, var_212_20)
				arg_209_1.mask_.color = var_212_21
			end

			if arg_209_1.time_ >= var_212_18 + var_212_19 and arg_209_1.time_ < var_212_18 + var_212_19 + arg_212_0 then
				local var_212_22 = Color.New(0, 0, 0)

				var_212_22.a = 1
				arg_209_1.mask_.color = var_212_22
			end

			local var_212_23 = 1.76666666666667

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_24 = 2

			if var_212_23 <= arg_209_1.time_ and arg_209_1.time_ < var_212_23 + var_212_24 then
				local var_212_25 = (arg_209_1.time_ - var_212_23) / var_212_24
				local var_212_26 = Color.New(0, 0, 0)

				var_212_26.a = Mathf.Lerp(1, 0, var_212_25)
				arg_209_1.mask_.color = var_212_26
			end

			if arg_209_1.time_ >= var_212_23 + var_212_24 and arg_209_1.time_ < var_212_23 + var_212_24 + arg_212_0 then
				local var_212_27 = Color.New(0, 0, 0)
				local var_212_28 = 0

				arg_209_1.mask_.enabled = false
				var_212_27.a = var_212_28
				arg_209_1.mask_.color = var_212_27
			end

			local var_212_29 = 1.76666666666667
			local var_212_30 = 1

			if var_212_29 < arg_209_1.time_ and arg_209_1.time_ <= var_212_29 + arg_212_0 then
				local var_212_31 = "play"
				local var_212_32 = "effect"

				arg_209_1:AudioAction(var_212_31, var_212_32, "se_story_140", "se_story_140_amb_drain", "")
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_33 = 3.61666666666667
			local var_212_34 = 0.15

			if var_212_33 < arg_209_1.time_ and arg_209_1.time_ <= var_212_33 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_35 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_35:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_36 = arg_209_1:FormatText(StoryNameCfg[184].name)

				arg_209_1.leftNameTxt_.text = var_212_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_37 = arg_209_1:GetWordFromCfg(321022051)
				local var_212_38 = arg_209_1:FormatText(var_212_37.content)

				arg_209_1.text_.text = var_212_38

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_39 = 6
				local var_212_40 = utf8.len(var_212_38)
				local var_212_41 = var_212_39 <= 0 and var_212_34 or var_212_34 * (var_212_40 / var_212_39)

				if var_212_41 > 0 and var_212_34 < var_212_41 then
					arg_209_1.talkMaxDuration = var_212_41
					var_212_33 = var_212_33 + 0.3

					if var_212_41 + var_212_33 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_41 + var_212_33
					end
				end

				arg_209_1.text_.text = var_212_38
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022051", "story_v_out_321022.awb") ~= 0 then
					local var_212_42 = manager.audio:GetVoiceLength("story_v_out_321022", "321022051", "story_v_out_321022.awb") / 1000

					if var_212_42 + var_212_33 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_42 + var_212_33
					end

					if var_212_37.prefab_name ~= "" and arg_209_1.actors_[var_212_37.prefab_name] ~= nil then
						local var_212_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_37.prefab_name].transform, "story_v_out_321022", "321022051", "story_v_out_321022.awb")

						arg_209_1:RecordAudio("321022051", var_212_43)
						arg_209_1:RecordAudio("321022051", var_212_43)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_321022", "321022051", "story_v_out_321022.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_321022", "321022051", "story_v_out_321022.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_44 = var_212_33 + 0.3
			local var_212_45 = math.max(var_212_34, arg_209_1.talkMaxDuration)

			if var_212_44 <= arg_209_1.time_ and arg_209_1.time_ < var_212_44 + var_212_45 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_44) / var_212_45

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_44 + var_212_45 and arg_209_1.time_ < var_212_44 + var_212_45 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play321022052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 321022052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play321022053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 1.625

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_2 = arg_215_1:GetWordFromCfg(321022052)
				local var_218_3 = arg_215_1:FormatText(var_218_2.content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 65
				local var_218_5 = utf8.len(var_218_3)
				local var_218_6 = var_218_4 <= 0 and var_218_1 or var_218_1 * (var_218_5 / var_218_4)

				if var_218_6 > 0 and var_218_1 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_7 and arg_215_1.time_ < var_218_0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play321022053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 321022053
		arg_219_1.duration_ = 6.07

		local var_219_0 = {
			zh = 5,
			ja = 6.066
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
				arg_219_0:Play321022054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.325

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[184].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(321022053)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 13
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022053", "story_v_out_321022.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_321022", "321022053", "story_v_out_321022.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_321022", "321022053", "story_v_out_321022.awb")

						arg_219_1:RecordAudio("321022053", var_222_9)
						arg_219_1:RecordAudio("321022053", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_321022", "321022053", "story_v_out_321022.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_321022", "321022053", "story_v_out_321022.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play321022054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 321022054
		arg_223_1.duration_ = 7.87

		local var_223_0 = {
			zh = 6.466,
			ja = 7.866
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
				arg_223_0:Play321022055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.725

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[184].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(321022054)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 29
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022054", "story_v_out_321022.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_321022", "321022054", "story_v_out_321022.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_321022", "321022054", "story_v_out_321022.awb")

						arg_223_1:RecordAudio("321022054", var_226_9)
						arg_223_1:RecordAudio("321022054", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_321022", "321022054", "story_v_out_321022.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_321022", "321022054", "story_v_out_321022.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_10 and arg_223_1.time_ < var_226_0 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play321022055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 321022055
		arg_227_1.duration_ = 8.9

		local var_227_0 = {
			zh = 7.433,
			ja = 8.9
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
				arg_227_0:Play321022056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.65

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[184].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(321022055)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 26
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022055", "story_v_out_321022.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_321022", "321022055", "story_v_out_321022.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_321022", "321022055", "story_v_out_321022.awb")

						arg_227_1:RecordAudio("321022055", var_230_9)
						arg_227_1:RecordAudio("321022055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_321022", "321022055", "story_v_out_321022.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_321022", "321022055", "story_v_out_321022.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play321022056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 321022056
		arg_231_1.duration_ = 12.7

		local var_231_0 = {
			zh = 12.266,
			ja = 12.7
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
				arg_231_0:Play321022057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.775

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[184].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(321022056)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022056", "story_v_out_321022.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_321022", "321022056", "story_v_out_321022.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_321022", "321022056", "story_v_out_321022.awb")

						arg_231_1:RecordAudio("321022056", var_234_9)
						arg_231_1:RecordAudio("321022056", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_321022", "321022056", "story_v_out_321022.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_321022", "321022056", "story_v_out_321022.awb")
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
	Play321022057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 321022057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play321022058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 1.45

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(321022057)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 58
				local var_238_5 = utf8.len(var_238_3)
				local var_238_6 = var_238_4 <= 0 and var_238_1 or var_238_1 * (var_238_5 / var_238_4)

				if var_238_6 > 0 and var_238_1 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_7 and arg_235_1.time_ < var_238_0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play321022058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 321022058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play321022059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.675

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(321022058)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 27
				local var_242_5 = utf8.len(var_242_3)
				local var_242_6 = var_242_4 <= 0 and var_242_1 or var_242_1 * (var_242_5 / var_242_4)

				if var_242_6 > 0 and var_242_1 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_7 and arg_239_1.time_ < var_242_0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play321022059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 321022059
		arg_243_1.duration_ = 9

		local var_243_0 = {
			zh = 6.333,
			ja = 9
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play321022060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.8

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[184].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(321022059)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 32
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022059", "story_v_out_321022.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_321022", "321022059", "story_v_out_321022.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_321022", "321022059", "story_v_out_321022.awb")

						arg_243_1:RecordAudio("321022059", var_246_9)
						arg_243_1:RecordAudio("321022059", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_321022", "321022059", "story_v_out_321022.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_321022", "321022059", "story_v_out_321022.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play321022060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 321022060
		arg_247_1.duration_ = 8

		local var_247_0 = {
			zh = 8,
			ja = 7.733
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
				arg_247_0:Play321022061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.7

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[184].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(321022060)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022060", "story_v_out_321022.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_321022", "321022060", "story_v_out_321022.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_321022", "321022060", "story_v_out_321022.awb")

						arg_247_1:RecordAudio("321022060", var_250_9)
						arg_247_1:RecordAudio("321022060", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_321022", "321022060", "story_v_out_321022.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_321022", "321022060", "story_v_out_321022.awb")
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
	Play321022061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 321022061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play321022062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 1.325

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(321022061)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 53
				local var_254_5 = utf8.len(var_254_3)
				local var_254_6 = var_254_4 <= 0 and var_254_1 or var_254_1 * (var_254_5 / var_254_4)

				if var_254_6 > 0 and var_254_1 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_7 and arg_251_1.time_ < var_254_0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play321022062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 321022062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play321022063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.426197500200942
			local var_258_1 = 1

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				local var_258_2 = "play"
				local var_258_3 = "effect"

				arg_255_1:AudioAction(var_258_2, var_258_3, "se_story_16", "se_story_16_whoosh", "")
			end

			local var_258_4 = 0
			local var_258_5 = 1.25

			if var_258_4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:GetWordFromCfg(321022062)
				local var_258_7 = arg_255_1:FormatText(var_258_6.content)

				arg_255_1.text_.text = var_258_7

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_8 = 50
				local var_258_9 = utf8.len(var_258_7)
				local var_258_10 = var_258_8 <= 0 and var_258_5 or var_258_5 * (var_258_9 / var_258_8)

				if var_258_10 > 0 and var_258_5 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_7
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_11 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_11 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_11

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_11 and arg_255_1.time_ < var_258_4 + var_258_11 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play321022063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 321022063
		arg_259_1.duration_ = 1

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"

			SetActive(arg_259_1.choicesGo_, true)

			for iter_260_0, iter_260_1 in ipairs(arg_259_1.choices_) do
				local var_260_0 = iter_260_0 <= 2

				SetActive(iter_260_1.go, var_260_0)
			end

			arg_259_1.choices_[1].txt.text = arg_259_1:FormatText(StoryChoiceCfg[1251].name)
			arg_259_1.choices_[2].txt.text = arg_259_1:FormatText(StoryChoiceCfg[1252].name)
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play321022064(arg_259_1)
			end

			if arg_261_0 == 2 then
				arg_259_0:Play321022064(arg_259_1)
			end

			arg_259_1:RecordChoiceLog(321022063, 1251, 1252)
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			return
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play321022064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 321022064
		arg_263_1.duration_ = 5.49

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
			arg_263_1.auto_ = false
		end

		function arg_263_1.playNext_(arg_265_0)
			arg_263_1.onStoryFinished_()
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 1

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				local var_266_2 = "play"
				local var_266_3 = "effect"

				arg_263_1:AudioAction(var_266_2, var_266_3, "se_story_140", "se_story_140_hit", "")
			end

			local var_266_4 = 0
			local var_266_5 = 0.2

			if var_266_4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				local var_266_6 = "play"
				local var_266_7 = "music"

				arg_263_1:AudioAction(var_266_6, var_266_7, "ui_battle", "ui_battle_stopbgm", "")

				local var_266_8 = ""
				local var_266_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_266_9 ~= "" then
					if arg_263_1.bgmTxt_.text ~= var_266_9 and arg_263_1.bgmTxt_.text ~= "" then
						if arg_263_1.bgmTxt2_.text ~= "" then
							arg_263_1.bgmTxt_.text = arg_263_1.bgmTxt2_.text
						end

						arg_263_1.bgmTxt2_.text = var_266_9

						arg_263_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_263_1.bgmTxt_.text = var_266_9
						arg_263_1.bgmTxt2_.text = var_266_9
					end

					if arg_263_1.bgmTimer then
						arg_263_1.bgmTimer:Stop()

						arg_263_1.bgmTimer = nil
					end

					if arg_263_1.settingData.show_music_name == 1 then
						arg_263_1.musicController:SetSelectedState("show")
						arg_263_1.musicAnimator_:Play("open", 0, 0)

						if arg_263_1.settingData.music_time ~= 0 then
							arg_263_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_263_1.settingData.music_time), function()
								if arg_263_1 == nil or isNil(arg_263_1.bgmTxt_) then
									return
								end

								arg_263_1.musicController:SetSelectedState("hide")
								arg_263_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_266_10 = manager.ui.mainCamera.transform
			local var_266_11 = 0

			if var_266_11 < arg_263_1.time_ and arg_263_1.time_ <= var_266_11 + arg_266_0 then
				arg_263_1.var_.shakeOldPos = var_266_10.localPosition
			end

			local var_266_12 = 0.833333333333333

			if var_266_11 <= arg_263_1.time_ and arg_263_1.time_ < var_266_11 + var_266_12 then
				local var_266_13 = (arg_263_1.time_ - var_266_11) / 0.066
				local var_266_14, var_266_15 = math.modf(var_266_13)

				var_266_10.localPosition = Vector3.New(var_266_15 * 0.13, var_266_15 * 0.13, var_266_15 * 0.13) + arg_263_1.var_.shakeOldPos
			end

			if arg_263_1.time_ >= var_266_11 + var_266_12 and arg_263_1.time_ < var_266_11 + var_266_12 + arg_266_0 then
				var_266_10.localPosition = arg_263_1.var_.shakeOldPos
			end

			local var_266_16 = 0

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			local var_266_17 = 0.566666666666667

			if arg_263_1.time_ >= var_266_16 + var_266_17 and arg_263_1.time_ < var_266_16 + var_266_17 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_18 = 0.491666666666667
			local var_266_19 = 0.075

			if var_266_18 < arg_263_1.time_ and arg_263_1.time_ <= var_266_18 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_20 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_20:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_263_1.dialogCg_.alpha = arg_268_0
				end))
				var_266_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_21 = arg_263_1:GetWordFromCfg(321022064)
				local var_266_22 = arg_263_1:FormatText(var_266_21.content)

				arg_263_1.text_.text = var_266_22

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_23 = 3
				local var_266_24 = utf8.len(var_266_22)
				local var_266_25 = var_266_23 <= 0 and var_266_19 or var_266_19 * (var_266_24 / var_266_23)

				if var_266_25 > 0 and var_266_19 < var_266_25 then
					arg_263_1.talkMaxDuration = var_266_25
					var_266_18 = var_266_18 + 0.3

					if var_266_25 + var_266_18 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_25 + var_266_18
					end
				end

				arg_263_1.text_.text = var_266_22
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_26 = var_266_18 + 0.3
			local var_266_27 = math.max(var_266_19, arg_263_1.talkMaxDuration)

			if var_266_26 <= arg_263_1.time_ and arg_263_1.time_ < var_266_26 + var_266_27 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_26) / var_266_27

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_26 + var_266_27 and arg_263_1.time_ < var_266_26 + var_266_27 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L13g",
		"TextureConfig/Background/ST0506",
		"TextureConfig/Background/L08f"
	},
	voices = {
		"story_v_out_321022.awb"
	}
}
