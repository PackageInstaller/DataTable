return {
	Play426051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play426051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2007a"

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
				local var_4_5 = arg_1_1.bgs_.ST2007a

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
					if iter_4_0 ~= "ST2007a" then
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

			local var_4_24 = 0
			local var_4_25 = 0.3

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_30 = 0.433333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 0.166666666666667
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 0.75

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_43 = arg_1_1:GetWordFromCfg(426051001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 30
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_41 or var_4_41 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_41 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_40 = var_4_40 + 0.3

					if var_4_47 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_40 + 0.3
			local var_4_49 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play426051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 426051002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play426051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.975

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

				local var_12_2 = arg_9_1:GetWordFromCfg(426051002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 39
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
	Play426051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 426051003
		arg_13_1.duration_ = 9.17

		local var_13_0 = {
			zh = 9.166,
			ja = 7.666
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
				arg_13_0:Play426051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "6148ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["6148ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos6148ui_story = var_16_5.localPosition

				local var_16_7 = GameObjectTools.GetOrAddComponent(var_16_5.gameObject, typeof(DynamicBoneHelper))

				if var_16_7 then
					var_16_7:EnableDynamicBone(false)
				end
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(0, -0.985, -6)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos6148ui_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_5.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_5.localEulerAngles = var_16_14

				local var_16_15 = GameObjectTools.GetOrAddComponent(var_16_5.gameObject, typeof(DynamicBoneHelper))

				if var_16_15 then
					var_16_15:EnableDynamicBone(true)
				end
			end

			local var_16_16 = arg_13_1.actors_["6148ui_story"]
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect6148ui_story == nil then
				arg_13_1.var_.characterEffect6148ui_story = var_16_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_18 = 0.200000002980232

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_18 and not isNil(var_16_16) then
				local var_16_19 = (arg_13_1.time_ - var_16_17) / var_16_18

				if arg_13_1.var_.characterEffect6148ui_story and not isNil(var_16_16) then
					arg_13_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_17 + var_16_18 and arg_13_1.time_ < var_16_17 + var_16_18 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect6148ui_story then
				arg_13_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_16_22 = 0
			local var_16_23 = 0.8

			if var_16_22 < arg_13_1.time_ and arg_13_1.time_ <= var_16_22 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_24 = arg_13_1:FormatText(StoryNameCfg[1488].name)

				arg_13_1.leftNameTxt_.text = var_16_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_25 = arg_13_1:GetWordFromCfg(426051003)
				local var_16_26 = arg_13_1:FormatText(var_16_25.content)

				arg_13_1.text_.text = var_16_26

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_27 = 32
				local var_16_28 = utf8.len(var_16_26)
				local var_16_29 = var_16_27 <= 0 and var_16_23 or var_16_23 * (var_16_28 / var_16_27)

				if var_16_29 > 0 and var_16_23 < var_16_29 then
					arg_13_1.talkMaxDuration = var_16_29

					if var_16_29 + var_16_22 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_29 + var_16_22
					end
				end

				arg_13_1.text_.text = var_16_26
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051003", "story_v_out_426051.awb") ~= 0 then
					local var_16_30 = manager.audio:GetVoiceLength("story_v_out_426051", "426051003", "story_v_out_426051.awb") / 1000

					if var_16_30 + var_16_22 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_30 + var_16_22
					end

					if var_16_25.prefab_name ~= "" and arg_13_1.actors_[var_16_25.prefab_name] ~= nil then
						local var_16_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_25.prefab_name].transform, "story_v_out_426051", "426051003", "story_v_out_426051.awb")

						arg_13_1:RecordAudio("426051003", var_16_31)
						arg_13_1:RecordAudio("426051003", var_16_31)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_426051", "426051003", "story_v_out_426051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_426051", "426051003", "story_v_out_426051.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_32 = math.max(var_16_23, arg_13_1.talkMaxDuration)

			if var_16_22 <= arg_13_1.time_ and arg_13_1.time_ < var_16_22 + var_16_32 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_22) / var_16_32

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_22 + var_16_32 and arg_13_1.time_ < var_16_22 + var_16_32 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play426051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 426051004
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"

			SetActive(arg_17_1.choicesGo_, true)

			for iter_18_0, iter_18_1 in ipairs(arg_17_1.choices_) do
				local var_18_0 = iter_18_0 <= 2

				SetActive(iter_18_1.go, var_18_0)
			end

			arg_17_1.choices_[1].txt.text = arg_17_1:FormatText(StoryChoiceCfg[1603].name)
			arg_17_1.choices_[2].txt.text = arg_17_1:FormatText(StoryChoiceCfg[1604].name)
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play426051005(arg_17_1)
			end

			if arg_19_0 == 2 then
				arg_17_0:Play426051005(arg_17_1)
			end

			arg_17_1:RecordChoiceLog(426051004, 1603, 1604)
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["6148ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect6148ui_story == nil then
				arg_17_1.var_.characterEffect6148ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect6148ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_17_1.var_.characterEffect6148ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect6148ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_17_1.var_.characterEffect6148ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			local var_20_7 = 0.6

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play426051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 426051005
		arg_21_1.duration_ = 3.23

		local var_21_0 = {
			zh = 3.233,
			ja = 2.233
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
				arg_21_0:Play426051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["6148ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos6148ui_story = var_24_0.localPosition

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0.gameObject, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end
			end

			local var_24_3 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_3 then
				local var_24_4 = (arg_21_1.time_ - var_24_1) / var_24_3
				local var_24_5 = Vector3.New(0, -0.985, -6)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos6148ui_story, var_24_5, var_24_4)

				local var_24_6 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_6.x, var_24_6.y, var_24_6.z)

				local var_24_7 = var_24_0.localEulerAngles

				var_24_7.z = 0
				var_24_7.x = 0
				var_24_0.localEulerAngles = var_24_7
			end

			if arg_21_1.time_ >= var_24_1 + var_24_3 and arg_21_1.time_ < var_24_1 + var_24_3 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_24_8 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_8.x, var_24_8.y, var_24_8.z)

				local var_24_9 = var_24_0.localEulerAngles

				var_24_9.z = 0
				var_24_9.x = 0
				var_24_0.localEulerAngles = var_24_9

				local var_24_10 = GameObjectTools.GetOrAddComponent(var_24_0.gameObject, typeof(DynamicBoneHelper))

				if var_24_10 then
					var_24_10:EnableDynamicBone(true)
				end
			end

			local var_24_11 = arg_21_1.actors_["6148ui_story"]
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.characterEffect6148ui_story == nil then
				arg_21_1.var_.characterEffect6148ui_story = var_24_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_13 = 0.200000002980232

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_13 and not isNil(var_24_11) then
				local var_24_14 = (arg_21_1.time_ - var_24_12) / var_24_13

				if arg_21_1.var_.characterEffect6148ui_story and not isNil(var_24_11) then
					arg_21_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_12 + var_24_13 and arg_21_1.time_ < var_24_12 + var_24_13 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.characterEffect6148ui_story then
				arg_21_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_24_15 = "6148ui_story"

			if arg_21_1.actors_[var_24_15] == nil then
				local var_24_16 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_24_16) then
					local var_24_17 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_21_1.stage_.transform)

					var_24_17.name = var_24_15
					var_24_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_15] = var_24_17

					local var_24_18 = var_24_17:GetComponentInChildren(typeof(CharacterEffect))

					var_24_18.enabled = true

					local var_24_19 = GameObjectTools.GetOrAddComponent(var_24_17, typeof(DynamicBoneHelper))

					if var_24_19 then
						var_24_19:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_18.transform, false)

					arg_21_1.var_[var_24_15 .. "Animator"] = var_24_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_15 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_15 .. "LipSync"] = var_24_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_20 = 0

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_24_21 = "6148ui_story"

			if arg_21_1.actors_[var_24_21] == nil then
				local var_24_22 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_24_22) then
					local var_24_23 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_21_1.stage_.transform)

					var_24_23.name = var_24_21
					var_24_23.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_21] = var_24_23

					local var_24_24 = var_24_23:GetComponentInChildren(typeof(CharacterEffect))

					var_24_24.enabled = true

					local var_24_25 = GameObjectTools.GetOrAddComponent(var_24_23, typeof(DynamicBoneHelper))

					if var_24_25 then
						var_24_25:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_24.transform, false)

					arg_21_1.var_[var_24_21 .. "Animator"] = var_24_24.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_21 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_21 .. "LipSync"] = var_24_24.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_26 = 0

			if var_24_26 < arg_21_1.time_ and arg_21_1.time_ <= var_24_26 + arg_24_0 then
				arg_21_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_24_27 = 0
			local var_24_28 = 0.25

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_29 = arg_21_1:FormatText(StoryNameCfg[1488].name)

				arg_21_1.leftNameTxt_.text = var_24_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_30 = arg_21_1:GetWordFromCfg(426051005)
				local var_24_31 = arg_21_1:FormatText(var_24_30.content)

				arg_21_1.text_.text = var_24_31

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_32 = 10
				local var_24_33 = utf8.len(var_24_31)
				local var_24_34 = var_24_32 <= 0 and var_24_28 or var_24_28 * (var_24_33 / var_24_32)

				if var_24_34 > 0 and var_24_28 < var_24_34 then
					arg_21_1.talkMaxDuration = var_24_34

					if var_24_34 + var_24_27 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_34 + var_24_27
					end
				end

				arg_21_1.text_.text = var_24_31
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051005", "story_v_out_426051.awb") ~= 0 then
					local var_24_35 = manager.audio:GetVoiceLength("story_v_out_426051", "426051005", "story_v_out_426051.awb") / 1000

					if var_24_35 + var_24_27 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_35 + var_24_27
					end

					if var_24_30.prefab_name ~= "" and arg_21_1.actors_[var_24_30.prefab_name] ~= nil then
						local var_24_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_30.prefab_name].transform, "story_v_out_426051", "426051005", "story_v_out_426051.awb")

						arg_21_1:RecordAudio("426051005", var_24_36)
						arg_21_1:RecordAudio("426051005", var_24_36)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_426051", "426051005", "story_v_out_426051.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_426051", "426051005", "story_v_out_426051.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_37 = math.max(var_24_28, arg_21_1.talkMaxDuration)

			if var_24_27 <= arg_21_1.time_ and arg_21_1.time_ < var_24_27 + var_24_37 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_27) / var_24_37

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_27 + var_24_37 and arg_21_1.time_ < var_24_27 + var_24_37 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play426051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 426051006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play426051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["6148ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect6148ui_story == nil then
				arg_25_1.var_.characterEffect6148ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect6148ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_25_1.var_.characterEffect6148ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect6148ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_25_1.var_.characterEffect6148ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.7

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(426051006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 28
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play426051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 426051007
		arg_29_1.duration_ = 7.17

		local var_29_0 = {
			zh = 7.166,
			ja = 6.333
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
				arg_29_0:Play426051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["6148ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos6148ui_story = var_32_0.localPosition

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0.gameObject, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end
			end

			local var_32_3 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_3 then
				local var_32_4 = (arg_29_1.time_ - var_32_1) / var_32_3
				local var_32_5 = Vector3.New(0, -0.985, -6)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos6148ui_story, var_32_5, var_32_4)

				local var_32_6 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_6.x, var_32_6.y, var_32_6.z)

				local var_32_7 = var_32_0.localEulerAngles

				var_32_7.z = 0
				var_32_7.x = 0
				var_32_0.localEulerAngles = var_32_7
			end

			if arg_29_1.time_ >= var_32_1 + var_32_3 and arg_29_1.time_ < var_32_1 + var_32_3 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_32_8 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_8.x, var_32_8.y, var_32_8.z)

				local var_32_9 = var_32_0.localEulerAngles

				var_32_9.z = 0
				var_32_9.x = 0
				var_32_0.localEulerAngles = var_32_9

				local var_32_10 = GameObjectTools.GetOrAddComponent(var_32_0.gameObject, typeof(DynamicBoneHelper))

				if var_32_10 then
					var_32_10:EnableDynamicBone(true)
				end
			end

			local var_32_11 = arg_29_1.actors_["6148ui_story"]
			local var_32_12 = 0

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.characterEffect6148ui_story == nil then
				arg_29_1.var_.characterEffect6148ui_story = var_32_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_13 = 0.200000002980232

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_13 and not isNil(var_32_11) then
				local var_32_14 = (arg_29_1.time_ - var_32_12) / var_32_13

				if arg_29_1.var_.characterEffect6148ui_story and not isNil(var_32_11) then
					arg_29_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_12 + var_32_13 and arg_29_1.time_ < var_32_12 + var_32_13 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.characterEffect6148ui_story then
				arg_29_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_32_17 = 0
			local var_32_18 = 0.675

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_19 = arg_29_1:FormatText(StoryNameCfg[1488].name)

				arg_29_1.leftNameTxt_.text = var_32_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_20 = arg_29_1:GetWordFromCfg(426051007)
				local var_32_21 = arg_29_1:FormatText(var_32_20.content)

				arg_29_1.text_.text = var_32_21

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_22 = 27
				local var_32_23 = utf8.len(var_32_21)
				local var_32_24 = var_32_22 <= 0 and var_32_18 or var_32_18 * (var_32_23 / var_32_22)

				if var_32_24 > 0 and var_32_18 < var_32_24 then
					arg_29_1.talkMaxDuration = var_32_24

					if var_32_24 + var_32_17 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_17
					end
				end

				arg_29_1.text_.text = var_32_21
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051007", "story_v_out_426051.awb") ~= 0 then
					local var_32_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051007", "story_v_out_426051.awb") / 1000

					if var_32_25 + var_32_17 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_25 + var_32_17
					end

					if var_32_20.prefab_name ~= "" and arg_29_1.actors_[var_32_20.prefab_name] ~= nil then
						local var_32_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_20.prefab_name].transform, "story_v_out_426051", "426051007", "story_v_out_426051.awb")

						arg_29_1:RecordAudio("426051007", var_32_26)
						arg_29_1:RecordAudio("426051007", var_32_26)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_426051", "426051007", "story_v_out_426051.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_426051", "426051007", "story_v_out_426051.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_27 = math.max(var_32_18, arg_29_1.talkMaxDuration)

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_27 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_17) / var_32_27

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_17 + var_32_27 and arg_29_1.time_ < var_32_17 + var_32_27 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play426051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 426051008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play426051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["6148ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect6148ui_story == nil then
				arg_33_1.var_.characterEffect6148ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect6148ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_33_1.var_.characterEffect6148ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect6148ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_33_1.var_.characterEffect6148ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.725

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(426051008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 29
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play426051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 426051009
		arg_37_1.duration_ = 7.1

		local var_37_0 = {
			zh = 7.1,
			ja = 6.266
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
				arg_37_0:Play426051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["6148ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect6148ui_story == nil then
				arg_37_1.var_.characterEffect6148ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect6148ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect6148ui_story then
				arg_37_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_40_5 = 0
			local var_40_6 = 0.6

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_7 = arg_37_1:FormatText(StoryNameCfg[1488].name)

				arg_37_1.leftNameTxt_.text = var_40_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(426051009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 24
				local var_40_11 = utf8.len(var_40_9)
				local var_40_12 = var_40_10 <= 0 and var_40_6 or var_40_6 * (var_40_11 / var_40_10)

				if var_40_12 > 0 and var_40_6 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12

					if var_40_12 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051009", "story_v_out_426051.awb") ~= 0 then
					local var_40_13 = manager.audio:GetVoiceLength("story_v_out_426051", "426051009", "story_v_out_426051.awb") / 1000

					if var_40_13 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_5
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_426051", "426051009", "story_v_out_426051.awb")

						arg_37_1:RecordAudio("426051009", var_40_14)
						arg_37_1:RecordAudio("426051009", var_40_14)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_426051", "426051009", "story_v_out_426051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_426051", "426051009", "story_v_out_426051.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_15 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_15 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_15

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_15 and arg_37_1.time_ < var_40_5 + var_40_15 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play426051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 426051010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play426051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["6148ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect6148ui_story == nil then
				arg_41_1.var_.characterEffect6148ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect6148ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_41_1.var_.characterEffect6148ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect6148ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_41_1.var_.characterEffect6148ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.65

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

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(426051010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 26
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
	Play426051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 426051011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play426051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.75

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

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(426051011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 30
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
	Play426051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 426051012
		arg_49_1.duration_ = 4.87

		local var_49_0 = {
			zh = 4.866,
			ja = 2.9
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
				arg_49_0:Play426051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["6148ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos6148ui_story = var_52_0.localPosition

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0.gameObject, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end
			end

			local var_52_3 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_3 then
				local var_52_4 = (arg_49_1.time_ - var_52_1) / var_52_3
				local var_52_5 = Vector3.New(0, -0.985, -6)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos6148ui_story, var_52_5, var_52_4)

				local var_52_6 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_6.x, var_52_6.y, var_52_6.z)

				local var_52_7 = var_52_0.localEulerAngles

				var_52_7.z = 0
				var_52_7.x = 0
				var_52_0.localEulerAngles = var_52_7
			end

			if arg_49_1.time_ >= var_52_1 + var_52_3 and arg_49_1.time_ < var_52_1 + var_52_3 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_52_8 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_8.x, var_52_8.y, var_52_8.z)

				local var_52_9 = var_52_0.localEulerAngles

				var_52_9.z = 0
				var_52_9.x = 0
				var_52_0.localEulerAngles = var_52_9

				local var_52_10 = GameObjectTools.GetOrAddComponent(var_52_0.gameObject, typeof(DynamicBoneHelper))

				if var_52_10 then
					var_52_10:EnableDynamicBone(true)
				end
			end

			local var_52_11 = arg_49_1.actors_["6148ui_story"]
			local var_52_12 = 0

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 and not isNil(var_52_11) and arg_49_1.var_.characterEffect6148ui_story == nil then
				arg_49_1.var_.characterEffect6148ui_story = var_52_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_13 = 0.200000002980232

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_13 and not isNil(var_52_11) then
				local var_52_14 = (arg_49_1.time_ - var_52_12) / var_52_13

				if arg_49_1.var_.characterEffect6148ui_story and not isNil(var_52_11) then
					arg_49_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_12 + var_52_13 and arg_49_1.time_ < var_52_12 + var_52_13 + arg_52_0 and not isNil(var_52_11) and arg_49_1.var_.characterEffect6148ui_story then
				arg_49_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_52_15 = 0

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_52_17 = 0
			local var_52_18 = 0.55

			if var_52_17 < arg_49_1.time_ and arg_49_1.time_ <= var_52_17 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_19 = arg_49_1:FormatText(StoryNameCfg[1488].name)

				arg_49_1.leftNameTxt_.text = var_52_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_20 = arg_49_1:GetWordFromCfg(426051012)
				local var_52_21 = arg_49_1:FormatText(var_52_20.content)

				arg_49_1.text_.text = var_52_21

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_22 = 22
				local var_52_23 = utf8.len(var_52_21)
				local var_52_24 = var_52_22 <= 0 and var_52_18 or var_52_18 * (var_52_23 / var_52_22)

				if var_52_24 > 0 and var_52_18 < var_52_24 then
					arg_49_1.talkMaxDuration = var_52_24

					if var_52_24 + var_52_17 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_24 + var_52_17
					end
				end

				arg_49_1.text_.text = var_52_21
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051012", "story_v_out_426051.awb") ~= 0 then
					local var_52_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051012", "story_v_out_426051.awb") / 1000

					if var_52_25 + var_52_17 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_25 + var_52_17
					end

					if var_52_20.prefab_name ~= "" and arg_49_1.actors_[var_52_20.prefab_name] ~= nil then
						local var_52_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_20.prefab_name].transform, "story_v_out_426051", "426051012", "story_v_out_426051.awb")

						arg_49_1:RecordAudio("426051012", var_52_26)
						arg_49_1:RecordAudio("426051012", var_52_26)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_426051", "426051012", "story_v_out_426051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_426051", "426051012", "story_v_out_426051.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_27 = math.max(var_52_18, arg_49_1.talkMaxDuration)

			if var_52_17 <= arg_49_1.time_ and arg_49_1.time_ < var_52_17 + var_52_27 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_17) / var_52_27

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_17 + var_52_27 and arg_49_1.time_ < var_52_17 + var_52_27 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play426051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 426051013
		arg_53_1.duration_ = 11.87

		local var_53_0 = {
			zh = 8.7,
			ja = 11.866
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
				arg_53_0:Play426051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "1054ui_story"

			if arg_53_1.actors_[var_56_0] == nil then
				local var_56_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_56_1) then
					local var_56_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_53_1.stage_.transform)

					var_56_2.name = var_56_0
					var_56_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_53_1.actors_[var_56_0] = var_56_2

					local var_56_3 = var_56_2:GetComponentInChildren(typeof(CharacterEffect))

					var_56_3.enabled = true

					local var_56_4 = GameObjectTools.GetOrAddComponent(var_56_2, typeof(DynamicBoneHelper))

					if var_56_4 then
						var_56_4:EnableDynamicBone(false)
					end

					arg_53_1:ShowWeapon(var_56_3.transform, false)

					arg_53_1.var_[var_56_0 .. "Animator"] = var_56_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_53_1.var_[var_56_0 .. "Animator"].applyRootMotion = true
					arg_53_1.var_[var_56_0 .. "LipSync"] = var_56_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_56_5 = arg_53_1.actors_["1054ui_story"].transform
			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.var_.moveOldPos1054ui_story = var_56_5.localPosition

				local var_56_7 = GameObjectTools.GetOrAddComponent(var_56_5.gameObject, typeof(DynamicBoneHelper))

				if var_56_7 then
					var_56_7:EnableDynamicBone(false)
				end
			end

			local var_56_8 = 0.001

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_8 then
				local var_56_9 = (arg_53_1.time_ - var_56_6) / var_56_8
				local var_56_10 = Vector3.New(0.7, -0.985, -6)

				var_56_5.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1054ui_story, var_56_10, var_56_9)

				local var_56_11 = manager.ui.mainCamera.transform.position - var_56_5.position

				var_56_5.forward = Vector3.New(var_56_11.x, var_56_11.y, var_56_11.z)

				local var_56_12 = var_56_5.localEulerAngles

				var_56_12.z = 0
				var_56_12.x = 0
				var_56_5.localEulerAngles = var_56_12
			end

			if arg_53_1.time_ >= var_56_6 + var_56_8 and arg_53_1.time_ < var_56_6 + var_56_8 + arg_56_0 then
				var_56_5.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_56_13 = manager.ui.mainCamera.transform.position - var_56_5.position

				var_56_5.forward = Vector3.New(var_56_13.x, var_56_13.y, var_56_13.z)

				local var_56_14 = var_56_5.localEulerAngles

				var_56_14.z = 0
				var_56_14.x = 0
				var_56_5.localEulerAngles = var_56_14

				local var_56_15 = GameObjectTools.GetOrAddComponent(var_56_5.gameObject, typeof(DynamicBoneHelper))

				if var_56_15 then
					var_56_15:EnableDynamicBone(true)
				end
			end

			local var_56_16 = arg_53_1.actors_["6148ui_story"].transform
			local var_56_17 = 0

			if var_56_17 < arg_53_1.time_ and arg_53_1.time_ <= var_56_17 + arg_56_0 then
				arg_53_1.var_.moveOldPos6148ui_story = var_56_16.localPosition

				local var_56_18 = GameObjectTools.GetOrAddComponent(var_56_16.gameObject, typeof(DynamicBoneHelper))

				if var_56_18 then
					var_56_18:EnableDynamicBone(false)
				end
			end

			local var_56_19 = 0.001

			if var_56_17 <= arg_53_1.time_ and arg_53_1.time_ < var_56_17 + var_56_19 then
				local var_56_20 = (arg_53_1.time_ - var_56_17) / var_56_19
				local var_56_21 = Vector3.New(-0.7, -0.985, -6)

				var_56_16.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos6148ui_story, var_56_21, var_56_20)

				local var_56_22 = manager.ui.mainCamera.transform.position - var_56_16.position

				var_56_16.forward = Vector3.New(var_56_22.x, var_56_22.y, var_56_22.z)

				local var_56_23 = var_56_16.localEulerAngles

				var_56_23.z = 0
				var_56_23.x = 0
				var_56_16.localEulerAngles = var_56_23
			end

			if arg_53_1.time_ >= var_56_17 + var_56_19 and arg_53_1.time_ < var_56_17 + var_56_19 + arg_56_0 then
				var_56_16.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_56_24 = manager.ui.mainCamera.transform.position - var_56_16.position

				var_56_16.forward = Vector3.New(var_56_24.x, var_56_24.y, var_56_24.z)

				local var_56_25 = var_56_16.localEulerAngles

				var_56_25.z = 0
				var_56_25.x = 0
				var_56_16.localEulerAngles = var_56_25

				local var_56_26 = GameObjectTools.GetOrAddComponent(var_56_16.gameObject, typeof(DynamicBoneHelper))

				if var_56_26 then
					var_56_26:EnableDynamicBone(true)
				end
			end

			local var_56_27 = arg_53_1.actors_["1054ui_story"]
			local var_56_28 = 0

			if var_56_28 < arg_53_1.time_ and arg_53_1.time_ <= var_56_28 + arg_56_0 and not isNil(var_56_27) and arg_53_1.var_.characterEffect1054ui_story == nil then
				arg_53_1.var_.characterEffect1054ui_story = var_56_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_29 = 0.200000002980232

			if var_56_28 <= arg_53_1.time_ and arg_53_1.time_ < var_56_28 + var_56_29 and not isNil(var_56_27) then
				local var_56_30 = (arg_53_1.time_ - var_56_28) / var_56_29

				if arg_53_1.var_.characterEffect1054ui_story and not isNil(var_56_27) then
					arg_53_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_28 + var_56_29 and arg_53_1.time_ < var_56_28 + var_56_29 + arg_56_0 and not isNil(var_56_27) and arg_53_1.var_.characterEffect1054ui_story then
				arg_53_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_56_31 = arg_53_1.actors_["6148ui_story"]
			local var_56_32 = 0

			if var_56_32 < arg_53_1.time_ and arg_53_1.time_ <= var_56_32 + arg_56_0 and not isNil(var_56_31) and arg_53_1.var_.characterEffect6148ui_story == nil then
				arg_53_1.var_.characterEffect6148ui_story = var_56_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_33 = 0.200000002980232

			if var_56_32 <= arg_53_1.time_ and arg_53_1.time_ < var_56_32 + var_56_33 and not isNil(var_56_31) then
				local var_56_34 = (arg_53_1.time_ - var_56_32) / var_56_33

				if arg_53_1.var_.characterEffect6148ui_story and not isNil(var_56_31) then
					local var_56_35 = Mathf.Lerp(0, 0.5, var_56_34)

					arg_53_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_53_1.var_.characterEffect6148ui_story.fillRatio = var_56_35
				end
			end

			if arg_53_1.time_ >= var_56_32 + var_56_33 and arg_53_1.time_ < var_56_32 + var_56_33 + arg_56_0 and not isNil(var_56_31) and arg_53_1.var_.characterEffect6148ui_story then
				local var_56_36 = 0.5

				arg_53_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_53_1.var_.characterEffect6148ui_story.fillRatio = var_56_36
			end

			local var_56_37 = 0

			if var_56_37 < arg_53_1.time_ and arg_53_1.time_ <= var_56_37 + arg_56_0 then
				arg_53_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_56_38 = 0

			if var_56_38 < arg_53_1.time_ and arg_53_1.time_ <= var_56_38 + arg_56_0 then
				arg_53_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_56_39 = 0
			local var_56_40 = 0.9

			if var_56_39 < arg_53_1.time_ and arg_53_1.time_ <= var_56_39 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_41 = arg_53_1:FormatText(StoryNameCfg[1487].name)

				arg_53_1.leftNameTxt_.text = var_56_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_42 = arg_53_1:GetWordFromCfg(426051013)
				local var_56_43 = arg_53_1:FormatText(var_56_42.content)

				arg_53_1.text_.text = var_56_43

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_44 = 36
				local var_56_45 = utf8.len(var_56_43)
				local var_56_46 = var_56_44 <= 0 and var_56_40 or var_56_40 * (var_56_45 / var_56_44)

				if var_56_46 > 0 and var_56_40 < var_56_46 then
					arg_53_1.talkMaxDuration = var_56_46

					if var_56_46 + var_56_39 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_46 + var_56_39
					end
				end

				arg_53_1.text_.text = var_56_43
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051013", "story_v_out_426051.awb") ~= 0 then
					local var_56_47 = manager.audio:GetVoiceLength("story_v_out_426051", "426051013", "story_v_out_426051.awb") / 1000

					if var_56_47 + var_56_39 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_47 + var_56_39
					end

					if var_56_42.prefab_name ~= "" and arg_53_1.actors_[var_56_42.prefab_name] ~= nil then
						local var_56_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_42.prefab_name].transform, "story_v_out_426051", "426051013", "story_v_out_426051.awb")

						arg_53_1:RecordAudio("426051013", var_56_48)
						arg_53_1:RecordAudio("426051013", var_56_48)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_426051", "426051013", "story_v_out_426051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_426051", "426051013", "story_v_out_426051.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_49 = math.max(var_56_40, arg_53_1.talkMaxDuration)

			if var_56_39 <= arg_53_1.time_ and arg_53_1.time_ < var_56_39 + var_56_49 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_39) / var_56_49

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_39 + var_56_49 and arg_53_1.time_ < var_56_39 + var_56_49 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play426051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 426051014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play426051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1054ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1054ui_story == nil then
				arg_57_1.var_.characterEffect1054ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1054ui_story and not isNil(var_60_0) then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1054ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1054ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1054ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.8

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_9 = arg_57_1:GetWordFromCfg(426051014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 32
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play426051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 426051015
		arg_61_1.duration_ = 8.03

		local var_61_0 = {
			zh = 6.566,
			ja = 8.033
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
				arg_61_0:Play426051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["6148ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos6148ui_story = var_64_0.localPosition

				local var_64_2 = GameObjectTools.GetOrAddComponent(var_64_0.gameObject, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(false)
				end
			end

			local var_64_3 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_3 then
				local var_64_4 = (arg_61_1.time_ - var_64_1) / var_64_3
				local var_64_5 = Vector3.New(-0.7, -0.985, -6)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos6148ui_story, var_64_5, var_64_4)

				local var_64_6 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_6.x, var_64_6.y, var_64_6.z)

				local var_64_7 = var_64_0.localEulerAngles

				var_64_7.z = 0
				var_64_7.x = 0
				var_64_0.localEulerAngles = var_64_7
			end

			if arg_61_1.time_ >= var_64_1 + var_64_3 and arg_61_1.time_ < var_64_1 + var_64_3 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_64_8 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_8.x, var_64_8.y, var_64_8.z)

				local var_64_9 = var_64_0.localEulerAngles

				var_64_9.z = 0
				var_64_9.x = 0
				var_64_0.localEulerAngles = var_64_9

				local var_64_10 = GameObjectTools.GetOrAddComponent(var_64_0.gameObject, typeof(DynamicBoneHelper))

				if var_64_10 then
					var_64_10:EnableDynamicBone(true)
				end
			end

			local var_64_11 = arg_61_1.actors_["6148ui_story"]
			local var_64_12 = 0

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.characterEffect6148ui_story == nil then
				arg_61_1.var_.characterEffect6148ui_story = var_64_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_13 = 0.200000002980232

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_13 and not isNil(var_64_11) then
				local var_64_14 = (arg_61_1.time_ - var_64_12) / var_64_13

				if arg_61_1.var_.characterEffect6148ui_story and not isNil(var_64_11) then
					arg_61_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_12 + var_64_13 and arg_61_1.time_ < var_64_12 + var_64_13 + arg_64_0 and not isNil(var_64_11) and arg_61_1.var_.characterEffect6148ui_story then
				arg_61_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_64_17 = 0
			local var_64_18 = 0.725

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_19 = arg_61_1:FormatText(StoryNameCfg[1488].name)

				arg_61_1.leftNameTxt_.text = var_64_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_20 = arg_61_1:GetWordFromCfg(426051015)
				local var_64_21 = arg_61_1:FormatText(var_64_20.content)

				arg_61_1.text_.text = var_64_21

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_22 = 29
				local var_64_23 = utf8.len(var_64_21)
				local var_64_24 = var_64_22 <= 0 and var_64_18 or var_64_18 * (var_64_23 / var_64_22)

				if var_64_24 > 0 and var_64_18 < var_64_24 then
					arg_61_1.talkMaxDuration = var_64_24

					if var_64_24 + var_64_17 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_17
					end
				end

				arg_61_1.text_.text = var_64_21
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051015", "story_v_out_426051.awb") ~= 0 then
					local var_64_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051015", "story_v_out_426051.awb") / 1000

					if var_64_25 + var_64_17 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_25 + var_64_17
					end

					if var_64_20.prefab_name ~= "" and arg_61_1.actors_[var_64_20.prefab_name] ~= nil then
						local var_64_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_20.prefab_name].transform, "story_v_out_426051", "426051015", "story_v_out_426051.awb")

						arg_61_1:RecordAudio("426051015", var_64_26)
						arg_61_1:RecordAudio("426051015", var_64_26)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_426051", "426051015", "story_v_out_426051.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_426051", "426051015", "story_v_out_426051.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_27 = math.max(var_64_18, arg_61_1.talkMaxDuration)

			if var_64_17 <= arg_61_1.time_ and arg_61_1.time_ < var_64_17 + var_64_27 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_17) / var_64_27

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_17 + var_64_27 and arg_61_1.time_ < var_64_17 + var_64_27 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play426051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 426051016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play426051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["6148ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect6148ui_story == nil then
				arg_65_1.var_.characterEffect6148ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect6148ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_65_1.var_.characterEffect6148ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect6148ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_65_1.var_.characterEffect6148ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 0.7

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(426051016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 28
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play426051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 426051017
		arg_69_1.duration_ = 5.6

		local var_69_0 = {
			zh = 5.6,
			ja = 5.566
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
				arg_69_0:Play426051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["6148ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos6148ui_story = var_72_0.localPosition

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0.gameObject, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end
			end

			local var_72_3 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_3 then
				local var_72_4 = (arg_69_1.time_ - var_72_1) / var_72_3
				local var_72_5 = Vector3.New(-0.7, -0.985, -6)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos6148ui_story, var_72_5, var_72_4)

				local var_72_6 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_6.x, var_72_6.y, var_72_6.z)

				local var_72_7 = var_72_0.localEulerAngles

				var_72_7.z = 0
				var_72_7.x = 0
				var_72_0.localEulerAngles = var_72_7
			end

			if arg_69_1.time_ >= var_72_1 + var_72_3 and arg_69_1.time_ < var_72_1 + var_72_3 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_72_8 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_8.x, var_72_8.y, var_72_8.z)

				local var_72_9 = var_72_0.localEulerAngles

				var_72_9.z = 0
				var_72_9.x = 0
				var_72_0.localEulerAngles = var_72_9

				local var_72_10 = GameObjectTools.GetOrAddComponent(var_72_0.gameObject, typeof(DynamicBoneHelper))

				if var_72_10 then
					var_72_10:EnableDynamicBone(true)
				end
			end

			local var_72_11 = arg_69_1.actors_["6148ui_story"]
			local var_72_12 = 0

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.characterEffect6148ui_story == nil then
				arg_69_1.var_.characterEffect6148ui_story = var_72_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_13 = 0.200000002980232

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_13 and not isNil(var_72_11) then
				local var_72_14 = (arg_69_1.time_ - var_72_12) / var_72_13

				if arg_69_1.var_.characterEffect6148ui_story and not isNil(var_72_11) then
					arg_69_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_12 + var_72_13 and arg_69_1.time_ < var_72_12 + var_72_13 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.characterEffect6148ui_story then
				arg_69_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_72_15 = 0

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_72_16 = 0
			local var_72_17 = 0.4

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_18 = arg_69_1:FormatText(StoryNameCfg[1488].name)

				arg_69_1.leftNameTxt_.text = var_72_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_19 = arg_69_1:GetWordFromCfg(426051017)
				local var_72_20 = arg_69_1:FormatText(var_72_19.content)

				arg_69_1.text_.text = var_72_20

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_21 = 16
				local var_72_22 = utf8.len(var_72_20)
				local var_72_23 = var_72_21 <= 0 and var_72_17 or var_72_17 * (var_72_22 / var_72_21)

				if var_72_23 > 0 and var_72_17 < var_72_23 then
					arg_69_1.talkMaxDuration = var_72_23

					if var_72_23 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_16
					end
				end

				arg_69_1.text_.text = var_72_20
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051017", "story_v_out_426051.awb") ~= 0 then
					local var_72_24 = manager.audio:GetVoiceLength("story_v_out_426051", "426051017", "story_v_out_426051.awb") / 1000

					if var_72_24 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_24 + var_72_16
					end

					if var_72_19.prefab_name ~= "" and arg_69_1.actors_[var_72_19.prefab_name] ~= nil then
						local var_72_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_19.prefab_name].transform, "story_v_out_426051", "426051017", "story_v_out_426051.awb")

						arg_69_1:RecordAudio("426051017", var_72_25)
						arg_69_1:RecordAudio("426051017", var_72_25)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_426051", "426051017", "story_v_out_426051.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_426051", "426051017", "story_v_out_426051.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_26 = math.max(var_72_17, arg_69_1.talkMaxDuration)

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_26 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_16) / var_72_26

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_16 + var_72_26 and arg_69_1.time_ < var_72_16 + var_72_26 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play426051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 426051018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play426051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["6148ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect6148ui_story == nil then
				arg_73_1.var_.characterEffect6148ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect6148ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_73_1.var_.characterEffect6148ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect6148ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_73_1.var_.characterEffect6148ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.4

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(426051018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 16
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play426051019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 426051019
		arg_77_1.duration_ = 2.33

		local var_77_0 = {
			zh = 2,
			ja = 2.333
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
				arg_77_0:Play426051020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["6148ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos6148ui_story = var_80_0.localPosition

				local var_80_2 = GameObjectTools.GetOrAddComponent(var_80_0.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(false)
				end
			end

			local var_80_3 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_3 then
				local var_80_4 = (arg_77_1.time_ - var_80_1) / var_80_3
				local var_80_5 = Vector3.New(-0.7, -0.985, -6)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos6148ui_story, var_80_5, var_80_4)

				local var_80_6 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_6.x, var_80_6.y, var_80_6.z)

				local var_80_7 = var_80_0.localEulerAngles

				var_80_7.z = 0
				var_80_7.x = 0
				var_80_0.localEulerAngles = var_80_7
			end

			if arg_77_1.time_ >= var_80_1 + var_80_3 and arg_77_1.time_ < var_80_1 + var_80_3 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_80_8 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_8.x, var_80_8.y, var_80_8.z)

				local var_80_9 = var_80_0.localEulerAngles

				var_80_9.z = 0
				var_80_9.x = 0
				var_80_0.localEulerAngles = var_80_9

				local var_80_10 = GameObjectTools.GetOrAddComponent(var_80_0.gameObject, typeof(DynamicBoneHelper))

				if var_80_10 then
					var_80_10:EnableDynamicBone(true)
				end
			end

			local var_80_11 = arg_77_1.actors_["6148ui_story"]
			local var_80_12 = 0

			if var_80_12 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 and not isNil(var_80_11) and arg_77_1.var_.characterEffect6148ui_story == nil then
				arg_77_1.var_.characterEffect6148ui_story = var_80_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_13 = 0.200000002980232

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_13 and not isNil(var_80_11) then
				local var_80_14 = (arg_77_1.time_ - var_80_12) / var_80_13

				if arg_77_1.var_.characterEffect6148ui_story and not isNil(var_80_11) then
					arg_77_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_12 + var_80_13 and arg_77_1.time_ < var_80_12 + var_80_13 + arg_80_0 and not isNil(var_80_11) and arg_77_1.var_.characterEffect6148ui_story then
				arg_77_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_80_15 = 0

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_80_17 = 0
			local var_80_18 = 0.1

			if var_80_17 < arg_77_1.time_ and arg_77_1.time_ <= var_80_17 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_19 = arg_77_1:FormatText(StoryNameCfg[1488].name)

				arg_77_1.leftNameTxt_.text = var_80_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_20 = arg_77_1:GetWordFromCfg(426051019)
				local var_80_21 = arg_77_1:FormatText(var_80_20.content)

				arg_77_1.text_.text = var_80_21

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_22 = 4
				local var_80_23 = utf8.len(var_80_21)
				local var_80_24 = var_80_22 <= 0 and var_80_18 or var_80_18 * (var_80_23 / var_80_22)

				if var_80_24 > 0 and var_80_18 < var_80_24 then
					arg_77_1.talkMaxDuration = var_80_24

					if var_80_24 + var_80_17 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_24 + var_80_17
					end
				end

				arg_77_1.text_.text = var_80_21
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051019", "story_v_out_426051.awb") ~= 0 then
					local var_80_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051019", "story_v_out_426051.awb") / 1000

					if var_80_25 + var_80_17 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_25 + var_80_17
					end

					if var_80_20.prefab_name ~= "" and arg_77_1.actors_[var_80_20.prefab_name] ~= nil then
						local var_80_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_20.prefab_name].transform, "story_v_out_426051", "426051019", "story_v_out_426051.awb")

						arg_77_1:RecordAudio("426051019", var_80_26)
						arg_77_1:RecordAudio("426051019", var_80_26)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_426051", "426051019", "story_v_out_426051.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_426051", "426051019", "story_v_out_426051.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_27 = math.max(var_80_18, arg_77_1.talkMaxDuration)

			if var_80_17 <= arg_77_1.time_ and arg_77_1.time_ < var_80_17 + var_80_27 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_17) / var_80_27

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_17 + var_80_27 and arg_77_1.time_ < var_80_17 + var_80_27 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play426051020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 426051020
		arg_81_1.duration_ = 14.07

		local var_81_0 = {
			zh = 10.033,
			ja = 14.066
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
				arg_81_0:Play426051021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1054ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1054ui_story == nil then
				arg_81_1.var_.characterEffect1054ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1054ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1054ui_story then
				arg_81_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["6148ui_story"]
			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect6148ui_story == nil then
				arg_81_1.var_.characterEffect6148ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 and not isNil(var_84_4) then
				local var_84_7 = (arg_81_1.time_ - var_84_5) / var_84_6

				if arg_81_1.var_.characterEffect6148ui_story and not isNil(var_84_4) then
					local var_84_8 = Mathf.Lerp(0, 0.5, var_84_7)

					arg_81_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_81_1.var_.characterEffect6148ui_story.fillRatio = var_84_8
				end
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect6148ui_story then
				local var_84_9 = 0.5

				arg_81_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_81_1.var_.characterEffect6148ui_story.fillRatio = var_84_9
			end

			local var_84_10 = 0
			local var_84_11 = 0.975

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_12 = arg_81_1:FormatText(StoryNameCfg[1487].name)

				arg_81_1.leftNameTxt_.text = var_84_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_13 = arg_81_1:GetWordFromCfg(426051020)
				local var_84_14 = arg_81_1:FormatText(var_84_13.content)

				arg_81_1.text_.text = var_84_14

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_15 = 39
				local var_84_16 = utf8.len(var_84_14)
				local var_84_17 = var_84_15 <= 0 and var_84_11 or var_84_11 * (var_84_16 / var_84_15)

				if var_84_17 > 0 and var_84_11 < var_84_17 then
					arg_81_1.talkMaxDuration = var_84_17

					if var_84_17 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_17 + var_84_10
					end
				end

				arg_81_1.text_.text = var_84_14
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051020", "story_v_out_426051.awb") ~= 0 then
					local var_84_18 = manager.audio:GetVoiceLength("story_v_out_426051", "426051020", "story_v_out_426051.awb") / 1000

					if var_84_18 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_10
					end

					if var_84_13.prefab_name ~= "" and arg_81_1.actors_[var_84_13.prefab_name] ~= nil then
						local var_84_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_13.prefab_name].transform, "story_v_out_426051", "426051020", "story_v_out_426051.awb")

						arg_81_1:RecordAudio("426051020", var_84_19)
						arg_81_1:RecordAudio("426051020", var_84_19)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_426051", "426051020", "story_v_out_426051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_426051", "426051020", "story_v_out_426051.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_20 = math.max(var_84_11, arg_81_1.talkMaxDuration)

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_20 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_10) / var_84_20

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_10 + var_84_20 and arg_81_1.time_ < var_84_10 + var_84_20 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play426051021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 426051021
		arg_85_1.duration_ = 10.23

		local var_85_0 = {
			zh = 6.733,
			ja = 10.233
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
				arg_85_0:Play426051022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["6148ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos6148ui_story = var_88_0.localPosition

				local var_88_2 = GameObjectTools.GetOrAddComponent(var_88_0.gameObject, typeof(DynamicBoneHelper))

				if var_88_2 then
					var_88_2:EnableDynamicBone(false)
				end
			end

			local var_88_3 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_3 then
				local var_88_4 = (arg_85_1.time_ - var_88_1) / var_88_3
				local var_88_5 = Vector3.New(-0.7, -0.985, -6)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos6148ui_story, var_88_5, var_88_4)

				local var_88_6 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_6.x, var_88_6.y, var_88_6.z)

				local var_88_7 = var_88_0.localEulerAngles

				var_88_7.z = 0
				var_88_7.x = 0
				var_88_0.localEulerAngles = var_88_7
			end

			if arg_85_1.time_ >= var_88_1 + var_88_3 and arg_85_1.time_ < var_88_1 + var_88_3 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_88_8 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_8.x, var_88_8.y, var_88_8.z)

				local var_88_9 = var_88_0.localEulerAngles

				var_88_9.z = 0
				var_88_9.x = 0
				var_88_0.localEulerAngles = var_88_9

				local var_88_10 = GameObjectTools.GetOrAddComponent(var_88_0.gameObject, typeof(DynamicBoneHelper))

				if var_88_10 then
					var_88_10:EnableDynamicBone(true)
				end
			end

			local var_88_11 = 0

			if var_88_11 < arg_85_1.time_ and arg_85_1.time_ <= var_88_11 + arg_88_0 then
				arg_85_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_88_12 = 0

			if var_88_12 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 then
				arg_85_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_88_13 = 0
			local var_88_14 = 0.75

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_15 = arg_85_1:FormatText(StoryNameCfg[1487].name)

				arg_85_1.leftNameTxt_.text = var_88_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_16 = arg_85_1:GetWordFromCfg(426051021)
				local var_88_17 = arg_85_1:FormatText(var_88_16.content)

				arg_85_1.text_.text = var_88_17

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_18 = 30
				local var_88_19 = utf8.len(var_88_17)
				local var_88_20 = var_88_18 <= 0 and var_88_14 or var_88_14 * (var_88_19 / var_88_18)

				if var_88_20 > 0 and var_88_14 < var_88_20 then
					arg_85_1.talkMaxDuration = var_88_20

					if var_88_20 + var_88_13 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_20 + var_88_13
					end
				end

				arg_85_1.text_.text = var_88_17
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051021", "story_v_out_426051.awb") ~= 0 then
					local var_88_21 = manager.audio:GetVoiceLength("story_v_out_426051", "426051021", "story_v_out_426051.awb") / 1000

					if var_88_21 + var_88_13 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_21 + var_88_13
					end

					if var_88_16.prefab_name ~= "" and arg_85_1.actors_[var_88_16.prefab_name] ~= nil then
						local var_88_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_16.prefab_name].transform, "story_v_out_426051", "426051021", "story_v_out_426051.awb")

						arg_85_1:RecordAudio("426051021", var_88_22)
						arg_85_1:RecordAudio("426051021", var_88_22)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_426051", "426051021", "story_v_out_426051.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_426051", "426051021", "story_v_out_426051.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_23 = math.max(var_88_14, arg_85_1.talkMaxDuration)

			if var_88_13 <= arg_85_1.time_ and arg_85_1.time_ < var_88_13 + var_88_23 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_13) / var_88_23

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_13 + var_88_23 and arg_85_1.time_ < var_88_13 + var_88_23 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play426051022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 426051022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play426051023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1054ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1054ui_story == nil then
				arg_89_1.var_.characterEffect1054ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1054ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1054ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1054ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1054ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.725

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(426051022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 29
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_7 or var_92_7 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_7 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_13 and arg_89_1.time_ < var_92_6 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play426051023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 426051023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play426051024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.325

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(426051023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 13
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
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play426051024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 426051024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play426051025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(426051024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 40
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play426051025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 426051025
		arg_101_1.duration_ = 11.43

		local var_101_0 = {
			zh = 9.2,
			ja = 11.433
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
				arg_101_0:Play426051026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["6148ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos6148ui_story = var_104_0.localPosition

				local var_104_2 = GameObjectTools.GetOrAddComponent(var_104_0.gameObject, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(false)
				end
			end

			local var_104_3 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_3 then
				local var_104_4 = (arg_101_1.time_ - var_104_1) / var_104_3
				local var_104_5 = Vector3.New(-0.7, -0.985, -6)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos6148ui_story, var_104_5, var_104_4)

				local var_104_6 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_6.x, var_104_6.y, var_104_6.z)

				local var_104_7 = var_104_0.localEulerAngles

				var_104_7.z = 0
				var_104_7.x = 0
				var_104_0.localEulerAngles = var_104_7
			end

			if arg_101_1.time_ >= var_104_1 + var_104_3 and arg_101_1.time_ < var_104_1 + var_104_3 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_104_8 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_8.x, var_104_8.y, var_104_8.z)

				local var_104_9 = var_104_0.localEulerAngles

				var_104_9.z = 0
				var_104_9.x = 0
				var_104_0.localEulerAngles = var_104_9

				local var_104_10 = GameObjectTools.GetOrAddComponent(var_104_0.gameObject, typeof(DynamicBoneHelper))

				if var_104_10 then
					var_104_10:EnableDynamicBone(true)
				end
			end

			local var_104_11 = arg_101_1.actors_["6148ui_story"]
			local var_104_12 = 0

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 and not isNil(var_104_11) and arg_101_1.var_.characterEffect6148ui_story == nil then
				arg_101_1.var_.characterEffect6148ui_story = var_104_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_13 = 0.200000002980232

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_13 and not isNil(var_104_11) then
				local var_104_14 = (arg_101_1.time_ - var_104_12) / var_104_13

				if arg_101_1.var_.characterEffect6148ui_story and not isNil(var_104_11) then
					arg_101_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_12 + var_104_13 and arg_101_1.time_ < var_104_12 + var_104_13 + arg_104_0 and not isNil(var_104_11) and arg_101_1.var_.characterEffect6148ui_story then
				arg_101_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_104_15 = 0

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_104_17 = 0
			local var_104_18 = 0.775

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_19 = arg_101_1:FormatText(StoryNameCfg[1488].name)

				arg_101_1.leftNameTxt_.text = var_104_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_20 = arg_101_1:GetWordFromCfg(426051025)
				local var_104_21 = arg_101_1:FormatText(var_104_20.content)

				arg_101_1.text_.text = var_104_21

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_22 = 31
				local var_104_23 = utf8.len(var_104_21)
				local var_104_24 = var_104_22 <= 0 and var_104_18 or var_104_18 * (var_104_23 / var_104_22)

				if var_104_24 > 0 and var_104_18 < var_104_24 then
					arg_101_1.talkMaxDuration = var_104_24

					if var_104_24 + var_104_17 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_24 + var_104_17
					end
				end

				arg_101_1.text_.text = var_104_21
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051025", "story_v_out_426051.awb") ~= 0 then
					local var_104_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051025", "story_v_out_426051.awb") / 1000

					if var_104_25 + var_104_17 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_25 + var_104_17
					end

					if var_104_20.prefab_name ~= "" and arg_101_1.actors_[var_104_20.prefab_name] ~= nil then
						local var_104_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_20.prefab_name].transform, "story_v_out_426051", "426051025", "story_v_out_426051.awb")

						arg_101_1:RecordAudio("426051025", var_104_26)
						arg_101_1:RecordAudio("426051025", var_104_26)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_426051", "426051025", "story_v_out_426051.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_426051", "426051025", "story_v_out_426051.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_27 = math.max(var_104_18, arg_101_1.talkMaxDuration)

			if var_104_17 <= arg_101_1.time_ and arg_101_1.time_ < var_104_17 + var_104_27 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_17) / var_104_27

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_17 + var_104_27 and arg_101_1.time_ < var_104_17 + var_104_27 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play426051026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 426051026
		arg_105_1.duration_ = 12.83

		local var_105_0 = {
			zh = 11.766,
			ja = 12.833
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
				arg_105_0:Play426051027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1054ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1054ui_story = var_108_0.localPosition

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end
			end

			local var_108_3 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_3 then
				local var_108_4 = (arg_105_1.time_ - var_108_1) / var_108_3
				local var_108_5 = Vector3.New(0.7, -0.985, -6)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1054ui_story, var_108_5, var_108_4)

				local var_108_6 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_6.x, var_108_6.y, var_108_6.z)

				local var_108_7 = var_108_0.localEulerAngles

				var_108_7.z = 0
				var_108_7.x = 0
				var_108_0.localEulerAngles = var_108_7
			end

			if arg_105_1.time_ >= var_108_1 + var_108_3 and arg_105_1.time_ < var_108_1 + var_108_3 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_108_8 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_8.x, var_108_8.y, var_108_8.z)

				local var_108_9 = var_108_0.localEulerAngles

				var_108_9.z = 0
				var_108_9.x = 0
				var_108_0.localEulerAngles = var_108_9

				local var_108_10 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_10 then
					var_108_10:EnableDynamicBone(true)
				end
			end

			local var_108_11 = arg_105_1.actors_["1054ui_story"]
			local var_108_12 = 0

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 and not isNil(var_108_11) and arg_105_1.var_.characterEffect1054ui_story == nil then
				arg_105_1.var_.characterEffect1054ui_story = var_108_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_13 = 0.200000002980232

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_13 and not isNil(var_108_11) then
				local var_108_14 = (arg_105_1.time_ - var_108_12) / var_108_13

				if arg_105_1.var_.characterEffect1054ui_story and not isNil(var_108_11) then
					arg_105_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_12 + var_108_13 and arg_105_1.time_ < var_108_12 + var_108_13 + arg_108_0 and not isNil(var_108_11) and arg_105_1.var_.characterEffect1054ui_story then
				arg_105_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_108_15 = arg_105_1.actors_["6148ui_story"]
			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 and not isNil(var_108_15) and arg_105_1.var_.characterEffect6148ui_story == nil then
				arg_105_1.var_.characterEffect6148ui_story = var_108_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_17 = 0.200000002980232

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 and not isNil(var_108_15) then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17

				if arg_105_1.var_.characterEffect6148ui_story and not isNil(var_108_15) then
					local var_108_19 = Mathf.Lerp(0, 0.5, var_108_18)

					arg_105_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_105_1.var_.characterEffect6148ui_story.fillRatio = var_108_19
				end
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 and not isNil(var_108_15) and arg_105_1.var_.characterEffect6148ui_story then
				local var_108_20 = 0.5

				arg_105_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_105_1.var_.characterEffect6148ui_story.fillRatio = var_108_20
			end

			local var_108_21 = 0

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 then
				arg_105_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_108_22 = 0

			if var_108_22 < arg_105_1.time_ and arg_105_1.time_ <= var_108_22 + arg_108_0 then
				arg_105_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_108_23 = 0
			local var_108_24 = 1.15

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_25 = arg_105_1:FormatText(StoryNameCfg[1487].name)

				arg_105_1.leftNameTxt_.text = var_108_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_26 = arg_105_1:GetWordFromCfg(426051026)
				local var_108_27 = arg_105_1:FormatText(var_108_26.content)

				arg_105_1.text_.text = var_108_27

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_28 = 46
				local var_108_29 = utf8.len(var_108_27)
				local var_108_30 = var_108_28 <= 0 and var_108_24 or var_108_24 * (var_108_29 / var_108_28)

				if var_108_30 > 0 and var_108_24 < var_108_30 then
					arg_105_1.talkMaxDuration = var_108_30

					if var_108_30 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_30 + var_108_23
					end
				end

				arg_105_1.text_.text = var_108_27
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051026", "story_v_out_426051.awb") ~= 0 then
					local var_108_31 = manager.audio:GetVoiceLength("story_v_out_426051", "426051026", "story_v_out_426051.awb") / 1000

					if var_108_31 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_31 + var_108_23
					end

					if var_108_26.prefab_name ~= "" and arg_105_1.actors_[var_108_26.prefab_name] ~= nil then
						local var_108_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_26.prefab_name].transform, "story_v_out_426051", "426051026", "story_v_out_426051.awb")

						arg_105_1:RecordAudio("426051026", var_108_32)
						arg_105_1:RecordAudio("426051026", var_108_32)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_426051", "426051026", "story_v_out_426051.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_426051", "426051026", "story_v_out_426051.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_33 = math.max(var_108_24, arg_105_1.talkMaxDuration)

			if var_108_23 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_33 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_23) / var_108_33

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_23 + var_108_33 and arg_105_1.time_ < var_108_23 + var_108_33 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play426051027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 426051027
		arg_109_1.duration_ = 14.3

		local var_109_0 = {
			zh = 11.833,
			ja = 14.3
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
				arg_109_0:Play426051028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1.1

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[1487].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(426051027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 44
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051027", "story_v_out_426051.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051027", "story_v_out_426051.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_426051", "426051027", "story_v_out_426051.awb")

						arg_109_1:RecordAudio("426051027", var_112_9)
						arg_109_1:RecordAudio("426051027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_426051", "426051027", "story_v_out_426051.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_426051", "426051027", "story_v_out_426051.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play426051028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 426051028
		arg_113_1.duration_ = 7.7

		local var_113_0 = {
			zh = 7.7,
			ja = 6.533
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
				arg_113_0:Play426051029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["6148ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect6148ui_story == nil then
				arg_113_1.var_.characterEffect6148ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect6148ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect6148ui_story then
				arg_113_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_116_4 = arg_113_1.actors_["1054ui_story"]
			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1054ui_story == nil then
				arg_113_1.var_.characterEffect1054ui_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_6 = 0.200000002980232

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_6 and not isNil(var_116_4) then
				local var_116_7 = (arg_113_1.time_ - var_116_5) / var_116_6

				if arg_113_1.var_.characterEffect1054ui_story and not isNil(var_116_4) then
					local var_116_8 = Mathf.Lerp(0, 0.5, var_116_7)

					arg_113_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1054ui_story.fillRatio = var_116_8
				end
			end

			if arg_113_1.time_ >= var_116_5 + var_116_6 and arg_113_1.time_ < var_116_5 + var_116_6 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1054ui_story then
				local var_116_9 = 0.5

				arg_113_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1054ui_story.fillRatio = var_116_9
			end

			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_116_11 = 0
			local var_116_12 = 0.725

			if var_116_11 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_13 = arg_113_1:FormatText(StoryNameCfg[1488].name)

				arg_113_1.leftNameTxt_.text = var_116_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_14 = arg_113_1:GetWordFromCfg(426051028)
				local var_116_15 = arg_113_1:FormatText(var_116_14.content)

				arg_113_1.text_.text = var_116_15

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_16 = 29
				local var_116_17 = utf8.len(var_116_15)
				local var_116_18 = var_116_16 <= 0 and var_116_12 or var_116_12 * (var_116_17 / var_116_16)

				if var_116_18 > 0 and var_116_12 < var_116_18 then
					arg_113_1.talkMaxDuration = var_116_18

					if var_116_18 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_11
					end
				end

				arg_113_1.text_.text = var_116_15
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051028", "story_v_out_426051.awb") ~= 0 then
					local var_116_19 = manager.audio:GetVoiceLength("story_v_out_426051", "426051028", "story_v_out_426051.awb") / 1000

					if var_116_19 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_11
					end

					if var_116_14.prefab_name ~= "" and arg_113_1.actors_[var_116_14.prefab_name] ~= nil then
						local var_116_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_14.prefab_name].transform, "story_v_out_426051", "426051028", "story_v_out_426051.awb")

						arg_113_1:RecordAudio("426051028", var_116_20)
						arg_113_1:RecordAudio("426051028", var_116_20)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_426051", "426051028", "story_v_out_426051.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_426051", "426051028", "story_v_out_426051.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_21 = math.max(var_116_12, arg_113_1.talkMaxDuration)

			if var_116_11 <= arg_113_1.time_ and arg_113_1.time_ < var_116_11 + var_116_21 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_11) / var_116_21

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_11 + var_116_21 and arg_113_1.time_ < var_116_11 + var_116_21 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play426051029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 426051029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play426051030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["6148ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect6148ui_story == nil then
				arg_117_1.var_.characterEffect6148ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect6148ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_117_1.var_.characterEffect6148ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect6148ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_117_1.var_.characterEffect6148ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.6

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_8 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_9 = arg_117_1:GetWordFromCfg(426051029)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 24
				local var_120_12 = utf8.len(var_120_10)
				local var_120_13 = var_120_11 <= 0 and var_120_7 or var_120_7 * (var_120_12 / var_120_11)

				if var_120_13 > 0 and var_120_7 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play426051030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 426051030
		arg_121_1.duration_ = 8.27

		local var_121_0 = {
			zh = 8.266,
			ja = 6.566
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
				arg_121_0:Play426051031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["6148ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos6148ui_story = var_124_0.localPosition

				local var_124_2 = GameObjectTools.GetOrAddComponent(var_124_0.gameObject, typeof(DynamicBoneHelper))

				if var_124_2 then
					var_124_2:EnableDynamicBone(false)
				end
			end

			local var_124_3 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_3 then
				local var_124_4 = (arg_121_1.time_ - var_124_1) / var_124_3
				local var_124_5 = Vector3.New(-0.7, -0.985, -6)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos6148ui_story, var_124_5, var_124_4)

				local var_124_6 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_6.x, var_124_6.y, var_124_6.z)

				local var_124_7 = var_124_0.localEulerAngles

				var_124_7.z = 0
				var_124_7.x = 0
				var_124_0.localEulerAngles = var_124_7
			end

			if arg_121_1.time_ >= var_124_1 + var_124_3 and arg_121_1.time_ < var_124_1 + var_124_3 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(-0.7, -0.985, -6)

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

			local var_124_11 = arg_121_1.actors_["6148ui_story"]
			local var_124_12 = 0

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.characterEffect6148ui_story == nil then
				arg_121_1.var_.characterEffect6148ui_story = var_124_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_13 = 0.200000002980232

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_13 and not isNil(var_124_11) then
				local var_124_14 = (arg_121_1.time_ - var_124_12) / var_124_13

				if arg_121_1.var_.characterEffect6148ui_story and not isNil(var_124_11) then
					arg_121_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_12 + var_124_13 and arg_121_1.time_ < var_124_12 + var_124_13 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.characterEffect6148ui_story then
				arg_121_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_124_15 = 0

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action445")
			end

			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_124_17 = 0
			local var_124_18 = 0.975

			if var_124_17 < arg_121_1.time_ and arg_121_1.time_ <= var_124_17 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_19 = arg_121_1:FormatText(StoryNameCfg[1488].name)

				arg_121_1.leftNameTxt_.text = var_124_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_20 = arg_121_1:GetWordFromCfg(426051030)
				local var_124_21 = arg_121_1:FormatText(var_124_20.content)

				arg_121_1.text_.text = var_124_21

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_22 = 39
				local var_124_23 = utf8.len(var_124_21)
				local var_124_24 = var_124_22 <= 0 and var_124_18 or var_124_18 * (var_124_23 / var_124_22)

				if var_124_24 > 0 and var_124_18 < var_124_24 then
					arg_121_1.talkMaxDuration = var_124_24

					if var_124_24 + var_124_17 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_24 + var_124_17
					end
				end

				arg_121_1.text_.text = var_124_21
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051030", "story_v_out_426051.awb") ~= 0 then
					local var_124_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051030", "story_v_out_426051.awb") / 1000

					if var_124_25 + var_124_17 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_25 + var_124_17
					end

					if var_124_20.prefab_name ~= "" and arg_121_1.actors_[var_124_20.prefab_name] ~= nil then
						local var_124_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_20.prefab_name].transform, "story_v_out_426051", "426051030", "story_v_out_426051.awb")

						arg_121_1:RecordAudio("426051030", var_124_26)
						arg_121_1:RecordAudio("426051030", var_124_26)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_426051", "426051030", "story_v_out_426051.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_426051", "426051030", "story_v_out_426051.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_27 = math.max(var_124_18, arg_121_1.talkMaxDuration)

			if var_124_17 <= arg_121_1.time_ and arg_121_1.time_ < var_124_17 + var_124_27 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_17) / var_124_27

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_17 + var_124_27 and arg_121_1.time_ < var_124_17 + var_124_27 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play426051031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 426051031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play426051032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["6148ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect6148ui_story == nil then
				arg_125_1.var_.characterEffect6148ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect6148ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_125_1.var_.characterEffect6148ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect6148ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_125_1.var_.characterEffect6148ui_story.fillRatio = var_128_5
			end

			local var_128_6 = arg_125_1.actors_["6148ui_story"].transform
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 then
				arg_125_1.var_.moveOldPos6148ui_story = var_128_6.localPosition

				local var_128_8 = GameObjectTools.GetOrAddComponent(var_128_6.gameObject, typeof(DynamicBoneHelper))

				if var_128_8 then
					var_128_8:EnableDynamicBone(false)
				end
			end

			local var_128_9 = 0.001

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_9 then
				local var_128_10 = (arg_125_1.time_ - var_128_7) / var_128_9
				local var_128_11 = Vector3.New(0, 100, 0)

				var_128_6.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos6148ui_story, var_128_11, var_128_10)

				local var_128_12 = manager.ui.mainCamera.transform.position - var_128_6.position

				var_128_6.forward = Vector3.New(var_128_12.x, var_128_12.y, var_128_12.z)

				local var_128_13 = var_128_6.localEulerAngles

				var_128_13.z = 0
				var_128_13.x = 0
				var_128_6.localEulerAngles = var_128_13
			end

			if arg_125_1.time_ >= var_128_7 + var_128_9 and arg_125_1.time_ < var_128_7 + var_128_9 + arg_128_0 then
				var_128_6.localPosition = Vector3.New(0, 100, 0)

				local var_128_14 = manager.ui.mainCamera.transform.position - var_128_6.position

				var_128_6.forward = Vector3.New(var_128_14.x, var_128_14.y, var_128_14.z)

				local var_128_15 = var_128_6.localEulerAngles

				var_128_15.z = 0
				var_128_15.x = 0
				var_128_6.localEulerAngles = var_128_15

				local var_128_16 = GameObjectTools.GetOrAddComponent(var_128_6.gameObject, typeof(DynamicBoneHelper))

				if var_128_16 then
					var_128_16:EnableDynamicBone(true)
				end
			end

			local var_128_17 = arg_125_1.actors_["1054ui_story"].transform
			local var_128_18 = 0

			if var_128_18 < arg_125_1.time_ and arg_125_1.time_ <= var_128_18 + arg_128_0 then
				arg_125_1.var_.moveOldPos1054ui_story = var_128_17.localPosition

				local var_128_19 = GameObjectTools.GetOrAddComponent(var_128_17.gameObject, typeof(DynamicBoneHelper))

				if var_128_19 then
					var_128_19:EnableDynamicBone(false)
				end
			end

			local var_128_20 = 0.001

			if var_128_18 <= arg_125_1.time_ and arg_125_1.time_ < var_128_18 + var_128_20 then
				local var_128_21 = (arg_125_1.time_ - var_128_18) / var_128_20
				local var_128_22 = Vector3.New(0, 100, 0)

				var_128_17.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1054ui_story, var_128_22, var_128_21)

				local var_128_23 = manager.ui.mainCamera.transform.position - var_128_17.position

				var_128_17.forward = Vector3.New(var_128_23.x, var_128_23.y, var_128_23.z)

				local var_128_24 = var_128_17.localEulerAngles

				var_128_24.z = 0
				var_128_24.x = 0
				var_128_17.localEulerAngles = var_128_24
			end

			if arg_125_1.time_ >= var_128_18 + var_128_20 and arg_125_1.time_ < var_128_18 + var_128_20 + arg_128_0 then
				var_128_17.localPosition = Vector3.New(0, 100, 0)

				local var_128_25 = manager.ui.mainCamera.transform.position - var_128_17.position

				var_128_17.forward = Vector3.New(var_128_25.x, var_128_25.y, var_128_25.z)

				local var_128_26 = var_128_17.localEulerAngles

				var_128_26.z = 0
				var_128_26.x = 0
				var_128_17.localEulerAngles = var_128_26

				local var_128_27 = GameObjectTools.GetOrAddComponent(var_128_17.gameObject, typeof(DynamicBoneHelper))

				if var_128_27 then
					var_128_27:EnableDynamicBone(true)
				end
			end

			local var_128_28 = 0
			local var_128_29 = 1.05

			if var_128_28 < arg_125_1.time_ and arg_125_1.time_ <= var_128_28 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_30 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_31 = arg_125_1:GetWordFromCfg(426051031)
				local var_128_32 = arg_125_1:FormatText(var_128_31.content)

				arg_125_1.text_.text = var_128_32

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_33 = 42
				local var_128_34 = utf8.len(var_128_32)
				local var_128_35 = var_128_33 <= 0 and var_128_29 or var_128_29 * (var_128_34 / var_128_33)

				if var_128_35 > 0 and var_128_29 < var_128_35 then
					arg_125_1.talkMaxDuration = var_128_35

					if var_128_35 + var_128_28 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_35 + var_128_28
					end
				end

				arg_125_1.text_.text = var_128_32
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_36 = math.max(var_128_29, arg_125_1.talkMaxDuration)

			if var_128_28 <= arg_125_1.time_ and arg_125_1.time_ < var_128_28 + var_128_36 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_28) / var_128_36

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_28 + var_128_36 and arg_125_1.time_ < var_128_28 + var_128_36 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play426051032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 426051032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play426051033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 1

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(426051032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 40
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
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play426051033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 426051033
		arg_133_1.duration_ = 12.47

		local var_133_0 = {
			zh = 10.533,
			ja = 12.466
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
				arg_133_0:Play426051034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1054ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1054ui_story = var_136_0.localPosition

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end
			end

			local var_136_3 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_3 then
				local var_136_4 = (arg_133_1.time_ - var_136_1) / var_136_3
				local var_136_5 = Vector3.New(0, -0.985, -6)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1054ui_story, var_136_5, var_136_4)

				local var_136_6 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_6.x, var_136_6.y, var_136_6.z)

				local var_136_7 = var_136_0.localEulerAngles

				var_136_7.z = 0
				var_136_7.x = 0
				var_136_0.localEulerAngles = var_136_7
			end

			if arg_133_1.time_ >= var_136_1 + var_136_3 and arg_133_1.time_ < var_136_1 + var_136_3 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, -0.985, -6)

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

			local var_136_11 = arg_133_1.actors_["1054ui_story"]
			local var_136_12 = 0

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect1054ui_story == nil then
				arg_133_1.var_.characterEffect1054ui_story = var_136_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_13 = 0.200000002980232

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_13 and not isNil(var_136_11) then
				local var_136_14 = (arg_133_1.time_ - var_136_12) / var_136_13

				if arg_133_1.var_.characterEffect1054ui_story and not isNil(var_136_11) then
					arg_133_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_12 + var_136_13 and arg_133_1.time_ < var_136_12 + var_136_13 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect1054ui_story then
				arg_133_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_136_15 = 0

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_136_17 = 0
			local var_136_18 = 0.975

			if var_136_17 < arg_133_1.time_ and arg_133_1.time_ <= var_136_17 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_19 = arg_133_1:FormatText(StoryNameCfg[1487].name)

				arg_133_1.leftNameTxt_.text = var_136_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_20 = arg_133_1:GetWordFromCfg(426051033)
				local var_136_21 = arg_133_1:FormatText(var_136_20.content)

				arg_133_1.text_.text = var_136_21

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_22 = 39
				local var_136_23 = utf8.len(var_136_21)
				local var_136_24 = var_136_22 <= 0 and var_136_18 or var_136_18 * (var_136_23 / var_136_22)

				if var_136_24 > 0 and var_136_18 < var_136_24 then
					arg_133_1.talkMaxDuration = var_136_24

					if var_136_24 + var_136_17 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_24 + var_136_17
					end
				end

				arg_133_1.text_.text = var_136_21
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051033", "story_v_out_426051.awb") ~= 0 then
					local var_136_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051033", "story_v_out_426051.awb") / 1000

					if var_136_25 + var_136_17 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_25 + var_136_17
					end

					if var_136_20.prefab_name ~= "" and arg_133_1.actors_[var_136_20.prefab_name] ~= nil then
						local var_136_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_20.prefab_name].transform, "story_v_out_426051", "426051033", "story_v_out_426051.awb")

						arg_133_1:RecordAudio("426051033", var_136_26)
						arg_133_1:RecordAudio("426051033", var_136_26)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_426051", "426051033", "story_v_out_426051.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_426051", "426051033", "story_v_out_426051.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_27 = math.max(var_136_18, arg_133_1.talkMaxDuration)

			if var_136_17 <= arg_133_1.time_ and arg_133_1.time_ < var_136_17 + var_136_27 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_17) / var_136_27

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_17 + var_136_27 and arg_133_1.time_ < var_136_17 + var_136_27 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play426051034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 426051034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play426051035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["6148ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos6148ui_story = var_140_0.localPosition

				local var_140_2 = GameObjectTools.GetOrAddComponent(var_140_0.gameObject, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(false)
				end
			end

			local var_140_3 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_3 then
				local var_140_4 = (arg_137_1.time_ - var_140_1) / var_140_3
				local var_140_5 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos6148ui_story, var_140_5, var_140_4)

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

			local var_140_11 = arg_137_1.actors_["1054ui_story"].transform
			local var_140_12 = 0

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.var_.moveOldPos1054ui_story = var_140_11.localPosition

				local var_140_13 = GameObjectTools.GetOrAddComponent(var_140_11.gameObject, typeof(DynamicBoneHelper))

				if var_140_13 then
					var_140_13:EnableDynamicBone(false)
				end
			end

			local var_140_14 = 0.001

			if var_140_12 <= arg_137_1.time_ and arg_137_1.time_ < var_140_12 + var_140_14 then
				local var_140_15 = (arg_137_1.time_ - var_140_12) / var_140_14
				local var_140_16 = Vector3.New(0, 100, 0)

				var_140_11.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1054ui_story, var_140_16, var_140_15)

				local var_140_17 = manager.ui.mainCamera.transform.position - var_140_11.position

				var_140_11.forward = Vector3.New(var_140_17.x, var_140_17.y, var_140_17.z)

				local var_140_18 = var_140_11.localEulerAngles

				var_140_18.z = 0
				var_140_18.x = 0
				var_140_11.localEulerAngles = var_140_18
			end

			if arg_137_1.time_ >= var_140_12 + var_140_14 and arg_137_1.time_ < var_140_12 + var_140_14 + arg_140_0 then
				var_140_11.localPosition = Vector3.New(0, 100, 0)

				local var_140_19 = manager.ui.mainCamera.transform.position - var_140_11.position

				var_140_11.forward = Vector3.New(var_140_19.x, var_140_19.y, var_140_19.z)

				local var_140_20 = var_140_11.localEulerAngles

				var_140_20.z = 0
				var_140_20.x = 0
				var_140_11.localEulerAngles = var_140_20

				local var_140_21 = GameObjectTools.GetOrAddComponent(var_140_11.gameObject, typeof(DynamicBoneHelper))

				if var_140_21 then
					var_140_21:EnableDynamicBone(true)
				end
			end

			local var_140_22 = arg_137_1.actors_["1054ui_story"]
			local var_140_23 = 0

			if var_140_23 < arg_137_1.time_ and arg_137_1.time_ <= var_140_23 + arg_140_0 and not isNil(var_140_22) and arg_137_1.var_.characterEffect1054ui_story == nil then
				arg_137_1.var_.characterEffect1054ui_story = var_140_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_24 = 0.200000002980232

			if var_140_23 <= arg_137_1.time_ and arg_137_1.time_ < var_140_23 + var_140_24 and not isNil(var_140_22) then
				local var_140_25 = (arg_137_1.time_ - var_140_23) / var_140_24

				if arg_137_1.var_.characterEffect1054ui_story and not isNil(var_140_22) then
					local var_140_26 = Mathf.Lerp(0, 0.5, var_140_25)

					arg_137_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1054ui_story.fillRatio = var_140_26
				end
			end

			if arg_137_1.time_ >= var_140_23 + var_140_24 and arg_137_1.time_ < var_140_23 + var_140_24 + arg_140_0 and not isNil(var_140_22) and arg_137_1.var_.characterEffect1054ui_story then
				local var_140_27 = 0.5

				arg_137_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1054ui_story.fillRatio = var_140_27
			end

			local var_140_28 = 0
			local var_140_29 = 0.7

			if var_140_28 < arg_137_1.time_ and arg_137_1.time_ <= var_140_28 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_30 = arg_137_1:GetWordFromCfg(426051034)
				local var_140_31 = arg_137_1:FormatText(var_140_30.content)

				arg_137_1.text_.text = var_140_31

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_32 = 28
				local var_140_33 = utf8.len(var_140_31)
				local var_140_34 = var_140_32 <= 0 and var_140_29 or var_140_29 * (var_140_33 / var_140_32)

				if var_140_34 > 0 and var_140_29 < var_140_34 then
					arg_137_1.talkMaxDuration = var_140_34

					if var_140_34 + var_140_28 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_34 + var_140_28
					end
				end

				arg_137_1.text_.text = var_140_31
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_35 = math.max(var_140_29, arg_137_1.talkMaxDuration)

			if var_140_28 <= arg_137_1.time_ and arg_137_1.time_ < var_140_28 + var_140_35 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_28) / var_140_35

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_28 + var_140_35 and arg_137_1.time_ < var_140_28 + var_140_35 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play426051035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 426051035
		arg_141_1.duration_ = 4.53

		local var_141_0 = {
			zh = 4.3,
			ja = 4.533
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
				arg_141_0:Play426051036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["6148ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos6148ui_story = var_144_0.localPosition

				local var_144_2 = GameObjectTools.GetOrAddComponent(var_144_0.gameObject, typeof(DynamicBoneHelper))

				if var_144_2 then
					var_144_2:EnableDynamicBone(false)
				end
			end

			local var_144_3 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_3 then
				local var_144_4 = (arg_141_1.time_ - var_144_1) / var_144_3
				local var_144_5 = Vector3.New(0, -0.985, -6)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos6148ui_story, var_144_5, var_144_4)

				local var_144_6 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_6.x, var_144_6.y, var_144_6.z)

				local var_144_7 = var_144_0.localEulerAngles

				var_144_7.z = 0
				var_144_7.x = 0
				var_144_0.localEulerAngles = var_144_7
			end

			if arg_141_1.time_ >= var_144_1 + var_144_3 and arg_141_1.time_ < var_144_1 + var_144_3 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_144_8 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_8.x, var_144_8.y, var_144_8.z)

				local var_144_9 = var_144_0.localEulerAngles

				var_144_9.z = 0
				var_144_9.x = 0
				var_144_0.localEulerAngles = var_144_9

				local var_144_10 = GameObjectTools.GetOrAddComponent(var_144_0.gameObject, typeof(DynamicBoneHelper))

				if var_144_10 then
					var_144_10:EnableDynamicBone(true)
				end
			end

			local var_144_11 = arg_141_1.actors_["6148ui_story"]
			local var_144_12 = 0

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.characterEffect6148ui_story == nil then
				arg_141_1.var_.characterEffect6148ui_story = var_144_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_13 = 0.200000002980232

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_13 and not isNil(var_144_11) then
				local var_144_14 = (arg_141_1.time_ - var_144_12) / var_144_13

				if arg_141_1.var_.characterEffect6148ui_story and not isNil(var_144_11) then
					arg_141_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_12 + var_144_13 and arg_141_1.time_ < var_144_12 + var_144_13 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.characterEffect6148ui_story then
				arg_141_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_144_15 = 0

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_144_17 = 0
			local var_144_18 = 0.475

			if var_144_17 < arg_141_1.time_ and arg_141_1.time_ <= var_144_17 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_19 = arg_141_1:FormatText(StoryNameCfg[1488].name)

				arg_141_1.leftNameTxt_.text = var_144_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_20 = arg_141_1:GetWordFromCfg(426051035)
				local var_144_21 = arg_141_1:FormatText(var_144_20.content)

				arg_141_1.text_.text = var_144_21

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_22 = 19
				local var_144_23 = utf8.len(var_144_21)
				local var_144_24 = var_144_22 <= 0 and var_144_18 or var_144_18 * (var_144_23 / var_144_22)

				if var_144_24 > 0 and var_144_18 < var_144_24 then
					arg_141_1.talkMaxDuration = var_144_24

					if var_144_24 + var_144_17 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_24 + var_144_17
					end
				end

				arg_141_1.text_.text = var_144_21
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051035", "story_v_out_426051.awb") ~= 0 then
					local var_144_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051035", "story_v_out_426051.awb") / 1000

					if var_144_25 + var_144_17 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_25 + var_144_17
					end

					if var_144_20.prefab_name ~= "" and arg_141_1.actors_[var_144_20.prefab_name] ~= nil then
						local var_144_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_20.prefab_name].transform, "story_v_out_426051", "426051035", "story_v_out_426051.awb")

						arg_141_1:RecordAudio("426051035", var_144_26)
						arg_141_1:RecordAudio("426051035", var_144_26)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_426051", "426051035", "story_v_out_426051.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_426051", "426051035", "story_v_out_426051.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_27 = math.max(var_144_18, arg_141_1.talkMaxDuration)

			if var_144_17 <= arg_141_1.time_ and arg_141_1.time_ < var_144_17 + var_144_27 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_17) / var_144_27

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_17 + var_144_27 and arg_141_1.time_ < var_144_17 + var_144_27 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play426051036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 426051036
		arg_145_1.duration_ = 11.73

		local var_145_0 = {
			zh = 10.1,
			ja = 11.733
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
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play426051037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 2

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				local var_148_1 = manager.ui.mainCamera.transform.localPosition
				local var_148_2 = Vector3.New(0, 0, 10) + Vector3.New(var_148_1.x, var_148_1.y, 0)
				local var_148_3 = arg_145_1.bgs_.ST2007a

				var_148_3.transform.localPosition = var_148_2
				var_148_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_4 = var_148_3:GetComponent("SpriteRenderer")

				if var_148_4 and var_148_4.sprite then
					local var_148_5 = (var_148_3.transform.localPosition - var_148_1).z
					local var_148_6 = manager.ui.mainCameraCom_
					local var_148_7 = 2 * var_148_5 * Mathf.Tan(var_148_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_148_8 = var_148_7 * var_148_6.aspect
					local var_148_9 = var_148_4.sprite.bounds.size.x
					local var_148_10 = var_148_4.sprite.bounds.size.y
					local var_148_11 = var_148_8 / var_148_9
					local var_148_12 = var_148_7 / var_148_10
					local var_148_13 = var_148_12 < var_148_11 and var_148_11 or var_148_12

					var_148_3.transform.localScale = Vector3.New(var_148_13, var_148_13, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "ST2007a" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_14 = 4

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			local var_148_15 = 0.3

			if arg_145_1.time_ >= var_148_14 + var_148_15 and arg_145_1.time_ < var_148_14 + var_148_15 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			local var_148_16 = 0

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_17 = 2

			if var_148_16 <= arg_145_1.time_ and arg_145_1.time_ < var_148_16 + var_148_17 then
				local var_148_18 = (arg_145_1.time_ - var_148_16) / var_148_17
				local var_148_19 = Color.New(0, 0, 0)

				var_148_19.a = Mathf.Lerp(0, 1, var_148_18)
				arg_145_1.mask_.color = var_148_19
			end

			if arg_145_1.time_ >= var_148_16 + var_148_17 and arg_145_1.time_ < var_148_16 + var_148_17 + arg_148_0 then
				local var_148_20 = Color.New(0, 0, 0)

				var_148_20.a = 1
				arg_145_1.mask_.color = var_148_20
			end

			local var_148_21 = 2

			if var_148_21 < arg_145_1.time_ and arg_145_1.time_ <= var_148_21 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_22 = 2

			if var_148_21 <= arg_145_1.time_ and arg_145_1.time_ < var_148_21 + var_148_22 then
				local var_148_23 = (arg_145_1.time_ - var_148_21) / var_148_22
				local var_148_24 = Color.New(0, 0, 0)

				var_148_24.a = Mathf.Lerp(1, 0, var_148_23)
				arg_145_1.mask_.color = var_148_24
			end

			if arg_145_1.time_ >= var_148_21 + var_148_22 and arg_145_1.time_ < var_148_21 + var_148_22 + arg_148_0 then
				local var_148_25 = Color.New(0, 0, 0)
				local var_148_26 = 0

				arg_145_1.mask_.enabled = false
				var_148_25.a = var_148_26
				arg_145_1.mask_.color = var_148_25
			end

			local var_148_27 = arg_145_1.actors_["6148ui_story"].transform
			local var_148_28 = 3.8

			if var_148_28 < arg_145_1.time_ and arg_145_1.time_ <= var_148_28 + arg_148_0 then
				arg_145_1.var_.moveOldPos6148ui_story = var_148_27.localPosition

				local var_148_29 = GameObjectTools.GetOrAddComponent(var_148_27.gameObject, typeof(DynamicBoneHelper))

				if var_148_29 then
					var_148_29:EnableDynamicBone(false)
				end
			end

			local var_148_30 = 0.001

			if var_148_28 <= arg_145_1.time_ and arg_145_1.time_ < var_148_28 + var_148_30 then
				local var_148_31 = (arg_145_1.time_ - var_148_28) / var_148_30
				local var_148_32 = Vector3.New(0, -0.985, -6)

				var_148_27.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos6148ui_story, var_148_32, var_148_31)

				local var_148_33 = manager.ui.mainCamera.transform.position - var_148_27.position

				var_148_27.forward = Vector3.New(var_148_33.x, var_148_33.y, var_148_33.z)

				local var_148_34 = var_148_27.localEulerAngles

				var_148_34.z = 0
				var_148_34.x = 0
				var_148_27.localEulerAngles = var_148_34
			end

			if arg_145_1.time_ >= var_148_28 + var_148_30 and arg_145_1.time_ < var_148_28 + var_148_30 + arg_148_0 then
				var_148_27.localPosition = Vector3.New(0, -0.985, -6)

				local var_148_35 = manager.ui.mainCamera.transform.position - var_148_27.position

				var_148_27.forward = Vector3.New(var_148_35.x, var_148_35.y, var_148_35.z)

				local var_148_36 = var_148_27.localEulerAngles

				var_148_36.z = 0
				var_148_36.x = 0
				var_148_27.localEulerAngles = var_148_36

				local var_148_37 = GameObjectTools.GetOrAddComponent(var_148_27.gameObject, typeof(DynamicBoneHelper))

				if var_148_37 then
					var_148_37:EnableDynamicBone(true)
				end
			end

			local var_148_38 = 3.8

			if var_148_38 < arg_145_1.time_ and arg_145_1.time_ <= var_148_38 + arg_148_0 then
				arg_145_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_148_39 = 3.8

			if var_148_39 < arg_145_1.time_ and arg_145_1.time_ <= var_148_39 + arg_148_0 then
				arg_145_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_40 = arg_145_1.actors_["6148ui_story"].transform
			local var_148_41 = 1.96599999815226

			if var_148_41 < arg_145_1.time_ and arg_145_1.time_ <= var_148_41 + arg_148_0 then
				arg_145_1.var_.moveOldPos6148ui_story = var_148_40.localPosition

				local var_148_42 = GameObjectTools.GetOrAddComponent(var_148_40.gameObject, typeof(DynamicBoneHelper))

				if var_148_42 then
					var_148_42:EnableDynamicBone(false)
				end
			end

			local var_148_43 = 0.001

			if var_148_41 <= arg_145_1.time_ and arg_145_1.time_ < var_148_41 + var_148_43 then
				local var_148_44 = (arg_145_1.time_ - var_148_41) / var_148_43
				local var_148_45 = Vector3.New(0, 100, 0)

				var_148_40.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos6148ui_story, var_148_45, var_148_44)

				local var_148_46 = manager.ui.mainCamera.transform.position - var_148_40.position

				var_148_40.forward = Vector3.New(var_148_46.x, var_148_46.y, var_148_46.z)

				local var_148_47 = var_148_40.localEulerAngles

				var_148_47.z = 0
				var_148_47.x = 0
				var_148_40.localEulerAngles = var_148_47
			end

			if arg_145_1.time_ >= var_148_41 + var_148_43 and arg_145_1.time_ < var_148_41 + var_148_43 + arg_148_0 then
				var_148_40.localPosition = Vector3.New(0, 100, 0)

				local var_148_48 = manager.ui.mainCamera.transform.position - var_148_40.position

				var_148_40.forward = Vector3.New(var_148_48.x, var_148_48.y, var_148_48.z)

				local var_148_49 = var_148_40.localEulerAngles

				var_148_49.z = 0
				var_148_49.x = 0
				var_148_40.localEulerAngles = var_148_49

				local var_148_50 = GameObjectTools.GetOrAddComponent(var_148_40.gameObject, typeof(DynamicBoneHelper))

				if var_148_50 then
					var_148_50:EnableDynamicBone(true)
				end
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_51 = 4
			local var_148_52 = 0.675

			if var_148_51 < arg_145_1.time_ and arg_145_1.time_ <= var_148_51 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_53 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_53:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_54 = arg_145_1:FormatText(StoryNameCfg[1488].name)

				arg_145_1.leftNameTxt_.text = var_148_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_55 = arg_145_1:GetWordFromCfg(426051036)
				local var_148_56 = arg_145_1:FormatText(var_148_55.content)

				arg_145_1.text_.text = var_148_56

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_57 = 27
				local var_148_58 = utf8.len(var_148_56)
				local var_148_59 = var_148_57 <= 0 and var_148_52 or var_148_52 * (var_148_58 / var_148_57)

				if var_148_59 > 0 and var_148_52 < var_148_59 then
					arg_145_1.talkMaxDuration = var_148_59
					var_148_51 = var_148_51 + 0.3

					if var_148_59 + var_148_51 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_59 + var_148_51
					end
				end

				arg_145_1.text_.text = var_148_56
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051036", "story_v_out_426051.awb") ~= 0 then
					local var_148_60 = manager.audio:GetVoiceLength("story_v_out_426051", "426051036", "story_v_out_426051.awb") / 1000

					if var_148_60 + var_148_51 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_60 + var_148_51
					end

					if var_148_55.prefab_name ~= "" and arg_145_1.actors_[var_148_55.prefab_name] ~= nil then
						local var_148_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_55.prefab_name].transform, "story_v_out_426051", "426051036", "story_v_out_426051.awb")

						arg_145_1:RecordAudio("426051036", var_148_61)
						arg_145_1:RecordAudio("426051036", var_148_61)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_426051", "426051036", "story_v_out_426051.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_426051", "426051036", "story_v_out_426051.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_62 = var_148_51 + 0.3
			local var_148_63 = math.max(var_148_52, arg_145_1.talkMaxDuration)

			if var_148_62 <= arg_145_1.time_ and arg_145_1.time_ < var_148_62 + var_148_63 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_62) / var_148_63

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_62 + var_148_63 and arg_145_1.time_ < var_148_62 + var_148_63 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play426051037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 426051037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play426051038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["6148ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect6148ui_story == nil then
				arg_151_1.var_.characterEffect6148ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect6148ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_151_1.var_.characterEffect6148ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect6148ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_151_1.var_.characterEffect6148ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.325

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[7].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(426051037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 13
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play426051038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 426051038
		arg_155_1.duration_ = 6.3

		local var_155_0 = {
			zh = 2.466,
			ja = 6.3
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
				arg_155_0:Play426051039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["6148ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos6148ui_story = var_158_0.localPosition

				local var_158_2 = GameObjectTools.GetOrAddComponent(var_158_0.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(false)
				end
			end

			local var_158_3 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_3 then
				local var_158_4 = (arg_155_1.time_ - var_158_1) / var_158_3
				local var_158_5 = Vector3.New(0, -0.985, -6)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos6148ui_story, var_158_5, var_158_4)

				local var_158_6 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_6.x, var_158_6.y, var_158_6.z)

				local var_158_7 = var_158_0.localEulerAngles

				var_158_7.z = 0
				var_158_7.x = 0
				var_158_0.localEulerAngles = var_158_7
			end

			if arg_155_1.time_ >= var_158_1 + var_158_3 and arg_155_1.time_ < var_158_1 + var_158_3 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_158_8 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_8.x, var_158_8.y, var_158_8.z)

				local var_158_9 = var_158_0.localEulerAngles

				var_158_9.z = 0
				var_158_9.x = 0
				var_158_0.localEulerAngles = var_158_9

				local var_158_10 = GameObjectTools.GetOrAddComponent(var_158_0.gameObject, typeof(DynamicBoneHelper))

				if var_158_10 then
					var_158_10:EnableDynamicBone(true)
				end
			end

			local var_158_11 = arg_155_1.actors_["6148ui_story"]
			local var_158_12 = 0

			if var_158_12 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 and not isNil(var_158_11) and arg_155_1.var_.characterEffect6148ui_story == nil then
				arg_155_1.var_.characterEffect6148ui_story = var_158_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_13 = 0.200000002980232

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_13 and not isNil(var_158_11) then
				local var_158_14 = (arg_155_1.time_ - var_158_12) / var_158_13

				if arg_155_1.var_.characterEffect6148ui_story and not isNil(var_158_11) then
					arg_155_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_12 + var_158_13 and arg_155_1.time_ < var_158_12 + var_158_13 + arg_158_0 and not isNil(var_158_11) and arg_155_1.var_.characterEffect6148ui_story then
				arg_155_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_158_15 = 0

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 then
				arg_155_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_158_17 = 0
			local var_158_18 = 0.275

			if var_158_17 < arg_155_1.time_ and arg_155_1.time_ <= var_158_17 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_19 = arg_155_1:FormatText(StoryNameCfg[1488].name)

				arg_155_1.leftNameTxt_.text = var_158_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_20 = arg_155_1:GetWordFromCfg(426051038)
				local var_158_21 = arg_155_1:FormatText(var_158_20.content)

				arg_155_1.text_.text = var_158_21

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_22 = 11
				local var_158_23 = utf8.len(var_158_21)
				local var_158_24 = var_158_22 <= 0 and var_158_18 or var_158_18 * (var_158_23 / var_158_22)

				if var_158_24 > 0 and var_158_18 < var_158_24 then
					arg_155_1.talkMaxDuration = var_158_24

					if var_158_24 + var_158_17 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_24 + var_158_17
					end
				end

				arg_155_1.text_.text = var_158_21
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051038", "story_v_out_426051.awb") ~= 0 then
					local var_158_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051038", "story_v_out_426051.awb") / 1000

					if var_158_25 + var_158_17 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_25 + var_158_17
					end

					if var_158_20.prefab_name ~= "" and arg_155_1.actors_[var_158_20.prefab_name] ~= nil then
						local var_158_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_20.prefab_name].transform, "story_v_out_426051", "426051038", "story_v_out_426051.awb")

						arg_155_1:RecordAudio("426051038", var_158_26)
						arg_155_1:RecordAudio("426051038", var_158_26)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_426051", "426051038", "story_v_out_426051.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_426051", "426051038", "story_v_out_426051.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_27 = math.max(var_158_18, arg_155_1.talkMaxDuration)

			if var_158_17 <= arg_155_1.time_ and arg_155_1.time_ < var_158_17 + var_158_27 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_17) / var_158_27

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_17 + var_158_27 and arg_155_1.time_ < var_158_17 + var_158_27 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play426051039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 426051039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play426051040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["6148ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos6148ui_story = var_162_0.localPosition

				local var_162_2 = GameObjectTools.GetOrAddComponent(var_162_0.gameObject, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(false)
				end
			end

			local var_162_3 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_3 then
				local var_162_4 = (arg_159_1.time_ - var_162_1) / var_162_3
				local var_162_5 = Vector3.New(0, 100, 0)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos6148ui_story, var_162_5, var_162_4)

				local var_162_6 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_6.x, var_162_6.y, var_162_6.z)

				local var_162_7 = var_162_0.localEulerAngles

				var_162_7.z = 0
				var_162_7.x = 0
				var_162_0.localEulerAngles = var_162_7
			end

			if arg_159_1.time_ >= var_162_1 + var_162_3 and arg_159_1.time_ < var_162_1 + var_162_3 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, 100, 0)

				local var_162_8 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_8.x, var_162_8.y, var_162_8.z)

				local var_162_9 = var_162_0.localEulerAngles

				var_162_9.z = 0
				var_162_9.x = 0
				var_162_0.localEulerAngles = var_162_9

				local var_162_10 = GameObjectTools.GetOrAddComponent(var_162_0.gameObject, typeof(DynamicBoneHelper))

				if var_162_10 then
					var_162_10:EnableDynamicBone(true)
				end
			end

			local var_162_11 = arg_159_1.actors_["6148ui_story"]
			local var_162_12 = 0

			if var_162_12 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 and not isNil(var_162_11) and arg_159_1.var_.characterEffect6148ui_story == nil then
				arg_159_1.var_.characterEffect6148ui_story = var_162_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_13 = 0.200000002980232

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_13 and not isNil(var_162_11) then
				local var_162_14 = (arg_159_1.time_ - var_162_12) / var_162_13

				if arg_159_1.var_.characterEffect6148ui_story and not isNil(var_162_11) then
					local var_162_15 = Mathf.Lerp(0, 0.5, var_162_14)

					arg_159_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_159_1.var_.characterEffect6148ui_story.fillRatio = var_162_15
				end
			end

			if arg_159_1.time_ >= var_162_12 + var_162_13 and arg_159_1.time_ < var_162_12 + var_162_13 + arg_162_0 and not isNil(var_162_11) and arg_159_1.var_.characterEffect6148ui_story then
				local var_162_16 = 0.5

				arg_159_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_159_1.var_.characterEffect6148ui_story.fillRatio = var_162_16
			end

			local var_162_17 = 0.7
			local var_162_18 = 1

			if var_162_17 < arg_159_1.time_ and arg_159_1.time_ <= var_162_17 + arg_162_0 then
				local var_162_19 = "play"
				local var_162_20 = "effect"

				arg_159_1:AudioAction(var_162_19, var_162_20, "se_story_1310", "se_story_1310_footstep02", "")
			end

			local var_162_21 = 0
			local var_162_22 = 1

			if var_162_21 < arg_159_1.time_ and arg_159_1.time_ <= var_162_21 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_23 = arg_159_1:GetWordFromCfg(426051039)
				local var_162_24 = arg_159_1:FormatText(var_162_23.content)

				arg_159_1.text_.text = var_162_24

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_25 = 40
				local var_162_26 = utf8.len(var_162_24)
				local var_162_27 = var_162_25 <= 0 and var_162_22 or var_162_22 * (var_162_26 / var_162_25)

				if var_162_27 > 0 and var_162_22 < var_162_27 then
					arg_159_1.talkMaxDuration = var_162_27

					if var_162_27 + var_162_21 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_27 + var_162_21
					end
				end

				arg_159_1.text_.text = var_162_24
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_28 = math.max(var_162_22, arg_159_1.talkMaxDuration)

			if var_162_21 <= arg_159_1.time_ and arg_159_1.time_ < var_162_21 + var_162_28 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_21) / var_162_28

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_21 + var_162_28 and arg_159_1.time_ < var_162_21 + var_162_28 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play426051040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 426051040
		arg_163_1.duration_ = 6.9

		local var_163_0 = {
			zh = 6.8,
			ja = 6.9
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play426051041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["6148ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos6148ui_story = var_166_0.localPosition

				local var_166_2 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(false)
				end
			end

			local var_166_3 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_3 then
				local var_166_4 = (arg_163_1.time_ - var_166_1) / var_166_3
				local var_166_5 = Vector3.New(-0.7, -0.985, -6)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos6148ui_story, var_166_5, var_166_4)

				local var_166_6 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_6.x, var_166_6.y, var_166_6.z)

				local var_166_7 = var_166_0.localEulerAngles

				var_166_7.z = 0
				var_166_7.x = 0
				var_166_0.localEulerAngles = var_166_7
			end

			if arg_163_1.time_ >= var_166_1 + var_166_3 and arg_163_1.time_ < var_166_1 + var_166_3 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_166_8 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_8.x, var_166_8.y, var_166_8.z)

				local var_166_9 = var_166_0.localEulerAngles

				var_166_9.z = 0
				var_166_9.x = 0
				var_166_0.localEulerAngles = var_166_9

				local var_166_10 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_10 then
					var_166_10:EnableDynamicBone(true)
				end
			end

			local var_166_11 = arg_163_1.actors_["6148ui_story"]
			local var_166_12 = 0

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect6148ui_story == nil then
				arg_163_1.var_.characterEffect6148ui_story = var_166_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_13 = 0.200000002980232

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_13 and not isNil(var_166_11) then
				local var_166_14 = (arg_163_1.time_ - var_166_12) / var_166_13

				if arg_163_1.var_.characterEffect6148ui_story and not isNil(var_166_11) then
					arg_163_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_12 + var_166_13 and arg_163_1.time_ < var_166_12 + var_166_13 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect6148ui_story then
				arg_163_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_166_15 = 0

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_166_17 = 0
			local var_166_18 = 0.85

			if var_166_17 < arg_163_1.time_ and arg_163_1.time_ <= var_166_17 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_19 = arg_163_1:FormatText(StoryNameCfg[1488].name)

				arg_163_1.leftNameTxt_.text = var_166_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_20 = arg_163_1:GetWordFromCfg(426051040)
				local var_166_21 = arg_163_1:FormatText(var_166_20.content)

				arg_163_1.text_.text = var_166_21

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_22 = 34
				local var_166_23 = utf8.len(var_166_21)
				local var_166_24 = var_166_22 <= 0 and var_166_18 or var_166_18 * (var_166_23 / var_166_22)

				if var_166_24 > 0 and var_166_18 < var_166_24 then
					arg_163_1.talkMaxDuration = var_166_24

					if var_166_24 + var_166_17 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_24 + var_166_17
					end
				end

				arg_163_1.text_.text = var_166_21
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051040", "story_v_out_426051.awb") ~= 0 then
					local var_166_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051040", "story_v_out_426051.awb") / 1000

					if var_166_25 + var_166_17 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_25 + var_166_17
					end

					if var_166_20.prefab_name ~= "" and arg_163_1.actors_[var_166_20.prefab_name] ~= nil then
						local var_166_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_20.prefab_name].transform, "story_v_out_426051", "426051040", "story_v_out_426051.awb")

						arg_163_1:RecordAudio("426051040", var_166_26)
						arg_163_1:RecordAudio("426051040", var_166_26)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_426051", "426051040", "story_v_out_426051.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_426051", "426051040", "story_v_out_426051.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_27 = math.max(var_166_18, arg_163_1.talkMaxDuration)

			if var_166_17 <= arg_163_1.time_ and arg_163_1.time_ < var_166_17 + var_166_27 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_17) / var_166_27

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_17 + var_166_27 and arg_163_1.time_ < var_166_17 + var_166_27 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play426051041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 426051041
		arg_167_1.duration_ = 3.23

		local var_167_0 = {
			zh = 1.999999999999,
			ja = 3.233
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
				arg_167_0:Play426051042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1054ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1054ui_story = var_170_0.localPosition

				local var_170_2 = GameObjectTools.GetOrAddComponent(var_170_0.gameObject, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(false)
				end
			end

			local var_170_3 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_3 then
				local var_170_4 = (arg_167_1.time_ - var_170_1) / var_170_3
				local var_170_5 = Vector3.New(0.7, -0.985, -6)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1054ui_story, var_170_5, var_170_4)

				local var_170_6 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_6.x, var_170_6.y, var_170_6.z)

				local var_170_7 = var_170_0.localEulerAngles

				var_170_7.z = 0
				var_170_7.x = 0
				var_170_0.localEulerAngles = var_170_7
			end

			if arg_167_1.time_ >= var_170_1 + var_170_3 and arg_167_1.time_ < var_170_1 + var_170_3 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_170_8 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_8.x, var_170_8.y, var_170_8.z)

				local var_170_9 = var_170_0.localEulerAngles

				var_170_9.z = 0
				var_170_9.x = 0
				var_170_0.localEulerAngles = var_170_9

				local var_170_10 = GameObjectTools.GetOrAddComponent(var_170_0.gameObject, typeof(DynamicBoneHelper))

				if var_170_10 then
					var_170_10:EnableDynamicBone(true)
				end
			end

			local var_170_11 = arg_167_1.actors_["1054ui_story"]
			local var_170_12 = 0

			if var_170_12 < arg_167_1.time_ and arg_167_1.time_ <= var_170_12 + arg_170_0 and not isNil(var_170_11) and arg_167_1.var_.characterEffect1054ui_story == nil then
				arg_167_1.var_.characterEffect1054ui_story = var_170_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_13 = 0.200000002980232

			if var_170_12 <= arg_167_1.time_ and arg_167_1.time_ < var_170_12 + var_170_13 and not isNil(var_170_11) then
				local var_170_14 = (arg_167_1.time_ - var_170_12) / var_170_13

				if arg_167_1.var_.characterEffect1054ui_story and not isNil(var_170_11) then
					arg_167_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_12 + var_170_13 and arg_167_1.time_ < var_170_12 + var_170_13 + arg_170_0 and not isNil(var_170_11) and arg_167_1.var_.characterEffect1054ui_story then
				arg_167_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_170_15 = arg_167_1.actors_["6148ui_story"]
			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 and not isNil(var_170_15) and arg_167_1.var_.characterEffect6148ui_story == nil then
				arg_167_1.var_.characterEffect6148ui_story = var_170_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_17 = 0.200000002980232

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_17 and not isNil(var_170_15) then
				local var_170_18 = (arg_167_1.time_ - var_170_16) / var_170_17

				if arg_167_1.var_.characterEffect6148ui_story and not isNil(var_170_15) then
					local var_170_19 = Mathf.Lerp(0, 0.5, var_170_18)

					arg_167_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_167_1.var_.characterEffect6148ui_story.fillRatio = var_170_19
				end
			end

			if arg_167_1.time_ >= var_170_16 + var_170_17 and arg_167_1.time_ < var_170_16 + var_170_17 + arg_170_0 and not isNil(var_170_15) and arg_167_1.var_.characterEffect6148ui_story then
				local var_170_20 = 0.5

				arg_167_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_167_1.var_.characterEffect6148ui_story.fillRatio = var_170_20
			end

			local var_170_21 = 0

			if var_170_21 < arg_167_1.time_ and arg_167_1.time_ <= var_170_21 + arg_170_0 then
				arg_167_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_170_22 = 0

			if var_170_22 < arg_167_1.time_ and arg_167_1.time_ <= var_170_22 + arg_170_0 then
				arg_167_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_170_23 = 0
			local var_170_24 = 0.1

			if var_170_23 < arg_167_1.time_ and arg_167_1.time_ <= var_170_23 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_25 = arg_167_1:FormatText(StoryNameCfg[1487].name)

				arg_167_1.leftNameTxt_.text = var_170_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_26 = arg_167_1:GetWordFromCfg(426051041)
				local var_170_27 = arg_167_1:FormatText(var_170_26.content)

				arg_167_1.text_.text = var_170_27

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_28 = 4
				local var_170_29 = utf8.len(var_170_27)
				local var_170_30 = var_170_28 <= 0 and var_170_24 or var_170_24 * (var_170_29 / var_170_28)

				if var_170_30 > 0 and var_170_24 < var_170_30 then
					arg_167_1.talkMaxDuration = var_170_30

					if var_170_30 + var_170_23 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_30 + var_170_23
					end
				end

				arg_167_1.text_.text = var_170_27
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051041", "story_v_out_426051.awb") ~= 0 then
					local var_170_31 = manager.audio:GetVoiceLength("story_v_out_426051", "426051041", "story_v_out_426051.awb") / 1000

					if var_170_31 + var_170_23 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_31 + var_170_23
					end

					if var_170_26.prefab_name ~= "" and arg_167_1.actors_[var_170_26.prefab_name] ~= nil then
						local var_170_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_26.prefab_name].transform, "story_v_out_426051", "426051041", "story_v_out_426051.awb")

						arg_167_1:RecordAudio("426051041", var_170_32)
						arg_167_1:RecordAudio("426051041", var_170_32)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_426051", "426051041", "story_v_out_426051.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_426051", "426051041", "story_v_out_426051.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_33 = math.max(var_170_24, arg_167_1.talkMaxDuration)

			if var_170_23 <= arg_167_1.time_ and arg_167_1.time_ < var_170_23 + var_170_33 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_23) / var_170_33

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_23 + var_170_33 and arg_167_1.time_ < var_170_23 + var_170_33 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play426051042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 426051042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play426051043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["6148ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos6148ui_story = var_174_0.localPosition

				local var_174_2 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(false)
				end
			end

			local var_174_3 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_3 then
				local var_174_4 = (arg_171_1.time_ - var_174_1) / var_174_3
				local var_174_5 = Vector3.New(0, 100, 0)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos6148ui_story, var_174_5, var_174_4)

				local var_174_6 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_6.x, var_174_6.y, var_174_6.z)

				local var_174_7 = var_174_0.localEulerAngles

				var_174_7.z = 0
				var_174_7.x = 0
				var_174_0.localEulerAngles = var_174_7
			end

			if arg_171_1.time_ >= var_174_1 + var_174_3 and arg_171_1.time_ < var_174_1 + var_174_3 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, 100, 0)

				local var_174_8 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_8.x, var_174_8.y, var_174_8.z)

				local var_174_9 = var_174_0.localEulerAngles

				var_174_9.z = 0
				var_174_9.x = 0
				var_174_0.localEulerAngles = var_174_9

				local var_174_10 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_10 then
					var_174_10:EnableDynamicBone(true)
				end
			end

			local var_174_11 = arg_171_1.actors_["1054ui_story"].transform
			local var_174_12 = 0

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.var_.moveOldPos1054ui_story = var_174_11.localPosition

				local var_174_13 = GameObjectTools.GetOrAddComponent(var_174_11.gameObject, typeof(DynamicBoneHelper))

				if var_174_13 then
					var_174_13:EnableDynamicBone(false)
				end
			end

			local var_174_14 = 0.001

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_14 then
				local var_174_15 = (arg_171_1.time_ - var_174_12) / var_174_14
				local var_174_16 = Vector3.New(0, 100, 0)

				var_174_11.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1054ui_story, var_174_16, var_174_15)

				local var_174_17 = manager.ui.mainCamera.transform.position - var_174_11.position

				var_174_11.forward = Vector3.New(var_174_17.x, var_174_17.y, var_174_17.z)

				local var_174_18 = var_174_11.localEulerAngles

				var_174_18.z = 0
				var_174_18.x = 0
				var_174_11.localEulerAngles = var_174_18
			end

			if arg_171_1.time_ >= var_174_12 + var_174_14 and arg_171_1.time_ < var_174_12 + var_174_14 + arg_174_0 then
				var_174_11.localPosition = Vector3.New(0, 100, 0)

				local var_174_19 = manager.ui.mainCamera.transform.position - var_174_11.position

				var_174_11.forward = Vector3.New(var_174_19.x, var_174_19.y, var_174_19.z)

				local var_174_20 = var_174_11.localEulerAngles

				var_174_20.z = 0
				var_174_20.x = 0
				var_174_11.localEulerAngles = var_174_20

				local var_174_21 = GameObjectTools.GetOrAddComponent(var_174_11.gameObject, typeof(DynamicBoneHelper))

				if var_174_21 then
					var_174_21:EnableDynamicBone(true)
				end
			end

			local var_174_22 = arg_171_1.actors_["1054ui_story"]
			local var_174_23 = 0

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.characterEffect1054ui_story == nil then
				arg_171_1.var_.characterEffect1054ui_story = var_174_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_24 = 0.200000002980232

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_24 and not isNil(var_174_22) then
				local var_174_25 = (arg_171_1.time_ - var_174_23) / var_174_24

				if arg_171_1.var_.characterEffect1054ui_story and not isNil(var_174_22) then
					local var_174_26 = Mathf.Lerp(0, 0.5, var_174_25)

					arg_171_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1054ui_story.fillRatio = var_174_26
				end
			end

			if arg_171_1.time_ >= var_174_23 + var_174_24 and arg_171_1.time_ < var_174_23 + var_174_24 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.characterEffect1054ui_story then
				local var_174_27 = 0.5

				arg_171_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1054ui_story.fillRatio = var_174_27
			end

			local var_174_28 = 0
			local var_174_29 = 0.775

			if var_174_28 < arg_171_1.time_ and arg_171_1.time_ <= var_174_28 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_30 = arg_171_1:GetWordFromCfg(426051042)
				local var_174_31 = arg_171_1:FormatText(var_174_30.content)

				arg_171_1.text_.text = var_174_31

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_32 = 31
				local var_174_33 = utf8.len(var_174_31)
				local var_174_34 = var_174_32 <= 0 and var_174_29 or var_174_29 * (var_174_33 / var_174_32)

				if var_174_34 > 0 and var_174_29 < var_174_34 then
					arg_171_1.talkMaxDuration = var_174_34

					if var_174_34 + var_174_28 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_34 + var_174_28
					end
				end

				arg_171_1.text_.text = var_174_31
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_35 = math.max(var_174_29, arg_171_1.talkMaxDuration)

			if var_174_28 <= arg_171_1.time_ and arg_171_1.time_ < var_174_28 + var_174_35 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_28) / var_174_35

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_28 + var_174_35 and arg_171_1.time_ < var_174_28 + var_174_35 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play426051043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 426051043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play426051044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.15

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(426051043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 6
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play426051044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 426051044
		arg_179_1.duration_ = 3.33

		local var_179_0 = {
			zh = 2.266,
			ja = 3.333
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
				arg_179_0:Play426051045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["6148ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos6148ui_story = var_182_0.localPosition

				local var_182_2 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(false)
				end
			end

			local var_182_3 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_3 then
				local var_182_4 = (arg_179_1.time_ - var_182_1) / var_182_3
				local var_182_5 = Vector3.New(0, -0.985, -6)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos6148ui_story, var_182_5, var_182_4)

				local var_182_6 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_6.x, var_182_6.y, var_182_6.z)

				local var_182_7 = var_182_0.localEulerAngles

				var_182_7.z = 0
				var_182_7.x = 0
				var_182_0.localEulerAngles = var_182_7
			end

			if arg_179_1.time_ >= var_182_1 + var_182_3 and arg_179_1.time_ < var_182_1 + var_182_3 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_182_8 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_8.x, var_182_8.y, var_182_8.z)

				local var_182_9 = var_182_0.localEulerAngles

				var_182_9.z = 0
				var_182_9.x = 0
				var_182_0.localEulerAngles = var_182_9

				local var_182_10 = GameObjectTools.GetOrAddComponent(var_182_0.gameObject, typeof(DynamicBoneHelper))

				if var_182_10 then
					var_182_10:EnableDynamicBone(true)
				end
			end

			local var_182_11 = arg_179_1.actors_["6148ui_story"]
			local var_182_12 = 0

			if var_182_12 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect6148ui_story == nil then
				arg_179_1.var_.characterEffect6148ui_story = var_182_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_13 = 0.200000002980232

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_13 and not isNil(var_182_11) then
				local var_182_14 = (arg_179_1.time_ - var_182_12) / var_182_13

				if arg_179_1.var_.characterEffect6148ui_story and not isNil(var_182_11) then
					arg_179_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_12 + var_182_13 and arg_179_1.time_ < var_182_12 + var_182_13 + arg_182_0 and not isNil(var_182_11) and arg_179_1.var_.characterEffect6148ui_story then
				arg_179_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_182_15 = 0

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_182_16 = 0

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 then
				arg_179_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_182_17 = 0
			local var_182_18 = 0.5

			if var_182_17 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_19 = arg_179_1:FormatText(StoryNameCfg[1488].name)

				arg_179_1.leftNameTxt_.text = var_182_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_20 = arg_179_1:GetWordFromCfg(426051044)
				local var_182_21 = arg_179_1:FormatText(var_182_20.content)

				arg_179_1.text_.text = var_182_21

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_22 = 20
				local var_182_23 = utf8.len(var_182_21)
				local var_182_24 = var_182_22 <= 0 and var_182_18 or var_182_18 * (var_182_23 / var_182_22)

				if var_182_24 > 0 and var_182_18 < var_182_24 then
					arg_179_1.talkMaxDuration = var_182_24

					if var_182_24 + var_182_17 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_24 + var_182_17
					end
				end

				arg_179_1.text_.text = var_182_21
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051044", "story_v_out_426051.awb") ~= 0 then
					local var_182_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051044", "story_v_out_426051.awb") / 1000

					if var_182_25 + var_182_17 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_25 + var_182_17
					end

					if var_182_20.prefab_name ~= "" and arg_179_1.actors_[var_182_20.prefab_name] ~= nil then
						local var_182_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_20.prefab_name].transform, "story_v_out_426051", "426051044", "story_v_out_426051.awb")

						arg_179_1:RecordAudio("426051044", var_182_26)
						arg_179_1:RecordAudio("426051044", var_182_26)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_426051", "426051044", "story_v_out_426051.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_426051", "426051044", "story_v_out_426051.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_27 = math.max(var_182_18, arg_179_1.talkMaxDuration)

			if var_182_17 <= arg_179_1.time_ and arg_179_1.time_ < var_182_17 + var_182_27 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_17) / var_182_27

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_17 + var_182_27 and arg_179_1.time_ < var_182_17 + var_182_27 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play426051045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 426051045
		arg_183_1.duration_ = 6.03

		local var_183_0 = {
			zh = 6.033,
			ja = 4.866
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
				arg_183_0:Play426051046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["6148ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos6148ui_story = var_186_0.localPosition

				local var_186_2 = GameObjectTools.GetOrAddComponent(var_186_0.gameObject, typeof(DynamicBoneHelper))

				if var_186_2 then
					var_186_2:EnableDynamicBone(false)
				end
			end

			local var_186_3 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_3 then
				local var_186_4 = (arg_183_1.time_ - var_186_1) / var_186_3
				local var_186_5 = Vector3.New(0, -0.985, -6)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos6148ui_story, var_186_5, var_186_4)

				local var_186_6 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_6.x, var_186_6.y, var_186_6.z)

				local var_186_7 = var_186_0.localEulerAngles

				var_186_7.z = 0
				var_186_7.x = 0
				var_186_0.localEulerAngles = var_186_7
			end

			if arg_183_1.time_ >= var_186_1 + var_186_3 and arg_183_1.time_ < var_186_1 + var_186_3 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_186_8 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_8.x, var_186_8.y, var_186_8.z)

				local var_186_9 = var_186_0.localEulerAngles

				var_186_9.z = 0
				var_186_9.x = 0
				var_186_0.localEulerAngles = var_186_9

				local var_186_10 = GameObjectTools.GetOrAddComponent(var_186_0.gameObject, typeof(DynamicBoneHelper))

				if var_186_10 then
					var_186_10:EnableDynamicBone(true)
				end
			end

			local var_186_11 = 0

			if var_186_11 < arg_183_1.time_ and arg_183_1.time_ <= var_186_11 + arg_186_0 then
				arg_183_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_186_12 = 0

			if var_186_12 < arg_183_1.time_ and arg_183_1.time_ <= var_186_12 + arg_186_0 then
				arg_183_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_186_13 = 0
			local var_186_14 = 0.75

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_15 = arg_183_1:FormatText(StoryNameCfg[1488].name)

				arg_183_1.leftNameTxt_.text = var_186_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_16 = arg_183_1:GetWordFromCfg(426051045)
				local var_186_17 = arg_183_1:FormatText(var_186_16.content)

				arg_183_1.text_.text = var_186_17

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_18 = 30
				local var_186_19 = utf8.len(var_186_17)
				local var_186_20 = var_186_18 <= 0 and var_186_14 or var_186_14 * (var_186_19 / var_186_18)

				if var_186_20 > 0 and var_186_14 < var_186_20 then
					arg_183_1.talkMaxDuration = var_186_20

					if var_186_20 + var_186_13 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_20 + var_186_13
					end
				end

				arg_183_1.text_.text = var_186_17
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051045", "story_v_out_426051.awb") ~= 0 then
					local var_186_21 = manager.audio:GetVoiceLength("story_v_out_426051", "426051045", "story_v_out_426051.awb") / 1000

					if var_186_21 + var_186_13 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_21 + var_186_13
					end

					if var_186_16.prefab_name ~= "" and arg_183_1.actors_[var_186_16.prefab_name] ~= nil then
						local var_186_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_16.prefab_name].transform, "story_v_out_426051", "426051045", "story_v_out_426051.awb")

						arg_183_1:RecordAudio("426051045", var_186_22)
						arg_183_1:RecordAudio("426051045", var_186_22)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_426051", "426051045", "story_v_out_426051.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_426051", "426051045", "story_v_out_426051.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_23 = math.max(var_186_14, arg_183_1.talkMaxDuration)

			if var_186_13 <= arg_183_1.time_ and arg_183_1.time_ < var_186_13 + var_186_23 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_13) / var_186_23

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_13 + var_186_23 and arg_183_1.time_ < var_186_13 + var_186_23 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play426051046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 426051046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play426051047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["6148ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect6148ui_story == nil then
				arg_187_1.var_.characterEffect6148ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect6148ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_187_1.var_.characterEffect6148ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect6148ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_187_1.var_.characterEffect6148ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.8

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(426051046)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 32
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_14 and arg_187_1.time_ < var_190_6 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play426051047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 426051047
		arg_191_1.duration_ = 5.57

		local var_191_0 = {
			zh = 5.566,
			ja = 5.1
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
				arg_191_0:Play426051048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["6148ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos6148ui_story = var_194_0.localPosition

				local var_194_2 = GameObjectTools.GetOrAddComponent(var_194_0.gameObject, typeof(DynamicBoneHelper))

				if var_194_2 then
					var_194_2:EnableDynamicBone(false)
				end
			end

			local var_194_3 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_3 then
				local var_194_4 = (arg_191_1.time_ - var_194_1) / var_194_3
				local var_194_5 = Vector3.New(0, -0.985, -6)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos6148ui_story, var_194_5, var_194_4)

				local var_194_6 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_6.x, var_194_6.y, var_194_6.z)

				local var_194_7 = var_194_0.localEulerAngles

				var_194_7.z = 0
				var_194_7.x = 0
				var_194_0.localEulerAngles = var_194_7
			end

			if arg_191_1.time_ >= var_194_1 + var_194_3 and arg_191_1.time_ < var_194_1 + var_194_3 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_194_8 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_8.x, var_194_8.y, var_194_8.z)

				local var_194_9 = var_194_0.localEulerAngles

				var_194_9.z = 0
				var_194_9.x = 0
				var_194_0.localEulerAngles = var_194_9

				local var_194_10 = GameObjectTools.GetOrAddComponent(var_194_0.gameObject, typeof(DynamicBoneHelper))

				if var_194_10 then
					var_194_10:EnableDynamicBone(true)
				end
			end

			local var_194_11 = arg_191_1.actors_["6148ui_story"]
			local var_194_12 = 0

			if var_194_12 < arg_191_1.time_ and arg_191_1.time_ <= var_194_12 + arg_194_0 and not isNil(var_194_11) and arg_191_1.var_.characterEffect6148ui_story == nil then
				arg_191_1.var_.characterEffect6148ui_story = var_194_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_13 = 0.200000002980232

			if var_194_12 <= arg_191_1.time_ and arg_191_1.time_ < var_194_12 + var_194_13 and not isNil(var_194_11) then
				local var_194_14 = (arg_191_1.time_ - var_194_12) / var_194_13

				if arg_191_1.var_.characterEffect6148ui_story and not isNil(var_194_11) then
					arg_191_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_12 + var_194_13 and arg_191_1.time_ < var_194_12 + var_194_13 + arg_194_0 and not isNil(var_194_11) and arg_191_1.var_.characterEffect6148ui_story then
				arg_191_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_194_15 = 0

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_194_17 = 0
			local var_194_18 = 0.475

			if var_194_17 < arg_191_1.time_ and arg_191_1.time_ <= var_194_17 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_19 = arg_191_1:FormatText(StoryNameCfg[1488].name)

				arg_191_1.leftNameTxt_.text = var_194_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_20 = arg_191_1:GetWordFromCfg(426051047)
				local var_194_21 = arg_191_1:FormatText(var_194_20.content)

				arg_191_1.text_.text = var_194_21

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_22 = 19
				local var_194_23 = utf8.len(var_194_21)
				local var_194_24 = var_194_22 <= 0 and var_194_18 or var_194_18 * (var_194_23 / var_194_22)

				if var_194_24 > 0 and var_194_18 < var_194_24 then
					arg_191_1.talkMaxDuration = var_194_24

					if var_194_24 + var_194_17 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_24 + var_194_17
					end
				end

				arg_191_1.text_.text = var_194_21
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051047", "story_v_out_426051.awb") ~= 0 then
					local var_194_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051047", "story_v_out_426051.awb") / 1000

					if var_194_25 + var_194_17 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_25 + var_194_17
					end

					if var_194_20.prefab_name ~= "" and arg_191_1.actors_[var_194_20.prefab_name] ~= nil then
						local var_194_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_20.prefab_name].transform, "story_v_out_426051", "426051047", "story_v_out_426051.awb")

						arg_191_1:RecordAudio("426051047", var_194_26)
						arg_191_1:RecordAudio("426051047", var_194_26)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_426051", "426051047", "story_v_out_426051.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_426051", "426051047", "story_v_out_426051.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_27 = math.max(var_194_18, arg_191_1.talkMaxDuration)

			if var_194_17 <= arg_191_1.time_ and arg_191_1.time_ < var_194_17 + var_194_27 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_17) / var_194_27

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_17 + var_194_27 and arg_191_1.time_ < var_194_17 + var_194_27 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play426051048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 426051048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play426051049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["6148ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect6148ui_story == nil then
				arg_195_1.var_.characterEffect6148ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect6148ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_195_1.var_.characterEffect6148ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect6148ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_195_1.var_.characterEffect6148ui_story.fillRatio = var_198_5
			end

			local var_198_6 = 0
			local var_198_7 = 0.15

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_9 = arg_195_1:GetWordFromCfg(426051048)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 6
				local var_198_12 = utf8.len(var_198_10)
				local var_198_13 = var_198_11 <= 0 and var_198_7 or var_198_7 * (var_198_12 / var_198_11)

				if var_198_13 > 0 and var_198_7 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play426051049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 426051049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play426051050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["6148ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos6148ui_story = var_202_0.localPosition

				local var_202_2 = GameObjectTools.GetOrAddComponent(var_202_0.gameObject, typeof(DynamicBoneHelper))

				if var_202_2 then
					var_202_2:EnableDynamicBone(false)
				end
			end

			local var_202_3 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_3 then
				local var_202_4 = (arg_199_1.time_ - var_202_1) / var_202_3
				local var_202_5 = Vector3.New(0, 100, 0)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos6148ui_story, var_202_5, var_202_4)

				local var_202_6 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_6.x, var_202_6.y, var_202_6.z)

				local var_202_7 = var_202_0.localEulerAngles

				var_202_7.z = 0
				var_202_7.x = 0
				var_202_0.localEulerAngles = var_202_7
			end

			if arg_199_1.time_ >= var_202_1 + var_202_3 and arg_199_1.time_ < var_202_1 + var_202_3 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, 100, 0)

				local var_202_8 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_8.x, var_202_8.y, var_202_8.z)

				local var_202_9 = var_202_0.localEulerAngles

				var_202_9.z = 0
				var_202_9.x = 0
				var_202_0.localEulerAngles = var_202_9

				local var_202_10 = GameObjectTools.GetOrAddComponent(var_202_0.gameObject, typeof(DynamicBoneHelper))

				if var_202_10 then
					var_202_10:EnableDynamicBone(true)
				end
			end

			local var_202_11 = 0.733333333333333
			local var_202_12 = 1

			if var_202_11 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 then
				local var_202_13 = "play"
				local var_202_14 = "effect"

				arg_199_1:AudioAction(var_202_13, var_202_14, "se_story_side_1084", "se_story_1084_electric", "")
			end

			local var_202_15 = 0
			local var_202_16 = 1.125

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_17 = arg_199_1:GetWordFromCfg(426051049)
				local var_202_18 = arg_199_1:FormatText(var_202_17.content)

				arg_199_1.text_.text = var_202_18

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_19 = 45
				local var_202_20 = utf8.len(var_202_18)
				local var_202_21 = var_202_19 <= 0 and var_202_16 or var_202_16 * (var_202_20 / var_202_19)

				if var_202_21 > 0 and var_202_16 < var_202_21 then
					arg_199_1.talkMaxDuration = var_202_21

					if var_202_21 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_21 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_18
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_22 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_22 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_22

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_22 and arg_199_1.time_ < var_202_15 + var_202_22 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play426051050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 426051050
		arg_203_1.duration_ = 3.3

		local var_203_0 = {
			zh = 3.3,
			ja = 1.999999999999
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
				arg_203_0:Play426051051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["6148ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos6148ui_story = var_206_0.localPosition

				local var_206_2 = GameObjectTools.GetOrAddComponent(var_206_0.gameObject, typeof(DynamicBoneHelper))

				if var_206_2 then
					var_206_2:EnableDynamicBone(false)
				end
			end

			local var_206_3 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_3 then
				local var_206_4 = (arg_203_1.time_ - var_206_1) / var_206_3
				local var_206_5 = Vector3.New(-0.7, -0.985, -6)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos6148ui_story, var_206_5, var_206_4)

				local var_206_6 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_6.x, var_206_6.y, var_206_6.z)

				local var_206_7 = var_206_0.localEulerAngles

				var_206_7.z = 0
				var_206_7.x = 0
				var_206_0.localEulerAngles = var_206_7
			end

			if arg_203_1.time_ >= var_206_1 + var_206_3 and arg_203_1.time_ < var_206_1 + var_206_3 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_206_8 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_8.x, var_206_8.y, var_206_8.z)

				local var_206_9 = var_206_0.localEulerAngles

				var_206_9.z = 0
				var_206_9.x = 0
				var_206_0.localEulerAngles = var_206_9

				local var_206_10 = GameObjectTools.GetOrAddComponent(var_206_0.gameObject, typeof(DynamicBoneHelper))

				if var_206_10 then
					var_206_10:EnableDynamicBone(true)
				end
			end

			local var_206_11 = arg_203_1.actors_["6148ui_story"]
			local var_206_12 = 0

			if var_206_12 < arg_203_1.time_ and arg_203_1.time_ <= var_206_12 + arg_206_0 and not isNil(var_206_11) and arg_203_1.var_.characterEffect6148ui_story == nil then
				arg_203_1.var_.characterEffect6148ui_story = var_206_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_13 = 0.200000002980232

			if var_206_12 <= arg_203_1.time_ and arg_203_1.time_ < var_206_12 + var_206_13 and not isNil(var_206_11) then
				local var_206_14 = (arg_203_1.time_ - var_206_12) / var_206_13

				if arg_203_1.var_.characterEffect6148ui_story and not isNil(var_206_11) then
					arg_203_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_12 + var_206_13 and arg_203_1.time_ < var_206_12 + var_206_13 + arg_206_0 and not isNil(var_206_11) and arg_203_1.var_.characterEffect6148ui_story then
				arg_203_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_206_15 = 0

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_206_17 = 0
			local var_206_18 = 0.4

			if var_206_17 < arg_203_1.time_ and arg_203_1.time_ <= var_206_17 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_19 = arg_203_1:FormatText(StoryNameCfg[1488].name)

				arg_203_1.leftNameTxt_.text = var_206_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_20 = arg_203_1:GetWordFromCfg(426051050)
				local var_206_21 = arg_203_1:FormatText(var_206_20.content)

				arg_203_1.text_.text = var_206_21

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_22 = 16
				local var_206_23 = utf8.len(var_206_21)
				local var_206_24 = var_206_22 <= 0 and var_206_18 or var_206_18 * (var_206_23 / var_206_22)

				if var_206_24 > 0 and var_206_18 < var_206_24 then
					arg_203_1.talkMaxDuration = var_206_24

					if var_206_24 + var_206_17 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_24 + var_206_17
					end
				end

				arg_203_1.text_.text = var_206_21
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051050", "story_v_out_426051.awb") ~= 0 then
					local var_206_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051050", "story_v_out_426051.awb") / 1000

					if var_206_25 + var_206_17 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_25 + var_206_17
					end

					if var_206_20.prefab_name ~= "" and arg_203_1.actors_[var_206_20.prefab_name] ~= nil then
						local var_206_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_20.prefab_name].transform, "story_v_out_426051", "426051050", "story_v_out_426051.awb")

						arg_203_1:RecordAudio("426051050", var_206_26)
						arg_203_1:RecordAudio("426051050", var_206_26)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_426051", "426051050", "story_v_out_426051.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_426051", "426051050", "story_v_out_426051.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_27 = math.max(var_206_18, arg_203_1.talkMaxDuration)

			if var_206_17 <= arg_203_1.time_ and arg_203_1.time_ < var_206_17 + var_206_27 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_17) / var_206_27

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_17 + var_206_27 and arg_203_1.time_ < var_206_17 + var_206_27 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play426051051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 426051051
		arg_207_1.duration_ = 3.93

		local var_207_0 = {
			zh = 3.933,
			ja = 1.999999999999
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
				arg_207_0:Play426051052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1054ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1054ui_story = var_210_0.localPosition

				local var_210_2 = GameObjectTools.GetOrAddComponent(var_210_0.gameObject, typeof(DynamicBoneHelper))

				if var_210_2 then
					var_210_2:EnableDynamicBone(false)
				end
			end

			local var_210_3 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_3 then
				local var_210_4 = (arg_207_1.time_ - var_210_1) / var_210_3
				local var_210_5 = Vector3.New(0.7, -0.985, -6)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1054ui_story, var_210_5, var_210_4)

				local var_210_6 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_6.x, var_210_6.y, var_210_6.z)

				local var_210_7 = var_210_0.localEulerAngles

				var_210_7.z = 0
				var_210_7.x = 0
				var_210_0.localEulerAngles = var_210_7
			end

			if arg_207_1.time_ >= var_210_1 + var_210_3 and arg_207_1.time_ < var_210_1 + var_210_3 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_210_8 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_8.x, var_210_8.y, var_210_8.z)

				local var_210_9 = var_210_0.localEulerAngles

				var_210_9.z = 0
				var_210_9.x = 0
				var_210_0.localEulerAngles = var_210_9

				local var_210_10 = GameObjectTools.GetOrAddComponent(var_210_0.gameObject, typeof(DynamicBoneHelper))

				if var_210_10 then
					var_210_10:EnableDynamicBone(true)
				end
			end

			local var_210_11 = arg_207_1.actors_["1054ui_story"]
			local var_210_12 = 0

			if var_210_12 < arg_207_1.time_ and arg_207_1.time_ <= var_210_12 + arg_210_0 and not isNil(var_210_11) and arg_207_1.var_.characterEffect1054ui_story == nil then
				arg_207_1.var_.characterEffect1054ui_story = var_210_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_13 = 0.200000002980232

			if var_210_12 <= arg_207_1.time_ and arg_207_1.time_ < var_210_12 + var_210_13 and not isNil(var_210_11) then
				local var_210_14 = (arg_207_1.time_ - var_210_12) / var_210_13

				if arg_207_1.var_.characterEffect1054ui_story and not isNil(var_210_11) then
					arg_207_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_12 + var_210_13 and arg_207_1.time_ < var_210_12 + var_210_13 + arg_210_0 and not isNil(var_210_11) and arg_207_1.var_.characterEffect1054ui_story then
				arg_207_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_210_15 = arg_207_1.actors_["6148ui_story"]
			local var_210_16 = 0

			if var_210_16 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 and not isNil(var_210_15) and arg_207_1.var_.characterEffect6148ui_story == nil then
				arg_207_1.var_.characterEffect6148ui_story = var_210_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_17 = 0.200000002980232

			if var_210_16 <= arg_207_1.time_ and arg_207_1.time_ < var_210_16 + var_210_17 and not isNil(var_210_15) then
				local var_210_18 = (arg_207_1.time_ - var_210_16) / var_210_17

				if arg_207_1.var_.characterEffect6148ui_story and not isNil(var_210_15) then
					local var_210_19 = Mathf.Lerp(0, 0.5, var_210_18)

					arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_207_1.var_.characterEffect6148ui_story.fillRatio = var_210_19
				end
			end

			if arg_207_1.time_ >= var_210_16 + var_210_17 and arg_207_1.time_ < var_210_16 + var_210_17 + arg_210_0 and not isNil(var_210_15) and arg_207_1.var_.characterEffect6148ui_story then
				local var_210_20 = 0.5

				arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_207_1.var_.characterEffect6148ui_story.fillRatio = var_210_20
			end

			local var_210_21 = 0

			if var_210_21 < arg_207_1.time_ and arg_207_1.time_ <= var_210_21 + arg_210_0 then
				arg_207_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			local var_210_22 = 0

			if var_210_22 < arg_207_1.time_ and arg_207_1.time_ <= var_210_22 + arg_210_0 then
				arg_207_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_210_23 = 0
			local var_210_24 = 0.4

			if var_210_23 < arg_207_1.time_ and arg_207_1.time_ <= var_210_23 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_25 = arg_207_1:FormatText(StoryNameCfg[1487].name)

				arg_207_1.leftNameTxt_.text = var_210_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_26 = arg_207_1:GetWordFromCfg(426051051)
				local var_210_27 = arg_207_1:FormatText(var_210_26.content)

				arg_207_1.text_.text = var_210_27

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_28 = 16
				local var_210_29 = utf8.len(var_210_27)
				local var_210_30 = var_210_28 <= 0 and var_210_24 or var_210_24 * (var_210_29 / var_210_28)

				if var_210_30 > 0 and var_210_24 < var_210_30 then
					arg_207_1.talkMaxDuration = var_210_30

					if var_210_30 + var_210_23 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_30 + var_210_23
					end
				end

				arg_207_1.text_.text = var_210_27
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051051", "story_v_out_426051.awb") ~= 0 then
					local var_210_31 = manager.audio:GetVoiceLength("story_v_out_426051", "426051051", "story_v_out_426051.awb") / 1000

					if var_210_31 + var_210_23 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_31 + var_210_23
					end

					if var_210_26.prefab_name ~= "" and arg_207_1.actors_[var_210_26.prefab_name] ~= nil then
						local var_210_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_26.prefab_name].transform, "story_v_out_426051", "426051051", "story_v_out_426051.awb")

						arg_207_1:RecordAudio("426051051", var_210_32)
						arg_207_1:RecordAudio("426051051", var_210_32)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_426051", "426051051", "story_v_out_426051.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_426051", "426051051", "story_v_out_426051.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_33 = math.max(var_210_24, arg_207_1.talkMaxDuration)

			if var_210_23 <= arg_207_1.time_ and arg_207_1.time_ < var_210_23 + var_210_33 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_23) / var_210_33

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_23 + var_210_33 and arg_207_1.time_ < var_210_23 + var_210_33 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play426051052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 426051052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play426051053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["6148ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos6148ui_story = var_214_0.localPosition

				local var_214_2 = GameObjectTools.GetOrAddComponent(var_214_0.gameObject, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(false)
				end
			end

			local var_214_3 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_3 then
				local var_214_4 = (arg_211_1.time_ - var_214_1) / var_214_3
				local var_214_5 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos6148ui_story, var_214_5, var_214_4)

				local var_214_6 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_6.x, var_214_6.y, var_214_6.z)

				local var_214_7 = var_214_0.localEulerAngles

				var_214_7.z = 0
				var_214_7.x = 0
				var_214_0.localEulerAngles = var_214_7
			end

			if arg_211_1.time_ >= var_214_1 + var_214_3 and arg_211_1.time_ < var_214_1 + var_214_3 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_8 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_8.x, var_214_8.y, var_214_8.z)

				local var_214_9 = var_214_0.localEulerAngles

				var_214_9.z = 0
				var_214_9.x = 0
				var_214_0.localEulerAngles = var_214_9

				local var_214_10 = GameObjectTools.GetOrAddComponent(var_214_0.gameObject, typeof(DynamicBoneHelper))

				if var_214_10 then
					var_214_10:EnableDynamicBone(true)
				end
			end

			local var_214_11 = arg_211_1.actors_["1054ui_story"]
			local var_214_12 = 0

			if var_214_12 < arg_211_1.time_ and arg_211_1.time_ <= var_214_12 + arg_214_0 and not isNil(var_214_11) and arg_211_1.var_.characterEffect1054ui_story == nil then
				arg_211_1.var_.characterEffect1054ui_story = var_214_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_13 = 0.200000002980232

			if var_214_12 <= arg_211_1.time_ and arg_211_1.time_ < var_214_12 + var_214_13 and not isNil(var_214_11) then
				local var_214_14 = (arg_211_1.time_ - var_214_12) / var_214_13

				if arg_211_1.var_.characterEffect1054ui_story and not isNil(var_214_11) then
					local var_214_15 = Mathf.Lerp(0, 0.5, var_214_14)

					arg_211_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1054ui_story.fillRatio = var_214_15
				end
			end

			if arg_211_1.time_ >= var_214_12 + var_214_13 and arg_211_1.time_ < var_214_12 + var_214_13 + arg_214_0 and not isNil(var_214_11) and arg_211_1.var_.characterEffect1054ui_story then
				local var_214_16 = 0.5

				arg_211_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1054ui_story.fillRatio = var_214_16
			end

			local var_214_17 = arg_211_1.actors_["1054ui_story"].transform
			local var_214_18 = 0

			if var_214_18 < arg_211_1.time_ and arg_211_1.time_ <= var_214_18 + arg_214_0 then
				arg_211_1.var_.moveOldPos1054ui_story = var_214_17.localPosition

				local var_214_19 = GameObjectTools.GetOrAddComponent(var_214_17.gameObject, typeof(DynamicBoneHelper))

				if var_214_19 then
					var_214_19:EnableDynamicBone(false)
				end
			end

			local var_214_20 = 0.001

			if var_214_18 <= arg_211_1.time_ and arg_211_1.time_ < var_214_18 + var_214_20 then
				local var_214_21 = (arg_211_1.time_ - var_214_18) / var_214_20
				local var_214_22 = Vector3.New(0, 100, 0)

				var_214_17.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1054ui_story, var_214_22, var_214_21)

				local var_214_23 = manager.ui.mainCamera.transform.position - var_214_17.position

				var_214_17.forward = Vector3.New(var_214_23.x, var_214_23.y, var_214_23.z)

				local var_214_24 = var_214_17.localEulerAngles

				var_214_24.z = 0
				var_214_24.x = 0
				var_214_17.localEulerAngles = var_214_24
			end

			if arg_211_1.time_ >= var_214_18 + var_214_20 and arg_211_1.time_ < var_214_18 + var_214_20 + arg_214_0 then
				var_214_17.localPosition = Vector3.New(0, 100, 0)

				local var_214_25 = manager.ui.mainCamera.transform.position - var_214_17.position

				var_214_17.forward = Vector3.New(var_214_25.x, var_214_25.y, var_214_25.z)

				local var_214_26 = var_214_17.localEulerAngles

				var_214_26.z = 0
				var_214_26.x = 0
				var_214_17.localEulerAngles = var_214_26

				local var_214_27 = GameObjectTools.GetOrAddComponent(var_214_17.gameObject, typeof(DynamicBoneHelper))

				if var_214_27 then
					var_214_27:EnableDynamicBone(true)
				end
			end

			local var_214_28 = 0
			local var_214_29 = 0.825

			if var_214_28 < arg_211_1.time_ and arg_211_1.time_ <= var_214_28 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_30 = arg_211_1:GetWordFromCfg(426051052)
				local var_214_31 = arg_211_1:FormatText(var_214_30.content)

				arg_211_1.text_.text = var_214_31

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_32 = 33
				local var_214_33 = utf8.len(var_214_31)
				local var_214_34 = var_214_32 <= 0 and var_214_29 or var_214_29 * (var_214_33 / var_214_32)

				if var_214_34 > 0 and var_214_29 < var_214_34 then
					arg_211_1.talkMaxDuration = var_214_34

					if var_214_34 + var_214_28 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_34 + var_214_28
					end
				end

				arg_211_1.text_.text = var_214_31
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_35 = math.max(var_214_29, arg_211_1.talkMaxDuration)

			if var_214_28 <= arg_211_1.time_ and arg_211_1.time_ < var_214_28 + var_214_35 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_28) / var_214_35

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_28 + var_214_35 and arg_211_1.time_ < var_214_28 + var_214_35 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play426051053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 426051053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play426051054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.45

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(426051053)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 18
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
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play426051054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 426051054
		arg_219_1.duration_ = 9

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play426051055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 2

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				local var_222_1 = manager.ui.mainCamera.transform.localPosition
				local var_222_2 = Vector3.New(0, 0, 10) + Vector3.New(var_222_1.x, var_222_1.y, 0)
				local var_222_3 = arg_219_1.bgs_.ST2007a

				var_222_3.transform.localPosition = var_222_2
				var_222_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_4 = var_222_3:GetComponent("SpriteRenderer")

				if var_222_4 and var_222_4.sprite then
					local var_222_5 = (var_222_3.transform.localPosition - var_222_1).z
					local var_222_6 = manager.ui.mainCameraCom_
					local var_222_7 = 2 * var_222_5 * Mathf.Tan(var_222_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_222_8 = var_222_7 * var_222_6.aspect
					local var_222_9 = var_222_4.sprite.bounds.size.x
					local var_222_10 = var_222_4.sprite.bounds.size.y
					local var_222_11 = var_222_8 / var_222_9
					local var_222_12 = var_222_7 / var_222_10
					local var_222_13 = var_222_12 < var_222_11 and var_222_11 or var_222_12

					var_222_3.transform.localScale = Vector3.New(var_222_13, var_222_13, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "ST2007a" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_14 = 3.999999999999

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			local var_222_15 = 0.3

			if arg_219_1.time_ >= var_222_14 + var_222_15 and arg_219_1.time_ < var_222_14 + var_222_15 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			local var_222_16 = 0

			if var_222_16 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_17 = 2

			if var_222_16 <= arg_219_1.time_ and arg_219_1.time_ < var_222_16 + var_222_17 then
				local var_222_18 = (arg_219_1.time_ - var_222_16) / var_222_17
				local var_222_19 = Color.New(0, 0, 0)

				var_222_19.a = Mathf.Lerp(0, 1, var_222_18)
				arg_219_1.mask_.color = var_222_19
			end

			if arg_219_1.time_ >= var_222_16 + var_222_17 and arg_219_1.time_ < var_222_16 + var_222_17 + arg_222_0 then
				local var_222_20 = Color.New(0, 0, 0)

				var_222_20.a = 1
				arg_219_1.mask_.color = var_222_20
			end

			local var_222_21 = 2

			if var_222_21 < arg_219_1.time_ and arg_219_1.time_ <= var_222_21 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_22 = 2

			if var_222_21 <= arg_219_1.time_ and arg_219_1.time_ < var_222_21 + var_222_22 then
				local var_222_23 = (arg_219_1.time_ - var_222_21) / var_222_22
				local var_222_24 = Color.New(0, 0, 0)

				var_222_24.a = Mathf.Lerp(1, 0, var_222_23)
				arg_219_1.mask_.color = var_222_24
			end

			if arg_219_1.time_ >= var_222_21 + var_222_22 and arg_219_1.time_ < var_222_21 + var_222_22 + arg_222_0 then
				local var_222_25 = Color.New(0, 0, 0)
				local var_222_26 = 0

				arg_219_1.mask_.enabled = false
				var_222_25.a = var_222_26
				arg_219_1.mask_.color = var_222_25
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_27 = 3.999999999999
			local var_222_28 = 1.375

			if var_222_27 < arg_219_1.time_ and arg_219_1.time_ <= var_222_27 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_29 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_29:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_30 = arg_219_1:GetWordFromCfg(426051054)
				local var_222_31 = arg_219_1:FormatText(var_222_30.content)

				arg_219_1.text_.text = var_222_31

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_32 = 55
				local var_222_33 = utf8.len(var_222_31)
				local var_222_34 = var_222_32 <= 0 and var_222_28 or var_222_28 * (var_222_33 / var_222_32)

				if var_222_34 > 0 and var_222_28 < var_222_34 then
					arg_219_1.talkMaxDuration = var_222_34
					var_222_27 = var_222_27 + 0.3

					if var_222_34 + var_222_27 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_34 + var_222_27
					end
				end

				arg_219_1.text_.text = var_222_31
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_35 = var_222_27 + 0.3
			local var_222_36 = math.max(var_222_28, arg_219_1.talkMaxDuration)

			if var_222_35 <= arg_219_1.time_ and arg_219_1.time_ < var_222_35 + var_222_36 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_35) / var_222_36

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_35 + var_222_36 and arg_219_1.time_ < var_222_35 + var_222_36 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play426051055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 426051055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play426051056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.2

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(426051055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 8
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_8 and arg_225_1.time_ < var_228_0 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play426051056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 426051056
		arg_229_1.duration_ = 6.4

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play426051057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.866666666666667
			local var_232_1 = 1

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				local var_232_2 = "play"
				local var_232_3 = "effect"

				arg_229_1:AudioAction(var_232_2, var_232_3, "se_story_140", "se_story_140_foley_hug", "")
			end

			local var_232_4 = manager.ui.mainCamera.transform
			local var_232_5 = 0.6

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				local var_232_6 = arg_229_1.var_.effectpuguolai1
				local var_232_7
				local var_232_8 = var_232_4

				if not var_232_6 then
					var_232_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_out"), var_232_8)
					var_232_6.name = "puguolai1"
					arg_229_1.var_.effectpuguolai1 = var_232_6
				else
					var_232_6.transform:SetParent(var_232_8)
				end

				var_232_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_232_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_232_9 = arg_229_1.bgs_.ST2007a.transform
			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1.var_.moveOldPosST2007a = var_232_9.localPosition
			end

			local var_232_11 = 1.6

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_11 then
				local var_232_12 = (arg_229_1.time_ - var_232_10) / var_232_11
				local var_232_13 = Vector3.New(0, 1, 9.5)

				var_232_9.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPosST2007a, var_232_13, var_232_12)
			end

			if arg_229_1.time_ >= var_232_10 + var_232_11 and arg_229_1.time_ < var_232_10 + var_232_11 + arg_232_0 then
				var_232_9.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_232_14 = 0

			if var_232_14 < arg_229_1.time_ and arg_229_1.time_ <= var_232_14 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			local var_232_15 = 2.1

			if arg_229_1.time_ >= var_232_14 + var_232_15 and arg_229_1.time_ < var_232_14 + var_232_15 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_16 = 1.4
			local var_232_17 = 1.325

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_18 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_18:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_19 = arg_229_1:GetWordFromCfg(426051056)
				local var_232_20 = arg_229_1:FormatText(var_232_19.content)

				arg_229_1.text_.text = var_232_20

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_21 = 53
				local var_232_22 = utf8.len(var_232_20)
				local var_232_23 = var_232_21 <= 0 and var_232_17 or var_232_17 * (var_232_22 / var_232_21)

				if var_232_23 > 0 and var_232_17 < var_232_23 then
					arg_229_1.talkMaxDuration = var_232_23
					var_232_16 = var_232_16 + 0.3

					if var_232_23 + var_232_16 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_16
					end
				end

				arg_229_1.text_.text = var_232_20
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_24 = var_232_16 + 0.3
			local var_232_25 = math.max(var_232_17, arg_229_1.talkMaxDuration)

			if var_232_24 <= arg_229_1.time_ and arg_229_1.time_ < var_232_24 + var_232_25 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_24) / var_232_25

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_24 + var_232_25 and arg_229_1.time_ < var_232_24 + var_232_25 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST2007a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.6,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play426051057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 426051057
		arg_235_1.duration_ = 2.2

		local var_235_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_235_0:Play426051058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["6148ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos6148ui_story = var_238_0.localPosition

				local var_238_2 = GameObjectTools.GetOrAddComponent(var_238_0.gameObject, typeof(DynamicBoneHelper))

				if var_238_2 then
					var_238_2:EnableDynamicBone(false)
				end
			end

			local var_238_3 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_3 then
				local var_238_4 = (arg_235_1.time_ - var_238_1) / var_238_3
				local var_238_5 = Vector3.New(0, -0.985, -6)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos6148ui_story, var_238_5, var_238_4)

				local var_238_6 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_6.x, var_238_6.y, var_238_6.z)

				local var_238_7 = var_238_0.localEulerAngles

				var_238_7.z = 0
				var_238_7.x = 0
				var_238_0.localEulerAngles = var_238_7
			end

			if arg_235_1.time_ >= var_238_1 + var_238_3 and arg_235_1.time_ < var_238_1 + var_238_3 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_238_8 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_8.x, var_238_8.y, var_238_8.z)

				local var_238_9 = var_238_0.localEulerAngles

				var_238_9.z = 0
				var_238_9.x = 0
				var_238_0.localEulerAngles = var_238_9

				local var_238_10 = GameObjectTools.GetOrAddComponent(var_238_0.gameObject, typeof(DynamicBoneHelper))

				if var_238_10 then
					var_238_10:EnableDynamicBone(true)
				end
			end

			local var_238_11 = arg_235_1.actors_["6148ui_story"]
			local var_238_12 = 0

			if var_238_12 < arg_235_1.time_ and arg_235_1.time_ <= var_238_12 + arg_238_0 and not isNil(var_238_11) and arg_235_1.var_.characterEffect6148ui_story == nil then
				arg_235_1.var_.characterEffect6148ui_story = var_238_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_13 = 0.200000002980232

			if var_238_12 <= arg_235_1.time_ and arg_235_1.time_ < var_238_12 + var_238_13 and not isNil(var_238_11) then
				local var_238_14 = (arg_235_1.time_ - var_238_12) / var_238_13

				if arg_235_1.var_.characterEffect6148ui_story and not isNil(var_238_11) then
					arg_235_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_12 + var_238_13 and arg_235_1.time_ < var_238_12 + var_238_13 + arg_238_0 and not isNil(var_238_11) and arg_235_1.var_.characterEffect6148ui_story then
				arg_235_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_238_15 = 0

			if var_238_15 < arg_235_1.time_ and arg_235_1.time_ <= var_238_15 + arg_238_0 then
				arg_235_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_238_17 = 0
			local var_238_18 = 0.225

			if var_238_17 < arg_235_1.time_ and arg_235_1.time_ <= var_238_17 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_19 = arg_235_1:FormatText(StoryNameCfg[1488].name)

				arg_235_1.leftNameTxt_.text = var_238_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_20 = arg_235_1:GetWordFromCfg(426051057)
				local var_238_21 = arg_235_1:FormatText(var_238_20.content)

				arg_235_1.text_.text = var_238_21

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_22 = 9
				local var_238_23 = utf8.len(var_238_21)
				local var_238_24 = var_238_22 <= 0 and var_238_18 or var_238_18 * (var_238_23 / var_238_22)

				if var_238_24 > 0 and var_238_18 < var_238_24 then
					arg_235_1.talkMaxDuration = var_238_24

					if var_238_24 + var_238_17 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_24 + var_238_17
					end
				end

				arg_235_1.text_.text = var_238_21
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051057", "story_v_out_426051.awb") ~= 0 then
					local var_238_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051057", "story_v_out_426051.awb") / 1000

					if var_238_25 + var_238_17 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_25 + var_238_17
					end

					if var_238_20.prefab_name ~= "" and arg_235_1.actors_[var_238_20.prefab_name] ~= nil then
						local var_238_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_20.prefab_name].transform, "story_v_out_426051", "426051057", "story_v_out_426051.awb")

						arg_235_1:RecordAudio("426051057", var_238_26)
						arg_235_1:RecordAudio("426051057", var_238_26)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_426051", "426051057", "story_v_out_426051.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_426051", "426051057", "story_v_out_426051.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_27 = math.max(var_238_18, arg_235_1.talkMaxDuration)

			if var_238_17 <= arg_235_1.time_ and arg_235_1.time_ < var_238_17 + var_238_27 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_17) / var_238_27

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_17 + var_238_27 and arg_235_1.time_ < var_238_17 + var_238_27 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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

		arg_235_1:InitPlayNodeList()
	end,
	Play426051058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 426051058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play426051059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["6148ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect6148ui_story == nil then
				arg_239_1.var_.characterEffect6148ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect6148ui_story and not isNil(var_242_0) then
					local var_242_4 = Mathf.Lerp(0, 0.5, var_242_3)

					arg_239_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_239_1.var_.characterEffect6148ui_story.fillRatio = var_242_4
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect6148ui_story then
				local var_242_5 = 0.5

				arg_239_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_239_1.var_.characterEffect6148ui_story.fillRatio = var_242_5
			end

			local var_242_6 = 0
			local var_242_7 = 0.075

			if var_242_6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_8 = arg_239_1:FormatText(StoryNameCfg[7].name)

				arg_239_1.leftNameTxt_.text = var_242_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_9 = arg_239_1:GetWordFromCfg(426051058)
				local var_242_10 = arg_239_1:FormatText(var_242_9.content)

				arg_239_1.text_.text = var_242_10

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 3
				local var_242_12 = utf8.len(var_242_10)
				local var_242_13 = var_242_11 <= 0 and var_242_7 or var_242_7 * (var_242_12 / var_242_11)

				if var_242_13 > 0 and var_242_7 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_10
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_14 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_14 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_14

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_14 and arg_239_1.time_ < var_242_6 + var_242_14 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play426051059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 426051059
		arg_243_1.duration_ = 2.07

		local var_243_0 = {
			zh = 2,
			ja = 2.066
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
				arg_243_0:Play426051060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1054ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1054ui_story = var_246_0.localPosition

				local var_246_2 = GameObjectTools.GetOrAddComponent(var_246_0.gameObject, typeof(DynamicBoneHelper))

				if var_246_2 then
					var_246_2:EnableDynamicBone(false)
				end
			end

			local var_246_3 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_3 then
				local var_246_4 = (arg_243_1.time_ - var_246_1) / var_246_3
				local var_246_5 = Vector3.New(0.7, -0.985, -6)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1054ui_story, var_246_5, var_246_4)

				local var_246_6 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_6.x, var_246_6.y, var_246_6.z)

				local var_246_7 = var_246_0.localEulerAngles

				var_246_7.z = 0
				var_246_7.x = 0
				var_246_0.localEulerAngles = var_246_7
			end

			if arg_243_1.time_ >= var_246_1 + var_246_3 and arg_243_1.time_ < var_246_1 + var_246_3 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_246_8 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_8.x, var_246_8.y, var_246_8.z)

				local var_246_9 = var_246_0.localEulerAngles

				var_246_9.z = 0
				var_246_9.x = 0
				var_246_0.localEulerAngles = var_246_9

				local var_246_10 = GameObjectTools.GetOrAddComponent(var_246_0.gameObject, typeof(DynamicBoneHelper))

				if var_246_10 then
					var_246_10:EnableDynamicBone(true)
				end
			end

			local var_246_11 = arg_243_1.actors_["6148ui_story"].transform
			local var_246_12 = 0

			if var_246_12 < arg_243_1.time_ and arg_243_1.time_ <= var_246_12 + arg_246_0 then
				arg_243_1.var_.moveOldPos6148ui_story = var_246_11.localPosition

				local var_246_13 = GameObjectTools.GetOrAddComponent(var_246_11.gameObject, typeof(DynamicBoneHelper))

				if var_246_13 then
					var_246_13:EnableDynamicBone(false)
				end
			end

			local var_246_14 = 0.001

			if var_246_12 <= arg_243_1.time_ and arg_243_1.time_ < var_246_12 + var_246_14 then
				local var_246_15 = (arg_243_1.time_ - var_246_12) / var_246_14
				local var_246_16 = Vector3.New(-0.7, -0.985, -6)

				var_246_11.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos6148ui_story, var_246_16, var_246_15)

				local var_246_17 = manager.ui.mainCamera.transform.position - var_246_11.position

				var_246_11.forward = Vector3.New(var_246_17.x, var_246_17.y, var_246_17.z)

				local var_246_18 = var_246_11.localEulerAngles

				var_246_18.z = 0
				var_246_18.x = 0
				var_246_11.localEulerAngles = var_246_18
			end

			if arg_243_1.time_ >= var_246_12 + var_246_14 and arg_243_1.time_ < var_246_12 + var_246_14 + arg_246_0 then
				var_246_11.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_246_19 = manager.ui.mainCamera.transform.position - var_246_11.position

				var_246_11.forward = Vector3.New(var_246_19.x, var_246_19.y, var_246_19.z)

				local var_246_20 = var_246_11.localEulerAngles

				var_246_20.z = 0
				var_246_20.x = 0
				var_246_11.localEulerAngles = var_246_20

				local var_246_21 = GameObjectTools.GetOrAddComponent(var_246_11.gameObject, typeof(DynamicBoneHelper))

				if var_246_21 then
					var_246_21:EnableDynamicBone(true)
				end
			end

			local var_246_22 = arg_243_1.actors_["1054ui_story"]
			local var_246_23 = 0

			if var_246_23 < arg_243_1.time_ and arg_243_1.time_ <= var_246_23 + arg_246_0 and not isNil(var_246_22) and arg_243_1.var_.characterEffect1054ui_story == nil then
				arg_243_1.var_.characterEffect1054ui_story = var_246_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_24 = 0.200000002980232

			if var_246_23 <= arg_243_1.time_ and arg_243_1.time_ < var_246_23 + var_246_24 and not isNil(var_246_22) then
				local var_246_25 = (arg_243_1.time_ - var_246_23) / var_246_24

				if arg_243_1.var_.characterEffect1054ui_story and not isNil(var_246_22) then
					arg_243_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_23 + var_246_24 and arg_243_1.time_ < var_246_23 + var_246_24 + arg_246_0 and not isNil(var_246_22) and arg_243_1.var_.characterEffect1054ui_story then
				arg_243_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_246_26 = 0

			if var_246_26 < arg_243_1.time_ and arg_243_1.time_ <= var_246_26 + arg_246_0 then
				arg_243_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_246_27 = 0

			if var_246_27 < arg_243_1.time_ and arg_243_1.time_ <= var_246_27 + arg_246_0 then
				arg_243_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_246_28 = 0
			local var_246_29 = 0.25

			if var_246_28 < arg_243_1.time_ and arg_243_1.time_ <= var_246_28 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_30 = arg_243_1:FormatText(StoryNameCfg[1487].name)

				arg_243_1.leftNameTxt_.text = var_246_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_31 = arg_243_1:GetWordFromCfg(426051059)
				local var_246_32 = arg_243_1:FormatText(var_246_31.content)

				arg_243_1.text_.text = var_246_32

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_33 = 10
				local var_246_34 = utf8.len(var_246_32)
				local var_246_35 = var_246_33 <= 0 and var_246_29 or var_246_29 * (var_246_34 / var_246_33)

				if var_246_35 > 0 and var_246_29 < var_246_35 then
					arg_243_1.talkMaxDuration = var_246_35

					if var_246_35 + var_246_28 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_35 + var_246_28
					end
				end

				arg_243_1.text_.text = var_246_32
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051059", "story_v_out_426051.awb") ~= 0 then
					local var_246_36 = manager.audio:GetVoiceLength("story_v_out_426051", "426051059", "story_v_out_426051.awb") / 1000

					if var_246_36 + var_246_28 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_36 + var_246_28
					end

					if var_246_31.prefab_name ~= "" and arg_243_1.actors_[var_246_31.prefab_name] ~= nil then
						local var_246_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_31.prefab_name].transform, "story_v_out_426051", "426051059", "story_v_out_426051.awb")

						arg_243_1:RecordAudio("426051059", var_246_37)
						arg_243_1:RecordAudio("426051059", var_246_37)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_426051", "426051059", "story_v_out_426051.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_426051", "426051059", "story_v_out_426051.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_38 = math.max(var_246_29, arg_243_1.talkMaxDuration)

			if var_246_28 <= arg_243_1.time_ and arg_243_1.time_ < var_246_28 + var_246_38 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_28) / var_246_38

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_28 + var_246_38 and arg_243_1.time_ < var_246_28 + var_246_38 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play426051060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 426051060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play426051061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1054ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1054ui_story == nil then
				arg_247_1.var_.characterEffect1054ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1054ui_story and not isNil(var_250_0) then
					local var_250_4 = Mathf.Lerp(0, 0.5, var_250_3)

					arg_247_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1054ui_story.fillRatio = var_250_4
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1054ui_story then
				local var_250_5 = 0.5

				arg_247_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1054ui_story.fillRatio = var_250_5
			end

			local var_250_6 = 0
			local var_250_7 = 0.275

			if var_250_6 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_8 = arg_247_1:FormatText(StoryNameCfg[7].name)

				arg_247_1.leftNameTxt_.text = var_250_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_9 = arg_247_1:GetWordFromCfg(426051060)
				local var_250_10 = arg_247_1:FormatText(var_250_9.content)

				arg_247_1.text_.text = var_250_10

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 11
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
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_14 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_14 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_14

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_14 and arg_247_1.time_ < var_250_6 + var_250_14 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play426051061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 426051061
		arg_251_1.duration_ = 2.1

		local var_251_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_251_0:Play426051062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["6148ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos6148ui_story = var_254_0.localPosition

				local var_254_2 = GameObjectTools.GetOrAddComponent(var_254_0.gameObject, typeof(DynamicBoneHelper))

				if var_254_2 then
					var_254_2:EnableDynamicBone(false)
				end
			end

			local var_254_3 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_3 then
				local var_254_4 = (arg_251_1.time_ - var_254_1) / var_254_3
				local var_254_5 = Vector3.New(-0.7, -0.985, -6)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos6148ui_story, var_254_5, var_254_4)

				local var_254_6 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_6.x, var_254_6.y, var_254_6.z)

				local var_254_7 = var_254_0.localEulerAngles

				var_254_7.z = 0
				var_254_7.x = 0
				var_254_0.localEulerAngles = var_254_7
			end

			if arg_251_1.time_ >= var_254_1 + var_254_3 and arg_251_1.time_ < var_254_1 + var_254_3 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_254_8 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_8.x, var_254_8.y, var_254_8.z)

				local var_254_9 = var_254_0.localEulerAngles

				var_254_9.z = 0
				var_254_9.x = 0
				var_254_0.localEulerAngles = var_254_9

				local var_254_10 = GameObjectTools.GetOrAddComponent(var_254_0.gameObject, typeof(DynamicBoneHelper))

				if var_254_10 then
					var_254_10:EnableDynamicBone(true)
				end
			end

			local var_254_11 = arg_251_1.actors_["6148ui_story"]
			local var_254_12 = 0

			if var_254_12 < arg_251_1.time_ and arg_251_1.time_ <= var_254_12 + arg_254_0 and not isNil(var_254_11) and arg_251_1.var_.characterEffect6148ui_story == nil then
				arg_251_1.var_.characterEffect6148ui_story = var_254_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_13 = 0.200000002980232

			if var_254_12 <= arg_251_1.time_ and arg_251_1.time_ < var_254_12 + var_254_13 and not isNil(var_254_11) then
				local var_254_14 = (arg_251_1.time_ - var_254_12) / var_254_13

				if arg_251_1.var_.characterEffect6148ui_story and not isNil(var_254_11) then
					arg_251_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_12 + var_254_13 and arg_251_1.time_ < var_254_12 + var_254_13 + arg_254_0 and not isNil(var_254_11) and arg_251_1.var_.characterEffect6148ui_story then
				arg_251_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_254_15 = 0

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_254_16 = 0

			if var_254_16 < arg_251_1.time_ and arg_251_1.time_ <= var_254_16 + arg_254_0 then
				arg_251_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_254_17 = 0
			local var_254_18 = 0.1

			if var_254_17 < arg_251_1.time_ and arg_251_1.time_ <= var_254_17 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_19 = arg_251_1:FormatText(StoryNameCfg[1488].name)

				arg_251_1.leftNameTxt_.text = var_254_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_20 = arg_251_1:GetWordFromCfg(426051061)
				local var_254_21 = arg_251_1:FormatText(var_254_20.content)

				arg_251_1.text_.text = var_254_21

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_22 = 4
				local var_254_23 = utf8.len(var_254_21)
				local var_254_24 = var_254_22 <= 0 and var_254_18 or var_254_18 * (var_254_23 / var_254_22)

				if var_254_24 > 0 and var_254_18 < var_254_24 then
					arg_251_1.talkMaxDuration = var_254_24

					if var_254_24 + var_254_17 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_24 + var_254_17
					end
				end

				arg_251_1.text_.text = var_254_21
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051061", "story_v_out_426051.awb") ~= 0 then
					local var_254_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051061", "story_v_out_426051.awb") / 1000

					if var_254_25 + var_254_17 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_25 + var_254_17
					end

					if var_254_20.prefab_name ~= "" and arg_251_1.actors_[var_254_20.prefab_name] ~= nil then
						local var_254_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_20.prefab_name].transform, "story_v_out_426051", "426051061", "story_v_out_426051.awb")

						arg_251_1:RecordAudio("426051061", var_254_26)
						arg_251_1:RecordAudio("426051061", var_254_26)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_426051", "426051061", "story_v_out_426051.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_426051", "426051061", "story_v_out_426051.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_27 = math.max(var_254_18, arg_251_1.talkMaxDuration)

			if var_254_17 <= arg_251_1.time_ and arg_251_1.time_ < var_254_17 + var_254_27 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_17) / var_254_27

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_17 + var_254_27 and arg_251_1.time_ < var_254_17 + var_254_27 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play426051062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 426051062
		arg_255_1.duration_ = 2

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play426051063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1054ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos1054ui_story = var_258_0.localPosition

				local var_258_2 = GameObjectTools.GetOrAddComponent(var_258_0.gameObject, typeof(DynamicBoneHelper))

				if var_258_2 then
					var_258_2:EnableDynamicBone(false)
				end
			end

			local var_258_3 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_3 then
				local var_258_4 = (arg_255_1.time_ - var_258_1) / var_258_3
				local var_258_5 = Vector3.New(0.7, -0.985, -6)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1054ui_story, var_258_5, var_258_4)

				local var_258_6 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_6.x, var_258_6.y, var_258_6.z)

				local var_258_7 = var_258_0.localEulerAngles

				var_258_7.z = 0
				var_258_7.x = 0
				var_258_0.localEulerAngles = var_258_7
			end

			if arg_255_1.time_ >= var_258_1 + var_258_3 and arg_255_1.time_ < var_258_1 + var_258_3 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_258_8 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_8.x, var_258_8.y, var_258_8.z)

				local var_258_9 = var_258_0.localEulerAngles

				var_258_9.z = 0
				var_258_9.x = 0
				var_258_0.localEulerAngles = var_258_9

				local var_258_10 = GameObjectTools.GetOrAddComponent(var_258_0.gameObject, typeof(DynamicBoneHelper))

				if var_258_10 then
					var_258_10:EnableDynamicBone(true)
				end
			end

			local var_258_11 = arg_255_1.actors_["1054ui_story"]
			local var_258_12 = 0

			if var_258_12 < arg_255_1.time_ and arg_255_1.time_ <= var_258_12 + arg_258_0 and not isNil(var_258_11) and arg_255_1.var_.characterEffect1054ui_story == nil then
				arg_255_1.var_.characterEffect1054ui_story = var_258_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_13 = 0.200000002980232

			if var_258_12 <= arg_255_1.time_ and arg_255_1.time_ < var_258_12 + var_258_13 and not isNil(var_258_11) then
				local var_258_14 = (arg_255_1.time_ - var_258_12) / var_258_13

				if arg_255_1.var_.characterEffect1054ui_story and not isNil(var_258_11) then
					arg_255_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_12 + var_258_13 and arg_255_1.time_ < var_258_12 + var_258_13 + arg_258_0 and not isNil(var_258_11) and arg_255_1.var_.characterEffect1054ui_story then
				arg_255_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_258_15 = arg_255_1.actors_["6148ui_story"]
			local var_258_16 = 0

			if var_258_16 < arg_255_1.time_ and arg_255_1.time_ <= var_258_16 + arg_258_0 and not isNil(var_258_15) and arg_255_1.var_.characterEffect6148ui_story == nil then
				arg_255_1.var_.characterEffect6148ui_story = var_258_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_17 = 0.200000002980232

			if var_258_16 <= arg_255_1.time_ and arg_255_1.time_ < var_258_16 + var_258_17 and not isNil(var_258_15) then
				local var_258_18 = (arg_255_1.time_ - var_258_16) / var_258_17

				if arg_255_1.var_.characterEffect6148ui_story and not isNil(var_258_15) then
					local var_258_19 = Mathf.Lerp(0, 0.5, var_258_18)

					arg_255_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_255_1.var_.characterEffect6148ui_story.fillRatio = var_258_19
				end
			end

			if arg_255_1.time_ >= var_258_16 + var_258_17 and arg_255_1.time_ < var_258_16 + var_258_17 + arg_258_0 and not isNil(var_258_15) and arg_255_1.var_.characterEffect6148ui_story then
				local var_258_20 = 0.5

				arg_255_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_255_1.var_.characterEffect6148ui_story.fillRatio = var_258_20
			end

			local var_258_21 = 0

			if var_258_21 < arg_255_1.time_ and arg_255_1.time_ <= var_258_21 + arg_258_0 then
				arg_255_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_258_22 = 0

			if var_258_22 < arg_255_1.time_ and arg_255_1.time_ <= var_258_22 + arg_258_0 then
				arg_255_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_258_23 = 0
			local var_258_24 = 0.075

			if var_258_23 < arg_255_1.time_ and arg_255_1.time_ <= var_258_23 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_25 = arg_255_1:FormatText(StoryNameCfg[1487].name)

				arg_255_1.leftNameTxt_.text = var_258_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_26 = arg_255_1:GetWordFromCfg(426051062)
				local var_258_27 = arg_255_1:FormatText(var_258_26.content)

				arg_255_1.text_.text = var_258_27

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_28 = 3
				local var_258_29 = utf8.len(var_258_27)
				local var_258_30 = var_258_28 <= 0 and var_258_24 or var_258_24 * (var_258_29 / var_258_28)

				if var_258_30 > 0 and var_258_24 < var_258_30 then
					arg_255_1.talkMaxDuration = var_258_30

					if var_258_30 + var_258_23 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_30 + var_258_23
					end
				end

				arg_255_1.text_.text = var_258_27
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051062", "story_v_out_426051.awb") ~= 0 then
					local var_258_31 = manager.audio:GetVoiceLength("story_v_out_426051", "426051062", "story_v_out_426051.awb") / 1000

					if var_258_31 + var_258_23 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_31 + var_258_23
					end

					if var_258_26.prefab_name ~= "" and arg_255_1.actors_[var_258_26.prefab_name] ~= nil then
						local var_258_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_26.prefab_name].transform, "story_v_out_426051", "426051062", "story_v_out_426051.awb")

						arg_255_1:RecordAudio("426051062", var_258_32)
						arg_255_1:RecordAudio("426051062", var_258_32)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_426051", "426051062", "story_v_out_426051.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_426051", "426051062", "story_v_out_426051.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_33 = math.max(var_258_24, arg_255_1.talkMaxDuration)

			if var_258_23 <= arg_255_1.time_ and arg_255_1.time_ < var_258_23 + var_258_33 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_23) / var_258_33

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_23 + var_258_33 and arg_255_1.time_ < var_258_23 + var_258_33 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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

		arg_255_1:InitPlayNodeList()
	end,
	Play426051063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 426051063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play426051064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1054ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1054ui_story == nil then
				arg_259_1.var_.characterEffect1054ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect1054ui_story and not isNil(var_262_0) then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1054ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1054ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1054ui_story.fillRatio = var_262_5
			end

			local var_262_6 = 0
			local var_262_7 = 0.4

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_9 = arg_259_1:GetWordFromCfg(426051063)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 16
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
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play426051064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 426051064
		arg_263_1.duration_ = 2

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play426051065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1054ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1054ui_story = var_266_0.localPosition

				local var_266_2 = GameObjectTools.GetOrAddComponent(var_266_0.gameObject, typeof(DynamicBoneHelper))

				if var_266_2 then
					var_266_2:EnableDynamicBone(false)
				end
			end

			local var_266_3 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_3 then
				local var_266_4 = (arg_263_1.time_ - var_266_1) / var_266_3
				local var_266_5 = Vector3.New(0.7, -0.985, -6)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1054ui_story, var_266_5, var_266_4)

				local var_266_6 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_6.x, var_266_6.y, var_266_6.z)

				local var_266_7 = var_266_0.localEulerAngles

				var_266_7.z = 0
				var_266_7.x = 0
				var_266_0.localEulerAngles = var_266_7
			end

			if arg_263_1.time_ >= var_266_1 + var_266_3 and arg_263_1.time_ < var_266_1 + var_266_3 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_266_8 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_8.x, var_266_8.y, var_266_8.z)

				local var_266_9 = var_266_0.localEulerAngles

				var_266_9.z = 0
				var_266_9.x = 0
				var_266_0.localEulerAngles = var_266_9

				local var_266_10 = GameObjectTools.GetOrAddComponent(var_266_0.gameObject, typeof(DynamicBoneHelper))

				if var_266_10 then
					var_266_10:EnableDynamicBone(true)
				end
			end

			local var_266_11 = arg_263_1.actors_["1054ui_story"]
			local var_266_12 = 0

			if var_266_12 < arg_263_1.time_ and arg_263_1.time_ <= var_266_12 + arg_266_0 and not isNil(var_266_11) and arg_263_1.var_.characterEffect1054ui_story == nil then
				arg_263_1.var_.characterEffect1054ui_story = var_266_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_13 = 0.200000002980232

			if var_266_12 <= arg_263_1.time_ and arg_263_1.time_ < var_266_12 + var_266_13 and not isNil(var_266_11) then
				local var_266_14 = (arg_263_1.time_ - var_266_12) / var_266_13

				if arg_263_1.var_.characterEffect1054ui_story and not isNil(var_266_11) then
					arg_263_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_12 + var_266_13 and arg_263_1.time_ < var_266_12 + var_266_13 + arg_266_0 and not isNil(var_266_11) and arg_263_1.var_.characterEffect1054ui_story then
				arg_263_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_266_15 = 0

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			local var_266_16 = 0

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_266_17 = 0
			local var_266_18 = 0.05

			if var_266_17 < arg_263_1.time_ and arg_263_1.time_ <= var_266_17 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_19 = arg_263_1:FormatText(StoryNameCfg[1487].name)

				arg_263_1.leftNameTxt_.text = var_266_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_20 = arg_263_1:GetWordFromCfg(426051064)
				local var_266_21 = arg_263_1:FormatText(var_266_20.content)

				arg_263_1.text_.text = var_266_21

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_22 = 2
				local var_266_23 = utf8.len(var_266_21)
				local var_266_24 = var_266_22 <= 0 and var_266_18 or var_266_18 * (var_266_23 / var_266_22)

				if var_266_24 > 0 and var_266_18 < var_266_24 then
					arg_263_1.talkMaxDuration = var_266_24

					if var_266_24 + var_266_17 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_24 + var_266_17
					end
				end

				arg_263_1.text_.text = var_266_21
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051064", "story_v_out_426051.awb") ~= 0 then
					local var_266_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051064", "story_v_out_426051.awb") / 1000

					if var_266_25 + var_266_17 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_25 + var_266_17
					end

					if var_266_20.prefab_name ~= "" and arg_263_1.actors_[var_266_20.prefab_name] ~= nil then
						local var_266_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_20.prefab_name].transform, "story_v_out_426051", "426051064", "story_v_out_426051.awb")

						arg_263_1:RecordAudio("426051064", var_266_26)
						arg_263_1:RecordAudio("426051064", var_266_26)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_426051", "426051064", "story_v_out_426051.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_426051", "426051064", "story_v_out_426051.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_27 = math.max(var_266_18, arg_263_1.talkMaxDuration)

			if var_266_17 <= arg_263_1.time_ and arg_263_1.time_ < var_266_17 + var_266_27 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_17) / var_266_27

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_17 + var_266_27 and arg_263_1.time_ < var_266_17 + var_266_27 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play426051065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 426051065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play426051066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1054ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1054ui_story == nil then
				arg_267_1.var_.characterEffect1054ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect1054ui_story and not isNil(var_270_0) then
					local var_270_4 = Mathf.Lerp(0, 0.5, var_270_3)

					arg_267_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1054ui_story.fillRatio = var_270_4
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1054ui_story then
				local var_270_5 = 0.5

				arg_267_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1054ui_story.fillRatio = var_270_5
			end

			local var_270_6 = 0
			local var_270_7 = 0.25

			if var_270_6 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_8 = arg_267_1:FormatText(StoryNameCfg[7].name)

				arg_267_1.leftNameTxt_.text = var_270_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_9 = arg_267_1:GetWordFromCfg(426051065)
				local var_270_10 = arg_267_1:FormatText(var_270_9.content)

				arg_267_1.text_.text = var_270_10

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_11 = 10
				local var_270_12 = utf8.len(var_270_10)
				local var_270_13 = var_270_11 <= 0 and var_270_7 or var_270_7 * (var_270_12 / var_270_11)

				if var_270_13 > 0 and var_270_7 < var_270_13 then
					arg_267_1.talkMaxDuration = var_270_13

					if var_270_13 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_13 + var_270_6
					end
				end

				arg_267_1.text_.text = var_270_10
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_14 = math.max(var_270_7, arg_267_1.talkMaxDuration)

			if var_270_6 <= arg_267_1.time_ and arg_267_1.time_ < var_270_6 + var_270_14 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_6) / var_270_14

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_6 + var_270_14 and arg_267_1.time_ < var_270_6 + var_270_14 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play426051066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 426051066
		arg_271_1.duration_ = 2

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play426051067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["6148ui_story"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos6148ui_story = var_274_0.localPosition

				local var_274_2 = GameObjectTools.GetOrAddComponent(var_274_0.gameObject, typeof(DynamicBoneHelper))

				if var_274_2 then
					var_274_2:EnableDynamicBone(false)
				end
			end

			local var_274_3 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_3 then
				local var_274_4 = (arg_271_1.time_ - var_274_1) / var_274_3
				local var_274_5 = Vector3.New(-0.7, -0.985, -6)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos6148ui_story, var_274_5, var_274_4)

				local var_274_6 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_6.x, var_274_6.y, var_274_6.z)

				local var_274_7 = var_274_0.localEulerAngles

				var_274_7.z = 0
				var_274_7.x = 0
				var_274_0.localEulerAngles = var_274_7
			end

			if arg_271_1.time_ >= var_274_1 + var_274_3 and arg_271_1.time_ < var_274_1 + var_274_3 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_274_8 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_8.x, var_274_8.y, var_274_8.z)

				local var_274_9 = var_274_0.localEulerAngles

				var_274_9.z = 0
				var_274_9.x = 0
				var_274_0.localEulerAngles = var_274_9

				local var_274_10 = GameObjectTools.GetOrAddComponent(var_274_0.gameObject, typeof(DynamicBoneHelper))

				if var_274_10 then
					var_274_10:EnableDynamicBone(true)
				end
			end

			local var_274_11 = arg_271_1.actors_["6148ui_story"]
			local var_274_12 = 0

			if var_274_12 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 and not isNil(var_274_11) and arg_271_1.var_.characterEffect6148ui_story == nil then
				arg_271_1.var_.characterEffect6148ui_story = var_274_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_13 = 0.200000002980232

			if var_274_12 <= arg_271_1.time_ and arg_271_1.time_ < var_274_12 + var_274_13 and not isNil(var_274_11) then
				local var_274_14 = (arg_271_1.time_ - var_274_12) / var_274_13

				if arg_271_1.var_.characterEffect6148ui_story and not isNil(var_274_11) then
					arg_271_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_12 + var_274_13 and arg_271_1.time_ < var_274_12 + var_274_13 + arg_274_0 and not isNil(var_274_11) and arg_271_1.var_.characterEffect6148ui_story then
				arg_271_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_274_15 = 0

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_274_16 = 0

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_274_17 = 0
			local var_274_18 = 0.125

			if var_274_17 < arg_271_1.time_ and arg_271_1.time_ <= var_274_17 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_19 = arg_271_1:FormatText(StoryNameCfg[1488].name)

				arg_271_1.leftNameTxt_.text = var_274_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_20 = arg_271_1:GetWordFromCfg(426051066)
				local var_274_21 = arg_271_1:FormatText(var_274_20.content)

				arg_271_1.text_.text = var_274_21

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_22 = 5
				local var_274_23 = utf8.len(var_274_21)
				local var_274_24 = var_274_22 <= 0 and var_274_18 or var_274_18 * (var_274_23 / var_274_22)

				if var_274_24 > 0 and var_274_18 < var_274_24 then
					arg_271_1.talkMaxDuration = var_274_24

					if var_274_24 + var_274_17 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_24 + var_274_17
					end
				end

				arg_271_1.text_.text = var_274_21
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051066", "story_v_out_426051.awb") ~= 0 then
					local var_274_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051066", "story_v_out_426051.awb") / 1000

					if var_274_25 + var_274_17 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_25 + var_274_17
					end

					if var_274_20.prefab_name ~= "" and arg_271_1.actors_[var_274_20.prefab_name] ~= nil then
						local var_274_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_20.prefab_name].transform, "story_v_out_426051", "426051066", "story_v_out_426051.awb")

						arg_271_1:RecordAudio("426051066", var_274_26)
						arg_271_1:RecordAudio("426051066", var_274_26)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_426051", "426051066", "story_v_out_426051.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_426051", "426051066", "story_v_out_426051.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_27 = math.max(var_274_18, arg_271_1.talkMaxDuration)

			if var_274_17 <= arg_271_1.time_ and arg_271_1.time_ < var_274_17 + var_274_27 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_17) / var_274_27

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_17 + var_274_27 and arg_271_1.time_ < var_274_17 + var_274_27 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play426051067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 426051067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play426051068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["6148ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect6148ui_story == nil then
				arg_275_1.var_.characterEffect6148ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect6148ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_275_1.var_.characterEffect6148ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect6148ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_275_1.var_.characterEffect6148ui_story.fillRatio = var_278_5
			end

			local var_278_6 = 0
			local var_278_7 = 0.275

			if var_278_6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_8 = arg_275_1:FormatText(StoryNameCfg[7].name)

				arg_275_1.leftNameTxt_.text = var_278_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_9 = arg_275_1:GetWordFromCfg(426051067)
				local var_278_10 = arg_275_1:FormatText(var_278_9.content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 11
				local var_278_12 = utf8.len(var_278_10)
				local var_278_13 = var_278_11 <= 0 and var_278_7 or var_278_7 * (var_278_12 / var_278_11)

				if var_278_13 > 0 and var_278_7 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_10
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play426051068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 426051068
		arg_279_1.duration_ = 1

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"

			SetActive(arg_279_1.choicesGo_, true)

			for iter_280_0, iter_280_1 in ipairs(arg_279_1.choices_) do
				local var_280_0 = iter_280_0 <= 1

				SetActive(iter_280_1.go, var_280_0)
			end

			arg_279_1.choices_[1].txt.text = arg_279_1:FormatText(StoryChoiceCfg[1605].name)
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play426051069(arg_279_1)
			end

			arg_279_1:RecordChoiceLog(426051068, 1605)
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.allBtn_.enabled = false
			end

			local var_282_1 = 0.6

			if arg_279_1.time_ >= var_282_0 + var_282_1 and arg_279_1.time_ < var_282_0 + var_282_1 + arg_282_0 then
				arg_279_1.allBtn_.enabled = true
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play426051069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 426051069
		arg_283_1.duration_ = 2.37

		local var_283_0 = {
			zh = 1.966,
			ja = 2.366
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play426051070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1054ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1054ui_story == nil then
				arg_283_1.var_.characterEffect1054ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1054ui_story and not isNil(var_286_0) then
					arg_283_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1054ui_story then
				arg_283_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_286_4 = arg_283_1.actors_["6148ui_story"]
			local var_286_5 = 0

			if var_286_5 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect6148ui_story == nil then
				arg_283_1.var_.characterEffect6148ui_story = var_286_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_6 = 0.200000002980232

			if var_286_5 <= arg_283_1.time_ and arg_283_1.time_ < var_286_5 + var_286_6 and not isNil(var_286_4) then
				local var_286_7 = (arg_283_1.time_ - var_286_5) / var_286_6

				if arg_283_1.var_.characterEffect6148ui_story and not isNil(var_286_4) then
					arg_283_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_5 + var_286_6 and arg_283_1.time_ < var_286_5 + var_286_6 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect6148ui_story then
				arg_283_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_286_8 = 0
			local var_286_9 = 0.075

			if var_286_8 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_10 = arg_283_1:FormatText(StoryNameCfg[1489].name)

				arg_283_1.leftNameTxt_.text = var_286_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_11 = arg_283_1:GetWordFromCfg(426051069)
				local var_286_12 = arg_283_1:FormatText(var_286_11.content)

				arg_283_1.text_.text = var_286_12

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 3
				local var_286_14 = utf8.len(var_286_12)
				local var_286_15 = var_286_13 <= 0 and var_286_9 or var_286_9 * (var_286_14 / var_286_13)

				if var_286_15 > 0 and var_286_9 < var_286_15 then
					arg_283_1.talkMaxDuration = var_286_15

					if var_286_15 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_12
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051069", "story_v_out_426051.awb") ~= 0 then
					local var_286_16 = manager.audio:GetVoiceLength("story_v_out_426051", "426051069", "story_v_out_426051.awb") / 1000

					if var_286_16 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_16 + var_286_8
					end

					if var_286_11.prefab_name ~= "" and arg_283_1.actors_[var_286_11.prefab_name] ~= nil then
						local var_286_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_11.prefab_name].transform, "story_v_out_426051", "426051069", "story_v_out_426051.awb")

						arg_283_1:RecordAudio("426051069", var_286_17)
						arg_283_1:RecordAudio("426051069", var_286_17)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_426051", "426051069", "story_v_out_426051.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_426051", "426051069", "story_v_out_426051.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_18 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_18 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_18

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_18 and arg_283_1.time_ < var_286_8 + var_286_18 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play426051070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 426051070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play426051071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1054ui_story"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1054ui_story == nil then
				arg_287_1.var_.characterEffect1054ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.characterEffect1054ui_story and not isNil(var_290_0) then
					local var_290_4 = Mathf.Lerp(0, 0.5, var_290_3)

					arg_287_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1054ui_story.fillRatio = var_290_4
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1054ui_story then
				local var_290_5 = 0.5

				arg_287_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1054ui_story.fillRatio = var_290_5
			end

			local var_290_6 = arg_287_1.actors_["6148ui_story"]
			local var_290_7 = 0

			if var_290_7 < arg_287_1.time_ and arg_287_1.time_ <= var_290_7 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect6148ui_story == nil then
				arg_287_1.var_.characterEffect6148ui_story = var_290_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_8 = 0.200000002980232

			if var_290_7 <= arg_287_1.time_ and arg_287_1.time_ < var_290_7 + var_290_8 and not isNil(var_290_6) then
				local var_290_9 = (arg_287_1.time_ - var_290_7) / var_290_8

				if arg_287_1.var_.characterEffect6148ui_story and not isNil(var_290_6) then
					local var_290_10 = Mathf.Lerp(0, 0.5, var_290_9)

					arg_287_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_287_1.var_.characterEffect6148ui_story.fillRatio = var_290_10
				end
			end

			if arg_287_1.time_ >= var_290_7 + var_290_8 and arg_287_1.time_ < var_290_7 + var_290_8 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect6148ui_story then
				local var_290_11 = 0.5

				arg_287_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_287_1.var_.characterEffect6148ui_story.fillRatio = var_290_11
			end

			local var_290_12 = 0
			local var_290_13 = 0.9

			if var_290_12 < arg_287_1.time_ and arg_287_1.time_ <= var_290_12 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_14 = arg_287_1:FormatText(StoryNameCfg[7].name)

				arg_287_1.leftNameTxt_.text = var_290_14

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

				local var_290_15 = arg_287_1:GetWordFromCfg(426051070)
				local var_290_16 = arg_287_1:FormatText(var_290_15.content)

				arg_287_1.text_.text = var_290_16

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_17 = 36
				local var_290_18 = utf8.len(var_290_16)
				local var_290_19 = var_290_17 <= 0 and var_290_13 or var_290_13 * (var_290_18 / var_290_17)

				if var_290_19 > 0 and var_290_13 < var_290_19 then
					arg_287_1.talkMaxDuration = var_290_19

					if var_290_19 + var_290_12 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_19 + var_290_12
					end
				end

				arg_287_1.text_.text = var_290_16
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_20 = math.max(var_290_13, arg_287_1.talkMaxDuration)

			if var_290_12 <= arg_287_1.time_ and arg_287_1.time_ < var_290_12 + var_290_20 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_12) / var_290_20

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_12 + var_290_20 and arg_287_1.time_ < var_290_12 + var_290_20 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play426051071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 426051071
		arg_291_1.duration_ = 5.7

		local var_291_0 = {
			zh = 5.7,
			ja = 4.7
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play426051072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["6148ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos6148ui_story = var_294_0.localPosition

				local var_294_2 = GameObjectTools.GetOrAddComponent(var_294_0.gameObject, typeof(DynamicBoneHelper))

				if var_294_2 then
					var_294_2:EnableDynamicBone(false)
				end
			end

			local var_294_3 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_3 then
				local var_294_4 = (arg_291_1.time_ - var_294_1) / var_294_3
				local var_294_5 = Vector3.New(-0.7, -0.985, -6)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos6148ui_story, var_294_5, var_294_4)

				local var_294_6 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_6.x, var_294_6.y, var_294_6.z)

				local var_294_7 = var_294_0.localEulerAngles

				var_294_7.z = 0
				var_294_7.x = 0
				var_294_0.localEulerAngles = var_294_7
			end

			if arg_291_1.time_ >= var_294_1 + var_294_3 and arg_291_1.time_ < var_294_1 + var_294_3 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_294_8 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_8.x, var_294_8.y, var_294_8.z)

				local var_294_9 = var_294_0.localEulerAngles

				var_294_9.z = 0
				var_294_9.x = 0
				var_294_0.localEulerAngles = var_294_9

				local var_294_10 = GameObjectTools.GetOrAddComponent(var_294_0.gameObject, typeof(DynamicBoneHelper))

				if var_294_10 then
					var_294_10:EnableDynamicBone(true)
				end
			end

			local var_294_11 = arg_291_1.actors_["6148ui_story"]
			local var_294_12 = 0

			if var_294_12 < arg_291_1.time_ and arg_291_1.time_ <= var_294_12 + arg_294_0 and not isNil(var_294_11) and arg_291_1.var_.characterEffect6148ui_story == nil then
				arg_291_1.var_.characterEffect6148ui_story = var_294_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_13 = 0.200000002980232

			if var_294_12 <= arg_291_1.time_ and arg_291_1.time_ < var_294_12 + var_294_13 and not isNil(var_294_11) then
				local var_294_14 = (arg_291_1.time_ - var_294_12) / var_294_13

				if arg_291_1.var_.characterEffect6148ui_story and not isNil(var_294_11) then
					arg_291_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_12 + var_294_13 and arg_291_1.time_ < var_294_12 + var_294_13 + arg_294_0 and not isNil(var_294_11) and arg_291_1.var_.characterEffect6148ui_story then
				arg_291_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_294_15 = 0

			if var_294_15 < arg_291_1.time_ and arg_291_1.time_ <= var_294_15 + arg_294_0 then
				arg_291_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_294_16 = 0

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				arg_291_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_294_17 = 0
			local var_294_18 = 0.65

			if var_294_17 < arg_291_1.time_ and arg_291_1.time_ <= var_294_17 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_19 = arg_291_1:FormatText(StoryNameCfg[1488].name)

				arg_291_1.leftNameTxt_.text = var_294_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_20 = arg_291_1:GetWordFromCfg(426051071)
				local var_294_21 = arg_291_1:FormatText(var_294_20.content)

				arg_291_1.text_.text = var_294_21

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_22 = 26
				local var_294_23 = utf8.len(var_294_21)
				local var_294_24 = var_294_22 <= 0 and var_294_18 or var_294_18 * (var_294_23 / var_294_22)

				if var_294_24 > 0 and var_294_18 < var_294_24 then
					arg_291_1.talkMaxDuration = var_294_24

					if var_294_24 + var_294_17 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_24 + var_294_17
					end
				end

				arg_291_1.text_.text = var_294_21
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051071", "story_v_out_426051.awb") ~= 0 then
					local var_294_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051071", "story_v_out_426051.awb") / 1000

					if var_294_25 + var_294_17 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_25 + var_294_17
					end

					if var_294_20.prefab_name ~= "" and arg_291_1.actors_[var_294_20.prefab_name] ~= nil then
						local var_294_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_20.prefab_name].transform, "story_v_out_426051", "426051071", "story_v_out_426051.awb")

						arg_291_1:RecordAudio("426051071", var_294_26)
						arg_291_1:RecordAudio("426051071", var_294_26)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_426051", "426051071", "story_v_out_426051.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_426051", "426051071", "story_v_out_426051.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_27 = math.max(var_294_18, arg_291_1.talkMaxDuration)

			if var_294_17 <= arg_291_1.time_ and arg_291_1.time_ < var_294_17 + var_294_27 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_17) / var_294_27

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_17 + var_294_27 and arg_291_1.time_ < var_294_17 + var_294_27 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play426051072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 426051072
		arg_295_1.duration_ = 5.67

		local var_295_0 = {
			zh = 5.666,
			ja = 3.9
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play426051073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["6148ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos6148ui_story = var_298_0.localPosition

				local var_298_2 = GameObjectTools.GetOrAddComponent(var_298_0.gameObject, typeof(DynamicBoneHelper))

				if var_298_2 then
					var_298_2:EnableDynamicBone(false)
				end
			end

			local var_298_3 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_3 then
				local var_298_4 = (arg_295_1.time_ - var_298_1) / var_298_3
				local var_298_5 = Vector3.New(-0.7, -0.985, -6)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos6148ui_story, var_298_5, var_298_4)

				local var_298_6 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_6.x, var_298_6.y, var_298_6.z)

				local var_298_7 = var_298_0.localEulerAngles

				var_298_7.z = 0
				var_298_7.x = 0
				var_298_0.localEulerAngles = var_298_7
			end

			if arg_295_1.time_ >= var_298_1 + var_298_3 and arg_295_1.time_ < var_298_1 + var_298_3 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_298_8 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_8.x, var_298_8.y, var_298_8.z)

				local var_298_9 = var_298_0.localEulerAngles

				var_298_9.z = 0
				var_298_9.x = 0
				var_298_0.localEulerAngles = var_298_9

				local var_298_10 = GameObjectTools.GetOrAddComponent(var_298_0.gameObject, typeof(DynamicBoneHelper))

				if var_298_10 then
					var_298_10:EnableDynamicBone(true)
				end
			end

			local var_298_11 = 0

			if var_298_11 < arg_295_1.time_ and arg_295_1.time_ <= var_298_11 + arg_298_0 then
				arg_295_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_298_12 = 0

			if var_298_12 < arg_295_1.time_ and arg_295_1.time_ <= var_298_12 + arg_298_0 then
				arg_295_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_298_13 = 0
			local var_298_14 = 0.625

			if var_298_13 < arg_295_1.time_ and arg_295_1.time_ <= var_298_13 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_15 = arg_295_1:FormatText(StoryNameCfg[1488].name)

				arg_295_1.leftNameTxt_.text = var_298_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_16 = arg_295_1:GetWordFromCfg(426051072)
				local var_298_17 = arg_295_1:FormatText(var_298_16.content)

				arg_295_1.text_.text = var_298_17

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_18 = 25
				local var_298_19 = utf8.len(var_298_17)
				local var_298_20 = var_298_18 <= 0 and var_298_14 or var_298_14 * (var_298_19 / var_298_18)

				if var_298_20 > 0 and var_298_14 < var_298_20 then
					arg_295_1.talkMaxDuration = var_298_20

					if var_298_20 + var_298_13 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_20 + var_298_13
					end
				end

				arg_295_1.text_.text = var_298_17
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051072", "story_v_out_426051.awb") ~= 0 then
					local var_298_21 = manager.audio:GetVoiceLength("story_v_out_426051", "426051072", "story_v_out_426051.awb") / 1000

					if var_298_21 + var_298_13 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_21 + var_298_13
					end

					if var_298_16.prefab_name ~= "" and arg_295_1.actors_[var_298_16.prefab_name] ~= nil then
						local var_298_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_16.prefab_name].transform, "story_v_out_426051", "426051072", "story_v_out_426051.awb")

						arg_295_1:RecordAudio("426051072", var_298_22)
						arg_295_1:RecordAudio("426051072", var_298_22)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_426051", "426051072", "story_v_out_426051.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_426051", "426051072", "story_v_out_426051.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_23 = math.max(var_298_14, arg_295_1.talkMaxDuration)

			if var_298_13 <= arg_295_1.time_ and arg_295_1.time_ < var_298_13 + var_298_23 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_13) / var_298_23

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_13 + var_298_23 and arg_295_1.time_ < var_298_13 + var_298_23 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play426051073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 426051073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play426051074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["6148ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect6148ui_story == nil then
				arg_299_1.var_.characterEffect6148ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect6148ui_story and not isNil(var_302_0) then
					local var_302_4 = Mathf.Lerp(0, 0.5, var_302_3)

					arg_299_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_299_1.var_.characterEffect6148ui_story.fillRatio = var_302_4
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect6148ui_story then
				local var_302_5 = 0.5

				arg_299_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_299_1.var_.characterEffect6148ui_story.fillRatio = var_302_5
			end

			local var_302_6 = 0
			local var_302_7 = 0.775

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_8 = arg_299_1:FormatText(StoryNameCfg[7].name)

				arg_299_1.leftNameTxt_.text = var_302_8

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

				local var_302_9 = arg_299_1:GetWordFromCfg(426051073)
				local var_302_10 = arg_299_1:FormatText(var_302_9.content)

				arg_299_1.text_.text = var_302_10

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 31
				local var_302_12 = utf8.len(var_302_10)
				local var_302_13 = var_302_11 <= 0 and var_302_7 or var_302_7 * (var_302_12 / var_302_11)

				if var_302_13 > 0 and var_302_7 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_10
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_14 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_14 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_14

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_14 and arg_299_1.time_ < var_302_6 + var_302_14 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play426051074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 426051074
		arg_303_1.duration_ = 2

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play426051075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1054ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos1054ui_story = var_306_0.localPosition

				local var_306_2 = GameObjectTools.GetOrAddComponent(var_306_0.gameObject, typeof(DynamicBoneHelper))

				if var_306_2 then
					var_306_2:EnableDynamicBone(false)
				end
			end

			local var_306_3 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_3 then
				local var_306_4 = (arg_303_1.time_ - var_306_1) / var_306_3
				local var_306_5 = Vector3.New(0.7, -0.985, -6)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1054ui_story, var_306_5, var_306_4)

				local var_306_6 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_6.x, var_306_6.y, var_306_6.z)

				local var_306_7 = var_306_0.localEulerAngles

				var_306_7.z = 0
				var_306_7.x = 0
				var_306_0.localEulerAngles = var_306_7
			end

			if arg_303_1.time_ >= var_306_1 + var_306_3 and arg_303_1.time_ < var_306_1 + var_306_3 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_306_8 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_8.x, var_306_8.y, var_306_8.z)

				local var_306_9 = var_306_0.localEulerAngles

				var_306_9.z = 0
				var_306_9.x = 0
				var_306_0.localEulerAngles = var_306_9

				local var_306_10 = GameObjectTools.GetOrAddComponent(var_306_0.gameObject, typeof(DynamicBoneHelper))

				if var_306_10 then
					var_306_10:EnableDynamicBone(true)
				end
			end

			local var_306_11 = arg_303_1.actors_["1054ui_story"]
			local var_306_12 = 0

			if var_306_12 < arg_303_1.time_ and arg_303_1.time_ <= var_306_12 + arg_306_0 and not isNil(var_306_11) and arg_303_1.var_.characterEffect1054ui_story == nil then
				arg_303_1.var_.characterEffect1054ui_story = var_306_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_13 = 0.200000002980232

			if var_306_12 <= arg_303_1.time_ and arg_303_1.time_ < var_306_12 + var_306_13 and not isNil(var_306_11) then
				local var_306_14 = (arg_303_1.time_ - var_306_12) / var_306_13

				if arg_303_1.var_.characterEffect1054ui_story and not isNil(var_306_11) then
					arg_303_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_12 + var_306_13 and arg_303_1.time_ < var_306_12 + var_306_13 + arg_306_0 and not isNil(var_306_11) and arg_303_1.var_.characterEffect1054ui_story then
				arg_303_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_306_15 = 0

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				arg_303_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_306_16 = 0

			if var_306_16 < arg_303_1.time_ and arg_303_1.time_ <= var_306_16 + arg_306_0 then
				arg_303_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_306_17 = 0
			local var_306_18 = 0.175

			if var_306_17 < arg_303_1.time_ and arg_303_1.time_ <= var_306_17 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_19 = arg_303_1:FormatText(StoryNameCfg[1487].name)

				arg_303_1.leftNameTxt_.text = var_306_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_20 = arg_303_1:GetWordFromCfg(426051074)
				local var_306_21 = arg_303_1:FormatText(var_306_20.content)

				arg_303_1.text_.text = var_306_21

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_22 = 7
				local var_306_23 = utf8.len(var_306_21)
				local var_306_24 = var_306_22 <= 0 and var_306_18 or var_306_18 * (var_306_23 / var_306_22)

				if var_306_24 > 0 and var_306_18 < var_306_24 then
					arg_303_1.talkMaxDuration = var_306_24

					if var_306_24 + var_306_17 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_24 + var_306_17
					end
				end

				arg_303_1.text_.text = var_306_21
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051074", "story_v_out_426051.awb") ~= 0 then
					local var_306_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051074", "story_v_out_426051.awb") / 1000

					if var_306_25 + var_306_17 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_25 + var_306_17
					end

					if var_306_20.prefab_name ~= "" and arg_303_1.actors_[var_306_20.prefab_name] ~= nil then
						local var_306_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_20.prefab_name].transform, "story_v_out_426051", "426051074", "story_v_out_426051.awb")

						arg_303_1:RecordAudio("426051074", var_306_26)
						arg_303_1:RecordAudio("426051074", var_306_26)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_426051", "426051074", "story_v_out_426051.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_426051", "426051074", "story_v_out_426051.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_27 = math.max(var_306_18, arg_303_1.talkMaxDuration)

			if var_306_17 <= arg_303_1.time_ and arg_303_1.time_ < var_306_17 + var_306_27 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_17) / var_306_27

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_17 + var_306_27 and arg_303_1.time_ < var_306_17 + var_306_27 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play426051075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 426051075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play426051076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1054ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1054ui_story == nil then
				arg_307_1.var_.characterEffect1054ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect1054ui_story and not isNil(var_310_0) then
					local var_310_4 = Mathf.Lerp(0, 0.5, var_310_3)

					arg_307_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1054ui_story.fillRatio = var_310_4
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1054ui_story then
				local var_310_5 = 0.5

				arg_307_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1054ui_story.fillRatio = var_310_5
			end

			local var_310_6 = 0
			local var_310_7 = 0.375

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

				local var_310_9 = arg_307_1:GetWordFromCfg(426051075)
				local var_310_10 = arg_307_1:FormatText(var_310_9.content)

				arg_307_1.text_.text = var_310_10

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 15
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
	Play426051076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 426051076
		arg_311_1.duration_ = 2.2

		local var_311_0 = {
			zh = 2.066,
			ja = 2.2
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play426051077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1054ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1054ui_story == nil then
				arg_311_1.var_.characterEffect1054ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect1054ui_story and not isNil(var_314_0) then
					arg_311_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect1054ui_story then
				arg_311_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_314_4 = arg_311_1.actors_["6148ui_story"]
			local var_314_5 = 0

			if var_314_5 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 and not isNil(var_314_4) and arg_311_1.var_.characterEffect6148ui_story == nil then
				arg_311_1.var_.characterEffect6148ui_story = var_314_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_6 = 0.200000002980232

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_6 and not isNil(var_314_4) then
				local var_314_7 = (arg_311_1.time_ - var_314_5) / var_314_6

				if arg_311_1.var_.characterEffect6148ui_story and not isNil(var_314_4) then
					arg_311_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_5 + var_314_6 and arg_311_1.time_ < var_314_5 + var_314_6 + arg_314_0 and not isNil(var_314_4) and arg_311_1.var_.characterEffect6148ui_story then
				arg_311_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_314_8 = 0
			local var_314_9 = 0.075

			if var_314_8 < arg_311_1.time_ and arg_311_1.time_ <= var_314_8 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_10 = arg_311_1:FormatText(StoryNameCfg[1489].name)

				arg_311_1.leftNameTxt_.text = var_314_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_11 = arg_311_1:GetWordFromCfg(426051076)
				local var_314_12 = arg_311_1:FormatText(var_314_11.content)

				arg_311_1.text_.text = var_314_12

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_13 = 3
				local var_314_14 = utf8.len(var_314_12)
				local var_314_15 = var_314_13 <= 0 and var_314_9 or var_314_9 * (var_314_14 / var_314_13)

				if var_314_15 > 0 and var_314_9 < var_314_15 then
					arg_311_1.talkMaxDuration = var_314_15

					if var_314_15 + var_314_8 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_15 + var_314_8
					end
				end

				arg_311_1.text_.text = var_314_12
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051076", "story_v_out_426051.awb") ~= 0 then
					local var_314_16 = manager.audio:GetVoiceLength("story_v_out_426051", "426051076", "story_v_out_426051.awb") / 1000

					if var_314_16 + var_314_8 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_16 + var_314_8
					end

					if var_314_11.prefab_name ~= "" and arg_311_1.actors_[var_314_11.prefab_name] ~= nil then
						local var_314_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_11.prefab_name].transform, "story_v_out_426051", "426051076", "story_v_out_426051.awb")

						arg_311_1:RecordAudio("426051076", var_314_17)
						arg_311_1:RecordAudio("426051076", var_314_17)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_426051", "426051076", "story_v_out_426051.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_426051", "426051076", "story_v_out_426051.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_18 = math.max(var_314_9, arg_311_1.talkMaxDuration)

			if var_314_8 <= arg_311_1.time_ and arg_311_1.time_ < var_314_8 + var_314_18 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_8) / var_314_18

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_8 + var_314_18 and arg_311_1.time_ < var_314_8 + var_314_18 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play426051077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 426051077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play426051078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1054ui_story"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1054ui_story == nil then
				arg_315_1.var_.characterEffect1054ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect1054ui_story and not isNil(var_318_0) then
					local var_318_4 = Mathf.Lerp(0, 0.5, var_318_3)

					arg_315_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1054ui_story.fillRatio = var_318_4
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1054ui_story then
				local var_318_5 = 0.5

				arg_315_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1054ui_story.fillRatio = var_318_5
			end

			local var_318_6 = arg_315_1.actors_["6148ui_story"]
			local var_318_7 = 0

			if var_318_7 < arg_315_1.time_ and arg_315_1.time_ <= var_318_7 + arg_318_0 and not isNil(var_318_6) and arg_315_1.var_.characterEffect6148ui_story == nil then
				arg_315_1.var_.characterEffect6148ui_story = var_318_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_8 = 0.200000002980232

			if var_318_7 <= arg_315_1.time_ and arg_315_1.time_ < var_318_7 + var_318_8 and not isNil(var_318_6) then
				local var_318_9 = (arg_315_1.time_ - var_318_7) / var_318_8

				if arg_315_1.var_.characterEffect6148ui_story and not isNil(var_318_6) then
					local var_318_10 = Mathf.Lerp(0, 0.5, var_318_9)

					arg_315_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_315_1.var_.characterEffect6148ui_story.fillRatio = var_318_10
				end
			end

			if arg_315_1.time_ >= var_318_7 + var_318_8 and arg_315_1.time_ < var_318_7 + var_318_8 + arg_318_0 and not isNil(var_318_6) and arg_315_1.var_.characterEffect6148ui_story then
				local var_318_11 = 0.5

				arg_315_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_315_1.var_.characterEffect6148ui_story.fillRatio = var_318_11
			end

			local var_318_12 = 0
			local var_318_13 = 0.15

			if var_318_12 < arg_315_1.time_ and arg_315_1.time_ <= var_318_12 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_14 = arg_315_1:FormatText(StoryNameCfg[7].name)

				arg_315_1.leftNameTxt_.text = var_318_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_15 = arg_315_1:GetWordFromCfg(426051077)
				local var_318_16 = arg_315_1:FormatText(var_318_15.content)

				arg_315_1.text_.text = var_318_16

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_17 = 6
				local var_318_18 = utf8.len(var_318_16)
				local var_318_19 = var_318_17 <= 0 and var_318_13 or var_318_13 * (var_318_18 / var_318_17)

				if var_318_19 > 0 and var_318_13 < var_318_19 then
					arg_315_1.talkMaxDuration = var_318_19

					if var_318_19 + var_318_12 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_19 + var_318_12
					end
				end

				arg_315_1.text_.text = var_318_16
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_20 = math.max(var_318_13, arg_315_1.talkMaxDuration)

			if var_318_12 <= arg_315_1.time_ and arg_315_1.time_ < var_318_12 + var_318_20 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_12) / var_318_20

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_12 + var_318_20 and arg_315_1.time_ < var_318_12 + var_318_20 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play426051078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 426051078
		arg_319_1.duration_ = 7.1

		local var_319_0 = {
			zh = 4.666,
			ja = 7.1
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play426051079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1054ui_story"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos1054ui_story = var_322_0.localPosition

				local var_322_2 = GameObjectTools.GetOrAddComponent(var_322_0.gameObject, typeof(DynamicBoneHelper))

				if var_322_2 then
					var_322_2:EnableDynamicBone(false)
				end
			end

			local var_322_3 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_3 then
				local var_322_4 = (arg_319_1.time_ - var_322_1) / var_322_3
				local var_322_5 = Vector3.New(0.7, -0.985, -6)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1054ui_story, var_322_5, var_322_4)

				local var_322_6 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_6.x, var_322_6.y, var_322_6.z)

				local var_322_7 = var_322_0.localEulerAngles

				var_322_7.z = 0
				var_322_7.x = 0
				var_322_0.localEulerAngles = var_322_7
			end

			if arg_319_1.time_ >= var_322_1 + var_322_3 and arg_319_1.time_ < var_322_1 + var_322_3 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_322_8 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_8.x, var_322_8.y, var_322_8.z)

				local var_322_9 = var_322_0.localEulerAngles

				var_322_9.z = 0
				var_322_9.x = 0
				var_322_0.localEulerAngles = var_322_9

				local var_322_10 = GameObjectTools.GetOrAddComponent(var_322_0.gameObject, typeof(DynamicBoneHelper))

				if var_322_10 then
					var_322_10:EnableDynamicBone(true)
				end
			end

			local var_322_11 = arg_319_1.actors_["1054ui_story"]
			local var_322_12 = 0

			if var_322_12 < arg_319_1.time_ and arg_319_1.time_ <= var_322_12 + arg_322_0 and not isNil(var_322_11) and arg_319_1.var_.characterEffect1054ui_story == nil then
				arg_319_1.var_.characterEffect1054ui_story = var_322_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_13 = 0.200000002980232

			if var_322_12 <= arg_319_1.time_ and arg_319_1.time_ < var_322_12 + var_322_13 and not isNil(var_322_11) then
				local var_322_14 = (arg_319_1.time_ - var_322_12) / var_322_13

				if arg_319_1.var_.characterEffect1054ui_story and not isNil(var_322_11) then
					arg_319_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_12 + var_322_13 and arg_319_1.time_ < var_322_12 + var_322_13 + arg_322_0 and not isNil(var_322_11) and arg_319_1.var_.characterEffect1054ui_story then
				arg_319_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_322_15 = 0

			if var_322_15 < arg_319_1.time_ and arg_319_1.time_ <= var_322_15 + arg_322_0 then
				arg_319_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			local var_322_16 = 0

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 then
				arg_319_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_322_17 = 0
			local var_322_18 = 0.475

			if var_322_17 < arg_319_1.time_ and arg_319_1.time_ <= var_322_17 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_19 = arg_319_1:FormatText(StoryNameCfg[1487].name)

				arg_319_1.leftNameTxt_.text = var_322_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_20 = arg_319_1:GetWordFromCfg(426051078)
				local var_322_21 = arg_319_1:FormatText(var_322_20.content)

				arg_319_1.text_.text = var_322_21

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_22 = 19
				local var_322_23 = utf8.len(var_322_21)
				local var_322_24 = var_322_22 <= 0 and var_322_18 or var_322_18 * (var_322_23 / var_322_22)

				if var_322_24 > 0 and var_322_18 < var_322_24 then
					arg_319_1.talkMaxDuration = var_322_24

					if var_322_24 + var_322_17 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_24 + var_322_17
					end
				end

				arg_319_1.text_.text = var_322_21
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051078", "story_v_out_426051.awb") ~= 0 then
					local var_322_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051078", "story_v_out_426051.awb") / 1000

					if var_322_25 + var_322_17 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_25 + var_322_17
					end

					if var_322_20.prefab_name ~= "" and arg_319_1.actors_[var_322_20.prefab_name] ~= nil then
						local var_322_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_20.prefab_name].transform, "story_v_out_426051", "426051078", "story_v_out_426051.awb")

						arg_319_1:RecordAudio("426051078", var_322_26)
						arg_319_1:RecordAudio("426051078", var_322_26)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_426051", "426051078", "story_v_out_426051.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_426051", "426051078", "story_v_out_426051.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_27 = math.max(var_322_18, arg_319_1.talkMaxDuration)

			if var_322_17 <= arg_319_1.time_ and arg_319_1.time_ < var_322_17 + var_322_27 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_17) / var_322_27

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_17 + var_322_27 and arg_319_1.time_ < var_322_17 + var_322_27 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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

		arg_319_1:InitPlayNodeList()
	end,
	Play426051079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 426051079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play426051080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["6148ui_story"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos6148ui_story = var_326_0.localPosition

				local var_326_2 = GameObjectTools.GetOrAddComponent(var_326_0.gameObject, typeof(DynamicBoneHelper))

				if var_326_2 then
					var_326_2:EnableDynamicBone(false)
				end
			end

			local var_326_3 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_3 then
				local var_326_4 = (arg_323_1.time_ - var_326_1) / var_326_3
				local var_326_5 = Vector3.New(0, 100, 0)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos6148ui_story, var_326_5, var_326_4)

				local var_326_6 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_6.x, var_326_6.y, var_326_6.z)

				local var_326_7 = var_326_0.localEulerAngles

				var_326_7.z = 0
				var_326_7.x = 0
				var_326_0.localEulerAngles = var_326_7
			end

			if arg_323_1.time_ >= var_326_1 + var_326_3 and arg_323_1.time_ < var_326_1 + var_326_3 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0, 100, 0)

				local var_326_8 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_8.x, var_326_8.y, var_326_8.z)

				local var_326_9 = var_326_0.localEulerAngles

				var_326_9.z = 0
				var_326_9.x = 0
				var_326_0.localEulerAngles = var_326_9

				local var_326_10 = GameObjectTools.GetOrAddComponent(var_326_0.gameObject, typeof(DynamicBoneHelper))

				if var_326_10 then
					var_326_10:EnableDynamicBone(true)
				end
			end

			local var_326_11 = arg_323_1.actors_["1054ui_story"].transform
			local var_326_12 = 0

			if var_326_12 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 then
				arg_323_1.var_.moveOldPos1054ui_story = var_326_11.localPosition

				local var_326_13 = GameObjectTools.GetOrAddComponent(var_326_11.gameObject, typeof(DynamicBoneHelper))

				if var_326_13 then
					var_326_13:EnableDynamicBone(false)
				end
			end

			local var_326_14 = 0.001

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_14 then
				local var_326_15 = (arg_323_1.time_ - var_326_12) / var_326_14
				local var_326_16 = Vector3.New(0, 100, 0)

				var_326_11.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1054ui_story, var_326_16, var_326_15)

				local var_326_17 = manager.ui.mainCamera.transform.position - var_326_11.position

				var_326_11.forward = Vector3.New(var_326_17.x, var_326_17.y, var_326_17.z)

				local var_326_18 = var_326_11.localEulerAngles

				var_326_18.z = 0
				var_326_18.x = 0
				var_326_11.localEulerAngles = var_326_18
			end

			if arg_323_1.time_ >= var_326_12 + var_326_14 and arg_323_1.time_ < var_326_12 + var_326_14 + arg_326_0 then
				var_326_11.localPosition = Vector3.New(0, 100, 0)

				local var_326_19 = manager.ui.mainCamera.transform.position - var_326_11.position

				var_326_11.forward = Vector3.New(var_326_19.x, var_326_19.y, var_326_19.z)

				local var_326_20 = var_326_11.localEulerAngles

				var_326_20.z = 0
				var_326_20.x = 0
				var_326_11.localEulerAngles = var_326_20

				local var_326_21 = GameObjectTools.GetOrAddComponent(var_326_11.gameObject, typeof(DynamicBoneHelper))

				if var_326_21 then
					var_326_21:EnableDynamicBone(true)
				end
			end

			local var_326_22 = arg_323_1.actors_["1054ui_story"]
			local var_326_23 = 0

			if var_326_23 < arg_323_1.time_ and arg_323_1.time_ <= var_326_23 + arg_326_0 and not isNil(var_326_22) and arg_323_1.var_.characterEffect1054ui_story == nil then
				arg_323_1.var_.characterEffect1054ui_story = var_326_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_24 = 0.200000002980232

			if var_326_23 <= arg_323_1.time_ and arg_323_1.time_ < var_326_23 + var_326_24 and not isNil(var_326_22) then
				local var_326_25 = (arg_323_1.time_ - var_326_23) / var_326_24

				if arg_323_1.var_.characterEffect1054ui_story and not isNil(var_326_22) then
					local var_326_26 = Mathf.Lerp(0, 0.5, var_326_25)

					arg_323_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1054ui_story.fillRatio = var_326_26
				end
			end

			if arg_323_1.time_ >= var_326_23 + var_326_24 and arg_323_1.time_ < var_326_23 + var_326_24 + arg_326_0 and not isNil(var_326_22) and arg_323_1.var_.characterEffect1054ui_story then
				local var_326_27 = 0.5

				arg_323_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1054ui_story.fillRatio = var_326_27
			end

			local var_326_28 = 0
			local var_326_29 = 0.375

			if var_326_28 < arg_323_1.time_ and arg_323_1.time_ <= var_326_28 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_30 = arg_323_1:GetWordFromCfg(426051079)
				local var_326_31 = arg_323_1:FormatText(var_326_30.content)

				arg_323_1.text_.text = var_326_31

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_32 = 15
				local var_326_33 = utf8.len(var_326_31)
				local var_326_34 = var_326_32 <= 0 and var_326_29 or var_326_29 * (var_326_33 / var_326_32)

				if var_326_34 > 0 and var_326_29 < var_326_34 then
					arg_323_1.talkMaxDuration = var_326_34

					if var_326_34 + var_326_28 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_34 + var_326_28
					end
				end

				arg_323_1.text_.text = var_326_31
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_35 = math.max(var_326_29, arg_323_1.talkMaxDuration)

			if var_326_28 <= arg_323_1.time_ and arg_323_1.time_ < var_326_28 + var_326_35 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_28) / var_326_35

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_28 + var_326_35 and arg_323_1.time_ < var_326_28 + var_326_35 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play426051080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 426051080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play426051081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 0.3

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_2 = arg_327_1:FormatText(StoryNameCfg[7].name)

				arg_327_1.leftNameTxt_.text = var_330_2

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

				local var_330_3 = arg_327_1:GetWordFromCfg(426051080)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 12
				local var_330_6 = utf8.len(var_330_4)
				local var_330_7 = var_330_5 <= 0 and var_330_1 or var_330_1 * (var_330_6 / var_330_5)

				if var_330_7 > 0 and var_330_1 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_8 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_8 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_8

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_8 and arg_327_1.time_ < var_330_0 + var_330_8 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play426051081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 426051081
		arg_331_1.duration_ = 2.3

		local var_331_0 = {
			zh = 1.999999999999,
			ja = 2.3
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play426051082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["6148ui_story"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos6148ui_story = var_334_0.localPosition

				local var_334_2 = GameObjectTools.GetOrAddComponent(var_334_0.gameObject, typeof(DynamicBoneHelper))

				if var_334_2 then
					var_334_2:EnableDynamicBone(false)
				end
			end

			local var_334_3 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_3 then
				local var_334_4 = (arg_331_1.time_ - var_334_1) / var_334_3
				local var_334_5 = Vector3.New(-0.7, -0.985, -6)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos6148ui_story, var_334_5, var_334_4)

				local var_334_6 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_6.x, var_334_6.y, var_334_6.z)

				local var_334_7 = var_334_0.localEulerAngles

				var_334_7.z = 0
				var_334_7.x = 0
				var_334_0.localEulerAngles = var_334_7
			end

			if arg_331_1.time_ >= var_334_1 + var_334_3 and arg_331_1.time_ < var_334_1 + var_334_3 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_334_8 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_8.x, var_334_8.y, var_334_8.z)

				local var_334_9 = var_334_0.localEulerAngles

				var_334_9.z = 0
				var_334_9.x = 0
				var_334_0.localEulerAngles = var_334_9

				local var_334_10 = GameObjectTools.GetOrAddComponent(var_334_0.gameObject, typeof(DynamicBoneHelper))

				if var_334_10 then
					var_334_10:EnableDynamicBone(true)
				end
			end

			local var_334_11 = arg_331_1.actors_["6148ui_story"]
			local var_334_12 = 0

			if var_334_12 < arg_331_1.time_ and arg_331_1.time_ <= var_334_12 + arg_334_0 and not isNil(var_334_11) and arg_331_1.var_.characterEffect6148ui_story == nil then
				arg_331_1.var_.characterEffect6148ui_story = var_334_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_13 = 0.200000002980232

			if var_334_12 <= arg_331_1.time_ and arg_331_1.time_ < var_334_12 + var_334_13 and not isNil(var_334_11) then
				local var_334_14 = (arg_331_1.time_ - var_334_12) / var_334_13

				if arg_331_1.var_.characterEffect6148ui_story and not isNil(var_334_11) then
					arg_331_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_12 + var_334_13 and arg_331_1.time_ < var_334_12 + var_334_13 + arg_334_0 and not isNil(var_334_11) and arg_331_1.var_.characterEffect6148ui_story then
				arg_331_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_334_15 = 0

			if var_334_15 < arg_331_1.time_ and arg_331_1.time_ <= var_334_15 + arg_334_0 then
				arg_331_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 then
				arg_331_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_334_17 = 0
			local var_334_18 = 0.175

			if var_334_17 < arg_331_1.time_ and arg_331_1.time_ <= var_334_17 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_19 = arg_331_1:FormatText(StoryNameCfg[1488].name)

				arg_331_1.leftNameTxt_.text = var_334_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_20 = arg_331_1:GetWordFromCfg(426051081)
				local var_334_21 = arg_331_1:FormatText(var_334_20.content)

				arg_331_1.text_.text = var_334_21

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_22 = 7
				local var_334_23 = utf8.len(var_334_21)
				local var_334_24 = var_334_22 <= 0 and var_334_18 or var_334_18 * (var_334_23 / var_334_22)

				if var_334_24 > 0 and var_334_18 < var_334_24 then
					arg_331_1.talkMaxDuration = var_334_24

					if var_334_24 + var_334_17 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_24 + var_334_17
					end
				end

				arg_331_1.text_.text = var_334_21
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051081", "story_v_out_426051.awb") ~= 0 then
					local var_334_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051081", "story_v_out_426051.awb") / 1000

					if var_334_25 + var_334_17 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_25 + var_334_17
					end

					if var_334_20.prefab_name ~= "" and arg_331_1.actors_[var_334_20.prefab_name] ~= nil then
						local var_334_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_20.prefab_name].transform, "story_v_out_426051", "426051081", "story_v_out_426051.awb")

						arg_331_1:RecordAudio("426051081", var_334_26)
						arg_331_1:RecordAudio("426051081", var_334_26)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_426051", "426051081", "story_v_out_426051.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_426051", "426051081", "story_v_out_426051.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_27 = math.max(var_334_18, arg_331_1.talkMaxDuration)

			if var_334_17 <= arg_331_1.time_ and arg_331_1.time_ < var_334_17 + var_334_27 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_17) / var_334_27

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_17 + var_334_27 and arg_331_1.time_ < var_334_17 + var_334_27 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
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

		arg_331_1:InitPlayNodeList()
	end,
	Play426051082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 426051082
		arg_335_1.duration_ = 4.3

		local var_335_0 = {
			zh = 4.3,
			ja = 3.266
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
				arg_335_0:Play426051083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1054ui_story"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos1054ui_story = var_338_0.localPosition

				local var_338_2 = GameObjectTools.GetOrAddComponent(var_338_0.gameObject, typeof(DynamicBoneHelper))

				if var_338_2 then
					var_338_2:EnableDynamicBone(false)
				end
			end

			local var_338_3 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_3 then
				local var_338_4 = (arg_335_1.time_ - var_338_1) / var_338_3
				local var_338_5 = Vector3.New(0.7, -0.985, -6)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1054ui_story, var_338_5, var_338_4)

				local var_338_6 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_6.x, var_338_6.y, var_338_6.z)

				local var_338_7 = var_338_0.localEulerAngles

				var_338_7.z = 0
				var_338_7.x = 0
				var_338_0.localEulerAngles = var_338_7
			end

			if arg_335_1.time_ >= var_338_1 + var_338_3 and arg_335_1.time_ < var_338_1 + var_338_3 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_338_8 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_8.x, var_338_8.y, var_338_8.z)

				local var_338_9 = var_338_0.localEulerAngles

				var_338_9.z = 0
				var_338_9.x = 0
				var_338_0.localEulerAngles = var_338_9

				local var_338_10 = GameObjectTools.GetOrAddComponent(var_338_0.gameObject, typeof(DynamicBoneHelper))

				if var_338_10 then
					var_338_10:EnableDynamicBone(true)
				end
			end

			local var_338_11 = arg_335_1.actors_["1054ui_story"]
			local var_338_12 = 0

			if var_338_12 < arg_335_1.time_ and arg_335_1.time_ <= var_338_12 + arg_338_0 and not isNil(var_338_11) and arg_335_1.var_.characterEffect1054ui_story == nil then
				arg_335_1.var_.characterEffect1054ui_story = var_338_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_13 = 0.200000002980232

			if var_338_12 <= arg_335_1.time_ and arg_335_1.time_ < var_338_12 + var_338_13 and not isNil(var_338_11) then
				local var_338_14 = (arg_335_1.time_ - var_338_12) / var_338_13

				if arg_335_1.var_.characterEffect1054ui_story and not isNil(var_338_11) then
					arg_335_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_12 + var_338_13 and arg_335_1.time_ < var_338_12 + var_338_13 + arg_338_0 and not isNil(var_338_11) and arg_335_1.var_.characterEffect1054ui_story then
				arg_335_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_338_15 = arg_335_1.actors_["6148ui_story"]
			local var_338_16 = 0

			if var_338_16 < arg_335_1.time_ and arg_335_1.time_ <= var_338_16 + arg_338_0 and not isNil(var_338_15) and arg_335_1.var_.characterEffect6148ui_story == nil then
				arg_335_1.var_.characterEffect6148ui_story = var_338_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_17 = 0.200000002980232

			if var_338_16 <= arg_335_1.time_ and arg_335_1.time_ < var_338_16 + var_338_17 and not isNil(var_338_15) then
				local var_338_18 = (arg_335_1.time_ - var_338_16) / var_338_17

				if arg_335_1.var_.characterEffect6148ui_story and not isNil(var_338_15) then
					local var_338_19 = Mathf.Lerp(0, 0.5, var_338_18)

					arg_335_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_335_1.var_.characterEffect6148ui_story.fillRatio = var_338_19
				end
			end

			if arg_335_1.time_ >= var_338_16 + var_338_17 and arg_335_1.time_ < var_338_16 + var_338_17 + arg_338_0 and not isNil(var_338_15) and arg_335_1.var_.characterEffect6148ui_story then
				local var_338_20 = 0.5

				arg_335_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_335_1.var_.characterEffect6148ui_story.fillRatio = var_338_20
			end

			local var_338_21 = 0

			if var_338_21 < arg_335_1.time_ and arg_335_1.time_ <= var_338_21 + arg_338_0 then
				arg_335_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_338_22 = 0

			if var_338_22 < arg_335_1.time_ and arg_335_1.time_ <= var_338_22 + arg_338_0 then
				arg_335_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_338_23 = 0
			local var_338_24 = 0.5

			if var_338_23 < arg_335_1.time_ and arg_335_1.time_ <= var_338_23 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_25 = arg_335_1:FormatText(StoryNameCfg[1487].name)

				arg_335_1.leftNameTxt_.text = var_338_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_26 = arg_335_1:GetWordFromCfg(426051082)
				local var_338_27 = arg_335_1:FormatText(var_338_26.content)

				arg_335_1.text_.text = var_338_27

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_28 = 20
				local var_338_29 = utf8.len(var_338_27)
				local var_338_30 = var_338_28 <= 0 and var_338_24 or var_338_24 * (var_338_29 / var_338_28)

				if var_338_30 > 0 and var_338_24 < var_338_30 then
					arg_335_1.talkMaxDuration = var_338_30

					if var_338_30 + var_338_23 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_30 + var_338_23
					end
				end

				arg_335_1.text_.text = var_338_27
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051082", "story_v_out_426051.awb") ~= 0 then
					local var_338_31 = manager.audio:GetVoiceLength("story_v_out_426051", "426051082", "story_v_out_426051.awb") / 1000

					if var_338_31 + var_338_23 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_31 + var_338_23
					end

					if var_338_26.prefab_name ~= "" and arg_335_1.actors_[var_338_26.prefab_name] ~= nil then
						local var_338_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_26.prefab_name].transform, "story_v_out_426051", "426051082", "story_v_out_426051.awb")

						arg_335_1:RecordAudio("426051082", var_338_32)
						arg_335_1:RecordAudio("426051082", var_338_32)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_426051", "426051082", "story_v_out_426051.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_426051", "426051082", "story_v_out_426051.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_33 = math.max(var_338_24, arg_335_1.talkMaxDuration)

			if var_338_23 <= arg_335_1.time_ and arg_335_1.time_ < var_338_23 + var_338_33 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_23) / var_338_33

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_23 + var_338_33 and arg_335_1.time_ < var_338_23 + var_338_33 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
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

		arg_335_1:InitPlayNodeList()
	end,
	Play426051083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 426051083
		arg_339_1.duration_ = 1

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"

			SetActive(arg_339_1.choicesGo_, true)

			for iter_340_0, iter_340_1 in ipairs(arg_339_1.choices_) do
				local var_340_0 = iter_340_0 <= 1

				SetActive(iter_340_1.go, var_340_0)
			end

			arg_339_1.choices_[1].txt.text = arg_339_1:FormatText(StoryChoiceCfg[1606].name)
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play426051084(arg_339_1)
			end

			arg_339_1:RecordChoiceLog(426051083, 1606)
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1054ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1054ui_story == nil then
				arg_339_1.var_.characterEffect1054ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect1054ui_story and not isNil(var_342_0) then
					local var_342_4 = Mathf.Lerp(0, 0.5, var_342_3)

					arg_339_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1054ui_story.fillRatio = var_342_4
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect1054ui_story then
				local var_342_5 = 0.5

				arg_339_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1054ui_story.fillRatio = var_342_5
			end

			local var_342_6 = arg_339_1.actors_["6148ui_story"]
			local var_342_7 = 0

			if var_342_7 < arg_339_1.time_ and arg_339_1.time_ <= var_342_7 + arg_342_0 and not isNil(var_342_6) and arg_339_1.var_.characterEffect6148ui_story == nil then
				arg_339_1.var_.characterEffect6148ui_story = var_342_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_8 = 0.200000002980232

			if var_342_7 <= arg_339_1.time_ and arg_339_1.time_ < var_342_7 + var_342_8 and not isNil(var_342_6) then
				local var_342_9 = (arg_339_1.time_ - var_342_7) / var_342_8

				if arg_339_1.var_.characterEffect6148ui_story and not isNil(var_342_6) then
					local var_342_10 = Mathf.Lerp(0, 0.5, var_342_9)

					arg_339_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_339_1.var_.characterEffect6148ui_story.fillRatio = var_342_10
				end
			end

			if arg_339_1.time_ >= var_342_7 + var_342_8 and arg_339_1.time_ < var_342_7 + var_342_8 + arg_342_0 and not isNil(var_342_6) and arg_339_1.var_.characterEffect6148ui_story then
				local var_342_11 = 0.5

				arg_339_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_339_1.var_.characterEffect6148ui_story.fillRatio = var_342_11
			end

			local var_342_12 = 0

			if var_342_12 < arg_339_1.time_ and arg_339_1.time_ <= var_342_12 + arg_342_0 then
				arg_339_1.allBtn_.enabled = false
			end

			local var_342_13 = 0.6

			if arg_339_1.time_ >= var_342_12 + var_342_13 and arg_339_1.time_ < var_342_12 + var_342_13 + arg_342_0 then
				arg_339_1.allBtn_.enabled = true
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play426051084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 426051084
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play426051085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1054ui_story"].transform
			local var_346_1 = 0.0333333333333333

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos1054ui_story = var_346_0.localPosition

				local var_346_2 = GameObjectTools.GetOrAddComponent(var_346_0.gameObject, typeof(DynamicBoneHelper))

				if var_346_2 then
					var_346_2:EnableDynamicBone(false)
				end
			end

			local var_346_3 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_3 then
				local var_346_4 = (arg_343_1.time_ - var_346_1) / var_346_3
				local var_346_5 = Vector3.New(0, 100, 0)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1054ui_story, var_346_5, var_346_4)

				local var_346_6 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_6.x, var_346_6.y, var_346_6.z)

				local var_346_7 = var_346_0.localEulerAngles

				var_346_7.z = 0
				var_346_7.x = 0
				var_346_0.localEulerAngles = var_346_7
			end

			if arg_343_1.time_ >= var_346_1 + var_346_3 and arg_343_1.time_ < var_346_1 + var_346_3 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(0, 100, 0)

				local var_346_8 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_8.x, var_346_8.y, var_346_8.z)

				local var_346_9 = var_346_0.localEulerAngles

				var_346_9.z = 0
				var_346_9.x = 0
				var_346_0.localEulerAngles = var_346_9

				local var_346_10 = GameObjectTools.GetOrAddComponent(var_346_0.gameObject, typeof(DynamicBoneHelper))

				if var_346_10 then
					var_346_10:EnableDynamicBone(true)
				end
			end

			local var_346_11 = arg_343_1.actors_["6148ui_story"].transform
			local var_346_12 = 0.0333333333333333

			if var_346_12 < arg_343_1.time_ and arg_343_1.time_ <= var_346_12 + arg_346_0 then
				arg_343_1.var_.moveOldPos6148ui_story = var_346_11.localPosition

				local var_346_13 = GameObjectTools.GetOrAddComponent(var_346_11.gameObject, typeof(DynamicBoneHelper))

				if var_346_13 then
					var_346_13:EnableDynamicBone(false)
				end
			end

			local var_346_14 = 0.001

			if var_346_12 <= arg_343_1.time_ and arg_343_1.time_ < var_346_12 + var_346_14 then
				local var_346_15 = (arg_343_1.time_ - var_346_12) / var_346_14
				local var_346_16 = Vector3.New(0, 100, 0)

				var_346_11.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos6148ui_story, var_346_16, var_346_15)

				local var_346_17 = manager.ui.mainCamera.transform.position - var_346_11.position

				var_346_11.forward = Vector3.New(var_346_17.x, var_346_17.y, var_346_17.z)

				local var_346_18 = var_346_11.localEulerAngles

				var_346_18.z = 0
				var_346_18.x = 0
				var_346_11.localEulerAngles = var_346_18
			end

			if arg_343_1.time_ >= var_346_12 + var_346_14 and arg_343_1.time_ < var_346_12 + var_346_14 + arg_346_0 then
				var_346_11.localPosition = Vector3.New(0, 100, 0)

				local var_346_19 = manager.ui.mainCamera.transform.position - var_346_11.position

				var_346_11.forward = Vector3.New(var_346_19.x, var_346_19.y, var_346_19.z)

				local var_346_20 = var_346_11.localEulerAngles

				var_346_20.z = 0
				var_346_20.x = 0
				var_346_11.localEulerAngles = var_346_20

				local var_346_21 = GameObjectTools.GetOrAddComponent(var_346_11.gameObject, typeof(DynamicBoneHelper))

				if var_346_21 then
					var_346_21:EnableDynamicBone(true)
				end
			end

			local var_346_22 = 0
			local var_346_23 = 0.55

			if var_346_22 < arg_343_1.time_ and arg_343_1.time_ <= var_346_22 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_24 = arg_343_1:GetWordFromCfg(426051084)
				local var_346_25 = arg_343_1:FormatText(var_346_24.content)

				arg_343_1.text_.text = var_346_25

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_26 = 22
				local var_346_27 = utf8.len(var_346_25)
				local var_346_28 = var_346_26 <= 0 and var_346_23 or var_346_23 * (var_346_27 / var_346_26)

				if var_346_28 > 0 and var_346_23 < var_346_28 then
					arg_343_1.talkMaxDuration = var_346_28

					if var_346_28 + var_346_22 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_28 + var_346_22
					end
				end

				arg_343_1.text_.text = var_346_25
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_29 = math.max(var_346_23, arg_343_1.talkMaxDuration)

			if var_346_22 <= arg_343_1.time_ and arg_343_1.time_ < var_346_22 + var_346_29 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_22) / var_346_29

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_22 + var_346_29 and arg_343_1.time_ < var_346_22 + var_346_29 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play426051085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 426051085
		arg_347_1.duration_ = 8

		local var_347_0 = {
			zh = 7.066,
			ja = 8
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play426051086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["6148ui_story"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos6148ui_story = var_350_0.localPosition

				local var_350_2 = GameObjectTools.GetOrAddComponent(var_350_0.gameObject, typeof(DynamicBoneHelper))

				if var_350_2 then
					var_350_2:EnableDynamicBone(false)
				end
			end

			local var_350_3 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_3 then
				local var_350_4 = (arg_347_1.time_ - var_350_1) / var_350_3
				local var_350_5 = Vector3.New(-0.7, -0.985, -6)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos6148ui_story, var_350_5, var_350_4)

				local var_350_6 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_6.x, var_350_6.y, var_350_6.z)

				local var_350_7 = var_350_0.localEulerAngles

				var_350_7.z = 0
				var_350_7.x = 0
				var_350_0.localEulerAngles = var_350_7
			end

			if arg_347_1.time_ >= var_350_1 + var_350_3 and arg_347_1.time_ < var_350_1 + var_350_3 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_350_8 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_8.x, var_350_8.y, var_350_8.z)

				local var_350_9 = var_350_0.localEulerAngles

				var_350_9.z = 0
				var_350_9.x = 0
				var_350_0.localEulerAngles = var_350_9

				local var_350_10 = GameObjectTools.GetOrAddComponent(var_350_0.gameObject, typeof(DynamicBoneHelper))

				if var_350_10 then
					var_350_10:EnableDynamicBone(true)
				end
			end

			local var_350_11 = arg_347_1.actors_["6148ui_story"]
			local var_350_12 = 0

			if var_350_12 < arg_347_1.time_ and arg_347_1.time_ <= var_350_12 + arg_350_0 and not isNil(var_350_11) and arg_347_1.var_.characterEffect6148ui_story == nil then
				arg_347_1.var_.characterEffect6148ui_story = var_350_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_13 = 0.200000002980232

			if var_350_12 <= arg_347_1.time_ and arg_347_1.time_ < var_350_12 + var_350_13 and not isNil(var_350_11) then
				local var_350_14 = (arg_347_1.time_ - var_350_12) / var_350_13

				if arg_347_1.var_.characterEffect6148ui_story and not isNil(var_350_11) then
					arg_347_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= var_350_12 + var_350_13 and arg_347_1.time_ < var_350_12 + var_350_13 + arg_350_0 and not isNil(var_350_11) and arg_347_1.var_.characterEffect6148ui_story then
				arg_347_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_350_15 = 0

			if var_350_15 < arg_347_1.time_ and arg_347_1.time_ <= var_350_15 + arg_350_0 then
				arg_347_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			local var_350_16 = 0

			if var_350_16 < arg_347_1.time_ and arg_347_1.time_ <= var_350_16 + arg_350_0 then
				arg_347_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_350_17 = 0
			local var_350_18 = 0.725

			if var_350_17 < arg_347_1.time_ and arg_347_1.time_ <= var_350_17 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_19 = arg_347_1:FormatText(StoryNameCfg[1488].name)

				arg_347_1.leftNameTxt_.text = var_350_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_20 = arg_347_1:GetWordFromCfg(426051085)
				local var_350_21 = arg_347_1:FormatText(var_350_20.content)

				arg_347_1.text_.text = var_350_21

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_22 = 29
				local var_350_23 = utf8.len(var_350_21)
				local var_350_24 = var_350_22 <= 0 and var_350_18 or var_350_18 * (var_350_23 / var_350_22)

				if var_350_24 > 0 and var_350_18 < var_350_24 then
					arg_347_1.talkMaxDuration = var_350_24

					if var_350_24 + var_350_17 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_24 + var_350_17
					end
				end

				arg_347_1.text_.text = var_350_21
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051085", "story_v_out_426051.awb") ~= 0 then
					local var_350_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051085", "story_v_out_426051.awb") / 1000

					if var_350_25 + var_350_17 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_25 + var_350_17
					end

					if var_350_20.prefab_name ~= "" and arg_347_1.actors_[var_350_20.prefab_name] ~= nil then
						local var_350_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_20.prefab_name].transform, "story_v_out_426051", "426051085", "story_v_out_426051.awb")

						arg_347_1:RecordAudio("426051085", var_350_26)
						arg_347_1:RecordAudio("426051085", var_350_26)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_426051", "426051085", "story_v_out_426051.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_426051", "426051085", "story_v_out_426051.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_27 = math.max(var_350_18, arg_347_1.talkMaxDuration)

			if var_350_17 <= arg_347_1.time_ and arg_347_1.time_ < var_350_17 + var_350_27 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_17) / var_350_27

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_17 + var_350_27 and arg_347_1.time_ < var_350_17 + var_350_27 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
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

		arg_347_1:InitPlayNodeList()
	end,
	Play426051086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 426051086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play426051087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["6148ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect6148ui_story == nil then
				arg_351_1.var_.characterEffect6148ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect6148ui_story and not isNil(var_354_0) then
					local var_354_4 = Mathf.Lerp(0, 0.5, var_354_3)

					arg_351_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_351_1.var_.characterEffect6148ui_story.fillRatio = var_354_4
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect6148ui_story then
				local var_354_5 = 0.5

				arg_351_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_351_1.var_.characterEffect6148ui_story.fillRatio = var_354_5
			end

			local var_354_6 = 0
			local var_354_7 = 0.275

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_8 = arg_351_1:FormatText(StoryNameCfg[7].name)

				arg_351_1.leftNameTxt_.text = var_354_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_9 = arg_351_1:GetWordFromCfg(426051086)
				local var_354_10 = arg_351_1:FormatText(var_354_9.content)

				arg_351_1.text_.text = var_354_10

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 11
				local var_354_12 = utf8.len(var_354_10)
				local var_354_13 = var_354_11 <= 0 and var_354_7 or var_354_7 * (var_354_12 / var_354_11)

				if var_354_13 > 0 and var_354_7 < var_354_13 then
					arg_351_1.talkMaxDuration = var_354_13

					if var_354_13 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_6
					end
				end

				arg_351_1.text_.text = var_354_10
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_14 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_14 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_14

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_14 and arg_351_1.time_ < var_354_6 + var_354_14 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play426051087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 426051087
		arg_355_1.duration_ = 5.6

		local var_355_0 = {
			zh = 5.6,
			ja = 3.666
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
				arg_355_0:Play426051088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1054ui_story"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos1054ui_story = var_358_0.localPosition

				local var_358_2 = GameObjectTools.GetOrAddComponent(var_358_0.gameObject, typeof(DynamicBoneHelper))

				if var_358_2 then
					var_358_2:EnableDynamicBone(false)
				end
			end

			local var_358_3 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_3 then
				local var_358_4 = (arg_355_1.time_ - var_358_1) / var_358_3
				local var_358_5 = Vector3.New(0.7, -0.985, -6)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1054ui_story, var_358_5, var_358_4)

				local var_358_6 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_6.x, var_358_6.y, var_358_6.z)

				local var_358_7 = var_358_0.localEulerAngles

				var_358_7.z = 0
				var_358_7.x = 0
				var_358_0.localEulerAngles = var_358_7
			end

			if arg_355_1.time_ >= var_358_1 + var_358_3 and arg_355_1.time_ < var_358_1 + var_358_3 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_358_8 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_8.x, var_358_8.y, var_358_8.z)

				local var_358_9 = var_358_0.localEulerAngles

				var_358_9.z = 0
				var_358_9.x = 0
				var_358_0.localEulerAngles = var_358_9

				local var_358_10 = GameObjectTools.GetOrAddComponent(var_358_0.gameObject, typeof(DynamicBoneHelper))

				if var_358_10 then
					var_358_10:EnableDynamicBone(true)
				end
			end

			local var_358_11 = arg_355_1.actors_["1054ui_story"]
			local var_358_12 = 0

			if var_358_12 < arg_355_1.time_ and arg_355_1.time_ <= var_358_12 + arg_358_0 and not isNil(var_358_11) and arg_355_1.var_.characterEffect1054ui_story == nil then
				arg_355_1.var_.characterEffect1054ui_story = var_358_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_13 = 0.200000002980232

			if var_358_12 <= arg_355_1.time_ and arg_355_1.time_ < var_358_12 + var_358_13 and not isNil(var_358_11) then
				local var_358_14 = (arg_355_1.time_ - var_358_12) / var_358_13

				if arg_355_1.var_.characterEffect1054ui_story and not isNil(var_358_11) then
					arg_355_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_12 + var_358_13 and arg_355_1.time_ < var_358_12 + var_358_13 + arg_358_0 and not isNil(var_358_11) and arg_355_1.var_.characterEffect1054ui_story then
				arg_355_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_358_15 = 0

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				arg_355_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_358_16 = 0

			if var_358_16 < arg_355_1.time_ and arg_355_1.time_ <= var_358_16 + arg_358_0 then
				arg_355_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_358_17 = 0
			local var_358_18 = 0.5

			if var_358_17 < arg_355_1.time_ and arg_355_1.time_ <= var_358_17 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_19 = arg_355_1:FormatText(StoryNameCfg[1487].name)

				arg_355_1.leftNameTxt_.text = var_358_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_20 = arg_355_1:GetWordFromCfg(426051087)
				local var_358_21 = arg_355_1:FormatText(var_358_20.content)

				arg_355_1.text_.text = var_358_21

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_22 = 19
				local var_358_23 = utf8.len(var_358_21)
				local var_358_24 = var_358_22 <= 0 and var_358_18 or var_358_18 * (var_358_23 / var_358_22)

				if var_358_24 > 0 and var_358_18 < var_358_24 then
					arg_355_1.talkMaxDuration = var_358_24

					if var_358_24 + var_358_17 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_24 + var_358_17
					end
				end

				arg_355_1.text_.text = var_358_21
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051087", "story_v_out_426051.awb") ~= 0 then
					local var_358_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051087", "story_v_out_426051.awb") / 1000

					if var_358_25 + var_358_17 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_25 + var_358_17
					end

					if var_358_20.prefab_name ~= "" and arg_355_1.actors_[var_358_20.prefab_name] ~= nil then
						local var_358_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_20.prefab_name].transform, "story_v_out_426051", "426051087", "story_v_out_426051.awb")

						arg_355_1:RecordAudio("426051087", var_358_26)
						arg_355_1:RecordAudio("426051087", var_358_26)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_426051", "426051087", "story_v_out_426051.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_426051", "426051087", "story_v_out_426051.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_27 = math.max(var_358_18, arg_355_1.talkMaxDuration)

			if var_358_17 <= arg_355_1.time_ and arg_355_1.time_ < var_358_17 + var_358_27 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_17) / var_358_27

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_17 + var_358_27 and arg_355_1.time_ < var_358_17 + var_358_27 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
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

		arg_355_1:InitPlayNodeList()
	end,
	Play426051088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 426051088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play426051089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["6148ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos6148ui_story = var_362_0.localPosition

				local var_362_2 = GameObjectTools.GetOrAddComponent(var_362_0.gameObject, typeof(DynamicBoneHelper))

				if var_362_2 then
					var_362_2:EnableDynamicBone(false)
				end
			end

			local var_362_3 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_3 then
				local var_362_4 = (arg_359_1.time_ - var_362_1) / var_362_3
				local var_362_5 = Vector3.New(0, 100, 0)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos6148ui_story, var_362_5, var_362_4)

				local var_362_6 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_6.x, var_362_6.y, var_362_6.z)

				local var_362_7 = var_362_0.localEulerAngles

				var_362_7.z = 0
				var_362_7.x = 0
				var_362_0.localEulerAngles = var_362_7
			end

			if arg_359_1.time_ >= var_362_1 + var_362_3 and arg_359_1.time_ < var_362_1 + var_362_3 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(0, 100, 0)

				local var_362_8 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_8.x, var_362_8.y, var_362_8.z)

				local var_362_9 = var_362_0.localEulerAngles

				var_362_9.z = 0
				var_362_9.x = 0
				var_362_0.localEulerAngles = var_362_9

				local var_362_10 = GameObjectTools.GetOrAddComponent(var_362_0.gameObject, typeof(DynamicBoneHelper))

				if var_362_10 then
					var_362_10:EnableDynamicBone(true)
				end
			end

			local var_362_11 = arg_359_1.actors_["1054ui_story"].transform
			local var_362_12 = 0

			if var_362_12 < arg_359_1.time_ and arg_359_1.time_ <= var_362_12 + arg_362_0 then
				arg_359_1.var_.moveOldPos1054ui_story = var_362_11.localPosition

				local var_362_13 = GameObjectTools.GetOrAddComponent(var_362_11.gameObject, typeof(DynamicBoneHelper))

				if var_362_13 then
					var_362_13:EnableDynamicBone(false)
				end
			end

			local var_362_14 = 0.001

			if var_362_12 <= arg_359_1.time_ and arg_359_1.time_ < var_362_12 + var_362_14 then
				local var_362_15 = (arg_359_1.time_ - var_362_12) / var_362_14
				local var_362_16 = Vector3.New(0, 100, 0)

				var_362_11.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1054ui_story, var_362_16, var_362_15)

				local var_362_17 = manager.ui.mainCamera.transform.position - var_362_11.position

				var_362_11.forward = Vector3.New(var_362_17.x, var_362_17.y, var_362_17.z)

				local var_362_18 = var_362_11.localEulerAngles

				var_362_18.z = 0
				var_362_18.x = 0
				var_362_11.localEulerAngles = var_362_18
			end

			if arg_359_1.time_ >= var_362_12 + var_362_14 and arg_359_1.time_ < var_362_12 + var_362_14 + arg_362_0 then
				var_362_11.localPosition = Vector3.New(0, 100, 0)

				local var_362_19 = manager.ui.mainCamera.transform.position - var_362_11.position

				var_362_11.forward = Vector3.New(var_362_19.x, var_362_19.y, var_362_19.z)

				local var_362_20 = var_362_11.localEulerAngles

				var_362_20.z = 0
				var_362_20.x = 0
				var_362_11.localEulerAngles = var_362_20

				local var_362_21 = GameObjectTools.GetOrAddComponent(var_362_11.gameObject, typeof(DynamicBoneHelper))

				if var_362_21 then
					var_362_21:EnableDynamicBone(true)
				end
			end

			local var_362_22 = arg_359_1.actors_["1054ui_story"]
			local var_362_23 = 0

			if var_362_23 < arg_359_1.time_ and arg_359_1.time_ <= var_362_23 + arg_362_0 and not isNil(var_362_22) and arg_359_1.var_.characterEffect1054ui_story == nil then
				arg_359_1.var_.characterEffect1054ui_story = var_362_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_24 = 0.200000002980232

			if var_362_23 <= arg_359_1.time_ and arg_359_1.time_ < var_362_23 + var_362_24 and not isNil(var_362_22) then
				local var_362_25 = (arg_359_1.time_ - var_362_23) / var_362_24

				if arg_359_1.var_.characterEffect1054ui_story and not isNil(var_362_22) then
					local var_362_26 = Mathf.Lerp(0, 0.5, var_362_25)

					arg_359_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1054ui_story.fillRatio = var_362_26
				end
			end

			if arg_359_1.time_ >= var_362_23 + var_362_24 and arg_359_1.time_ < var_362_23 + var_362_24 + arg_362_0 and not isNil(var_362_22) and arg_359_1.var_.characterEffect1054ui_story then
				local var_362_27 = 0.5

				arg_359_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1054ui_story.fillRatio = var_362_27
			end

			local var_362_28 = 0
			local var_362_29 = 0.725

			if var_362_28 < arg_359_1.time_ and arg_359_1.time_ <= var_362_28 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_30 = arg_359_1:GetWordFromCfg(426051088)
				local var_362_31 = arg_359_1:FormatText(var_362_30.content)

				arg_359_1.text_.text = var_362_31

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_32 = 29
				local var_362_33 = utf8.len(var_362_31)
				local var_362_34 = var_362_32 <= 0 and var_362_29 or var_362_29 * (var_362_33 / var_362_32)

				if var_362_34 > 0 and var_362_29 < var_362_34 then
					arg_359_1.talkMaxDuration = var_362_34

					if var_362_34 + var_362_28 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_34 + var_362_28
					end
				end

				arg_359_1.text_.text = var_362_31
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_35 = math.max(var_362_29, arg_359_1.talkMaxDuration)

			if var_362_28 <= arg_359_1.time_ and arg_359_1.time_ < var_362_28 + var_362_35 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_28) / var_362_35

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_28 + var_362_35 and arg_359_1.time_ < var_362_28 + var_362_35 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
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

		arg_359_1:InitPlayNodeList()
	end,
	Play426051089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 426051089
		arg_363_1.duration_ = 8.53

		local var_363_0 = {
			zh = 8.533,
			ja = 6.9
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
				arg_363_0:Play426051090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1054ui_story"].transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.moveOldPos1054ui_story = var_366_0.localPosition

				local var_366_2 = GameObjectTools.GetOrAddComponent(var_366_0.gameObject, typeof(DynamicBoneHelper))

				if var_366_2 then
					var_366_2:EnableDynamicBone(false)
				end
			end

			local var_366_3 = 0.001

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_3 then
				local var_366_4 = (arg_363_1.time_ - var_366_1) / var_366_3
				local var_366_5 = Vector3.New(0, -0.985, -6)

				var_366_0.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1054ui_story, var_366_5, var_366_4)

				local var_366_6 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_6.x, var_366_6.y, var_366_6.z)

				local var_366_7 = var_366_0.localEulerAngles

				var_366_7.z = 0
				var_366_7.x = 0
				var_366_0.localEulerAngles = var_366_7
			end

			if arg_363_1.time_ >= var_366_1 + var_366_3 and arg_363_1.time_ < var_366_1 + var_366_3 + arg_366_0 then
				var_366_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_366_8 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_8.x, var_366_8.y, var_366_8.z)

				local var_366_9 = var_366_0.localEulerAngles

				var_366_9.z = 0
				var_366_9.x = 0
				var_366_0.localEulerAngles = var_366_9

				local var_366_10 = GameObjectTools.GetOrAddComponent(var_366_0.gameObject, typeof(DynamicBoneHelper))

				if var_366_10 then
					var_366_10:EnableDynamicBone(true)
				end
			end

			local var_366_11 = arg_363_1.actors_["1054ui_story"]
			local var_366_12 = 0

			if var_366_12 < arg_363_1.time_ and arg_363_1.time_ <= var_366_12 + arg_366_0 and not isNil(var_366_11) and arg_363_1.var_.characterEffect1054ui_story == nil then
				arg_363_1.var_.characterEffect1054ui_story = var_366_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_13 = 0.200000002980232

			if var_366_12 <= arg_363_1.time_ and arg_363_1.time_ < var_366_12 + var_366_13 and not isNil(var_366_11) then
				local var_366_14 = (arg_363_1.time_ - var_366_12) / var_366_13

				if arg_363_1.var_.characterEffect1054ui_story and not isNil(var_366_11) then
					arg_363_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_12 + var_366_13 and arg_363_1.time_ < var_366_12 + var_366_13 + arg_366_0 and not isNil(var_366_11) and arg_363_1.var_.characterEffect1054ui_story then
				arg_363_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_366_15 = 0

			if var_366_15 < arg_363_1.time_ and arg_363_1.time_ <= var_366_15 + arg_366_0 then
				arg_363_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			local var_366_16 = 0

			if var_366_16 < arg_363_1.time_ and arg_363_1.time_ <= var_366_16 + arg_366_0 then
				arg_363_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_366_17 = 0
			local var_366_18 = 0.75

			if var_366_17 < arg_363_1.time_ and arg_363_1.time_ <= var_366_17 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_19 = arg_363_1:FormatText(StoryNameCfg[1487].name)

				arg_363_1.leftNameTxt_.text = var_366_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_20 = arg_363_1:GetWordFromCfg(426051089)
				local var_366_21 = arg_363_1:FormatText(var_366_20.content)

				arg_363_1.text_.text = var_366_21

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_22 = 30
				local var_366_23 = utf8.len(var_366_21)
				local var_366_24 = var_366_22 <= 0 and var_366_18 or var_366_18 * (var_366_23 / var_366_22)

				if var_366_24 > 0 and var_366_18 < var_366_24 then
					arg_363_1.talkMaxDuration = var_366_24

					if var_366_24 + var_366_17 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_24 + var_366_17
					end
				end

				arg_363_1.text_.text = var_366_21
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051089", "story_v_out_426051.awb") ~= 0 then
					local var_366_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051089", "story_v_out_426051.awb") / 1000

					if var_366_25 + var_366_17 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_25 + var_366_17
					end

					if var_366_20.prefab_name ~= "" and arg_363_1.actors_[var_366_20.prefab_name] ~= nil then
						local var_366_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_20.prefab_name].transform, "story_v_out_426051", "426051089", "story_v_out_426051.awb")

						arg_363_1:RecordAudio("426051089", var_366_26)
						arg_363_1:RecordAudio("426051089", var_366_26)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_426051", "426051089", "story_v_out_426051.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_426051", "426051089", "story_v_out_426051.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_27 = math.max(var_366_18, arg_363_1.talkMaxDuration)

			if var_366_17 <= arg_363_1.time_ and arg_363_1.time_ < var_366_17 + var_366_27 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_17) / var_366_27

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_17 + var_366_27 and arg_363_1.time_ < var_366_17 + var_366_27 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
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

		arg_363_1:InitPlayNodeList()
	end,
	Play426051090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 426051090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play426051091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["6148ui_story"].transform
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.var_.moveOldPos6148ui_story = var_370_0.localPosition

				local var_370_2 = GameObjectTools.GetOrAddComponent(var_370_0.gameObject, typeof(DynamicBoneHelper))

				if var_370_2 then
					var_370_2:EnableDynamicBone(false)
				end
			end

			local var_370_3 = 0.001

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_3 then
				local var_370_4 = (arg_367_1.time_ - var_370_1) / var_370_3
				local var_370_5 = Vector3.New(0, 100, 0)

				var_370_0.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos6148ui_story, var_370_5, var_370_4)

				local var_370_6 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_6.x, var_370_6.y, var_370_6.z)

				local var_370_7 = var_370_0.localEulerAngles

				var_370_7.z = 0
				var_370_7.x = 0
				var_370_0.localEulerAngles = var_370_7
			end

			if arg_367_1.time_ >= var_370_1 + var_370_3 and arg_367_1.time_ < var_370_1 + var_370_3 + arg_370_0 then
				var_370_0.localPosition = Vector3.New(0, 100, 0)

				local var_370_8 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_8.x, var_370_8.y, var_370_8.z)

				local var_370_9 = var_370_0.localEulerAngles

				var_370_9.z = 0
				var_370_9.x = 0
				var_370_0.localEulerAngles = var_370_9

				local var_370_10 = GameObjectTools.GetOrAddComponent(var_370_0.gameObject, typeof(DynamicBoneHelper))

				if var_370_10 then
					var_370_10:EnableDynamicBone(true)
				end
			end

			local var_370_11 = arg_367_1.actors_["1054ui_story"].transform
			local var_370_12 = 0

			if var_370_12 < arg_367_1.time_ and arg_367_1.time_ <= var_370_12 + arg_370_0 then
				arg_367_1.var_.moveOldPos1054ui_story = var_370_11.localPosition

				local var_370_13 = GameObjectTools.GetOrAddComponent(var_370_11.gameObject, typeof(DynamicBoneHelper))

				if var_370_13 then
					var_370_13:EnableDynamicBone(false)
				end
			end

			local var_370_14 = 0.001

			if var_370_12 <= arg_367_1.time_ and arg_367_1.time_ < var_370_12 + var_370_14 then
				local var_370_15 = (arg_367_1.time_ - var_370_12) / var_370_14
				local var_370_16 = Vector3.New(0, 100, 0)

				var_370_11.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1054ui_story, var_370_16, var_370_15)

				local var_370_17 = manager.ui.mainCamera.transform.position - var_370_11.position

				var_370_11.forward = Vector3.New(var_370_17.x, var_370_17.y, var_370_17.z)

				local var_370_18 = var_370_11.localEulerAngles

				var_370_18.z = 0
				var_370_18.x = 0
				var_370_11.localEulerAngles = var_370_18
			end

			if arg_367_1.time_ >= var_370_12 + var_370_14 and arg_367_1.time_ < var_370_12 + var_370_14 + arg_370_0 then
				var_370_11.localPosition = Vector3.New(0, 100, 0)

				local var_370_19 = manager.ui.mainCamera.transform.position - var_370_11.position

				var_370_11.forward = Vector3.New(var_370_19.x, var_370_19.y, var_370_19.z)

				local var_370_20 = var_370_11.localEulerAngles

				var_370_20.z = 0
				var_370_20.x = 0
				var_370_11.localEulerAngles = var_370_20

				local var_370_21 = GameObjectTools.GetOrAddComponent(var_370_11.gameObject, typeof(DynamicBoneHelper))

				if var_370_21 then
					var_370_21:EnableDynamicBone(true)
				end
			end

			local var_370_22 = arg_367_1.actors_["1054ui_story"]
			local var_370_23 = 0

			if var_370_23 < arg_367_1.time_ and arg_367_1.time_ <= var_370_23 + arg_370_0 and not isNil(var_370_22) and arg_367_1.var_.characterEffect1054ui_story == nil then
				arg_367_1.var_.characterEffect1054ui_story = var_370_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_24 = 0.200000002980232

			if var_370_23 <= arg_367_1.time_ and arg_367_1.time_ < var_370_23 + var_370_24 and not isNil(var_370_22) then
				local var_370_25 = (arg_367_1.time_ - var_370_23) / var_370_24

				if arg_367_1.var_.characterEffect1054ui_story and not isNil(var_370_22) then
					local var_370_26 = Mathf.Lerp(0, 0.5, var_370_25)

					arg_367_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1054ui_story.fillRatio = var_370_26
				end
			end

			if arg_367_1.time_ >= var_370_23 + var_370_24 and arg_367_1.time_ < var_370_23 + var_370_24 + arg_370_0 and not isNil(var_370_22) and arg_367_1.var_.characterEffect1054ui_story then
				local var_370_27 = 0.5

				arg_367_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1054ui_story.fillRatio = var_370_27
			end

			local var_370_28 = 0
			local var_370_29 = 0.6

			if var_370_28 < arg_367_1.time_ and arg_367_1.time_ <= var_370_28 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_30 = arg_367_1:GetWordFromCfg(426051090)
				local var_370_31 = arg_367_1:FormatText(var_370_30.content)

				arg_367_1.text_.text = var_370_31

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_32 = 24
				local var_370_33 = utf8.len(var_370_31)
				local var_370_34 = var_370_32 <= 0 and var_370_29 or var_370_29 * (var_370_33 / var_370_32)

				if var_370_34 > 0 and var_370_29 < var_370_34 then
					arg_367_1.talkMaxDuration = var_370_34

					if var_370_34 + var_370_28 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_34 + var_370_28
					end
				end

				arg_367_1.text_.text = var_370_31
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_35 = math.max(var_370_29, arg_367_1.talkMaxDuration)

			if var_370_28 <= arg_367_1.time_ and arg_367_1.time_ < var_370_28 + var_370_35 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_28) / var_370_35

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_28 + var_370_35 and arg_367_1.time_ < var_370_28 + var_370_35 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
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

		arg_367_1:InitPlayNodeList()
	end,
	Play426051091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 426051091
		arg_371_1.duration_ = 4.37

		local var_371_0 = {
			zh = 3.666,
			ja = 4.366
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
				arg_371_0:Play426051092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["6148ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos6148ui_story = var_374_0.localPosition

				local var_374_2 = GameObjectTools.GetOrAddComponent(var_374_0.gameObject, typeof(DynamicBoneHelper))

				if var_374_2 then
					var_374_2:EnableDynamicBone(false)
				end
			end

			local var_374_3 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_3 then
				local var_374_4 = (arg_371_1.time_ - var_374_1) / var_374_3
				local var_374_5 = Vector3.New(-0.7, -0.985, -6)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos6148ui_story, var_374_5, var_374_4)

				local var_374_6 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_6.x, var_374_6.y, var_374_6.z)

				local var_374_7 = var_374_0.localEulerAngles

				var_374_7.z = 0
				var_374_7.x = 0
				var_374_0.localEulerAngles = var_374_7
			end

			if arg_371_1.time_ >= var_374_1 + var_374_3 and arg_371_1.time_ < var_374_1 + var_374_3 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_374_8 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_8.x, var_374_8.y, var_374_8.z)

				local var_374_9 = var_374_0.localEulerAngles

				var_374_9.z = 0
				var_374_9.x = 0
				var_374_0.localEulerAngles = var_374_9

				local var_374_10 = GameObjectTools.GetOrAddComponent(var_374_0.gameObject, typeof(DynamicBoneHelper))

				if var_374_10 then
					var_374_10:EnableDynamicBone(true)
				end
			end

			local var_374_11 = arg_371_1.actors_["6148ui_story"]
			local var_374_12 = 0

			if var_374_12 < arg_371_1.time_ and arg_371_1.time_ <= var_374_12 + arg_374_0 and not isNil(var_374_11) and arg_371_1.var_.characterEffect6148ui_story == nil then
				arg_371_1.var_.characterEffect6148ui_story = var_374_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_13 = 0.200000002980232

			if var_374_12 <= arg_371_1.time_ and arg_371_1.time_ < var_374_12 + var_374_13 and not isNil(var_374_11) then
				local var_374_14 = (arg_371_1.time_ - var_374_12) / var_374_13

				if arg_371_1.var_.characterEffect6148ui_story and not isNil(var_374_11) then
					arg_371_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_12 + var_374_13 and arg_371_1.time_ < var_374_12 + var_374_13 + arg_374_0 and not isNil(var_374_11) and arg_371_1.var_.characterEffect6148ui_story then
				arg_371_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_374_15 = 0

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_2")
			end

			local var_374_16 = 0

			if var_374_16 < arg_371_1.time_ and arg_371_1.time_ <= var_374_16 + arg_374_0 then
				arg_371_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_374_17 = 0
			local var_374_18 = 0.15

			if var_374_17 < arg_371_1.time_ and arg_371_1.time_ <= var_374_17 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_19 = arg_371_1:FormatText(StoryNameCfg[1488].name)

				arg_371_1.leftNameTxt_.text = var_374_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_20 = arg_371_1:GetWordFromCfg(426051091)
				local var_374_21 = arg_371_1:FormatText(var_374_20.content)

				arg_371_1.text_.text = var_374_21

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_22 = 6
				local var_374_23 = utf8.len(var_374_21)
				local var_374_24 = var_374_22 <= 0 and var_374_18 or var_374_18 * (var_374_23 / var_374_22)

				if var_374_24 > 0 and var_374_18 < var_374_24 then
					arg_371_1.talkMaxDuration = var_374_24

					if var_374_24 + var_374_17 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_24 + var_374_17
					end
				end

				arg_371_1.text_.text = var_374_21
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051091", "story_v_out_426051.awb") ~= 0 then
					local var_374_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051091", "story_v_out_426051.awb") / 1000

					if var_374_25 + var_374_17 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_25 + var_374_17
					end

					if var_374_20.prefab_name ~= "" and arg_371_1.actors_[var_374_20.prefab_name] ~= nil then
						local var_374_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_20.prefab_name].transform, "story_v_out_426051", "426051091", "story_v_out_426051.awb")

						arg_371_1:RecordAudio("426051091", var_374_26)
						arg_371_1:RecordAudio("426051091", var_374_26)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_426051", "426051091", "story_v_out_426051.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_426051", "426051091", "story_v_out_426051.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_27 = math.max(var_374_18, arg_371_1.talkMaxDuration)

			if var_374_17 <= arg_371_1.time_ and arg_371_1.time_ < var_374_17 + var_374_27 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_17) / var_374_27

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_17 + var_374_27 and arg_371_1.time_ < var_374_17 + var_374_27 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
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

		arg_371_1:InitPlayNodeList()
	end,
	Play426051092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 426051092
		arg_375_1.duration_ = 7.1

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play426051093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1054ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1054ui_story = var_378_0.localPosition

				local var_378_2 = GameObjectTools.GetOrAddComponent(var_378_0.gameObject, typeof(DynamicBoneHelper))

				if var_378_2 then
					var_378_2:EnableDynamicBone(false)
				end
			end

			local var_378_3 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_3 then
				local var_378_4 = (arg_375_1.time_ - var_378_1) / var_378_3
				local var_378_5 = Vector3.New(0.7, -0.985, -6)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1054ui_story, var_378_5, var_378_4)

				local var_378_6 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_6.x, var_378_6.y, var_378_6.z)

				local var_378_7 = var_378_0.localEulerAngles

				var_378_7.z = 0
				var_378_7.x = 0
				var_378_0.localEulerAngles = var_378_7
			end

			if arg_375_1.time_ >= var_378_1 + var_378_3 and arg_375_1.time_ < var_378_1 + var_378_3 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_378_8 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_8.x, var_378_8.y, var_378_8.z)

				local var_378_9 = var_378_0.localEulerAngles

				var_378_9.z = 0
				var_378_9.x = 0
				var_378_0.localEulerAngles = var_378_9

				local var_378_10 = GameObjectTools.GetOrAddComponent(var_378_0.gameObject, typeof(DynamicBoneHelper))

				if var_378_10 then
					var_378_10:EnableDynamicBone(true)
				end
			end

			local var_378_11 = arg_375_1.actors_["1054ui_story"]
			local var_378_12 = 0

			if var_378_12 < arg_375_1.time_ and arg_375_1.time_ <= var_378_12 + arg_378_0 and not isNil(var_378_11) and arg_375_1.var_.characterEffect1054ui_story == nil then
				arg_375_1.var_.characterEffect1054ui_story = var_378_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_13 = 0.200000002980232

			if var_378_12 <= arg_375_1.time_ and arg_375_1.time_ < var_378_12 + var_378_13 and not isNil(var_378_11) then
				local var_378_14 = (arg_375_1.time_ - var_378_12) / var_378_13

				if arg_375_1.var_.characterEffect1054ui_story and not isNil(var_378_11) then
					arg_375_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_12 + var_378_13 and arg_375_1.time_ < var_378_12 + var_378_13 + arg_378_0 and not isNil(var_378_11) and arg_375_1.var_.characterEffect1054ui_story then
				arg_375_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_378_15 = arg_375_1.actors_["6148ui_story"]
			local var_378_16 = 0

			if var_378_16 < arg_375_1.time_ and arg_375_1.time_ <= var_378_16 + arg_378_0 and not isNil(var_378_15) and arg_375_1.var_.characterEffect6148ui_story == nil then
				arg_375_1.var_.characterEffect6148ui_story = var_378_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_17 = 0.200000002980232

			if var_378_16 <= arg_375_1.time_ and arg_375_1.time_ < var_378_16 + var_378_17 and not isNil(var_378_15) then
				local var_378_18 = (arg_375_1.time_ - var_378_16) / var_378_17

				if arg_375_1.var_.characterEffect6148ui_story and not isNil(var_378_15) then
					local var_378_19 = Mathf.Lerp(0, 0.5, var_378_18)

					arg_375_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_375_1.var_.characterEffect6148ui_story.fillRatio = var_378_19
				end
			end

			if arg_375_1.time_ >= var_378_16 + var_378_17 and arg_375_1.time_ < var_378_16 + var_378_17 + arg_378_0 and not isNil(var_378_15) and arg_375_1.var_.characterEffect6148ui_story then
				local var_378_20 = 0.5

				arg_375_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_375_1.var_.characterEffect6148ui_story.fillRatio = var_378_20
			end

			local var_378_21 = 0

			if var_378_21 < arg_375_1.time_ and arg_375_1.time_ <= var_378_21 + arg_378_0 then
				arg_375_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_378_22 = 0

			if var_378_22 < arg_375_1.time_ and arg_375_1.time_ <= var_378_22 + arg_378_0 then
				arg_375_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_378_23 = 0
			local var_378_24 = 0.675

			if var_378_23 < arg_375_1.time_ and arg_375_1.time_ <= var_378_23 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_25 = arg_375_1:FormatText(StoryNameCfg[1487].name)

				arg_375_1.leftNameTxt_.text = var_378_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_26 = arg_375_1:GetWordFromCfg(426051092)
				local var_378_27 = arg_375_1:FormatText(var_378_26.content)

				arg_375_1.text_.text = var_378_27

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_28 = 27
				local var_378_29 = utf8.len(var_378_27)
				local var_378_30 = var_378_28 <= 0 and var_378_24 or var_378_24 * (var_378_29 / var_378_28)

				if var_378_30 > 0 and var_378_24 < var_378_30 then
					arg_375_1.talkMaxDuration = var_378_30

					if var_378_30 + var_378_23 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_30 + var_378_23
					end
				end

				arg_375_1.text_.text = var_378_27
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051092", "story_v_out_426051.awb") ~= 0 then
					local var_378_31 = manager.audio:GetVoiceLength("story_v_out_426051", "426051092", "story_v_out_426051.awb") / 1000

					if var_378_31 + var_378_23 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_31 + var_378_23
					end

					if var_378_26.prefab_name ~= "" and arg_375_1.actors_[var_378_26.prefab_name] ~= nil then
						local var_378_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_26.prefab_name].transform, "story_v_out_426051", "426051092", "story_v_out_426051.awb")

						arg_375_1:RecordAudio("426051092", var_378_32)
						arg_375_1:RecordAudio("426051092", var_378_32)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_426051", "426051092", "story_v_out_426051.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_426051", "426051092", "story_v_out_426051.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_33 = math.max(var_378_24, arg_375_1.talkMaxDuration)

			if var_378_23 <= arg_375_1.time_ and arg_375_1.time_ < var_378_23 + var_378_33 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_23) / var_378_33

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_23 + var_378_33 and arg_375_1.time_ < var_378_23 + var_378_33 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	Play426051093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 426051093
		arg_379_1.duration_ = 7.9

		local var_379_0 = {
			zh = 6.133,
			ja = 7.9
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
				arg_379_0:Play426051094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["6148ui_story"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos6148ui_story = var_382_0.localPosition

				local var_382_2 = GameObjectTools.GetOrAddComponent(var_382_0.gameObject, typeof(DynamicBoneHelper))

				if var_382_2 then
					var_382_2:EnableDynamicBone(false)
				end
			end

			local var_382_3 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_3 then
				local var_382_4 = (arg_379_1.time_ - var_382_1) / var_382_3
				local var_382_5 = Vector3.New(-0.7, -0.985, -6)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos6148ui_story, var_382_5, var_382_4)

				local var_382_6 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_6.x, var_382_6.y, var_382_6.z)

				local var_382_7 = var_382_0.localEulerAngles

				var_382_7.z = 0
				var_382_7.x = 0
				var_382_0.localEulerAngles = var_382_7
			end

			if arg_379_1.time_ >= var_382_1 + var_382_3 and arg_379_1.time_ < var_382_1 + var_382_3 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_382_8 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_8.x, var_382_8.y, var_382_8.z)

				local var_382_9 = var_382_0.localEulerAngles

				var_382_9.z = 0
				var_382_9.x = 0
				var_382_0.localEulerAngles = var_382_9

				local var_382_10 = GameObjectTools.GetOrAddComponent(var_382_0.gameObject, typeof(DynamicBoneHelper))

				if var_382_10 then
					var_382_10:EnableDynamicBone(true)
				end
			end

			local var_382_11 = arg_379_1.actors_["6148ui_story"]
			local var_382_12 = 0

			if var_382_12 < arg_379_1.time_ and arg_379_1.time_ <= var_382_12 + arg_382_0 and not isNil(var_382_11) and arg_379_1.var_.characterEffect6148ui_story == nil then
				arg_379_1.var_.characterEffect6148ui_story = var_382_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_13 = 0.200000002980232

			if var_382_12 <= arg_379_1.time_ and arg_379_1.time_ < var_382_12 + var_382_13 and not isNil(var_382_11) then
				local var_382_14 = (arg_379_1.time_ - var_382_12) / var_382_13

				if arg_379_1.var_.characterEffect6148ui_story and not isNil(var_382_11) then
					arg_379_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_12 + var_382_13 and arg_379_1.time_ < var_382_12 + var_382_13 + arg_382_0 and not isNil(var_382_11) and arg_379_1.var_.characterEffect6148ui_story then
				arg_379_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_382_15 = arg_379_1.actors_["1054ui_story"]
			local var_382_16 = 0

			if var_382_16 < arg_379_1.time_ and arg_379_1.time_ <= var_382_16 + arg_382_0 and not isNil(var_382_15) and arg_379_1.var_.characterEffect1054ui_story == nil then
				arg_379_1.var_.characterEffect1054ui_story = var_382_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_17 = 0.200000002980232

			if var_382_16 <= arg_379_1.time_ and arg_379_1.time_ < var_382_16 + var_382_17 and not isNil(var_382_15) then
				local var_382_18 = (arg_379_1.time_ - var_382_16) / var_382_17

				if arg_379_1.var_.characterEffect1054ui_story and not isNil(var_382_15) then
					local var_382_19 = Mathf.Lerp(0, 0.5, var_382_18)

					arg_379_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1054ui_story.fillRatio = var_382_19
				end
			end

			if arg_379_1.time_ >= var_382_16 + var_382_17 and arg_379_1.time_ < var_382_16 + var_382_17 + arg_382_0 and not isNil(var_382_15) and arg_379_1.var_.characterEffect1054ui_story then
				local var_382_20 = 0.5

				arg_379_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1054ui_story.fillRatio = var_382_20
			end

			local var_382_21 = 0

			if var_382_21 < arg_379_1.time_ and arg_379_1.time_ <= var_382_21 + arg_382_0 then
				arg_379_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_382_22 = 0

			if var_382_22 < arg_379_1.time_ and arg_379_1.time_ <= var_382_22 + arg_382_0 then
				arg_379_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_382_23 = 0
			local var_382_24 = 0.675

			if var_382_23 < arg_379_1.time_ and arg_379_1.time_ <= var_382_23 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_25 = arg_379_1:FormatText(StoryNameCfg[1488].name)

				arg_379_1.leftNameTxt_.text = var_382_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_26 = arg_379_1:GetWordFromCfg(426051093)
				local var_382_27 = arg_379_1:FormatText(var_382_26.content)

				arg_379_1.text_.text = var_382_27

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_28 = 27
				local var_382_29 = utf8.len(var_382_27)
				local var_382_30 = var_382_28 <= 0 and var_382_24 or var_382_24 * (var_382_29 / var_382_28)

				if var_382_30 > 0 and var_382_24 < var_382_30 then
					arg_379_1.talkMaxDuration = var_382_30

					if var_382_30 + var_382_23 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_30 + var_382_23
					end
				end

				arg_379_1.text_.text = var_382_27
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051093", "story_v_out_426051.awb") ~= 0 then
					local var_382_31 = manager.audio:GetVoiceLength("story_v_out_426051", "426051093", "story_v_out_426051.awb") / 1000

					if var_382_31 + var_382_23 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_31 + var_382_23
					end

					if var_382_26.prefab_name ~= "" and arg_379_1.actors_[var_382_26.prefab_name] ~= nil then
						local var_382_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_26.prefab_name].transform, "story_v_out_426051", "426051093", "story_v_out_426051.awb")

						arg_379_1:RecordAudio("426051093", var_382_32)
						arg_379_1:RecordAudio("426051093", var_382_32)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_426051", "426051093", "story_v_out_426051.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_426051", "426051093", "story_v_out_426051.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_33 = math.max(var_382_24, arg_379_1.talkMaxDuration)

			if var_382_23 <= arg_379_1.time_ and arg_379_1.time_ < var_382_23 + var_382_33 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_23) / var_382_33

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_23 + var_382_33 and arg_379_1.time_ < var_382_23 + var_382_33 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play426051094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 426051094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play426051095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["6148ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect6148ui_story == nil then
				arg_383_1.var_.characterEffect6148ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect6148ui_story and not isNil(var_386_0) then
					local var_386_4 = Mathf.Lerp(0, 0.5, var_386_3)

					arg_383_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_383_1.var_.characterEffect6148ui_story.fillRatio = var_386_4
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect6148ui_story then
				local var_386_5 = 0.5

				arg_383_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_383_1.var_.characterEffect6148ui_story.fillRatio = var_386_5
			end

			local var_386_6 = 0
			local var_386_7 = 0.475

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

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_9 = arg_383_1:GetWordFromCfg(426051094)
				local var_386_10 = arg_383_1:FormatText(var_386_9.content)

				arg_383_1.text_.text = var_386_10

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_11 = 19
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
	Play426051095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 426051095
		arg_387_1.duration_ = 4.27

		local var_387_0 = {
			zh = 4.266,
			ja = 2.8
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
				arg_387_0:Play426051096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["6148ui_story"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos6148ui_story = var_390_0.localPosition

				local var_390_2 = GameObjectTools.GetOrAddComponent(var_390_0.gameObject, typeof(DynamicBoneHelper))

				if var_390_2 then
					var_390_2:EnableDynamicBone(false)
				end
			end

			local var_390_3 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_3 then
				local var_390_4 = (arg_387_1.time_ - var_390_1) / var_390_3
				local var_390_5 = Vector3.New(0, 100, 0)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos6148ui_story, var_390_5, var_390_4)

				local var_390_6 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_6.x, var_390_6.y, var_390_6.z)

				local var_390_7 = var_390_0.localEulerAngles

				var_390_7.z = 0
				var_390_7.x = 0
				var_390_0.localEulerAngles = var_390_7
			end

			if arg_387_1.time_ >= var_390_1 + var_390_3 and arg_387_1.time_ < var_390_1 + var_390_3 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(0, 100, 0)

				local var_390_8 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_8.x, var_390_8.y, var_390_8.z)

				local var_390_9 = var_390_0.localEulerAngles

				var_390_9.z = 0
				var_390_9.x = 0
				var_390_0.localEulerAngles = var_390_9

				local var_390_10 = GameObjectTools.GetOrAddComponent(var_390_0.gameObject, typeof(DynamicBoneHelper))

				if var_390_10 then
					var_390_10:EnableDynamicBone(true)
				end
			end

			local var_390_11 = arg_387_1.actors_["1054ui_story"].transform
			local var_390_12 = 0

			if var_390_12 < arg_387_1.time_ and arg_387_1.time_ <= var_390_12 + arg_390_0 then
				arg_387_1.var_.moveOldPos1054ui_story = var_390_11.localPosition

				local var_390_13 = GameObjectTools.GetOrAddComponent(var_390_11.gameObject, typeof(DynamicBoneHelper))

				if var_390_13 then
					var_390_13:EnableDynamicBone(false)
				end
			end

			local var_390_14 = 0.001

			if var_390_12 <= arg_387_1.time_ and arg_387_1.time_ < var_390_12 + var_390_14 then
				local var_390_15 = (arg_387_1.time_ - var_390_12) / var_390_14
				local var_390_16 = Vector3.New(0, 100, 0)

				var_390_11.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1054ui_story, var_390_16, var_390_15)

				local var_390_17 = manager.ui.mainCamera.transform.position - var_390_11.position

				var_390_11.forward = Vector3.New(var_390_17.x, var_390_17.y, var_390_17.z)

				local var_390_18 = var_390_11.localEulerAngles

				var_390_18.z = 0
				var_390_18.x = 0
				var_390_11.localEulerAngles = var_390_18
			end

			if arg_387_1.time_ >= var_390_12 + var_390_14 and arg_387_1.time_ < var_390_12 + var_390_14 + arg_390_0 then
				var_390_11.localPosition = Vector3.New(0, 100, 0)

				local var_390_19 = manager.ui.mainCamera.transform.position - var_390_11.position

				var_390_11.forward = Vector3.New(var_390_19.x, var_390_19.y, var_390_19.z)

				local var_390_20 = var_390_11.localEulerAngles

				var_390_20.z = 0
				var_390_20.x = 0
				var_390_11.localEulerAngles = var_390_20

				local var_390_21 = GameObjectTools.GetOrAddComponent(var_390_11.gameObject, typeof(DynamicBoneHelper))

				if var_390_21 then
					var_390_21:EnableDynamicBone(true)
				end
			end

			local var_390_22 = manager.ui.mainCamera.transform
			local var_390_23 = 0

			if var_390_23 < arg_387_1.time_ and arg_387_1.time_ <= var_390_23 + arg_390_0 then
				arg_387_1.var_.shakeOldPos = var_390_22.localPosition
			end

			local var_390_24 = 0.233333333333333

			if var_390_23 <= arg_387_1.time_ and arg_387_1.time_ < var_390_23 + var_390_24 then
				local var_390_25 = (arg_387_1.time_ - var_390_23) / 0.066
				local var_390_26, var_390_27 = math.modf(var_390_25)

				var_390_22.localPosition = Vector3.New(var_390_27 * 0.13, var_390_27 * 0.13, var_390_27 * 0.13) + arg_387_1.var_.shakeOldPos
			end

			if arg_387_1.time_ >= var_390_23 + var_390_24 and arg_387_1.time_ < var_390_23 + var_390_24 + arg_390_0 then
				var_390_22.localPosition = arg_387_1.var_.shakeOldPos
			end

			local var_390_28 = 0

			if var_390_28 < arg_387_1.time_ and arg_387_1.time_ <= var_390_28 + arg_390_0 then
				arg_387_1.allBtn_.enabled = false
			end

			local var_390_29 = 0.233333333333333

			if arg_387_1.time_ >= var_390_28 + var_390_29 and arg_387_1.time_ < var_390_28 + var_390_29 + arg_390_0 then
				arg_387_1.allBtn_.enabled = true
			end

			local var_390_30 = 0
			local var_390_31 = 0.4

			if var_390_30 < arg_387_1.time_ and arg_387_1.time_ <= var_390_30 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0

				arg_387_1.dialog_:SetActive(true)

				arg_387_1.dialogCg_.alpha = 0

				local var_390_32 = LeanTween.value(arg_387_1.dialog_, 0, 1, 0.3)

				var_390_32:setOnUpdate(LuaHelper.FloatAction(function(arg_391_0)
					arg_387_1.dialogCg_.alpha = arg_391_0
				end))
				var_390_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_387_1.dialog_)
					var_390_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_387_1.duration_ = arg_387_1.duration_ + 0.3

				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_33 = arg_387_1:FormatText(StoryNameCfg[1487].name)

				arg_387_1.leftNameTxt_.text = var_390_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_34 = arg_387_1:GetWordFromCfg(426051095)
				local var_390_35 = arg_387_1:FormatText(var_390_34.content)

				arg_387_1.text_.text = var_390_35

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_36 = 16
				local var_390_37 = utf8.len(var_390_35)
				local var_390_38 = var_390_36 <= 0 and var_390_31 or var_390_31 * (var_390_37 / var_390_36)

				if var_390_38 > 0 and var_390_31 < var_390_38 then
					arg_387_1.talkMaxDuration = var_390_38
					var_390_30 = var_390_30 + 0.3

					if var_390_38 + var_390_30 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_38 + var_390_30
					end
				end

				arg_387_1.text_.text = var_390_35
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051095", "story_v_out_426051.awb") ~= 0 then
					local var_390_39 = manager.audio:GetVoiceLength("story_v_out_426051", "426051095", "story_v_out_426051.awb") / 1000

					if var_390_39 + var_390_30 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_39 + var_390_30
					end

					if var_390_34.prefab_name ~= "" and arg_387_1.actors_[var_390_34.prefab_name] ~= nil then
						local var_390_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_34.prefab_name].transform, "story_v_out_426051", "426051095", "story_v_out_426051.awb")

						arg_387_1:RecordAudio("426051095", var_390_40)
						arg_387_1:RecordAudio("426051095", var_390_40)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_426051", "426051095", "story_v_out_426051.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_426051", "426051095", "story_v_out_426051.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_41 = var_390_30 + 0.3
			local var_390_42 = math.max(var_390_31, arg_387_1.talkMaxDuration)

			if var_390_41 <= arg_387_1.time_ and arg_387_1.time_ < var_390_41 + var_390_42 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_41) / var_390_42

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_41 + var_390_42 and arg_387_1.time_ < var_390_41 + var_390_42 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
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

		arg_387_1:InitPlayNodeList()
	end,
	Play426051096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 426051096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play426051097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1054ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1054ui_story == nil then
				arg_393_1.var_.characterEffect1054ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect1054ui_story and not isNil(var_396_0) then
					local var_396_4 = Mathf.Lerp(0, 0.5, var_396_3)

					arg_393_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1054ui_story.fillRatio = var_396_4
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1054ui_story then
				local var_396_5 = 0.5

				arg_393_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1054ui_story.fillRatio = var_396_5
			end

			local var_396_6 = 0
			local var_396_7 = 1.1

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_8 = arg_393_1:GetWordFromCfg(426051096)
				local var_396_9 = arg_393_1:FormatText(var_396_8.content)

				arg_393_1.text_.text = var_396_9

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_10 = 44
				local var_396_11 = utf8.len(var_396_9)
				local var_396_12 = var_396_10 <= 0 and var_396_7 or var_396_7 * (var_396_11 / var_396_10)

				if var_396_12 > 0 and var_396_7 < var_396_12 then
					arg_393_1.talkMaxDuration = var_396_12

					if var_396_12 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_12 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_9
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_13 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_13 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_13

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_13 and arg_393_1.time_ < var_396_6 + var_396_13 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play426051097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 426051097
		arg_397_1.duration_ = 5.27

		local var_397_0 = {
			zh = 3.933,
			ja = 5.266
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play426051098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["6148ui_story"].transform
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.var_.moveOldPos6148ui_story = var_400_0.localPosition

				local var_400_2 = GameObjectTools.GetOrAddComponent(var_400_0.gameObject, typeof(DynamicBoneHelper))

				if var_400_2 then
					var_400_2:EnableDynamicBone(false)
				end
			end

			local var_400_3 = 0.001

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_3 then
				local var_400_4 = (arg_397_1.time_ - var_400_1) / var_400_3
				local var_400_5 = Vector3.New(0, -0.985, -6)

				var_400_0.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos6148ui_story, var_400_5, var_400_4)

				local var_400_6 = manager.ui.mainCamera.transform.position - var_400_0.position

				var_400_0.forward = Vector3.New(var_400_6.x, var_400_6.y, var_400_6.z)

				local var_400_7 = var_400_0.localEulerAngles

				var_400_7.z = 0
				var_400_7.x = 0
				var_400_0.localEulerAngles = var_400_7
			end

			if arg_397_1.time_ >= var_400_1 + var_400_3 and arg_397_1.time_ < var_400_1 + var_400_3 + arg_400_0 then
				var_400_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_400_8 = manager.ui.mainCamera.transform.position - var_400_0.position

				var_400_0.forward = Vector3.New(var_400_8.x, var_400_8.y, var_400_8.z)

				local var_400_9 = var_400_0.localEulerAngles

				var_400_9.z = 0
				var_400_9.x = 0
				var_400_0.localEulerAngles = var_400_9

				local var_400_10 = GameObjectTools.GetOrAddComponent(var_400_0.gameObject, typeof(DynamicBoneHelper))

				if var_400_10 then
					var_400_10:EnableDynamicBone(true)
				end
			end

			local var_400_11 = arg_397_1.actors_["6148ui_story"]
			local var_400_12 = 0

			if var_400_12 < arg_397_1.time_ and arg_397_1.time_ <= var_400_12 + arg_400_0 and not isNil(var_400_11) and arg_397_1.var_.characterEffect6148ui_story == nil then
				arg_397_1.var_.characterEffect6148ui_story = var_400_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_13 = 0.200000002980232

			if var_400_12 <= arg_397_1.time_ and arg_397_1.time_ < var_400_12 + var_400_13 and not isNil(var_400_11) then
				local var_400_14 = (arg_397_1.time_ - var_400_12) / var_400_13

				if arg_397_1.var_.characterEffect6148ui_story and not isNil(var_400_11) then
					arg_397_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_12 + var_400_13 and arg_397_1.time_ < var_400_12 + var_400_13 + arg_400_0 and not isNil(var_400_11) and arg_397_1.var_.characterEffect6148ui_story then
				arg_397_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_400_15 = 0

			if var_400_15 < arg_397_1.time_ and arg_397_1.time_ <= var_400_15 + arg_400_0 then
				arg_397_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_400_16 = 0

			if var_400_16 < arg_397_1.time_ and arg_397_1.time_ <= var_400_16 + arg_400_0 then
				arg_397_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_400_17 = 0
			local var_400_18 = 0.5

			if var_400_17 < arg_397_1.time_ and arg_397_1.time_ <= var_400_17 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_19 = arg_397_1:FormatText(StoryNameCfg[1488].name)

				arg_397_1.leftNameTxt_.text = var_400_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_20 = arg_397_1:GetWordFromCfg(426051097)
				local var_400_21 = arg_397_1:FormatText(var_400_20.content)

				arg_397_1.text_.text = var_400_21

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_22 = 20
				local var_400_23 = utf8.len(var_400_21)
				local var_400_24 = var_400_22 <= 0 and var_400_18 or var_400_18 * (var_400_23 / var_400_22)

				if var_400_24 > 0 and var_400_18 < var_400_24 then
					arg_397_1.talkMaxDuration = var_400_24

					if var_400_24 + var_400_17 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_24 + var_400_17
					end
				end

				arg_397_1.text_.text = var_400_21
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051097", "story_v_out_426051.awb") ~= 0 then
					local var_400_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051097", "story_v_out_426051.awb") / 1000

					if var_400_25 + var_400_17 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_25 + var_400_17
					end

					if var_400_20.prefab_name ~= "" and arg_397_1.actors_[var_400_20.prefab_name] ~= nil then
						local var_400_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_20.prefab_name].transform, "story_v_out_426051", "426051097", "story_v_out_426051.awb")

						arg_397_1:RecordAudio("426051097", var_400_26)
						arg_397_1:RecordAudio("426051097", var_400_26)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_426051", "426051097", "story_v_out_426051.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_426051", "426051097", "story_v_out_426051.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_27 = math.max(var_400_18, arg_397_1.talkMaxDuration)

			if var_400_17 <= arg_397_1.time_ and arg_397_1.time_ < var_400_17 + var_400_27 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_17) / var_400_27

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_17 + var_400_27 and arg_397_1.time_ < var_400_17 + var_400_27 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
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

		arg_397_1:InitPlayNodeList()
	end,
	Play426051098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 426051098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play426051099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["6148ui_story"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect6148ui_story == nil then
				arg_401_1.var_.characterEffect6148ui_story = var_404_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.characterEffect6148ui_story and not isNil(var_404_0) then
					local var_404_4 = Mathf.Lerp(0, 0.5, var_404_3)

					arg_401_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_401_1.var_.characterEffect6148ui_story.fillRatio = var_404_4
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect6148ui_story then
				local var_404_5 = 0.5

				arg_401_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_401_1.var_.characterEffect6148ui_story.fillRatio = var_404_5
			end

			local var_404_6 = 0
			local var_404_7 = 0.175

			if var_404_6 < arg_401_1.time_ and arg_401_1.time_ <= var_404_6 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_8 = arg_401_1:FormatText(StoryNameCfg[7].name)

				arg_401_1.leftNameTxt_.text = var_404_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_9 = arg_401_1:GetWordFromCfg(426051098)
				local var_404_10 = arg_401_1:FormatText(var_404_9.content)

				arg_401_1.text_.text = var_404_10

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 7
				local var_404_12 = utf8.len(var_404_10)
				local var_404_13 = var_404_11 <= 0 and var_404_7 or var_404_7 * (var_404_12 / var_404_11)

				if var_404_13 > 0 and var_404_7 < var_404_13 then
					arg_401_1.talkMaxDuration = var_404_13

					if var_404_13 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_13 + var_404_6
					end
				end

				arg_401_1.text_.text = var_404_10
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_7, arg_401_1.talkMaxDuration)

			if var_404_6 <= arg_401_1.time_ and arg_401_1.time_ < var_404_6 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_6) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_6 + var_404_14 and arg_401_1.time_ < var_404_6 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play426051099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 426051099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play426051100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["6148ui_story"].transform
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.var_.moveOldPos6148ui_story = var_408_0.localPosition

				local var_408_2 = GameObjectTools.GetOrAddComponent(var_408_0.gameObject, typeof(DynamicBoneHelper))

				if var_408_2 then
					var_408_2:EnableDynamicBone(false)
				end
			end

			local var_408_3 = 0.001

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_3 then
				local var_408_4 = (arg_405_1.time_ - var_408_1) / var_408_3
				local var_408_5 = Vector3.New(0, 100, 0)

				var_408_0.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos6148ui_story, var_408_5, var_408_4)

				local var_408_6 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_6.x, var_408_6.y, var_408_6.z)

				local var_408_7 = var_408_0.localEulerAngles

				var_408_7.z = 0
				var_408_7.x = 0
				var_408_0.localEulerAngles = var_408_7
			end

			if arg_405_1.time_ >= var_408_1 + var_408_3 and arg_405_1.time_ < var_408_1 + var_408_3 + arg_408_0 then
				var_408_0.localPosition = Vector3.New(0, 100, 0)

				local var_408_8 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_8.x, var_408_8.y, var_408_8.z)

				local var_408_9 = var_408_0.localEulerAngles

				var_408_9.z = 0
				var_408_9.x = 0
				var_408_0.localEulerAngles = var_408_9

				local var_408_10 = GameObjectTools.GetOrAddComponent(var_408_0.gameObject, typeof(DynamicBoneHelper))

				if var_408_10 then
					var_408_10:EnableDynamicBone(true)
				end
			end

			local var_408_11 = arg_405_1.actors_["1054ui_story"].transform
			local var_408_12 = 0

			if var_408_12 < arg_405_1.time_ and arg_405_1.time_ <= var_408_12 + arg_408_0 then
				arg_405_1.var_.moveOldPos1054ui_story = var_408_11.localPosition

				local var_408_13 = GameObjectTools.GetOrAddComponent(var_408_11.gameObject, typeof(DynamicBoneHelper))

				if var_408_13 then
					var_408_13:EnableDynamicBone(false)
				end
			end

			local var_408_14 = 0.001

			if var_408_12 <= arg_405_1.time_ and arg_405_1.time_ < var_408_12 + var_408_14 then
				local var_408_15 = (arg_405_1.time_ - var_408_12) / var_408_14
				local var_408_16 = Vector3.New(0, 100, 0)

				var_408_11.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1054ui_story, var_408_16, var_408_15)

				local var_408_17 = manager.ui.mainCamera.transform.position - var_408_11.position

				var_408_11.forward = Vector3.New(var_408_17.x, var_408_17.y, var_408_17.z)

				local var_408_18 = var_408_11.localEulerAngles

				var_408_18.z = 0
				var_408_18.x = 0
				var_408_11.localEulerAngles = var_408_18
			end

			if arg_405_1.time_ >= var_408_12 + var_408_14 and arg_405_1.time_ < var_408_12 + var_408_14 + arg_408_0 then
				var_408_11.localPosition = Vector3.New(0, 100, 0)

				local var_408_19 = manager.ui.mainCamera.transform.position - var_408_11.position

				var_408_11.forward = Vector3.New(var_408_19.x, var_408_19.y, var_408_19.z)

				local var_408_20 = var_408_11.localEulerAngles

				var_408_20.z = 0
				var_408_20.x = 0
				var_408_11.localEulerAngles = var_408_20

				local var_408_21 = GameObjectTools.GetOrAddComponent(var_408_11.gameObject, typeof(DynamicBoneHelper))

				if var_408_21 then
					var_408_21:EnableDynamicBone(true)
				end
			end

			local var_408_22 = 0
			local var_408_23 = 0.75

			if var_408_22 < arg_405_1.time_ and arg_405_1.time_ <= var_408_22 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_24 = arg_405_1:GetWordFromCfg(426051099)
				local var_408_25 = arg_405_1:FormatText(var_408_24.content)

				arg_405_1.text_.text = var_408_25

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_26 = 30
				local var_408_27 = utf8.len(var_408_25)
				local var_408_28 = var_408_26 <= 0 and var_408_23 or var_408_23 * (var_408_27 / var_408_26)

				if var_408_28 > 0 and var_408_23 < var_408_28 then
					arg_405_1.talkMaxDuration = var_408_28

					if var_408_28 + var_408_22 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_28 + var_408_22
					end
				end

				arg_405_1.text_.text = var_408_25
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_29 = math.max(var_408_23, arg_405_1.talkMaxDuration)

			if var_408_22 <= arg_405_1.time_ and arg_405_1.time_ < var_408_22 + var_408_29 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_22) / var_408_29

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_22 + var_408_29 and arg_405_1.time_ < var_408_22 + var_408_29 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	Play426051100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 426051100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play426051101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.375

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_2 = arg_409_1:FormatText(StoryNameCfg[7].name)

				arg_409_1.leftNameTxt_.text = var_412_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:GetWordFromCfg(426051100)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 15
				local var_412_6 = utf8.len(var_412_4)
				local var_412_7 = var_412_5 <= 0 and var_412_1 or var_412_1 * (var_412_6 / var_412_5)

				if var_412_7 > 0 and var_412_1 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_0
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_8 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_8 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_8

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_8 and arg_409_1.time_ < var_412_0 + var_412_8 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play426051101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 426051101
		arg_413_1.duration_ = 9.43

		local var_413_0 = {
			zh = 4,
			ja = 9.433
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
				arg_413_0:Play426051102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1054ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos1054ui_story = var_416_0.localPosition

				local var_416_2 = GameObjectTools.GetOrAddComponent(var_416_0.gameObject, typeof(DynamicBoneHelper))

				if var_416_2 then
					var_416_2:EnableDynamicBone(false)
				end
			end

			local var_416_3 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_3 then
				local var_416_4 = (arg_413_1.time_ - var_416_1) / var_416_3
				local var_416_5 = Vector3.New(0, -0.985, -6)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1054ui_story, var_416_5, var_416_4)

				local var_416_6 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_6.x, var_416_6.y, var_416_6.z)

				local var_416_7 = var_416_0.localEulerAngles

				var_416_7.z = 0
				var_416_7.x = 0
				var_416_0.localEulerAngles = var_416_7
			end

			if arg_413_1.time_ >= var_416_1 + var_416_3 and arg_413_1.time_ < var_416_1 + var_416_3 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_416_8 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_8.x, var_416_8.y, var_416_8.z)

				local var_416_9 = var_416_0.localEulerAngles

				var_416_9.z = 0
				var_416_9.x = 0
				var_416_0.localEulerAngles = var_416_9

				local var_416_10 = GameObjectTools.GetOrAddComponent(var_416_0.gameObject, typeof(DynamicBoneHelper))

				if var_416_10 then
					var_416_10:EnableDynamicBone(true)
				end
			end

			local var_416_11 = arg_413_1.actors_["1054ui_story"]
			local var_416_12 = 0

			if var_416_12 < arg_413_1.time_ and arg_413_1.time_ <= var_416_12 + arg_416_0 and not isNil(var_416_11) and arg_413_1.var_.characterEffect1054ui_story == nil then
				arg_413_1.var_.characterEffect1054ui_story = var_416_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_13 = 0.200000002980232

			if var_416_12 <= arg_413_1.time_ and arg_413_1.time_ < var_416_12 + var_416_13 and not isNil(var_416_11) then
				local var_416_14 = (arg_413_1.time_ - var_416_12) / var_416_13

				if arg_413_1.var_.characterEffect1054ui_story and not isNil(var_416_11) then
					arg_413_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_12 + var_416_13 and arg_413_1.time_ < var_416_12 + var_416_13 + arg_416_0 and not isNil(var_416_11) and arg_413_1.var_.characterEffect1054ui_story then
				arg_413_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_416_15 = 0

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_416_16 = 0

			if var_416_16 < arg_413_1.time_ and arg_413_1.time_ <= var_416_16 + arg_416_0 then
				arg_413_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_416_17 = 0
			local var_416_18 = 0.375

			if var_416_17 < arg_413_1.time_ and arg_413_1.time_ <= var_416_17 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_19 = arg_413_1:FormatText(StoryNameCfg[1487].name)

				arg_413_1.leftNameTxt_.text = var_416_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_20 = arg_413_1:GetWordFromCfg(426051101)
				local var_416_21 = arg_413_1:FormatText(var_416_20.content)

				arg_413_1.text_.text = var_416_21

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_22 = 15
				local var_416_23 = utf8.len(var_416_21)
				local var_416_24 = var_416_22 <= 0 and var_416_18 or var_416_18 * (var_416_23 / var_416_22)

				if var_416_24 > 0 and var_416_18 < var_416_24 then
					arg_413_1.talkMaxDuration = var_416_24

					if var_416_24 + var_416_17 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_24 + var_416_17
					end
				end

				arg_413_1.text_.text = var_416_21
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051101", "story_v_out_426051.awb") ~= 0 then
					local var_416_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051101", "story_v_out_426051.awb") / 1000

					if var_416_25 + var_416_17 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_25 + var_416_17
					end

					if var_416_20.prefab_name ~= "" and arg_413_1.actors_[var_416_20.prefab_name] ~= nil then
						local var_416_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_20.prefab_name].transform, "story_v_out_426051", "426051101", "story_v_out_426051.awb")

						arg_413_1:RecordAudio("426051101", var_416_26)
						arg_413_1:RecordAudio("426051101", var_416_26)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_426051", "426051101", "story_v_out_426051.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_426051", "426051101", "story_v_out_426051.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_27 = math.max(var_416_18, arg_413_1.talkMaxDuration)

			if var_416_17 <= arg_413_1.time_ and arg_413_1.time_ < var_416_17 + var_416_27 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_17) / var_416_27

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_17 + var_416_27 and arg_413_1.time_ < var_416_17 + var_416_27 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
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

		arg_413_1:InitPlayNodeList()
	end,
	Play426051102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 426051102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play426051103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1054ui_story"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1054ui_story == nil then
				arg_417_1.var_.characterEffect1054ui_story = var_420_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.characterEffect1054ui_story and not isNil(var_420_0) then
					local var_420_4 = Mathf.Lerp(0, 0.5, var_420_3)

					arg_417_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1054ui_story.fillRatio = var_420_4
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1054ui_story then
				local var_420_5 = 0.5

				arg_417_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1054ui_story.fillRatio = var_420_5
			end

			local var_420_6 = 0
			local var_420_7 = 0.225

			if var_420_6 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_8 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_8

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

				local var_420_9 = arg_417_1:GetWordFromCfg(426051102)
				local var_420_10 = arg_417_1:FormatText(var_420_9.content)

				arg_417_1.text_.text = var_420_10

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_11 = 9
				local var_420_12 = utf8.len(var_420_10)
				local var_420_13 = var_420_11 <= 0 and var_420_7 or var_420_7 * (var_420_12 / var_420_11)

				if var_420_13 > 0 and var_420_7 < var_420_13 then
					arg_417_1.talkMaxDuration = var_420_13

					if var_420_13 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_13 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_10
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_14 = math.max(var_420_7, arg_417_1.talkMaxDuration)

			if var_420_6 <= arg_417_1.time_ and arg_417_1.time_ < var_420_6 + var_420_14 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_6) / var_420_14

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_6 + var_420_14 and arg_417_1.time_ < var_420_6 + var_420_14 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play426051103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 426051103
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play426051104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1054ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos1054ui_story = var_424_0.localPosition

				local var_424_2 = GameObjectTools.GetOrAddComponent(var_424_0.gameObject, typeof(DynamicBoneHelper))

				if var_424_2 then
					var_424_2:EnableDynamicBone(false)
				end
			end

			local var_424_3 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_3 then
				local var_424_4 = (arg_421_1.time_ - var_424_1) / var_424_3
				local var_424_5 = Vector3.New(0, 100, 0)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1054ui_story, var_424_5, var_424_4)

				local var_424_6 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_6.x, var_424_6.y, var_424_6.z)

				local var_424_7 = var_424_0.localEulerAngles

				var_424_7.z = 0
				var_424_7.x = 0
				var_424_0.localEulerAngles = var_424_7
			end

			if arg_421_1.time_ >= var_424_1 + var_424_3 and arg_421_1.time_ < var_424_1 + var_424_3 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, 100, 0)

				local var_424_8 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_8.x, var_424_8.y, var_424_8.z)

				local var_424_9 = var_424_0.localEulerAngles

				var_424_9.z = 0
				var_424_9.x = 0
				var_424_0.localEulerAngles = var_424_9

				local var_424_10 = GameObjectTools.GetOrAddComponent(var_424_0.gameObject, typeof(DynamicBoneHelper))

				if var_424_10 then
					var_424_10:EnableDynamicBone(true)
				end
			end

			local var_424_11 = 0
			local var_424_12 = 0.575

			if var_424_11 < arg_421_1.time_ and arg_421_1.time_ <= var_424_11 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_13 = arg_421_1:GetWordFromCfg(426051103)
				local var_424_14 = arg_421_1:FormatText(var_424_13.content)

				arg_421_1.text_.text = var_424_14

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_15 = 23
				local var_424_16 = utf8.len(var_424_14)
				local var_424_17 = var_424_15 <= 0 and var_424_12 or var_424_12 * (var_424_16 / var_424_15)

				if var_424_17 > 0 and var_424_12 < var_424_17 then
					arg_421_1.talkMaxDuration = var_424_17

					if var_424_17 + var_424_11 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_17 + var_424_11
					end
				end

				arg_421_1.text_.text = var_424_14
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_18 = math.max(var_424_12, arg_421_1.talkMaxDuration)

			if var_424_11 <= arg_421_1.time_ and arg_421_1.time_ < var_424_11 + var_424_18 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_11) / var_424_18

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_11 + var_424_18 and arg_421_1.time_ < var_424_11 + var_424_18 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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

		arg_421_1:InitPlayNodeList()
	end,
	Play426051104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 426051104
		arg_425_1.duration_ = 4.23

		local var_425_0 = {
			zh = 4.233,
			ja = 4.133
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
				arg_425_0:Play426051105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["6148ui_story"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos6148ui_story = var_428_0.localPosition

				local var_428_2 = GameObjectTools.GetOrAddComponent(var_428_0.gameObject, typeof(DynamicBoneHelper))

				if var_428_2 then
					var_428_2:EnableDynamicBone(false)
				end
			end

			local var_428_3 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_3 then
				local var_428_4 = (arg_425_1.time_ - var_428_1) / var_428_3
				local var_428_5 = Vector3.New(-0.7, -0.985, -6)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos6148ui_story, var_428_5, var_428_4)

				local var_428_6 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_6.x, var_428_6.y, var_428_6.z)

				local var_428_7 = var_428_0.localEulerAngles

				var_428_7.z = 0
				var_428_7.x = 0
				var_428_0.localEulerAngles = var_428_7
			end

			if arg_425_1.time_ >= var_428_1 + var_428_3 and arg_425_1.time_ < var_428_1 + var_428_3 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_428_8 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_8.x, var_428_8.y, var_428_8.z)

				local var_428_9 = var_428_0.localEulerAngles

				var_428_9.z = 0
				var_428_9.x = 0
				var_428_0.localEulerAngles = var_428_9

				local var_428_10 = GameObjectTools.GetOrAddComponent(var_428_0.gameObject, typeof(DynamicBoneHelper))

				if var_428_10 then
					var_428_10:EnableDynamicBone(true)
				end
			end

			local var_428_11 = arg_425_1.actors_["6148ui_story"]
			local var_428_12 = 0

			if var_428_12 < arg_425_1.time_ and arg_425_1.time_ <= var_428_12 + arg_428_0 and not isNil(var_428_11) and arg_425_1.var_.characterEffect6148ui_story == nil then
				arg_425_1.var_.characterEffect6148ui_story = var_428_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_13 = 0.200000002980232

			if var_428_12 <= arg_425_1.time_ and arg_425_1.time_ < var_428_12 + var_428_13 and not isNil(var_428_11) then
				local var_428_14 = (arg_425_1.time_ - var_428_12) / var_428_13

				if arg_425_1.var_.characterEffect6148ui_story and not isNil(var_428_11) then
					arg_425_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_12 + var_428_13 and arg_425_1.time_ < var_428_12 + var_428_13 + arg_428_0 and not isNil(var_428_11) and arg_425_1.var_.characterEffect6148ui_story then
				arg_425_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_428_15 = 0

			if var_428_15 < arg_425_1.time_ and arg_425_1.time_ <= var_428_15 + arg_428_0 then
				arg_425_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_428_16 = 0

			if var_428_16 < arg_425_1.time_ and arg_425_1.time_ <= var_428_16 + arg_428_0 then
				arg_425_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_428_17 = 0
			local var_428_18 = 0.375

			if var_428_17 < arg_425_1.time_ and arg_425_1.time_ <= var_428_17 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_19 = arg_425_1:FormatText(StoryNameCfg[1488].name)

				arg_425_1.leftNameTxt_.text = var_428_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_20 = arg_425_1:GetWordFromCfg(426051104)
				local var_428_21 = arg_425_1:FormatText(var_428_20.content)

				arg_425_1.text_.text = var_428_21

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_22 = 15
				local var_428_23 = utf8.len(var_428_21)
				local var_428_24 = var_428_22 <= 0 and var_428_18 or var_428_18 * (var_428_23 / var_428_22)

				if var_428_24 > 0 and var_428_18 < var_428_24 then
					arg_425_1.talkMaxDuration = var_428_24

					if var_428_24 + var_428_17 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_24 + var_428_17
					end
				end

				arg_425_1.text_.text = var_428_21
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051104", "story_v_out_426051.awb") ~= 0 then
					local var_428_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051104", "story_v_out_426051.awb") / 1000

					if var_428_25 + var_428_17 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_25 + var_428_17
					end

					if var_428_20.prefab_name ~= "" and arg_425_1.actors_[var_428_20.prefab_name] ~= nil then
						local var_428_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_20.prefab_name].transform, "story_v_out_426051", "426051104", "story_v_out_426051.awb")

						arg_425_1:RecordAudio("426051104", var_428_26)
						arg_425_1:RecordAudio("426051104", var_428_26)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_426051", "426051104", "story_v_out_426051.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_426051", "426051104", "story_v_out_426051.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_27 = math.max(var_428_18, arg_425_1.talkMaxDuration)

			if var_428_17 <= arg_425_1.time_ and arg_425_1.time_ < var_428_17 + var_428_27 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_17) / var_428_27

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_17 + var_428_27 and arg_425_1.time_ < var_428_17 + var_428_27 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
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

		arg_425_1:InitPlayNodeList()
	end,
	Play426051105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 426051105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play426051106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["6148ui_story"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect6148ui_story == nil then
				arg_429_1.var_.characterEffect6148ui_story = var_432_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.characterEffect6148ui_story and not isNil(var_432_0) then
					local var_432_4 = Mathf.Lerp(0, 0.5, var_432_3)

					arg_429_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_429_1.var_.characterEffect6148ui_story.fillRatio = var_432_4
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect6148ui_story then
				local var_432_5 = 0.5

				arg_429_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_429_1.var_.characterEffect6148ui_story.fillRatio = var_432_5
			end

			local var_432_6 = 0
			local var_432_7 = 0.3

			if var_432_6 < arg_429_1.time_ and arg_429_1.time_ <= var_432_6 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_8 = arg_429_1:FormatText(StoryNameCfg[7].name)

				arg_429_1.leftNameTxt_.text = var_432_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_9 = arg_429_1:GetWordFromCfg(426051105)
				local var_432_10 = arg_429_1:FormatText(var_432_9.content)

				arg_429_1.text_.text = var_432_10

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_11 = 12
				local var_432_12 = utf8.len(var_432_10)
				local var_432_13 = var_432_11 <= 0 and var_432_7 or var_432_7 * (var_432_12 / var_432_11)

				if var_432_13 > 0 and var_432_7 < var_432_13 then
					arg_429_1.talkMaxDuration = var_432_13

					if var_432_13 + var_432_6 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_13 + var_432_6
					end
				end

				arg_429_1.text_.text = var_432_10
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_14 = math.max(var_432_7, arg_429_1.talkMaxDuration)

			if var_432_6 <= arg_429_1.time_ and arg_429_1.time_ < var_432_6 + var_432_14 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_6) / var_432_14

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_6 + var_432_14 and arg_429_1.time_ < var_432_6 + var_432_14 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play426051106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 426051106
		arg_433_1.duration_ = 4.27

		local var_433_0 = {
			zh = 3.833,
			ja = 4.266
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
				arg_433_0:Play426051107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1054ui_story"].transform
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.var_.moveOldPos1054ui_story = var_436_0.localPosition

				local var_436_2 = GameObjectTools.GetOrAddComponent(var_436_0.gameObject, typeof(DynamicBoneHelper))

				if var_436_2 then
					var_436_2:EnableDynamicBone(false)
				end
			end

			local var_436_3 = 0.001

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_3 then
				local var_436_4 = (arg_433_1.time_ - var_436_1) / var_436_3
				local var_436_5 = Vector3.New(0.7, -0.985, -6)

				var_436_0.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1054ui_story, var_436_5, var_436_4)

				local var_436_6 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_6.x, var_436_6.y, var_436_6.z)

				local var_436_7 = var_436_0.localEulerAngles

				var_436_7.z = 0
				var_436_7.x = 0
				var_436_0.localEulerAngles = var_436_7
			end

			if arg_433_1.time_ >= var_436_1 + var_436_3 and arg_433_1.time_ < var_436_1 + var_436_3 + arg_436_0 then
				var_436_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_436_8 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_8.x, var_436_8.y, var_436_8.z)

				local var_436_9 = var_436_0.localEulerAngles

				var_436_9.z = 0
				var_436_9.x = 0
				var_436_0.localEulerAngles = var_436_9

				local var_436_10 = GameObjectTools.GetOrAddComponent(var_436_0.gameObject, typeof(DynamicBoneHelper))

				if var_436_10 then
					var_436_10:EnableDynamicBone(true)
				end
			end

			local var_436_11 = arg_433_1.actors_["1054ui_story"]
			local var_436_12 = 0

			if var_436_12 < arg_433_1.time_ and arg_433_1.time_ <= var_436_12 + arg_436_0 and not isNil(var_436_11) and arg_433_1.var_.characterEffect1054ui_story == nil then
				arg_433_1.var_.characterEffect1054ui_story = var_436_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_13 = 0.200000002980232

			if var_436_12 <= arg_433_1.time_ and arg_433_1.time_ < var_436_12 + var_436_13 and not isNil(var_436_11) then
				local var_436_14 = (arg_433_1.time_ - var_436_12) / var_436_13

				if arg_433_1.var_.characterEffect1054ui_story and not isNil(var_436_11) then
					arg_433_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= var_436_12 + var_436_13 and arg_433_1.time_ < var_436_12 + var_436_13 + arg_436_0 and not isNil(var_436_11) and arg_433_1.var_.characterEffect1054ui_story then
				arg_433_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_436_15 = 0

			if var_436_15 < arg_433_1.time_ and arg_433_1.time_ <= var_436_15 + arg_436_0 then
				arg_433_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_1")
			end

			local var_436_16 = 0

			if var_436_16 < arg_433_1.time_ and arg_433_1.time_ <= var_436_16 + arg_436_0 then
				arg_433_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_436_17 = 0
			local var_436_18 = 0.375

			if var_436_17 < arg_433_1.time_ and arg_433_1.time_ <= var_436_17 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_19 = arg_433_1:FormatText(StoryNameCfg[1487].name)

				arg_433_1.leftNameTxt_.text = var_436_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_20 = arg_433_1:GetWordFromCfg(426051106)
				local var_436_21 = arg_433_1:FormatText(var_436_20.content)

				arg_433_1.text_.text = var_436_21

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_22 = 15
				local var_436_23 = utf8.len(var_436_21)
				local var_436_24 = var_436_22 <= 0 and var_436_18 or var_436_18 * (var_436_23 / var_436_22)

				if var_436_24 > 0 and var_436_18 < var_436_24 then
					arg_433_1.talkMaxDuration = var_436_24

					if var_436_24 + var_436_17 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_24 + var_436_17
					end
				end

				arg_433_1.text_.text = var_436_21
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051106", "story_v_out_426051.awb") ~= 0 then
					local var_436_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051106", "story_v_out_426051.awb") / 1000

					if var_436_25 + var_436_17 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_25 + var_436_17
					end

					if var_436_20.prefab_name ~= "" and arg_433_1.actors_[var_436_20.prefab_name] ~= nil then
						local var_436_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_20.prefab_name].transform, "story_v_out_426051", "426051106", "story_v_out_426051.awb")

						arg_433_1:RecordAudio("426051106", var_436_26)
						arg_433_1:RecordAudio("426051106", var_436_26)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_426051", "426051106", "story_v_out_426051.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_426051", "426051106", "story_v_out_426051.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_27 = math.max(var_436_18, arg_433_1.talkMaxDuration)

			if var_436_17 <= arg_433_1.time_ and arg_433_1.time_ < var_436_17 + var_436_27 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_17) / var_436_27

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_17 + var_436_27 and arg_433_1.time_ < var_436_17 + var_436_27 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
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

		arg_433_1:InitPlayNodeList()
	end,
	Play426051107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 426051107
		arg_437_1.duration_ = 7

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play426051108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = "ST2012"

			if arg_437_1.bgs_[var_440_0] == nil then
				local var_440_1 = Object.Instantiate(arg_437_1.paintGo_)

				var_440_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_440_0)
				var_440_1.name = var_440_0
				var_440_1.transform.parent = arg_437_1.stage_.transform
				var_440_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_437_1.bgs_[var_440_0] = var_440_1
			end

			local var_440_2 = 0.965999998152256

			if var_440_2 < arg_437_1.time_ and arg_437_1.time_ <= var_440_2 + arg_440_0 then
				local var_440_3 = manager.ui.mainCamera.transform.localPosition
				local var_440_4 = Vector3.New(0, 0, 10) + Vector3.New(var_440_3.x, var_440_3.y, 0)
				local var_440_5 = arg_437_1.bgs_.ST2012

				var_440_5.transform.localPosition = var_440_4
				var_440_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_440_6 = var_440_5:GetComponent("SpriteRenderer")

				if var_440_6 and var_440_6.sprite then
					local var_440_7 = (var_440_5.transform.localPosition - var_440_3).z
					local var_440_8 = manager.ui.mainCameraCom_
					local var_440_9 = 2 * var_440_7 * Mathf.Tan(var_440_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_440_10 = var_440_9 * var_440_8.aspect
					local var_440_11 = var_440_6.sprite.bounds.size.x
					local var_440_12 = var_440_6.sprite.bounds.size.y
					local var_440_13 = var_440_10 / var_440_11
					local var_440_14 = var_440_9 / var_440_12
					local var_440_15 = var_440_14 < var_440_13 and var_440_13 or var_440_14

					var_440_5.transform.localScale = Vector3.New(var_440_15, var_440_15, 0)
				end

				for iter_440_0, iter_440_1 in pairs(arg_437_1.bgs_) do
					if iter_440_0 ~= "ST2012" then
						iter_440_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_440_16 = 1.999999999999

			if var_440_16 < arg_437_1.time_ and arg_437_1.time_ <= var_440_16 + arg_440_0 then
				arg_437_1.allBtn_.enabled = false
			end

			local var_440_17 = 0.3

			if arg_437_1.time_ >= var_440_16 + var_440_17 and arg_437_1.time_ < var_440_16 + var_440_17 + arg_440_0 then
				arg_437_1.allBtn_.enabled = true
			end

			local var_440_18 = manager.ui.mainCamera.transform
			local var_440_19 = 0

			if var_440_19 < arg_437_1.time_ and arg_437_1.time_ <= var_440_19 + arg_440_0 then
				local var_440_20 = arg_437_1.var_.effectjinfangjian1
				local var_440_21
				local var_440_22 = var_440_18

				if not var_440_20 then
					var_440_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_440_22)
					var_440_20.name = "jinfangjian1"
					arg_437_1.var_.effectjinfangjian1 = var_440_20
				else
					var_440_20.transform:SetParent(var_440_22)
				end

				var_440_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_440_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_440_23 = arg_437_1.actors_["6148ui_story"].transform
			local var_440_24 = 0.965999998152256

			if var_440_24 < arg_437_1.time_ and arg_437_1.time_ <= var_440_24 + arg_440_0 then
				arg_437_1.var_.moveOldPos6148ui_story = var_440_23.localPosition

				local var_440_25 = GameObjectTools.GetOrAddComponent(var_440_23.gameObject, typeof(DynamicBoneHelper))

				if var_440_25 then
					var_440_25:EnableDynamicBone(false)
				end
			end

			local var_440_26 = 0.001

			if var_440_24 <= arg_437_1.time_ and arg_437_1.time_ < var_440_24 + var_440_26 then
				local var_440_27 = (arg_437_1.time_ - var_440_24) / var_440_26
				local var_440_28 = Vector3.New(0, 100, 0)

				var_440_23.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos6148ui_story, var_440_28, var_440_27)

				local var_440_29 = manager.ui.mainCamera.transform.position - var_440_23.position

				var_440_23.forward = Vector3.New(var_440_29.x, var_440_29.y, var_440_29.z)

				local var_440_30 = var_440_23.localEulerAngles

				var_440_30.z = 0
				var_440_30.x = 0
				var_440_23.localEulerAngles = var_440_30
			end

			if arg_437_1.time_ >= var_440_24 + var_440_26 and arg_437_1.time_ < var_440_24 + var_440_26 + arg_440_0 then
				var_440_23.localPosition = Vector3.New(0, 100, 0)

				local var_440_31 = manager.ui.mainCamera.transform.position - var_440_23.position

				var_440_23.forward = Vector3.New(var_440_31.x, var_440_31.y, var_440_31.z)

				local var_440_32 = var_440_23.localEulerAngles

				var_440_32.z = 0
				var_440_32.x = 0
				var_440_23.localEulerAngles = var_440_32

				local var_440_33 = GameObjectTools.GetOrAddComponent(var_440_23.gameObject, typeof(DynamicBoneHelper))

				if var_440_33 then
					var_440_33:EnableDynamicBone(true)
				end
			end

			local var_440_34 = arg_437_1.actors_["1054ui_story"].transform
			local var_440_35 = 0.965999998152256

			if var_440_35 < arg_437_1.time_ and arg_437_1.time_ <= var_440_35 + arg_440_0 then
				arg_437_1.var_.moveOldPos1054ui_story = var_440_34.localPosition

				local var_440_36 = GameObjectTools.GetOrAddComponent(var_440_34.gameObject, typeof(DynamicBoneHelper))

				if var_440_36 then
					var_440_36:EnableDynamicBone(false)
				end
			end

			local var_440_37 = 0.001

			if var_440_35 <= arg_437_1.time_ and arg_437_1.time_ < var_440_35 + var_440_37 then
				local var_440_38 = (arg_437_1.time_ - var_440_35) / var_440_37
				local var_440_39 = Vector3.New(0, 100, 0)

				var_440_34.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1054ui_story, var_440_39, var_440_38)

				local var_440_40 = manager.ui.mainCamera.transform.position - var_440_34.position

				var_440_34.forward = Vector3.New(var_440_40.x, var_440_40.y, var_440_40.z)

				local var_440_41 = var_440_34.localEulerAngles

				var_440_41.z = 0
				var_440_41.x = 0
				var_440_34.localEulerAngles = var_440_41
			end

			if arg_437_1.time_ >= var_440_35 + var_440_37 and arg_437_1.time_ < var_440_35 + var_440_37 + arg_440_0 then
				var_440_34.localPosition = Vector3.New(0, 100, 0)

				local var_440_42 = manager.ui.mainCamera.transform.position - var_440_34.position

				var_440_34.forward = Vector3.New(var_440_42.x, var_440_42.y, var_440_42.z)

				local var_440_43 = var_440_34.localEulerAngles

				var_440_43.z = 0
				var_440_43.x = 0
				var_440_34.localEulerAngles = var_440_43

				local var_440_44 = GameObjectTools.GetOrAddComponent(var_440_34.gameObject, typeof(DynamicBoneHelper))

				if var_440_44 then
					var_440_44:EnableDynamicBone(true)
				end
			end

			local var_440_45 = arg_437_1.actors_["1054ui_story"]
			local var_440_46 = 0.965999998152256

			if var_440_46 < arg_437_1.time_ and arg_437_1.time_ <= var_440_46 + arg_440_0 and not isNil(var_440_45) and arg_437_1.var_.characterEffect1054ui_story == nil then
				arg_437_1.var_.characterEffect1054ui_story = var_440_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_47 = 0.034000001847744

			if var_440_46 <= arg_437_1.time_ and arg_437_1.time_ < var_440_46 + var_440_47 and not isNil(var_440_45) then
				local var_440_48 = (arg_437_1.time_ - var_440_46) / var_440_47

				if arg_437_1.var_.characterEffect1054ui_story and not isNil(var_440_45) then
					local var_440_49 = Mathf.Lerp(0, 0.5, var_440_48)

					arg_437_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1054ui_story.fillRatio = var_440_49
				end
			end

			if arg_437_1.time_ >= var_440_46 + var_440_47 and arg_437_1.time_ < var_440_46 + var_440_47 + arg_440_0 and not isNil(var_440_45) and arg_437_1.var_.characterEffect1054ui_story then
				local var_440_50 = 0.5

				arg_437_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1054ui_story.fillRatio = var_440_50
			end

			local var_440_51 = manager.ui.mainCamera.transform
			local var_440_52 = 0.965999998152256

			if var_440_52 < arg_437_1.time_ and arg_437_1.time_ <= var_440_52 + arg_440_0 then
				local var_440_53 = arg_437_1.var_.effectfangjianheian1
				local var_440_54
				local var_440_55 = var_440_51

				if not var_440_53 then
					var_440_53 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), var_440_55)
					var_440_53.name = "fangjianheian1"
					arg_437_1.var_.effectfangjianheian1 = var_440_53
				else
					var_440_53.transform:SetParent(var_440_55)
				end

				var_440_53.transform.localPosition = Vector3.New(0, 0, 0)
				var_440_53.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_440_56 = 0
			local var_440_57 = 0.3

			if var_440_56 < arg_437_1.time_ and arg_437_1.time_ <= var_440_56 + arg_440_0 then
				local var_440_58 = "play"
				local var_440_59 = "music"

				arg_437_1:AudioAction(var_440_58, var_440_59, "ui_battle", "ui_battle_stopbgm", "")

				local var_440_60 = ""
				local var_440_61 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_440_61 ~= "" then
					if arg_437_1.bgmTxt_.text ~= var_440_61 and arg_437_1.bgmTxt_.text ~= "" then
						if arg_437_1.bgmTxt2_.text ~= "" then
							arg_437_1.bgmTxt_.text = arg_437_1.bgmTxt2_.text
						end

						arg_437_1.bgmTxt2_.text = var_440_61

						arg_437_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_437_1.bgmTxt_.text = var_440_61
						arg_437_1.bgmTxt2_.text = var_440_61
					end

					if arg_437_1.bgmTimer then
						arg_437_1.bgmTimer:Stop()

						arg_437_1.bgmTimer = nil
					end

					if arg_437_1.settingData.show_music_name == 1 then
						arg_437_1.musicController:SetSelectedState("show")
						arg_437_1.musicAnimator_:Play("open", 0, 0)

						if arg_437_1.settingData.music_time ~= 0 then
							arg_437_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_437_1.settingData.music_time), function()
								if arg_437_1 == nil or isNil(arg_437_1.bgmTxt_) then
									return
								end

								arg_437_1.musicController:SetSelectedState("hide")
								arg_437_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_437_1.frameCnt_ <= 1 then
				arg_437_1.dialog_:SetActive(false)
			end

			local var_440_62 = 2
			local var_440_63 = 1.025

			if var_440_62 < arg_437_1.time_ and arg_437_1.time_ <= var_440_62 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0

				arg_437_1.dialog_:SetActive(true)

				arg_437_1.dialogCg_.alpha = 0

				local var_440_64 = LeanTween.value(arg_437_1.dialog_, 0, 1, 0.3)

				var_440_64:setOnUpdate(LuaHelper.FloatAction(function(arg_442_0)
					arg_437_1.dialogCg_.alpha = arg_442_0
				end))
				var_440_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_437_1.dialog_)
					var_440_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_437_1.duration_ = arg_437_1.duration_ + 0.3

				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_65 = arg_437_1:GetWordFromCfg(426051107)
				local var_440_66 = arg_437_1:FormatText(var_440_65.content)

				arg_437_1.text_.text = var_440_66

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_67 = 41
				local var_440_68 = utf8.len(var_440_66)
				local var_440_69 = var_440_67 <= 0 and var_440_63 or var_440_63 * (var_440_68 / var_440_67)

				if var_440_69 > 0 and var_440_63 < var_440_69 then
					arg_437_1.talkMaxDuration = var_440_69
					var_440_62 = var_440_62 + 0.3

					if var_440_69 + var_440_62 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_69 + var_440_62
					end
				end

				arg_437_1.text_.text = var_440_66
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_70 = var_440_62 + 0.3
			local var_440_71 = math.max(var_440_63, arg_437_1.talkMaxDuration)

			if var_440_70 <= arg_437_1.time_ and arg_437_1.time_ < var_440_70 + var_440_71 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_70) / var_440_71

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_70 + var_440_71 and arg_437_1.time_ < var_440_70 + var_440_71 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play426051108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 426051108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play426051109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 0.875

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, false)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_2 = arg_444_1:GetWordFromCfg(426051108)
				local var_447_3 = arg_444_1:FormatText(var_447_2.content)

				arg_444_1.text_.text = var_447_3

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_4 = 35
				local var_447_5 = utf8.len(var_447_3)
				local var_447_6 = var_447_4 <= 0 and var_447_1 or var_447_1 * (var_447_5 / var_447_4)

				if var_447_6 > 0 and var_447_1 < var_447_6 then
					arg_444_1.talkMaxDuration = var_447_6

					if var_447_6 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_6 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_3
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_7 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_7 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_7

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_7 and arg_444_1.time_ < var_447_0 + var_447_7 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play426051109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 426051109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play426051110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0
			local var_451_1 = 0.525

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_2 = arg_448_1:FormatText(StoryNameCfg[7].name)

				arg_448_1.leftNameTxt_.text = var_451_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_3 = arg_448_1:GetWordFromCfg(426051109)
				local var_451_4 = arg_448_1:FormatText(var_451_3.content)

				arg_448_1.text_.text = var_451_4

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 21
				local var_451_6 = utf8.len(var_451_4)
				local var_451_7 = var_451_5 <= 0 and var_451_1 or var_451_1 * (var_451_6 / var_451_5)

				if var_451_7 > 0 and var_451_1 < var_451_7 then
					arg_448_1.talkMaxDuration = var_451_7

					if var_451_7 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_7 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_4
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_8 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_8 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_8

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_8 and arg_448_1.time_ < var_451_0 + var_451_8 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play426051110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 426051110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play426051111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 0.35

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_2 = arg_452_1:FormatText(StoryNameCfg[7].name)

				arg_452_1.leftNameTxt_.text = var_455_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_3 = arg_452_1:GetWordFromCfg(426051110)
				local var_455_4 = arg_452_1:FormatText(var_455_3.content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 14
				local var_455_6 = utf8.len(var_455_4)
				local var_455_7 = var_455_5 <= 0 and var_455_1 or var_455_1 * (var_455_6 / var_455_5)

				if var_455_7 > 0 and var_455_1 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_0
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_8 = math.max(var_455_1, arg_452_1.talkMaxDuration)

			if var_455_0 <= arg_452_1.time_ and arg_452_1.time_ < var_455_0 + var_455_8 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_0) / var_455_8

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_0 + var_455_8 and arg_452_1.time_ < var_455_0 + var_455_8 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play426051111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 426051111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play426051112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0.633333333333333
			local var_459_1 = 1

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				local var_459_2 = "play"
				local var_459_3 = "effect"

				arg_456_1:AudioAction(var_459_2, var_459_3, "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_459_4 = 0
			local var_459_5 = 0.85

			if var_459_4 < arg_456_1.time_ and arg_456_1.time_ <= var_459_4 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_6 = arg_456_1:GetWordFromCfg(426051111)
				local var_459_7 = arg_456_1:FormatText(var_459_6.content)

				arg_456_1.text_.text = var_459_7

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_8 = 34
				local var_459_9 = utf8.len(var_459_7)
				local var_459_10 = var_459_8 <= 0 and var_459_5 or var_459_5 * (var_459_9 / var_459_8)

				if var_459_10 > 0 and var_459_5 < var_459_10 then
					arg_456_1.talkMaxDuration = var_459_10

					if var_459_10 + var_459_4 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_10 + var_459_4
					end
				end

				arg_456_1.text_.text = var_459_7
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_11 = math.max(var_459_5, arg_456_1.talkMaxDuration)

			if var_459_4 <= arg_456_1.time_ and arg_456_1.time_ < var_459_4 + var_459_11 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_4) / var_459_11

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_4 + var_459_11 and arg_456_1.time_ < var_459_4 + var_459_11 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play426051112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 426051112
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play426051113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0
			local var_463_1 = 0.75

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_2 = arg_460_1:FormatText(StoryNameCfg[7].name)

				arg_460_1.leftNameTxt_.text = var_463_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_3 = arg_460_1:GetWordFromCfg(426051112)
				local var_463_4 = arg_460_1:FormatText(var_463_3.content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 30
				local var_463_6 = utf8.len(var_463_4)
				local var_463_7 = var_463_5 <= 0 and var_463_1 or var_463_1 * (var_463_6 / var_463_5)

				if var_463_7 > 0 and var_463_1 < var_463_7 then
					arg_460_1.talkMaxDuration = var_463_7

					if var_463_7 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_7 + var_463_0
					end
				end

				arg_460_1.text_.text = var_463_4
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_8 = math.max(var_463_1, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_8 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_0) / var_463_8

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_8 and arg_460_1.time_ < var_463_0 + var_463_8 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play426051113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 426051113
		arg_464_1.duration_ = 3.93

		local var_464_0 = {
			zh = 2,
			ja = 3.933
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play426051114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = "1012ui_story"

			if arg_464_1.actors_[var_467_0] == nil then
				local var_467_1 = Asset.Load("Char/" .. "1012ui_story")

				if not isNil(var_467_1) then
					local var_467_2 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_464_1.stage_.transform)

					var_467_2.name = var_467_0
					var_467_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_464_1.actors_[var_467_0] = var_467_2

					local var_467_3 = var_467_2:GetComponentInChildren(typeof(CharacterEffect))

					var_467_3.enabled = true

					local var_467_4 = GameObjectTools.GetOrAddComponent(var_467_2, typeof(DynamicBoneHelper))

					if var_467_4 then
						var_467_4:EnableDynamicBone(false)
					end

					arg_464_1:ShowWeapon(var_467_3.transform, false)

					arg_464_1.var_[var_467_0 .. "Animator"] = var_467_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_464_1.var_[var_467_0 .. "Animator"].applyRootMotion = true
					arg_464_1.var_[var_467_0 .. "LipSync"] = var_467_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_467_5 = arg_464_1.actors_["1012ui_story"].transform
			local var_467_6 = 0

			if var_467_6 < arg_464_1.time_ and arg_464_1.time_ <= var_467_6 + arg_467_0 then
				arg_464_1.var_.moveOldPos1012ui_story = var_467_5.localPosition
			end

			local var_467_7 = 0.001

			if var_467_6 <= arg_464_1.time_ and arg_464_1.time_ < var_467_6 + var_467_7 then
				local var_467_8 = (arg_464_1.time_ - var_467_6) / var_467_7
				local var_467_9 = Vector3.New(0, -1.05, -6.24)

				var_467_5.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1012ui_story, var_467_9, var_467_8)

				local var_467_10 = manager.ui.mainCamera.transform.position - var_467_5.position

				var_467_5.forward = Vector3.New(var_467_10.x, var_467_10.y, var_467_10.z)

				local var_467_11 = var_467_5.localEulerAngles

				var_467_11.z = 0
				var_467_11.x = 0
				var_467_5.localEulerAngles = var_467_11
			end

			if arg_464_1.time_ >= var_467_6 + var_467_7 and arg_464_1.time_ < var_467_6 + var_467_7 + arg_467_0 then
				var_467_5.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_467_12 = manager.ui.mainCamera.transform.position - var_467_5.position

				var_467_5.forward = Vector3.New(var_467_12.x, var_467_12.y, var_467_12.z)

				local var_467_13 = var_467_5.localEulerAngles

				var_467_13.z = 0
				var_467_13.x = 0
				var_467_5.localEulerAngles = var_467_13
			end

			local var_467_14 = 0

			if var_467_14 < arg_464_1.time_ and arg_464_1.time_ <= var_467_14 + arg_467_0 then
				arg_464_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_467_15 = 0

			if var_467_15 < arg_464_1.time_ and arg_464_1.time_ <= var_467_15 + arg_467_0 then
				arg_464_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_467_16 = arg_464_1.actors_["1012ui_story"]
			local var_467_17 = 0

			if var_467_17 < arg_464_1.time_ and arg_464_1.time_ <= var_467_17 + arg_467_0 then
				if arg_464_1.var_.characterEffect1012ui_story == nil then
					arg_464_1.var_.characterEffect1012ui_story = var_467_16:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_467_18 = arg_464_1.var_.characterEffect1012ui_story

				var_467_18.imageEffect:turnOff()

				var_467_18.interferenceEffect.enabled = true
				var_467_18.interferenceEffect.noise = 0.001
				var_467_18.interferenceEffect.simTimeScale = 1
				var_467_18.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_467_19 = arg_464_1.actors_["1012ui_story"]
			local var_467_20 = 0
			local var_467_21 = 0.2

			if var_467_20 < arg_464_1.time_ and arg_464_1.time_ <= var_467_20 + arg_467_0 then
				if arg_464_1.var_.characterEffect1012ui_story == nil then
					arg_464_1.var_.characterEffect1012ui_story = var_467_19:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_464_1.var_.characterEffect1012ui_story.imageEffect:turnOn(false)
			end

			local var_467_22 = 0
			local var_467_23 = 0.25

			if var_467_22 < arg_464_1.time_ and arg_464_1.time_ <= var_467_22 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_24 = arg_464_1:FormatText(StoryNameCfg[595].name)

				arg_464_1.leftNameTxt_.text = var_467_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_25 = arg_464_1:GetWordFromCfg(426051113)
				local var_467_26 = arg_464_1:FormatText(var_467_25.content)

				arg_464_1.text_.text = var_467_26

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_27 = 10
				local var_467_28 = utf8.len(var_467_26)
				local var_467_29 = var_467_27 <= 0 and var_467_23 or var_467_23 * (var_467_28 / var_467_27)

				if var_467_29 > 0 and var_467_23 < var_467_29 then
					arg_464_1.talkMaxDuration = var_467_29

					if var_467_29 + var_467_22 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_29 + var_467_22
					end
				end

				arg_464_1.text_.text = var_467_26
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051113", "story_v_out_426051.awb") ~= 0 then
					local var_467_30 = manager.audio:GetVoiceLength("story_v_out_426051", "426051113", "story_v_out_426051.awb") / 1000

					if var_467_30 + var_467_22 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_30 + var_467_22
					end

					if var_467_25.prefab_name ~= "" and arg_464_1.actors_[var_467_25.prefab_name] ~= nil then
						local var_467_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_25.prefab_name].transform, "story_v_out_426051", "426051113", "story_v_out_426051.awb")

						arg_464_1:RecordAudio("426051113", var_467_31)
						arg_464_1:RecordAudio("426051113", var_467_31)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_426051", "426051113", "story_v_out_426051.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_426051", "426051113", "story_v_out_426051.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_32 = math.max(var_467_23, arg_464_1.talkMaxDuration)

			if var_467_22 <= arg_464_1.time_ and arg_464_1.time_ < var_467_22 + var_467_32 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_22) / var_467_32

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_22 + var_467_32 and arg_464_1.time_ < var_467_22 + var_467_32 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play426051114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 426051114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play426051115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1012ui_story"].transform
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 then
				arg_468_1.var_.moveOldPos1012ui_story = var_471_0.localPosition
			end

			local var_471_2 = 0.001

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2
				local var_471_4 = Vector3.New(0, 100, 0)

				var_471_0.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos1012ui_story, var_471_4, var_471_3)

				local var_471_5 = manager.ui.mainCamera.transform.position - var_471_0.position

				var_471_0.forward = Vector3.New(var_471_5.x, var_471_5.y, var_471_5.z)

				local var_471_6 = var_471_0.localEulerAngles

				var_471_6.z = 0
				var_471_6.x = 0
				var_471_0.localEulerAngles = var_471_6
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 then
				var_471_0.localPosition = Vector3.New(0, 100, 0)

				local var_471_7 = manager.ui.mainCamera.transform.position - var_471_0.position

				var_471_0.forward = Vector3.New(var_471_7.x, var_471_7.y, var_471_7.z)

				local var_471_8 = var_471_0.localEulerAngles

				var_471_8.z = 0
				var_471_8.x = 0
				var_471_0.localEulerAngles = var_471_8
			end

			local var_471_9 = arg_468_1.actors_["1012ui_story"]
			local var_471_10 = 0

			if var_471_10 < arg_468_1.time_ and arg_468_1.time_ <= var_471_10 + arg_471_0 and not isNil(var_471_9) and arg_468_1.var_.characterEffect1012ui_story == nil then
				arg_468_1.var_.characterEffect1012ui_story = var_471_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_11 = 0.200000002980232

			if var_471_10 <= arg_468_1.time_ and arg_468_1.time_ < var_471_10 + var_471_11 and not isNil(var_471_9) then
				local var_471_12 = (arg_468_1.time_ - var_471_10) / var_471_11

				if arg_468_1.var_.characterEffect1012ui_story and not isNil(var_471_9) then
					local var_471_13 = Mathf.Lerp(0, 0.5, var_471_12)

					arg_468_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1012ui_story.fillRatio = var_471_13
				end
			end

			if arg_468_1.time_ >= var_471_10 + var_471_11 and arg_468_1.time_ < var_471_10 + var_471_11 + arg_471_0 and not isNil(var_471_9) and arg_468_1.var_.characterEffect1012ui_story then
				local var_471_14 = 0.5

				arg_468_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1012ui_story.fillRatio = var_471_14
			end

			local var_471_15 = 0
			local var_471_16 = 0.9

			if var_471_15 < arg_468_1.time_ and arg_468_1.time_ <= var_471_15 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_17 = arg_468_1:GetWordFromCfg(426051114)
				local var_471_18 = arg_468_1:FormatText(var_471_17.content)

				arg_468_1.text_.text = var_471_18

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_19 = 36
				local var_471_20 = utf8.len(var_471_18)
				local var_471_21 = var_471_19 <= 0 and var_471_16 or var_471_16 * (var_471_20 / var_471_19)

				if var_471_21 > 0 and var_471_16 < var_471_21 then
					arg_468_1.talkMaxDuration = var_471_21

					if var_471_21 + var_471_15 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_21 + var_471_15
					end
				end

				arg_468_1.text_.text = var_471_18
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_22 = math.max(var_471_16, arg_468_1.talkMaxDuration)

			if var_471_15 <= arg_468_1.time_ and arg_468_1.time_ < var_471_15 + var_471_22 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_15) / var_471_22

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_15 + var_471_22 and arg_468_1.time_ < var_471_15 + var_471_22 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_468_1:InitPlayNodeList()
	end,
	Play426051115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 426051115
		arg_472_1.duration_ = 2

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play426051116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["1012ui_story"].transform
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.var_.moveOldPos1012ui_story = var_475_0.localPosition
			end

			local var_475_2 = 0.001

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2
				local var_475_4 = Vector3.New(0, -1.05, -6.24)

				var_475_0.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1012ui_story, var_475_4, var_475_3)

				local var_475_5 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_5.x, var_475_5.y, var_475_5.z)

				local var_475_6 = var_475_0.localEulerAngles

				var_475_6.z = 0
				var_475_6.x = 0
				var_475_0.localEulerAngles = var_475_6
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 then
				var_475_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_475_7 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_7.x, var_475_7.y, var_475_7.z)

				local var_475_8 = var_475_0.localEulerAngles

				var_475_8.z = 0
				var_475_8.x = 0
				var_475_0.localEulerAngles = var_475_8
			end

			local var_475_9 = 0

			if var_475_9 < arg_472_1.time_ and arg_472_1.time_ <= var_475_9 + arg_475_0 then
				arg_472_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_475_10 = 0
			local var_475_11 = 0.175

			if var_475_10 < arg_472_1.time_ and arg_472_1.time_ <= var_475_10 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_12 = arg_472_1:FormatText(StoryNameCfg[595].name)

				arg_472_1.leftNameTxt_.text = var_475_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_13 = arg_472_1:GetWordFromCfg(426051115)
				local var_475_14 = arg_472_1:FormatText(var_475_13.content)

				arg_472_1.text_.text = var_475_14

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_15 = 7
				local var_475_16 = utf8.len(var_475_14)
				local var_475_17 = var_475_15 <= 0 and var_475_11 or var_475_11 * (var_475_16 / var_475_15)

				if var_475_17 > 0 and var_475_11 < var_475_17 then
					arg_472_1.talkMaxDuration = var_475_17

					if var_475_17 + var_475_10 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_17 + var_475_10
					end
				end

				arg_472_1.text_.text = var_475_14
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051115", "story_v_out_426051.awb") ~= 0 then
					local var_475_18 = manager.audio:GetVoiceLength("story_v_out_426051", "426051115", "story_v_out_426051.awb") / 1000

					if var_475_18 + var_475_10 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_18 + var_475_10
					end

					if var_475_13.prefab_name ~= "" and arg_472_1.actors_[var_475_13.prefab_name] ~= nil then
						local var_475_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_13.prefab_name].transform, "story_v_out_426051", "426051115", "story_v_out_426051.awb")

						arg_472_1:RecordAudio("426051115", var_475_19)
						arg_472_1:RecordAudio("426051115", var_475_19)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_426051", "426051115", "story_v_out_426051.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_426051", "426051115", "story_v_out_426051.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_20 = math.max(var_475_11, arg_472_1.talkMaxDuration)

			if var_475_10 <= arg_472_1.time_ and arg_472_1.time_ < var_475_10 + var_475_20 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_10) / var_475_20

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_10 + var_475_20 and arg_472_1.time_ < var_475_10 + var_475_20 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play426051116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 426051116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play426051117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 0.475

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_2 = arg_476_1:FormatText(StoryNameCfg[7].name)

				arg_476_1.leftNameTxt_.text = var_479_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_3 = arg_476_1:GetWordFromCfg(426051116)
				local var_479_4 = arg_476_1:FormatText(var_479_3.content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 19
				local var_479_6 = utf8.len(var_479_4)
				local var_479_7 = var_479_5 <= 0 and var_479_1 or var_479_1 * (var_479_6 / var_479_5)

				if var_479_7 > 0 and var_479_1 < var_479_7 then
					arg_476_1.talkMaxDuration = var_479_7

					if var_479_7 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_7 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_4
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_8 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_8 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_8

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_8 and arg_476_1.time_ < var_479_0 + var_479_8 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play426051117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 426051117
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play426051118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["1012ui_story"].transform
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.var_.moveOldPos1012ui_story = var_483_0.localPosition
			end

			local var_483_2 = 0.001

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2
				local var_483_4 = Vector3.New(0, 100, 0)

				var_483_0.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1012ui_story, var_483_4, var_483_3)

				local var_483_5 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_5.x, var_483_5.y, var_483_5.z)

				local var_483_6 = var_483_0.localEulerAngles

				var_483_6.z = 0
				var_483_6.x = 0
				var_483_0.localEulerAngles = var_483_6
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 then
				var_483_0.localPosition = Vector3.New(0, 100, 0)

				local var_483_7 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_7.x, var_483_7.y, var_483_7.z)

				local var_483_8 = var_483_0.localEulerAngles

				var_483_8.z = 0
				var_483_8.x = 0
				var_483_0.localEulerAngles = var_483_8
			end

			local var_483_9 = 0
			local var_483_10 = 1

			if var_483_9 < arg_480_1.time_ and arg_480_1.time_ <= var_483_9 + arg_483_0 then
				local var_483_11 = "play"
				local var_483_12 = "effect"

				arg_480_1:AudioAction(var_483_11, var_483_12, "se_story_147", "se_story_147_light_button_off", "")
			end

			local var_483_13 = manager.ui.mainCamera.transform
			local var_483_14 = 0

			if var_483_14 < arg_480_1.time_ and arg_480_1.time_ <= var_483_14 + arg_483_0 then
				local var_483_15 = arg_480_1.var_.effectkaideng1
				local var_483_16
				local var_483_17 = var_483_13

				if not var_483_15 then
					var_483_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng02_in_keep"), var_483_17)
					var_483_15.name = "kaideng1"
					arg_480_1.var_.effectkaideng1 = var_483_15
				else
					var_483_15.transform:SetParent(var_483_17)
				end

				var_483_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_483_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_483_18 = 0
			local var_483_19 = 0.525

			if var_483_18 < arg_480_1.time_ and arg_480_1.time_ <= var_483_18 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_20 = arg_480_1:GetWordFromCfg(426051117)
				local var_483_21 = arg_480_1:FormatText(var_483_20.content)

				arg_480_1.text_.text = var_483_21

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_22 = 21
				local var_483_23 = utf8.len(var_483_21)
				local var_483_24 = var_483_22 <= 0 and var_483_19 or var_483_19 * (var_483_23 / var_483_22)

				if var_483_24 > 0 and var_483_19 < var_483_24 then
					arg_480_1.talkMaxDuration = var_483_24

					if var_483_24 + var_483_18 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_24 + var_483_18
					end
				end

				arg_480_1.text_.text = var_483_21
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_25 = math.max(var_483_19, arg_480_1.talkMaxDuration)

			if var_483_18 <= arg_480_1.time_ and arg_480_1.time_ < var_483_18 + var_483_25 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_18) / var_483_25

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_18 + var_483_25 and arg_480_1.time_ < var_483_18 + var_483_25 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play426051118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 426051118
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play426051119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 0.475

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_2 = arg_484_1:FormatText(StoryNameCfg[7].name)

				arg_484_1.leftNameTxt_.text = var_487_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_3 = arg_484_1:GetWordFromCfg(426051118)
				local var_487_4 = arg_484_1:FormatText(var_487_3.content)

				arg_484_1.text_.text = var_487_4

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 19
				local var_487_6 = utf8.len(var_487_4)
				local var_487_7 = var_487_5 <= 0 and var_487_1 or var_487_1 * (var_487_6 / var_487_5)

				if var_487_7 > 0 and var_487_1 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_4
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_8 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_8 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_8

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_8 and arg_484_1.time_ < var_487_0 + var_487_8 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play426051119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 426051119
		arg_488_1.duration_ = 7.77

		local var_488_0 = {
			zh = 7.766,
			ja = 7.1
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play426051120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1012ui_story"].transform
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.var_.moveOldPos1012ui_story = var_491_0.localPosition
			end

			local var_491_2 = 0.001

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2
				local var_491_4 = Vector3.New(0, -1.05, -6.24)

				var_491_0.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1012ui_story, var_491_4, var_491_3)

				local var_491_5 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_5.x, var_491_5.y, var_491_5.z)

				local var_491_6 = var_491_0.localEulerAngles

				var_491_6.z = 0
				var_491_6.x = 0
				var_491_0.localEulerAngles = var_491_6
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 then
				var_491_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_491_7 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_7.x, var_491_7.y, var_491_7.z)

				local var_491_8 = var_491_0.localEulerAngles

				var_491_8.z = 0
				var_491_8.x = 0
				var_491_0.localEulerAngles = var_491_8
			end

			local var_491_9 = 0

			if var_491_9 < arg_488_1.time_ and arg_488_1.time_ <= var_491_9 + arg_491_0 then
				arg_488_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			local var_491_10 = 0

			if var_491_10 < arg_488_1.time_ and arg_488_1.time_ <= var_491_10 + arg_491_0 then
				arg_488_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_491_11 = 0
			local var_491_12 = 1

			if var_491_11 < arg_488_1.time_ and arg_488_1.time_ <= var_491_11 + arg_491_0 then
				local var_491_13 = "play"
				local var_491_14 = "music"

				arg_488_1:AudioAction(var_491_13, var_491_14, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_491_15 = ""
				local var_491_16 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if var_491_16 ~= "" then
					if arg_488_1.bgmTxt_.text ~= var_491_16 and arg_488_1.bgmTxt_.text ~= "" then
						if arg_488_1.bgmTxt2_.text ~= "" then
							arg_488_1.bgmTxt_.text = arg_488_1.bgmTxt2_.text
						end

						arg_488_1.bgmTxt2_.text = var_491_16

						arg_488_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_488_1.bgmTxt_.text = var_491_16
						arg_488_1.bgmTxt2_.text = var_491_16
					end

					if arg_488_1.bgmTimer then
						arg_488_1.bgmTimer:Stop()

						arg_488_1.bgmTimer = nil
					end

					if arg_488_1.settingData.show_music_name == 1 then
						arg_488_1.musicController:SetSelectedState("show")
						arg_488_1.musicAnimator_:Play("open", 0, 0)

						if arg_488_1.settingData.music_time ~= 0 then
							arg_488_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_488_1.settingData.music_time), function()
								if arg_488_1 == nil or isNil(arg_488_1.bgmTxt_) then
									return
								end

								arg_488_1.musicController:SetSelectedState("hide")
								arg_488_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_491_17 = 0
			local var_491_18 = 0.875

			if var_491_17 < arg_488_1.time_ and arg_488_1.time_ <= var_491_17 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_19 = arg_488_1:FormatText(StoryNameCfg[595].name)

				arg_488_1.leftNameTxt_.text = var_491_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_20 = arg_488_1:GetWordFromCfg(426051119)
				local var_491_21 = arg_488_1:FormatText(var_491_20.content)

				arg_488_1.text_.text = var_491_21

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_22 = 35
				local var_491_23 = utf8.len(var_491_21)
				local var_491_24 = var_491_22 <= 0 and var_491_18 or var_491_18 * (var_491_23 / var_491_22)

				if var_491_24 > 0 and var_491_18 < var_491_24 then
					arg_488_1.talkMaxDuration = var_491_24

					if var_491_24 + var_491_17 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_24 + var_491_17
					end
				end

				arg_488_1.text_.text = var_491_21
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051119", "story_v_out_426051.awb") ~= 0 then
					local var_491_25 = manager.audio:GetVoiceLength("story_v_out_426051", "426051119", "story_v_out_426051.awb") / 1000

					if var_491_25 + var_491_17 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_25 + var_491_17
					end

					if var_491_20.prefab_name ~= "" and arg_488_1.actors_[var_491_20.prefab_name] ~= nil then
						local var_491_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_20.prefab_name].transform, "story_v_out_426051", "426051119", "story_v_out_426051.awb")

						arg_488_1:RecordAudio("426051119", var_491_26)
						arg_488_1:RecordAudio("426051119", var_491_26)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_426051", "426051119", "story_v_out_426051.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_426051", "426051119", "story_v_out_426051.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_27 = math.max(var_491_18, arg_488_1.talkMaxDuration)

			if var_491_17 <= arg_488_1.time_ and arg_488_1.time_ < var_491_17 + var_491_27 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_17) / var_491_27

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_17 + var_491_27 and arg_488_1.time_ < var_491_17 + var_491_27 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play426051120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 426051120
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play426051121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 0.475

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_2 = arg_493_1:FormatText(StoryNameCfg[7].name)

				arg_493_1.leftNameTxt_.text = var_496_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_3 = arg_493_1:GetWordFromCfg(426051120)
				local var_496_4 = arg_493_1:FormatText(var_496_3.content)

				arg_493_1.text_.text = var_496_4

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_5 = 19
				local var_496_6 = utf8.len(var_496_4)
				local var_496_7 = var_496_5 <= 0 and var_496_1 or var_496_1 * (var_496_6 / var_496_5)

				if var_496_7 > 0 and var_496_1 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_0
					end
				end

				arg_493_1.text_.text = var_496_4
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_8 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_8 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_8

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_8 and arg_493_1.time_ < var_496_0 + var_496_8 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play426051121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 426051121
		arg_497_1.duration_ = 2.7

		local var_497_0 = {
			zh = 2.7,
			ja = 2.633
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play426051122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["1012ui_story"].transform
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.var_.moveOldPos1012ui_story = var_500_0.localPosition
			end

			local var_500_2 = 0.001

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2
				local var_500_4 = Vector3.New(0, -1.05, -6.24)

				var_500_0.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1012ui_story, var_500_4, var_500_3)

				local var_500_5 = manager.ui.mainCamera.transform.position - var_500_0.position

				var_500_0.forward = Vector3.New(var_500_5.x, var_500_5.y, var_500_5.z)

				local var_500_6 = var_500_0.localEulerAngles

				var_500_6.z = 0
				var_500_6.x = 0
				var_500_0.localEulerAngles = var_500_6
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 then
				var_500_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_500_7 = manager.ui.mainCamera.transform.position - var_500_0.position

				var_500_0.forward = Vector3.New(var_500_7.x, var_500_7.y, var_500_7.z)

				local var_500_8 = var_500_0.localEulerAngles

				var_500_8.z = 0
				var_500_8.x = 0
				var_500_0.localEulerAngles = var_500_8
			end

			local var_500_9 = 0

			if var_500_9 < arg_497_1.time_ and arg_497_1.time_ <= var_500_9 + arg_500_0 then
				arg_497_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_1")
			end

			local var_500_10 = 0

			if var_500_10 < arg_497_1.time_ and arg_497_1.time_ <= var_500_10 + arg_500_0 then
				arg_497_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_500_11 = 0
			local var_500_12 = 0.275

			if var_500_11 < arg_497_1.time_ and arg_497_1.time_ <= var_500_11 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_13 = arg_497_1:FormatText(StoryNameCfg[595].name)

				arg_497_1.leftNameTxt_.text = var_500_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_14 = arg_497_1:GetWordFromCfg(426051121)
				local var_500_15 = arg_497_1:FormatText(var_500_14.content)

				arg_497_1.text_.text = var_500_15

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_16 = 11
				local var_500_17 = utf8.len(var_500_15)
				local var_500_18 = var_500_16 <= 0 and var_500_12 or var_500_12 * (var_500_17 / var_500_16)

				if var_500_18 > 0 and var_500_12 < var_500_18 then
					arg_497_1.talkMaxDuration = var_500_18

					if var_500_18 + var_500_11 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_18 + var_500_11
					end
				end

				arg_497_1.text_.text = var_500_15
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051121", "story_v_out_426051.awb") ~= 0 then
					local var_500_19 = manager.audio:GetVoiceLength("story_v_out_426051", "426051121", "story_v_out_426051.awb") / 1000

					if var_500_19 + var_500_11 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_19 + var_500_11
					end

					if var_500_14.prefab_name ~= "" and arg_497_1.actors_[var_500_14.prefab_name] ~= nil then
						local var_500_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_14.prefab_name].transform, "story_v_out_426051", "426051121", "story_v_out_426051.awb")

						arg_497_1:RecordAudio("426051121", var_500_20)
						arg_497_1:RecordAudio("426051121", var_500_20)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_426051", "426051121", "story_v_out_426051.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_426051", "426051121", "story_v_out_426051.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_21 = math.max(var_500_12, arg_497_1.talkMaxDuration)

			if var_500_11 <= arg_497_1.time_ and arg_497_1.time_ < var_500_11 + var_500_21 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_11) / var_500_21

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_11 + var_500_21 and arg_497_1.time_ < var_500_11 + var_500_21 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play426051122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 426051122
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play426051123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0
			local var_504_1 = 0.725

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_2 = arg_501_1:FormatText(StoryNameCfg[7].name)

				arg_501_1.leftNameTxt_.text = var_504_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_3 = arg_501_1:GetWordFromCfg(426051122)
				local var_504_4 = arg_501_1:FormatText(var_504_3.content)

				arg_501_1.text_.text = var_504_4

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 29
				local var_504_6 = utf8.len(var_504_4)
				local var_504_7 = var_504_5 <= 0 and var_504_1 or var_504_1 * (var_504_6 / var_504_5)

				if var_504_7 > 0 and var_504_1 < var_504_7 then
					arg_501_1.talkMaxDuration = var_504_7

					if var_504_7 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_7 + var_504_0
					end
				end

				arg_501_1.text_.text = var_504_4
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_8 = math.max(var_504_1, arg_501_1.talkMaxDuration)

			if var_504_0 <= arg_501_1.time_ and arg_501_1.time_ < var_504_0 + var_504_8 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_0) / var_504_8

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_0 + var_504_8 and arg_501_1.time_ < var_504_0 + var_504_8 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play426051123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 426051123
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play426051124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0
			local var_508_1 = 0.95

			if var_508_0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_2 = arg_505_1:FormatText(StoryNameCfg[7].name)

				arg_505_1.leftNameTxt_.text = var_508_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_3 = arg_505_1:GetWordFromCfg(426051123)
				local var_508_4 = arg_505_1:FormatText(var_508_3.content)

				arg_505_1.text_.text = var_508_4

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_5 = 38
				local var_508_6 = utf8.len(var_508_4)
				local var_508_7 = var_508_5 <= 0 and var_508_1 or var_508_1 * (var_508_6 / var_508_5)

				if var_508_7 > 0 and var_508_1 < var_508_7 then
					arg_505_1.talkMaxDuration = var_508_7

					if var_508_7 + var_508_0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_7 + var_508_0
					end
				end

				arg_505_1.text_.text = var_508_4
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_8 = math.max(var_508_1, arg_505_1.talkMaxDuration)

			if var_508_0 <= arg_505_1.time_ and arg_505_1.time_ < var_508_0 + var_508_8 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_0) / var_508_8

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_0 + var_508_8 and arg_505_1.time_ < var_508_0 + var_508_8 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play426051124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 426051124
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play426051125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["1012ui_story"].transform
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.var_.moveOldPos1012ui_story = var_512_0.localPosition
			end

			local var_512_2 = 0.001

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2
				local var_512_4 = Vector3.New(0, 100, 0)

				var_512_0.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1012ui_story, var_512_4, var_512_3)

				local var_512_5 = manager.ui.mainCamera.transform.position - var_512_0.position

				var_512_0.forward = Vector3.New(var_512_5.x, var_512_5.y, var_512_5.z)

				local var_512_6 = var_512_0.localEulerAngles

				var_512_6.z = 0
				var_512_6.x = 0
				var_512_0.localEulerAngles = var_512_6
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 then
				var_512_0.localPosition = Vector3.New(0, 100, 0)

				local var_512_7 = manager.ui.mainCamera.transform.position - var_512_0.position

				var_512_0.forward = Vector3.New(var_512_7.x, var_512_7.y, var_512_7.z)

				local var_512_8 = var_512_0.localEulerAngles

				var_512_8.z = 0
				var_512_8.x = 0
				var_512_0.localEulerAngles = var_512_8
			end

			local var_512_9 = 0
			local var_512_10 = 0.575

			if var_512_9 < arg_509_1.time_ and arg_509_1.time_ <= var_512_9 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_11 = arg_509_1:GetWordFromCfg(426051124)
				local var_512_12 = arg_509_1:FormatText(var_512_11.content)

				arg_509_1.text_.text = var_512_12

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_13 = 23
				local var_512_14 = utf8.len(var_512_12)
				local var_512_15 = var_512_13 <= 0 and var_512_10 or var_512_10 * (var_512_14 / var_512_13)

				if var_512_15 > 0 and var_512_10 < var_512_15 then
					arg_509_1.talkMaxDuration = var_512_15

					if var_512_15 + var_512_9 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_15 + var_512_9
					end
				end

				arg_509_1.text_.text = var_512_12
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_16 = math.max(var_512_10, arg_509_1.talkMaxDuration)

			if var_512_9 <= arg_509_1.time_ and arg_509_1.time_ < var_512_9 + var_512_16 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_9) / var_512_16

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_9 + var_512_16 and arg_509_1.time_ < var_512_9 + var_512_16 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_509_1:InitPlayNodeList()
	end,
	Play426051125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 426051125
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play426051126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.575

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_2 = arg_513_1:FormatText(StoryNameCfg[7].name)

				arg_513_1.leftNameTxt_.text = var_516_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_3 = arg_513_1:GetWordFromCfg(426051125)
				local var_516_4 = arg_513_1:FormatText(var_516_3.content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 23
				local var_516_6 = utf8.len(var_516_4)
				local var_516_7 = var_516_5 <= 0 and var_516_1 or var_516_1 * (var_516_6 / var_516_5)

				if var_516_7 > 0 and var_516_1 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_4
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_8 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_8 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_8

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_8 and arg_513_1.time_ < var_516_0 + var_516_8 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play426051126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 426051126
		arg_517_1.duration_ = 9.03

		local var_517_0 = {
			zh = 7.4,
			ja = 9.033
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play426051127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = arg_517_1.actors_["1012ui_story"].transform
			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1.var_.moveOldPos1012ui_story = var_520_0.localPosition
			end

			local var_520_2 = 0.001

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_2 then
				local var_520_3 = (arg_517_1.time_ - var_520_1) / var_520_2
				local var_520_4 = Vector3.New(0, -1.05, -6.24)

				var_520_0.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1012ui_story, var_520_4, var_520_3)

				local var_520_5 = manager.ui.mainCamera.transform.position - var_520_0.position

				var_520_0.forward = Vector3.New(var_520_5.x, var_520_5.y, var_520_5.z)

				local var_520_6 = var_520_0.localEulerAngles

				var_520_6.z = 0
				var_520_6.x = 0
				var_520_0.localEulerAngles = var_520_6
			end

			if arg_517_1.time_ >= var_520_1 + var_520_2 and arg_517_1.time_ < var_520_1 + var_520_2 + arg_520_0 then
				var_520_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_520_7 = manager.ui.mainCamera.transform.position - var_520_0.position

				var_520_0.forward = Vector3.New(var_520_7.x, var_520_7.y, var_520_7.z)

				local var_520_8 = var_520_0.localEulerAngles

				var_520_8.z = 0
				var_520_8.x = 0
				var_520_0.localEulerAngles = var_520_8
			end

			local var_520_9 = 0

			if var_520_9 < arg_517_1.time_ and arg_517_1.time_ <= var_520_9 + arg_520_0 then
				arg_517_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_2")
			end

			local var_520_10 = 0

			if var_520_10 < arg_517_1.time_ and arg_517_1.time_ <= var_520_10 + arg_520_0 then
				arg_517_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_520_11 = 0
			local var_520_12 = 0.95

			if var_520_11 < arg_517_1.time_ and arg_517_1.time_ <= var_520_11 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_13 = arg_517_1:FormatText(StoryNameCfg[595].name)

				arg_517_1.leftNameTxt_.text = var_520_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_14 = arg_517_1:GetWordFromCfg(426051126)
				local var_520_15 = arg_517_1:FormatText(var_520_14.content)

				arg_517_1.text_.text = var_520_15

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_16 = 38
				local var_520_17 = utf8.len(var_520_15)
				local var_520_18 = var_520_16 <= 0 and var_520_12 or var_520_12 * (var_520_17 / var_520_16)

				if var_520_18 > 0 and var_520_12 < var_520_18 then
					arg_517_1.talkMaxDuration = var_520_18

					if var_520_18 + var_520_11 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_18 + var_520_11
					end
				end

				arg_517_1.text_.text = var_520_15
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051126", "story_v_out_426051.awb") ~= 0 then
					local var_520_19 = manager.audio:GetVoiceLength("story_v_out_426051", "426051126", "story_v_out_426051.awb") / 1000

					if var_520_19 + var_520_11 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_19 + var_520_11
					end

					if var_520_14.prefab_name ~= "" and arg_517_1.actors_[var_520_14.prefab_name] ~= nil then
						local var_520_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_14.prefab_name].transform, "story_v_out_426051", "426051126", "story_v_out_426051.awb")

						arg_517_1:RecordAudio("426051126", var_520_20)
						arg_517_1:RecordAudio("426051126", var_520_20)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_426051", "426051126", "story_v_out_426051.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_426051", "426051126", "story_v_out_426051.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_21 = math.max(var_520_12, arg_517_1.talkMaxDuration)

			if var_520_11 <= arg_517_1.time_ and arg_517_1.time_ < var_520_11 + var_520_21 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_11) / var_520_21

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_11 + var_520_21 and arg_517_1.time_ < var_520_11 + var_520_21 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play426051127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 426051127
		arg_521_1.duration_ = 4.53

		local var_521_0 = {
			zh = 3.533,
			ja = 4.533
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play426051128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.5

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_2 = arg_521_1:FormatText(StoryNameCfg[595].name)

				arg_521_1.leftNameTxt_.text = var_524_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_3 = arg_521_1:GetWordFromCfg(426051127)
				local var_524_4 = arg_521_1:FormatText(var_524_3.content)

				arg_521_1.text_.text = var_524_4

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 20
				local var_524_6 = utf8.len(var_524_4)
				local var_524_7 = var_524_5 <= 0 and var_524_1 or var_524_1 * (var_524_6 / var_524_5)

				if var_524_7 > 0 and var_524_1 < var_524_7 then
					arg_521_1.talkMaxDuration = var_524_7

					if var_524_7 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_7 + var_524_0
					end
				end

				arg_521_1.text_.text = var_524_4
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051127", "story_v_out_426051.awb") ~= 0 then
					local var_524_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051127", "story_v_out_426051.awb") / 1000

					if var_524_8 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_8 + var_524_0
					end

					if var_524_3.prefab_name ~= "" and arg_521_1.actors_[var_524_3.prefab_name] ~= nil then
						local var_524_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_3.prefab_name].transform, "story_v_out_426051", "426051127", "story_v_out_426051.awb")

						arg_521_1:RecordAudio("426051127", var_524_9)
						arg_521_1:RecordAudio("426051127", var_524_9)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_426051", "426051127", "story_v_out_426051.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_426051", "426051127", "story_v_out_426051.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_10 = math.max(var_524_1, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_10 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_0) / var_524_10

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_10 and arg_521_1.time_ < var_524_0 + var_524_10 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play426051128 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 426051128
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play426051129(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0
			local var_528_1 = 0.4

			if var_528_0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_2 = arg_525_1:FormatText(StoryNameCfg[7].name)

				arg_525_1.leftNameTxt_.text = var_528_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_3 = arg_525_1:GetWordFromCfg(426051128)
				local var_528_4 = arg_525_1:FormatText(var_528_3.content)

				arg_525_1.text_.text = var_528_4

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_5 = 16
				local var_528_6 = utf8.len(var_528_4)
				local var_528_7 = var_528_5 <= 0 and var_528_1 or var_528_1 * (var_528_6 / var_528_5)

				if var_528_7 > 0 and var_528_1 < var_528_7 then
					arg_525_1.talkMaxDuration = var_528_7

					if var_528_7 + var_528_0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_7 + var_528_0
					end
				end

				arg_525_1.text_.text = var_528_4
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_8 = math.max(var_528_1, arg_525_1.talkMaxDuration)

			if var_528_0 <= arg_525_1.time_ and arg_525_1.time_ < var_528_0 + var_528_8 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_0) / var_528_8

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_0 + var_528_8 and arg_525_1.time_ < var_528_0 + var_528_8 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play426051129 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 426051129
		arg_529_1.duration_ = 7.8

		local var_529_0 = {
			zh = 4.6,
			ja = 7.8
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play426051130(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0

			if var_532_0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_532_2 = 0
			local var_532_3 = 0.475

			if var_532_2 < arg_529_1.time_ and arg_529_1.time_ <= var_532_2 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_4 = arg_529_1:FormatText(StoryNameCfg[595].name)

				arg_529_1.leftNameTxt_.text = var_532_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_5 = arg_529_1:GetWordFromCfg(426051129)
				local var_532_6 = arg_529_1:FormatText(var_532_5.content)

				arg_529_1.text_.text = var_532_6

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_7 = 19
				local var_532_8 = utf8.len(var_532_6)
				local var_532_9 = var_532_7 <= 0 and var_532_3 or var_532_3 * (var_532_8 / var_532_7)

				if var_532_9 > 0 and var_532_3 < var_532_9 then
					arg_529_1.talkMaxDuration = var_532_9

					if var_532_9 + var_532_2 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_9 + var_532_2
					end
				end

				arg_529_1.text_.text = var_532_6
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051129", "story_v_out_426051.awb") ~= 0 then
					local var_532_10 = manager.audio:GetVoiceLength("story_v_out_426051", "426051129", "story_v_out_426051.awb") / 1000

					if var_532_10 + var_532_2 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_10 + var_532_2
					end

					if var_532_5.prefab_name ~= "" and arg_529_1.actors_[var_532_5.prefab_name] ~= nil then
						local var_532_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_5.prefab_name].transform, "story_v_out_426051", "426051129", "story_v_out_426051.awb")

						arg_529_1:RecordAudio("426051129", var_532_11)
						arg_529_1:RecordAudio("426051129", var_532_11)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_426051", "426051129", "story_v_out_426051.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_426051", "426051129", "story_v_out_426051.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_12 = math.max(var_532_3, arg_529_1.talkMaxDuration)

			if var_532_2 <= arg_529_1.time_ and arg_529_1.time_ < var_532_2 + var_532_12 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_2) / var_532_12

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_2 + var_532_12 and arg_529_1.time_ < var_532_2 + var_532_12 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play426051130 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 426051130
		arg_533_1.duration_ = 6.53

		local var_533_0 = {
			zh = 6.533,
			ja = 5.666
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play426051131(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0
			local var_536_1 = 0.875

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_2 = arg_533_1:FormatText(StoryNameCfg[595].name)

				arg_533_1.leftNameTxt_.text = var_536_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_3 = arg_533_1:GetWordFromCfg(426051130)
				local var_536_4 = arg_533_1:FormatText(var_536_3.content)

				arg_533_1.text_.text = var_536_4

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 35
				local var_536_6 = utf8.len(var_536_4)
				local var_536_7 = var_536_5 <= 0 and var_536_1 or var_536_1 * (var_536_6 / var_536_5)

				if var_536_7 > 0 and var_536_1 < var_536_7 then
					arg_533_1.talkMaxDuration = var_536_7

					if var_536_7 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_7 + var_536_0
					end
				end

				arg_533_1.text_.text = var_536_4
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051130", "story_v_out_426051.awb") ~= 0 then
					local var_536_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051130", "story_v_out_426051.awb") / 1000

					if var_536_8 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_8 + var_536_0
					end

					if var_536_3.prefab_name ~= "" and arg_533_1.actors_[var_536_3.prefab_name] ~= nil then
						local var_536_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_3.prefab_name].transform, "story_v_out_426051", "426051130", "story_v_out_426051.awb")

						arg_533_1:RecordAudio("426051130", var_536_9)
						arg_533_1:RecordAudio("426051130", var_536_9)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_426051", "426051130", "story_v_out_426051.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_426051", "426051130", "story_v_out_426051.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_10 = math.max(var_536_1, arg_533_1.talkMaxDuration)

			if var_536_0 <= arg_533_1.time_ and arg_533_1.time_ < var_536_0 + var_536_10 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_0) / var_536_10

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_0 + var_536_10 and arg_533_1.time_ < var_536_0 + var_536_10 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play426051131 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 426051131
		arg_537_1.duration_ = 11.63

		local var_537_0 = {
			zh = 11.633,
			ja = 6.7
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play426051132(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_540_2 = 0
			local var_540_3 = 1.45

			if var_540_2 < arg_537_1.time_ and arg_537_1.time_ <= var_540_2 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_4 = arg_537_1:FormatText(StoryNameCfg[595].name)

				arg_537_1.leftNameTxt_.text = var_540_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_5 = arg_537_1:GetWordFromCfg(426051131)
				local var_540_6 = arg_537_1:FormatText(var_540_5.content)

				arg_537_1.text_.text = var_540_6

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_7 = 58
				local var_540_8 = utf8.len(var_540_6)
				local var_540_9 = var_540_7 <= 0 and var_540_3 or var_540_3 * (var_540_8 / var_540_7)

				if var_540_9 > 0 and var_540_3 < var_540_9 then
					arg_537_1.talkMaxDuration = var_540_9

					if var_540_9 + var_540_2 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_9 + var_540_2
					end
				end

				arg_537_1.text_.text = var_540_6
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051131", "story_v_out_426051.awb") ~= 0 then
					local var_540_10 = manager.audio:GetVoiceLength("story_v_out_426051", "426051131", "story_v_out_426051.awb") / 1000

					if var_540_10 + var_540_2 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_10 + var_540_2
					end

					if var_540_5.prefab_name ~= "" and arg_537_1.actors_[var_540_5.prefab_name] ~= nil then
						local var_540_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_5.prefab_name].transform, "story_v_out_426051", "426051131", "story_v_out_426051.awb")

						arg_537_1:RecordAudio("426051131", var_540_11)
						arg_537_1:RecordAudio("426051131", var_540_11)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_426051", "426051131", "story_v_out_426051.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_426051", "426051131", "story_v_out_426051.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_12 = math.max(var_540_3, arg_537_1.talkMaxDuration)

			if var_540_2 <= arg_537_1.time_ and arg_537_1.time_ < var_540_2 + var_540_12 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_2) / var_540_12

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_2 + var_540_12 and arg_537_1.time_ < var_540_2 + var_540_12 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play426051132 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 426051132
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play426051133(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 0.575

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_2 = arg_541_1:FormatText(StoryNameCfg[7].name)

				arg_541_1.leftNameTxt_.text = var_544_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_3 = arg_541_1:GetWordFromCfg(426051132)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 23
				local var_544_6 = utf8.len(var_544_4)
				local var_544_7 = var_544_5 <= 0 and var_544_1 or var_544_1 * (var_544_6 / var_544_5)

				if var_544_7 > 0 and var_544_1 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_8 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_8 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_8

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_8 and arg_541_1.time_ < var_544_0 + var_544_8 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play426051133 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 426051133
		arg_545_1.duration_ = 9.9

		local var_545_0 = {
			zh = 7.6,
			ja = 9.9
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play426051134(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			local var_548_1 = 0
			local var_548_2 = 0.875

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_3 = arg_545_1:FormatText(StoryNameCfg[595].name)

				arg_545_1.leftNameTxt_.text = var_548_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_4 = arg_545_1:GetWordFromCfg(426051133)
				local var_548_5 = arg_545_1:FormatText(var_548_4.content)

				arg_545_1.text_.text = var_548_5

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_6 = 35
				local var_548_7 = utf8.len(var_548_5)
				local var_548_8 = var_548_6 <= 0 and var_548_2 or var_548_2 * (var_548_7 / var_548_6)

				if var_548_8 > 0 and var_548_2 < var_548_8 then
					arg_545_1.talkMaxDuration = var_548_8

					if var_548_8 + var_548_1 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_8 + var_548_1
					end
				end

				arg_545_1.text_.text = var_548_5
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051133", "story_v_out_426051.awb") ~= 0 then
					local var_548_9 = manager.audio:GetVoiceLength("story_v_out_426051", "426051133", "story_v_out_426051.awb") / 1000

					if var_548_9 + var_548_1 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_9 + var_548_1
					end

					if var_548_4.prefab_name ~= "" and arg_545_1.actors_[var_548_4.prefab_name] ~= nil then
						local var_548_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_4.prefab_name].transform, "story_v_out_426051", "426051133", "story_v_out_426051.awb")

						arg_545_1:RecordAudio("426051133", var_548_10)
						arg_545_1:RecordAudio("426051133", var_548_10)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_426051", "426051133", "story_v_out_426051.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_426051", "426051133", "story_v_out_426051.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_11 = math.max(var_548_2, arg_545_1.talkMaxDuration)

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_11 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_1) / var_548_11

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_1 + var_548_11 and arg_545_1.time_ < var_548_1 + var_548_11 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play426051134 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 426051134
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play426051135(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.125

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_2 = arg_549_1:FormatText(StoryNameCfg[7].name)

				arg_549_1.leftNameTxt_.text = var_552_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_3 = arg_549_1:GetWordFromCfg(426051134)
				local var_552_4 = arg_549_1:FormatText(var_552_3.content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 5
				local var_552_6 = utf8.len(var_552_4)
				local var_552_7 = var_552_5 <= 0 and var_552_1 or var_552_1 * (var_552_6 / var_552_5)

				if var_552_7 > 0 and var_552_1 < var_552_7 then
					arg_549_1.talkMaxDuration = var_552_7

					if var_552_7 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_7 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_4
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_8 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_8 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_8

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_8 and arg_549_1.time_ < var_552_0 + var_552_8 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play426051135 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 426051135
		arg_553_1.duration_ = 9.93

		local var_553_0 = {
			zh = 6.933,
			ja = 9.933
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play426051136(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 then
				arg_553_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_556_2 = 0
			local var_556_3 = 0.925

			if var_556_2 < arg_553_1.time_ and arg_553_1.time_ <= var_556_2 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_4 = arg_553_1:FormatText(StoryNameCfg[595].name)

				arg_553_1.leftNameTxt_.text = var_556_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_5 = arg_553_1:GetWordFromCfg(426051135)
				local var_556_6 = arg_553_1:FormatText(var_556_5.content)

				arg_553_1.text_.text = var_556_6

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_7 = 37
				local var_556_8 = utf8.len(var_556_6)
				local var_556_9 = var_556_7 <= 0 and var_556_3 or var_556_3 * (var_556_8 / var_556_7)

				if var_556_9 > 0 and var_556_3 < var_556_9 then
					arg_553_1.talkMaxDuration = var_556_9

					if var_556_9 + var_556_2 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_9 + var_556_2
					end
				end

				arg_553_1.text_.text = var_556_6
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051135", "story_v_out_426051.awb") ~= 0 then
					local var_556_10 = manager.audio:GetVoiceLength("story_v_out_426051", "426051135", "story_v_out_426051.awb") / 1000

					if var_556_10 + var_556_2 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_2
					end

					if var_556_5.prefab_name ~= "" and arg_553_1.actors_[var_556_5.prefab_name] ~= nil then
						local var_556_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_5.prefab_name].transform, "story_v_out_426051", "426051135", "story_v_out_426051.awb")

						arg_553_1:RecordAudio("426051135", var_556_11)
						arg_553_1:RecordAudio("426051135", var_556_11)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_426051", "426051135", "story_v_out_426051.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_426051", "426051135", "story_v_out_426051.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_12 = math.max(var_556_3, arg_553_1.talkMaxDuration)

			if var_556_2 <= arg_553_1.time_ and arg_553_1.time_ < var_556_2 + var_556_12 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_2) / var_556_12

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_2 + var_556_12 and arg_553_1.time_ < var_556_2 + var_556_12 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play426051136 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 426051136
		arg_557_1.duration_ = 9.23

		local var_557_0 = {
			zh = 8.266,
			ja = 9.233
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play426051137(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0

			if var_560_0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_0 + arg_560_0 then
				arg_557_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_1")
			end

			local var_560_1 = 0
			local var_560_2 = 0.925

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_3 = arg_557_1:FormatText(StoryNameCfg[595].name)

				arg_557_1.leftNameTxt_.text = var_560_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_4 = arg_557_1:GetWordFromCfg(426051136)
				local var_560_5 = arg_557_1:FormatText(var_560_4.content)

				arg_557_1.text_.text = var_560_5

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_6 = 37
				local var_560_7 = utf8.len(var_560_5)
				local var_560_8 = var_560_6 <= 0 and var_560_2 or var_560_2 * (var_560_7 / var_560_6)

				if var_560_8 > 0 and var_560_2 < var_560_8 then
					arg_557_1.talkMaxDuration = var_560_8

					if var_560_8 + var_560_1 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_8 + var_560_1
					end
				end

				arg_557_1.text_.text = var_560_5
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051136", "story_v_out_426051.awb") ~= 0 then
					local var_560_9 = manager.audio:GetVoiceLength("story_v_out_426051", "426051136", "story_v_out_426051.awb") / 1000

					if var_560_9 + var_560_1 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_9 + var_560_1
					end

					if var_560_4.prefab_name ~= "" and arg_557_1.actors_[var_560_4.prefab_name] ~= nil then
						local var_560_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_4.prefab_name].transform, "story_v_out_426051", "426051136", "story_v_out_426051.awb")

						arg_557_1:RecordAudio("426051136", var_560_10)
						arg_557_1:RecordAudio("426051136", var_560_10)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_426051", "426051136", "story_v_out_426051.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_426051", "426051136", "story_v_out_426051.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_11 = math.max(var_560_2, arg_557_1.talkMaxDuration)

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_11 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_1) / var_560_11

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_1 + var_560_11 and arg_557_1.time_ < var_560_1 + var_560_11 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play426051137 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 426051137
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play426051138(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 0.55

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_2 = arg_561_1:FormatText(StoryNameCfg[7].name)

				arg_561_1.leftNameTxt_.text = var_564_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_3 = arg_561_1:GetWordFromCfg(426051137)
				local var_564_4 = arg_561_1:FormatText(var_564_3.content)

				arg_561_1.text_.text = var_564_4

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_5 = 22
				local var_564_6 = utf8.len(var_564_4)
				local var_564_7 = var_564_5 <= 0 and var_564_1 or var_564_1 * (var_564_6 / var_564_5)

				if var_564_7 > 0 and var_564_1 < var_564_7 then
					arg_561_1.talkMaxDuration = var_564_7

					if var_564_7 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_7 + var_564_0
					end
				end

				arg_561_1.text_.text = var_564_4
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_8 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_8 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_8

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_8 and arg_561_1.time_ < var_564_0 + var_564_8 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play426051138 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 426051138
		arg_565_1.duration_ = 13.3

		local var_565_0 = {
			zh = 7.866,
			ja = 13.3
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play426051139(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["1012ui_story"].transform
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.var_.moveOldPos1012ui_story = var_568_0.localPosition
			end

			local var_568_2 = 0.001

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2
				local var_568_4 = Vector3.New(0, -1.05, -6.24)

				var_568_0.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1012ui_story, var_568_4, var_568_3)

				local var_568_5 = manager.ui.mainCamera.transform.position - var_568_0.position

				var_568_0.forward = Vector3.New(var_568_5.x, var_568_5.y, var_568_5.z)

				local var_568_6 = var_568_0.localEulerAngles

				var_568_6.z = 0
				var_568_6.x = 0
				var_568_0.localEulerAngles = var_568_6
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 then
				var_568_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_568_7 = manager.ui.mainCamera.transform.position - var_568_0.position

				var_568_0.forward = Vector3.New(var_568_7.x, var_568_7.y, var_568_7.z)

				local var_568_8 = var_568_0.localEulerAngles

				var_568_8.z = 0
				var_568_8.x = 0
				var_568_0.localEulerAngles = var_568_8
			end

			local var_568_9 = 0

			if var_568_9 < arg_565_1.time_ and arg_565_1.time_ <= var_568_9 + arg_568_0 then
				arg_565_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_2")
			end

			local var_568_10 = 0

			if var_568_10 < arg_565_1.time_ and arg_565_1.time_ <= var_568_10 + arg_568_0 then
				arg_565_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_568_11 = 0
			local var_568_12 = 0.775

			if var_568_11 < arg_565_1.time_ and arg_565_1.time_ <= var_568_11 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_13 = arg_565_1:FormatText(StoryNameCfg[595].name)

				arg_565_1.leftNameTxt_.text = var_568_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_14 = arg_565_1:GetWordFromCfg(426051138)
				local var_568_15 = arg_565_1:FormatText(var_568_14.content)

				arg_565_1.text_.text = var_568_15

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_16 = 31
				local var_568_17 = utf8.len(var_568_15)
				local var_568_18 = var_568_16 <= 0 and var_568_12 or var_568_12 * (var_568_17 / var_568_16)

				if var_568_18 > 0 and var_568_12 < var_568_18 then
					arg_565_1.talkMaxDuration = var_568_18

					if var_568_18 + var_568_11 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_18 + var_568_11
					end
				end

				arg_565_1.text_.text = var_568_15
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051138", "story_v_out_426051.awb") ~= 0 then
					local var_568_19 = manager.audio:GetVoiceLength("story_v_out_426051", "426051138", "story_v_out_426051.awb") / 1000

					if var_568_19 + var_568_11 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_19 + var_568_11
					end

					if var_568_14.prefab_name ~= "" and arg_565_1.actors_[var_568_14.prefab_name] ~= nil then
						local var_568_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_14.prefab_name].transform, "story_v_out_426051", "426051138", "story_v_out_426051.awb")

						arg_565_1:RecordAudio("426051138", var_568_20)
						arg_565_1:RecordAudio("426051138", var_568_20)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_426051", "426051138", "story_v_out_426051.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_426051", "426051138", "story_v_out_426051.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_21 = math.max(var_568_12, arg_565_1.talkMaxDuration)

			if var_568_11 <= arg_565_1.time_ and arg_565_1.time_ < var_568_11 + var_568_21 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_11) / var_568_21

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_11 + var_568_21 and arg_565_1.time_ < var_568_11 + var_568_21 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_565_1:InitPlayNodeList()
	end,
	Play426051139 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 426051139
		arg_569_1.duration_ = 6.6

		local var_569_0 = {
			zh = 5.8,
			ja = 6.6
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play426051140(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0
			local var_572_1 = 0.55

			if var_572_0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_2 = arg_569_1:FormatText(StoryNameCfg[595].name)

				arg_569_1.leftNameTxt_.text = var_572_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_3 = arg_569_1:GetWordFromCfg(426051139)
				local var_572_4 = arg_569_1:FormatText(var_572_3.content)

				arg_569_1.text_.text = var_572_4

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_5 = 22
				local var_572_6 = utf8.len(var_572_4)
				local var_572_7 = var_572_5 <= 0 and var_572_1 or var_572_1 * (var_572_6 / var_572_5)

				if var_572_7 > 0 and var_572_1 < var_572_7 then
					arg_569_1.talkMaxDuration = var_572_7

					if var_572_7 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_7 + var_572_0
					end
				end

				arg_569_1.text_.text = var_572_4
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051139", "story_v_out_426051.awb") ~= 0 then
					local var_572_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051139", "story_v_out_426051.awb") / 1000

					if var_572_8 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_8 + var_572_0
					end

					if var_572_3.prefab_name ~= "" and arg_569_1.actors_[var_572_3.prefab_name] ~= nil then
						local var_572_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_3.prefab_name].transform, "story_v_out_426051", "426051139", "story_v_out_426051.awb")

						arg_569_1:RecordAudio("426051139", var_572_9)
						arg_569_1:RecordAudio("426051139", var_572_9)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_out_426051", "426051139", "story_v_out_426051.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_out_426051", "426051139", "story_v_out_426051.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_10 = math.max(var_572_1, arg_569_1.talkMaxDuration)

			if var_572_0 <= arg_569_1.time_ and arg_569_1.time_ < var_572_0 + var_572_10 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_0) / var_572_10

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_0 + var_572_10 and arg_569_1.time_ < var_572_0 + var_572_10 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play426051140 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 426051140
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play426051141(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = arg_573_1.actors_["1012ui_story"].transform
			local var_576_1 = 0

			if var_576_1 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 then
				arg_573_1.var_.moveOldPos1012ui_story = var_576_0.localPosition
			end

			local var_576_2 = 0.001

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_2 then
				local var_576_3 = (arg_573_1.time_ - var_576_1) / var_576_2
				local var_576_4 = Vector3.New(0, 100, 0)

				var_576_0.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1012ui_story, var_576_4, var_576_3)

				local var_576_5 = manager.ui.mainCamera.transform.position - var_576_0.position

				var_576_0.forward = Vector3.New(var_576_5.x, var_576_5.y, var_576_5.z)

				local var_576_6 = var_576_0.localEulerAngles

				var_576_6.z = 0
				var_576_6.x = 0
				var_576_0.localEulerAngles = var_576_6
			end

			if arg_573_1.time_ >= var_576_1 + var_576_2 and arg_573_1.time_ < var_576_1 + var_576_2 + arg_576_0 then
				var_576_0.localPosition = Vector3.New(0, 100, 0)

				local var_576_7 = manager.ui.mainCamera.transform.position - var_576_0.position

				var_576_0.forward = Vector3.New(var_576_7.x, var_576_7.y, var_576_7.z)

				local var_576_8 = var_576_0.localEulerAngles

				var_576_8.z = 0
				var_576_8.x = 0
				var_576_0.localEulerAngles = var_576_8
			end

			local var_576_9 = 0
			local var_576_10 = 0.925

			if var_576_9 < arg_573_1.time_ and arg_573_1.time_ <= var_576_9 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, false)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_11 = arg_573_1:GetWordFromCfg(426051140)
				local var_576_12 = arg_573_1:FormatText(var_576_11.content)

				arg_573_1.text_.text = var_576_12

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_13 = 37
				local var_576_14 = utf8.len(var_576_12)
				local var_576_15 = var_576_13 <= 0 and var_576_10 or var_576_10 * (var_576_14 / var_576_13)

				if var_576_15 > 0 and var_576_10 < var_576_15 then
					arg_573_1.talkMaxDuration = var_576_15

					if var_576_15 + var_576_9 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_15 + var_576_9
					end
				end

				arg_573_1.text_.text = var_576_12
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_16 = math.max(var_576_10, arg_573_1.talkMaxDuration)

			if var_576_9 <= arg_573_1.time_ and arg_573_1.time_ < var_576_9 + var_576_16 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_9) / var_576_16

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_9 + var_576_16 and arg_573_1.time_ < var_576_9 + var_576_16 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_573_1:InitPlayNodeList()
	end,
	Play426051141 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 426051141
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play426051142(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = 0
			local var_580_1 = 0.55

			if var_580_0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_0 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_2 = arg_577_1:FormatText(StoryNameCfg[7].name)

				arg_577_1.leftNameTxt_.text = var_580_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_3 = arg_577_1:GetWordFromCfg(426051141)
				local var_580_4 = arg_577_1:FormatText(var_580_3.content)

				arg_577_1.text_.text = var_580_4

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_5 = 22
				local var_580_6 = utf8.len(var_580_4)
				local var_580_7 = var_580_5 <= 0 and var_580_1 or var_580_1 * (var_580_6 / var_580_5)

				if var_580_7 > 0 and var_580_1 < var_580_7 then
					arg_577_1.talkMaxDuration = var_580_7

					if var_580_7 + var_580_0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_7 + var_580_0
					end
				end

				arg_577_1.text_.text = var_580_4
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_8 = math.max(var_580_1, arg_577_1.talkMaxDuration)

			if var_580_0 <= arg_577_1.time_ and arg_577_1.time_ < var_580_0 + var_580_8 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_0) / var_580_8

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_0 + var_580_8 and arg_577_1.time_ < var_580_0 + var_580_8 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play426051142 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 426051142
		arg_581_1.duration_ = 4.53

		local var_581_0 = {
			zh = 4.466,
			ja = 4.533
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play426051143(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = arg_581_1.actors_["1012ui_story"].transform
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 then
				arg_581_1.var_.moveOldPos1012ui_story = var_584_0.localPosition
			end

			local var_584_2 = 0.001

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2
				local var_584_4 = Vector3.New(0, -1.05, -6.24)

				var_584_0.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1012ui_story, var_584_4, var_584_3)

				local var_584_5 = manager.ui.mainCamera.transform.position - var_584_0.position

				var_584_0.forward = Vector3.New(var_584_5.x, var_584_5.y, var_584_5.z)

				local var_584_6 = var_584_0.localEulerAngles

				var_584_6.z = 0
				var_584_6.x = 0
				var_584_0.localEulerAngles = var_584_6
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 then
				var_584_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_584_7 = manager.ui.mainCamera.transform.position - var_584_0.position

				var_584_0.forward = Vector3.New(var_584_7.x, var_584_7.y, var_584_7.z)

				local var_584_8 = var_584_0.localEulerAngles

				var_584_8.z = 0
				var_584_8.x = 0
				var_584_0.localEulerAngles = var_584_8
			end

			local var_584_9 = 0

			if var_584_9 < arg_581_1.time_ and arg_581_1.time_ <= var_584_9 + arg_584_0 then
				arg_581_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_584_10 = 0

			if var_584_10 < arg_581_1.time_ and arg_581_1.time_ <= var_584_10 + arg_584_0 then
				arg_581_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_584_11 = 0
			local var_584_12 = 0.6

			if var_584_11 < arg_581_1.time_ and arg_581_1.time_ <= var_584_11 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_13 = arg_581_1:FormatText(StoryNameCfg[595].name)

				arg_581_1.leftNameTxt_.text = var_584_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_14 = arg_581_1:GetWordFromCfg(426051142)
				local var_584_15 = arg_581_1:FormatText(var_584_14.content)

				arg_581_1.text_.text = var_584_15

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_16 = 24
				local var_584_17 = utf8.len(var_584_15)
				local var_584_18 = var_584_16 <= 0 and var_584_12 or var_584_12 * (var_584_17 / var_584_16)

				if var_584_18 > 0 and var_584_12 < var_584_18 then
					arg_581_1.talkMaxDuration = var_584_18

					if var_584_18 + var_584_11 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_18 + var_584_11
					end
				end

				arg_581_1.text_.text = var_584_15
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051142", "story_v_out_426051.awb") ~= 0 then
					local var_584_19 = manager.audio:GetVoiceLength("story_v_out_426051", "426051142", "story_v_out_426051.awb") / 1000

					if var_584_19 + var_584_11 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_19 + var_584_11
					end

					if var_584_14.prefab_name ~= "" and arg_581_1.actors_[var_584_14.prefab_name] ~= nil then
						local var_584_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_14.prefab_name].transform, "story_v_out_426051", "426051142", "story_v_out_426051.awb")

						arg_581_1:RecordAudio("426051142", var_584_20)
						arg_581_1:RecordAudio("426051142", var_584_20)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_426051", "426051142", "story_v_out_426051.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_426051", "426051142", "story_v_out_426051.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_21 = math.max(var_584_12, arg_581_1.talkMaxDuration)

			if var_584_11 <= arg_581_1.time_ and arg_581_1.time_ < var_584_11 + var_584_21 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_11) / var_584_21

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_11 + var_584_21 and arg_581_1.time_ < var_584_11 + var_584_21 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_581_1:InitPlayNodeList()
	end,
	Play426051143 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 426051143
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play426051144(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0
			local var_588_1 = 0.2

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_2 = arg_585_1:FormatText(StoryNameCfg[7].name)

				arg_585_1.leftNameTxt_.text = var_588_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, true)
				arg_585_1.iconController_:SetSelectedState("hero")

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_3 = arg_585_1:GetWordFromCfg(426051143)
				local var_588_4 = arg_585_1:FormatText(var_588_3.content)

				arg_585_1.text_.text = var_588_4

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_5 = 8
				local var_588_6 = utf8.len(var_588_4)
				local var_588_7 = var_588_5 <= 0 and var_588_1 or var_588_1 * (var_588_6 / var_588_5)

				if var_588_7 > 0 and var_588_1 < var_588_7 then
					arg_585_1.talkMaxDuration = var_588_7

					if var_588_7 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_7 + var_588_0
					end
				end

				arg_585_1.text_.text = var_588_4
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_8 = math.max(var_588_1, arg_585_1.talkMaxDuration)

			if var_588_0 <= arg_585_1.time_ and arg_585_1.time_ < var_588_0 + var_588_8 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_0) / var_588_8

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_0 + var_588_8 and arg_585_1.time_ < var_588_0 + var_588_8 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play426051144 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 426051144
		arg_589_1.duration_ = 14.5

		local var_589_0 = {
			zh = 8.6,
			ja = 14.5
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play426051145(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = arg_589_1.actors_["1012ui_story"].transform
			local var_592_1 = 0

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.var_.moveOldPos1012ui_story = var_592_0.localPosition
			end

			local var_592_2 = 0.001

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_2 then
				local var_592_3 = (arg_589_1.time_ - var_592_1) / var_592_2
				local var_592_4 = Vector3.New(0, -1.05, -6.24)

				var_592_0.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1012ui_story, var_592_4, var_592_3)

				local var_592_5 = manager.ui.mainCamera.transform.position - var_592_0.position

				var_592_0.forward = Vector3.New(var_592_5.x, var_592_5.y, var_592_5.z)

				local var_592_6 = var_592_0.localEulerAngles

				var_592_6.z = 0
				var_592_6.x = 0
				var_592_0.localEulerAngles = var_592_6
			end

			if arg_589_1.time_ >= var_592_1 + var_592_2 and arg_589_1.time_ < var_592_1 + var_592_2 + arg_592_0 then
				var_592_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_592_7 = manager.ui.mainCamera.transform.position - var_592_0.position

				var_592_0.forward = Vector3.New(var_592_7.x, var_592_7.y, var_592_7.z)

				local var_592_8 = var_592_0.localEulerAngles

				var_592_8.z = 0
				var_592_8.x = 0
				var_592_0.localEulerAngles = var_592_8
			end

			local var_592_9 = 0

			if var_592_9 < arg_589_1.time_ and arg_589_1.time_ <= var_592_9 + arg_592_0 then
				arg_589_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_1")
			end

			local var_592_10 = 0

			if var_592_10 < arg_589_1.time_ and arg_589_1.time_ <= var_592_10 + arg_592_0 then
				arg_589_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_592_11 = 0
			local var_592_12 = 0.975

			if var_592_11 < arg_589_1.time_ and arg_589_1.time_ <= var_592_11 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_13 = arg_589_1:FormatText(StoryNameCfg[595].name)

				arg_589_1.leftNameTxt_.text = var_592_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_14 = arg_589_1:GetWordFromCfg(426051144)
				local var_592_15 = arg_589_1:FormatText(var_592_14.content)

				arg_589_1.text_.text = var_592_15

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_16 = 39
				local var_592_17 = utf8.len(var_592_15)
				local var_592_18 = var_592_16 <= 0 and var_592_12 or var_592_12 * (var_592_17 / var_592_16)

				if var_592_18 > 0 and var_592_12 < var_592_18 then
					arg_589_1.talkMaxDuration = var_592_18

					if var_592_18 + var_592_11 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_18 + var_592_11
					end
				end

				arg_589_1.text_.text = var_592_15
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051144", "story_v_out_426051.awb") ~= 0 then
					local var_592_19 = manager.audio:GetVoiceLength("story_v_out_426051", "426051144", "story_v_out_426051.awb") / 1000

					if var_592_19 + var_592_11 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_19 + var_592_11
					end

					if var_592_14.prefab_name ~= "" and arg_589_1.actors_[var_592_14.prefab_name] ~= nil then
						local var_592_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_14.prefab_name].transform, "story_v_out_426051", "426051144", "story_v_out_426051.awb")

						arg_589_1:RecordAudio("426051144", var_592_20)
						arg_589_1:RecordAudio("426051144", var_592_20)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_426051", "426051144", "story_v_out_426051.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_426051", "426051144", "story_v_out_426051.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_21 = math.max(var_592_12, arg_589_1.talkMaxDuration)

			if var_592_11 <= arg_589_1.time_ and arg_589_1.time_ < var_592_11 + var_592_21 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_11) / var_592_21

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_11 + var_592_21 and arg_589_1.time_ < var_592_11 + var_592_21 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play426051145 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 426051145
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play426051146(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0
			local var_596_1 = 0.275

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_2 = arg_593_1:FormatText(StoryNameCfg[7].name)

				arg_593_1.leftNameTxt_.text = var_596_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_3 = arg_593_1:GetWordFromCfg(426051145)
				local var_596_4 = arg_593_1:FormatText(var_596_3.content)

				arg_593_1.text_.text = var_596_4

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_5 = 11
				local var_596_6 = utf8.len(var_596_4)
				local var_596_7 = var_596_5 <= 0 and var_596_1 or var_596_1 * (var_596_6 / var_596_5)

				if var_596_7 > 0 and var_596_1 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_0
					end
				end

				arg_593_1.text_.text = var_596_4
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_8 = math.max(var_596_1, arg_593_1.talkMaxDuration)

			if var_596_0 <= arg_593_1.time_ and arg_593_1.time_ < var_596_0 + var_596_8 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_0) / var_596_8

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_0 + var_596_8 and arg_593_1.time_ < var_596_0 + var_596_8 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play426051146 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 426051146
		arg_597_1.duration_ = 11.77

		local var_597_0 = {
			zh = 6.4,
			ja = 11.766
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play426051147(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0

			if var_600_0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_2")
			end

			local var_600_1 = 0
			local var_600_2 = 0.75

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_3 = arg_597_1:FormatText(StoryNameCfg[595].name)

				arg_597_1.leftNameTxt_.text = var_600_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_4 = arg_597_1:GetWordFromCfg(426051146)
				local var_600_5 = arg_597_1:FormatText(var_600_4.content)

				arg_597_1.text_.text = var_600_5

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_6 = 30
				local var_600_7 = utf8.len(var_600_5)
				local var_600_8 = var_600_6 <= 0 and var_600_2 or var_600_2 * (var_600_7 / var_600_6)

				if var_600_8 > 0 and var_600_2 < var_600_8 then
					arg_597_1.talkMaxDuration = var_600_8

					if var_600_8 + var_600_1 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_8 + var_600_1
					end
				end

				arg_597_1.text_.text = var_600_5
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051146", "story_v_out_426051.awb") ~= 0 then
					local var_600_9 = manager.audio:GetVoiceLength("story_v_out_426051", "426051146", "story_v_out_426051.awb") / 1000

					if var_600_9 + var_600_1 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_9 + var_600_1
					end

					if var_600_4.prefab_name ~= "" and arg_597_1.actors_[var_600_4.prefab_name] ~= nil then
						local var_600_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_4.prefab_name].transform, "story_v_out_426051", "426051146", "story_v_out_426051.awb")

						arg_597_1:RecordAudio("426051146", var_600_10)
						arg_597_1:RecordAudio("426051146", var_600_10)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_426051", "426051146", "story_v_out_426051.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_426051", "426051146", "story_v_out_426051.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_11 = math.max(var_600_2, arg_597_1.talkMaxDuration)

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_11 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_1) / var_600_11

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_1 + var_600_11 and arg_597_1.time_ < var_600_1 + var_600_11 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play426051147 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 426051147
		arg_601_1.duration_ = 10.8

		local var_601_0 = {
			zh = 7.833,
			ja = 10.8
		}
		local var_601_1 = manager.audio:GetLocalizationFlag()

		if var_601_0[var_601_1] ~= nil then
			arg_601_1.duration_ = var_601_0[var_601_1]
		end

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play426051148(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0
			local var_604_1 = 0.9

			if var_604_0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_2 = arg_601_1:FormatText(StoryNameCfg[595].name)

				arg_601_1.leftNameTxt_.text = var_604_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_3 = arg_601_1:GetWordFromCfg(426051147)
				local var_604_4 = arg_601_1:FormatText(var_604_3.content)

				arg_601_1.text_.text = var_604_4

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_5 = 36
				local var_604_6 = utf8.len(var_604_4)
				local var_604_7 = var_604_5 <= 0 and var_604_1 or var_604_1 * (var_604_6 / var_604_5)

				if var_604_7 > 0 and var_604_1 < var_604_7 then
					arg_601_1.talkMaxDuration = var_604_7

					if var_604_7 + var_604_0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_7 + var_604_0
					end
				end

				arg_601_1.text_.text = var_604_4
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051147", "story_v_out_426051.awb") ~= 0 then
					local var_604_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051147", "story_v_out_426051.awb") / 1000

					if var_604_8 + var_604_0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_8 + var_604_0
					end

					if var_604_3.prefab_name ~= "" and arg_601_1.actors_[var_604_3.prefab_name] ~= nil then
						local var_604_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_3.prefab_name].transform, "story_v_out_426051", "426051147", "story_v_out_426051.awb")

						arg_601_1:RecordAudio("426051147", var_604_9)
						arg_601_1:RecordAudio("426051147", var_604_9)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_out_426051", "426051147", "story_v_out_426051.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_out_426051", "426051147", "story_v_out_426051.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_10 = math.max(var_604_1, arg_601_1.talkMaxDuration)

			if var_604_0 <= arg_601_1.time_ and arg_601_1.time_ < var_604_0 + var_604_10 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_0) / var_604_10

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_0 + var_604_10 and arg_601_1.time_ < var_604_0 + var_604_10 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play426051148 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 426051148
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play426051149(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0
			local var_608_1 = 0.375

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_2 = arg_605_1:FormatText(StoryNameCfg[7].name)

				arg_605_1.leftNameTxt_.text = var_608_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, true)
				arg_605_1.iconController_:SetSelectedState("hero")

				arg_605_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_605_1.callingController_:SetSelectedState("normal")

				arg_605_1.keyicon_.color = Color.New(1, 1, 1)
				arg_605_1.icon_.color = Color.New(1, 1, 1)

				local var_608_3 = arg_605_1:GetWordFromCfg(426051148)
				local var_608_4 = arg_605_1:FormatText(var_608_3.content)

				arg_605_1.text_.text = var_608_4

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_5 = 15
				local var_608_6 = utf8.len(var_608_4)
				local var_608_7 = var_608_5 <= 0 and var_608_1 or var_608_1 * (var_608_6 / var_608_5)

				if var_608_7 > 0 and var_608_1 < var_608_7 then
					arg_605_1.talkMaxDuration = var_608_7

					if var_608_7 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_7 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_4
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_8 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_8 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_8

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_8 and arg_605_1.time_ < var_608_0 + var_608_8 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play426051149 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 426051149
		arg_609_1.duration_ = 5.5

		local var_609_0 = {
			zh = 4.2,
			ja = 5.5
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play426051150(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0
			local var_612_1 = 0.475

			if var_612_0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_2 = arg_609_1:FormatText(StoryNameCfg[595].name)

				arg_609_1.leftNameTxt_.text = var_612_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_3 = arg_609_1:GetWordFromCfg(426051149)
				local var_612_4 = arg_609_1:FormatText(var_612_3.content)

				arg_609_1.text_.text = var_612_4

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_5 = 19
				local var_612_6 = utf8.len(var_612_4)
				local var_612_7 = var_612_5 <= 0 and var_612_1 or var_612_1 * (var_612_6 / var_612_5)

				if var_612_7 > 0 and var_612_1 < var_612_7 then
					arg_609_1.talkMaxDuration = var_612_7

					if var_612_7 + var_612_0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_7 + var_612_0
					end
				end

				arg_609_1.text_.text = var_612_4
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051149", "story_v_out_426051.awb") ~= 0 then
					local var_612_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051149", "story_v_out_426051.awb") / 1000

					if var_612_8 + var_612_0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_8 + var_612_0
					end

					if var_612_3.prefab_name ~= "" and arg_609_1.actors_[var_612_3.prefab_name] ~= nil then
						local var_612_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_3.prefab_name].transform, "story_v_out_426051", "426051149", "story_v_out_426051.awb")

						arg_609_1:RecordAudio("426051149", var_612_9)
						arg_609_1:RecordAudio("426051149", var_612_9)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_out_426051", "426051149", "story_v_out_426051.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_out_426051", "426051149", "story_v_out_426051.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_10 = math.max(var_612_1, arg_609_1.talkMaxDuration)

			if var_612_0 <= arg_609_1.time_ and arg_609_1.time_ < var_612_0 + var_612_10 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_0) / var_612_10

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_0 + var_612_10 and arg_609_1.time_ < var_612_0 + var_612_10 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play426051150 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 426051150
		arg_613_1.duration_ = 15.97

		local var_613_0 = {
			zh = 11.466,
			ja = 15.966
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play426051151(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0
			local var_616_1 = 1.2

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_2 = arg_613_1:FormatText(StoryNameCfg[595].name)

				arg_613_1.leftNameTxt_.text = var_616_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_3 = arg_613_1:GetWordFromCfg(426051150)
				local var_616_4 = arg_613_1:FormatText(var_616_3.content)

				arg_613_1.text_.text = var_616_4

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 48
				local var_616_6 = utf8.len(var_616_4)
				local var_616_7 = var_616_5 <= 0 and var_616_1 or var_616_1 * (var_616_6 / var_616_5)

				if var_616_7 > 0 and var_616_1 < var_616_7 then
					arg_613_1.talkMaxDuration = var_616_7

					if var_616_7 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_0
					end
				end

				arg_613_1.text_.text = var_616_4
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051150", "story_v_out_426051.awb") ~= 0 then
					local var_616_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051150", "story_v_out_426051.awb") / 1000

					if var_616_8 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_8 + var_616_0
					end

					if var_616_3.prefab_name ~= "" and arg_613_1.actors_[var_616_3.prefab_name] ~= nil then
						local var_616_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_3.prefab_name].transform, "story_v_out_426051", "426051150", "story_v_out_426051.awb")

						arg_613_1:RecordAudio("426051150", var_616_9)
						arg_613_1:RecordAudio("426051150", var_616_9)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_out_426051", "426051150", "story_v_out_426051.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_out_426051", "426051150", "story_v_out_426051.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_10 = math.max(var_616_1, arg_613_1.talkMaxDuration)

			if var_616_0 <= arg_613_1.time_ and arg_613_1.time_ < var_616_0 + var_616_10 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_0) / var_616_10

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_0 + var_616_10 and arg_613_1.time_ < var_616_0 + var_616_10 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play426051151 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 426051151
		arg_617_1.duration_ = 14.2

		local var_617_0 = {
			zh = 10.233,
			ja = 14.2
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play426051152(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0
			local var_620_1 = 1.15

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				local var_620_2 = arg_617_1:FormatText(StoryNameCfg[595].name)

				arg_617_1.leftNameTxt_.text = var_620_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_3 = arg_617_1:GetWordFromCfg(426051151)
				local var_620_4 = arg_617_1:FormatText(var_620_3.content)

				arg_617_1.text_.text = var_620_4

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_5 = 46
				local var_620_6 = utf8.len(var_620_4)
				local var_620_7 = var_620_5 <= 0 and var_620_1 or var_620_1 * (var_620_6 / var_620_5)

				if var_620_7 > 0 and var_620_1 < var_620_7 then
					arg_617_1.talkMaxDuration = var_620_7

					if var_620_7 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_7 + var_620_0
					end
				end

				arg_617_1.text_.text = var_620_4
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051151", "story_v_out_426051.awb") ~= 0 then
					local var_620_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051151", "story_v_out_426051.awb") / 1000

					if var_620_8 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_8 + var_620_0
					end

					if var_620_3.prefab_name ~= "" and arg_617_1.actors_[var_620_3.prefab_name] ~= nil then
						local var_620_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_3.prefab_name].transform, "story_v_out_426051", "426051151", "story_v_out_426051.awb")

						arg_617_1:RecordAudio("426051151", var_620_9)
						arg_617_1:RecordAudio("426051151", var_620_9)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_out_426051", "426051151", "story_v_out_426051.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_out_426051", "426051151", "story_v_out_426051.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_10 = math.max(var_620_1, arg_617_1.talkMaxDuration)

			if var_620_0 <= arg_617_1.time_ and arg_617_1.time_ < var_620_0 + var_620_10 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_0) / var_620_10

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_0 + var_620_10 and arg_617_1.time_ < var_620_0 + var_620_10 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play426051152 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 426051152
		arg_621_1.duration_ = 9.3

		local var_621_0 = {
			zh = 6.733,
			ja = 9.3
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play426051153(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0

			if var_624_0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_1")
			end

			local var_624_1 = 0
			local var_624_2 = 0.75

			if var_624_1 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_3 = arg_621_1:FormatText(StoryNameCfg[595].name)

				arg_621_1.leftNameTxt_.text = var_624_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_4 = arg_621_1:GetWordFromCfg(426051152)
				local var_624_5 = arg_621_1:FormatText(var_624_4.content)

				arg_621_1.text_.text = var_624_5

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_6 = 30
				local var_624_7 = utf8.len(var_624_5)
				local var_624_8 = var_624_6 <= 0 and var_624_2 or var_624_2 * (var_624_7 / var_624_6)

				if var_624_8 > 0 and var_624_2 < var_624_8 then
					arg_621_1.talkMaxDuration = var_624_8

					if var_624_8 + var_624_1 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_8 + var_624_1
					end
				end

				arg_621_1.text_.text = var_624_5
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051152", "story_v_out_426051.awb") ~= 0 then
					local var_624_9 = manager.audio:GetVoiceLength("story_v_out_426051", "426051152", "story_v_out_426051.awb") / 1000

					if var_624_9 + var_624_1 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_9 + var_624_1
					end

					if var_624_4.prefab_name ~= "" and arg_621_1.actors_[var_624_4.prefab_name] ~= nil then
						local var_624_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_4.prefab_name].transform, "story_v_out_426051", "426051152", "story_v_out_426051.awb")

						arg_621_1:RecordAudio("426051152", var_624_10)
						arg_621_1:RecordAudio("426051152", var_624_10)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_426051", "426051152", "story_v_out_426051.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_426051", "426051152", "story_v_out_426051.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_11 = math.max(var_624_2, arg_621_1.talkMaxDuration)

			if var_624_1 <= arg_621_1.time_ and arg_621_1.time_ < var_624_1 + var_624_11 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_1) / var_624_11

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_1 + var_624_11 and arg_621_1.time_ < var_624_1 + var_624_11 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play426051153 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 426051153
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play426051154(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0
			local var_628_1 = 0.275

			if var_628_0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				local var_628_2 = arg_625_1:FormatText(StoryNameCfg[7].name)

				arg_625_1.leftNameTxt_.text = var_628_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, true)
				arg_625_1.iconController_:SetSelectedState("hero")

				arg_625_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_625_1.callingController_:SetSelectedState("normal")

				arg_625_1.keyicon_.color = Color.New(1, 1, 1)
				arg_625_1.icon_.color = Color.New(1, 1, 1)

				local var_628_3 = arg_625_1:GetWordFromCfg(426051153)
				local var_628_4 = arg_625_1:FormatText(var_628_3.content)

				arg_625_1.text_.text = var_628_4

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_5 = 11
				local var_628_6 = utf8.len(var_628_4)
				local var_628_7 = var_628_5 <= 0 and var_628_1 or var_628_1 * (var_628_6 / var_628_5)

				if var_628_7 > 0 and var_628_1 < var_628_7 then
					arg_625_1.talkMaxDuration = var_628_7

					if var_628_7 + var_628_0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_7 + var_628_0
					end
				end

				arg_625_1.text_.text = var_628_4
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_8 = math.max(var_628_1, arg_625_1.talkMaxDuration)

			if var_628_0 <= arg_625_1.time_ and arg_625_1.time_ < var_628_0 + var_628_8 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_0) / var_628_8

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_0 + var_628_8 and arg_625_1.time_ < var_628_0 + var_628_8 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play426051154 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 426051154
		arg_629_1.duration_ = 9.6

		local var_629_0 = {
			zh = 6.1,
			ja = 9.6
		}
		local var_629_1 = manager.audio:GetLocalizationFlag()

		if var_629_0[var_629_1] ~= nil then
			arg_629_1.duration_ = var_629_0[var_629_1]
		end

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play426051155(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = arg_629_1.actors_["1012ui_story"].transform
			local var_632_1 = 0

			if var_632_1 < arg_629_1.time_ and arg_629_1.time_ <= var_632_1 + arg_632_0 then
				arg_629_1.var_.moveOldPos1012ui_story = var_632_0.localPosition
			end

			local var_632_2 = 0.001

			if var_632_1 <= arg_629_1.time_ and arg_629_1.time_ < var_632_1 + var_632_2 then
				local var_632_3 = (arg_629_1.time_ - var_632_1) / var_632_2
				local var_632_4 = Vector3.New(0, -1.05, -6.24)

				var_632_0.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1012ui_story, var_632_4, var_632_3)

				local var_632_5 = manager.ui.mainCamera.transform.position - var_632_0.position

				var_632_0.forward = Vector3.New(var_632_5.x, var_632_5.y, var_632_5.z)

				local var_632_6 = var_632_0.localEulerAngles

				var_632_6.z = 0
				var_632_6.x = 0
				var_632_0.localEulerAngles = var_632_6
			end

			if arg_629_1.time_ >= var_632_1 + var_632_2 and arg_629_1.time_ < var_632_1 + var_632_2 + arg_632_0 then
				var_632_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_632_7 = manager.ui.mainCamera.transform.position - var_632_0.position

				var_632_0.forward = Vector3.New(var_632_7.x, var_632_7.y, var_632_7.z)

				local var_632_8 = var_632_0.localEulerAngles

				var_632_8.z = 0
				var_632_8.x = 0
				var_632_0.localEulerAngles = var_632_8
			end

			local var_632_9 = 0

			if var_632_9 < arg_629_1.time_ and arg_629_1.time_ <= var_632_9 + arg_632_0 then
				arg_629_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012actionlink/1012action434")
			end

			local var_632_10 = 0
			local var_632_11 = 0.7

			if var_632_10 < arg_629_1.time_ and arg_629_1.time_ <= var_632_10 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				local var_632_12 = arg_629_1:FormatText(StoryNameCfg[595].name)

				arg_629_1.leftNameTxt_.text = var_632_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_13 = arg_629_1:GetWordFromCfg(426051154)
				local var_632_14 = arg_629_1:FormatText(var_632_13.content)

				arg_629_1.text_.text = var_632_14

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_15 = 28
				local var_632_16 = utf8.len(var_632_14)
				local var_632_17 = var_632_15 <= 0 and var_632_11 or var_632_11 * (var_632_16 / var_632_15)

				if var_632_17 > 0 and var_632_11 < var_632_17 then
					arg_629_1.talkMaxDuration = var_632_17

					if var_632_17 + var_632_10 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_17 + var_632_10
					end
				end

				arg_629_1.text_.text = var_632_14
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051154", "story_v_out_426051.awb") ~= 0 then
					local var_632_18 = manager.audio:GetVoiceLength("story_v_out_426051", "426051154", "story_v_out_426051.awb") / 1000

					if var_632_18 + var_632_10 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_18 + var_632_10
					end

					if var_632_13.prefab_name ~= "" and arg_629_1.actors_[var_632_13.prefab_name] ~= nil then
						local var_632_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_13.prefab_name].transform, "story_v_out_426051", "426051154", "story_v_out_426051.awb")

						arg_629_1:RecordAudio("426051154", var_632_19)
						arg_629_1:RecordAudio("426051154", var_632_19)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_out_426051", "426051154", "story_v_out_426051.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_out_426051", "426051154", "story_v_out_426051.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_20 = math.max(var_632_11, arg_629_1.talkMaxDuration)

			if var_632_10 <= arg_629_1.time_ and arg_629_1.time_ < var_632_10 + var_632_20 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_10) / var_632_20

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_10 + var_632_20 and arg_629_1.time_ < var_632_10 + var_632_20 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_629_1:InitPlayNodeList()
	end,
	Play426051155 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 426051155
		arg_633_1.duration_ = 7.5

		local var_633_0 = {
			zh = 4.4,
			ja = 7.5
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play426051156(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = 0
			local var_636_1 = 0.5

			if var_636_0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_0 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_2 = arg_633_1:FormatText(StoryNameCfg[595].name)

				arg_633_1.leftNameTxt_.text = var_636_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_3 = arg_633_1:GetWordFromCfg(426051155)
				local var_636_4 = arg_633_1:FormatText(var_636_3.content)

				arg_633_1.text_.text = var_636_4

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_5 = 20
				local var_636_6 = utf8.len(var_636_4)
				local var_636_7 = var_636_5 <= 0 and var_636_1 or var_636_1 * (var_636_6 / var_636_5)

				if var_636_7 > 0 and var_636_1 < var_636_7 then
					arg_633_1.talkMaxDuration = var_636_7

					if var_636_7 + var_636_0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_7 + var_636_0
					end
				end

				arg_633_1.text_.text = var_636_4
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051155", "story_v_out_426051.awb") ~= 0 then
					local var_636_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051155", "story_v_out_426051.awb") / 1000

					if var_636_8 + var_636_0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_8 + var_636_0
					end

					if var_636_3.prefab_name ~= "" and arg_633_1.actors_[var_636_3.prefab_name] ~= nil then
						local var_636_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_3.prefab_name].transform, "story_v_out_426051", "426051155", "story_v_out_426051.awb")

						arg_633_1:RecordAudio("426051155", var_636_9)
						arg_633_1:RecordAudio("426051155", var_636_9)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_out_426051", "426051155", "story_v_out_426051.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_out_426051", "426051155", "story_v_out_426051.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_10 = math.max(var_636_1, arg_633_1.talkMaxDuration)

			if var_636_0 <= arg_633_1.time_ and arg_633_1.time_ < var_636_0 + var_636_10 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_0) / var_636_10

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_0 + var_636_10 and arg_633_1.time_ < var_636_0 + var_636_10 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play426051156 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 426051156
		arg_637_1.duration_ = 7.63

		local var_637_0 = {
			zh = 5.666,
			ja = 7.633
		}
		local var_637_1 = manager.audio:GetLocalizationFlag()

		if var_637_0[var_637_1] ~= nil then
			arg_637_1.duration_ = var_637_0[var_637_1]
		end

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play426051157(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0
			local var_640_1 = 0.75

			if var_640_0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				local var_640_2 = arg_637_1:FormatText(StoryNameCfg[595].name)

				arg_637_1.leftNameTxt_.text = var_640_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_3 = arg_637_1:GetWordFromCfg(426051156)
				local var_640_4 = arg_637_1:FormatText(var_640_3.content)

				arg_637_1.text_.text = var_640_4

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_5 = 30
				local var_640_6 = utf8.len(var_640_4)
				local var_640_7 = var_640_5 <= 0 and var_640_1 or var_640_1 * (var_640_6 / var_640_5)

				if var_640_7 > 0 and var_640_1 < var_640_7 then
					arg_637_1.talkMaxDuration = var_640_7

					if var_640_7 + var_640_0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_7 + var_640_0
					end
				end

				arg_637_1.text_.text = var_640_4
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051156", "story_v_out_426051.awb") ~= 0 then
					local var_640_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051156", "story_v_out_426051.awb") / 1000

					if var_640_8 + var_640_0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_8 + var_640_0
					end

					if var_640_3.prefab_name ~= "" and arg_637_1.actors_[var_640_3.prefab_name] ~= nil then
						local var_640_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_3.prefab_name].transform, "story_v_out_426051", "426051156", "story_v_out_426051.awb")

						arg_637_1:RecordAudio("426051156", var_640_9)
						arg_637_1:RecordAudio("426051156", var_640_9)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_out_426051", "426051156", "story_v_out_426051.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_out_426051", "426051156", "story_v_out_426051.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_10 = math.max(var_640_1, arg_637_1.talkMaxDuration)

			if var_640_0 <= arg_637_1.time_ and arg_637_1.time_ < var_640_0 + var_640_10 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_0) / var_640_10

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_0 + var_640_10 and arg_637_1.time_ < var_640_0 + var_640_10 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play426051157 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 426051157
		arg_641_1.duration_ = 4.1

		local var_641_0 = {
			zh = 3.9,
			ja = 4.1
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play426051158(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0

			if var_644_0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_0 + arg_644_0 then
				arg_641_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			local var_644_1 = 0
			local var_644_2 = 0.425

			if var_644_1 < arg_641_1.time_ and arg_641_1.time_ <= var_644_1 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_3 = arg_641_1:FormatText(StoryNameCfg[595].name)

				arg_641_1.leftNameTxt_.text = var_644_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_4 = arg_641_1:GetWordFromCfg(426051157)
				local var_644_5 = arg_641_1:FormatText(var_644_4.content)

				arg_641_1.text_.text = var_644_5

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_6 = 17
				local var_644_7 = utf8.len(var_644_5)
				local var_644_8 = var_644_6 <= 0 and var_644_2 or var_644_2 * (var_644_7 / var_644_6)

				if var_644_8 > 0 and var_644_2 < var_644_8 then
					arg_641_1.talkMaxDuration = var_644_8

					if var_644_8 + var_644_1 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_8 + var_644_1
					end
				end

				arg_641_1.text_.text = var_644_5
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051157", "story_v_out_426051.awb") ~= 0 then
					local var_644_9 = manager.audio:GetVoiceLength("story_v_out_426051", "426051157", "story_v_out_426051.awb") / 1000

					if var_644_9 + var_644_1 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_9 + var_644_1
					end

					if var_644_4.prefab_name ~= "" and arg_641_1.actors_[var_644_4.prefab_name] ~= nil then
						local var_644_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_4.prefab_name].transform, "story_v_out_426051", "426051157", "story_v_out_426051.awb")

						arg_641_1:RecordAudio("426051157", var_644_10)
						arg_641_1:RecordAudio("426051157", var_644_10)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_out_426051", "426051157", "story_v_out_426051.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_out_426051", "426051157", "story_v_out_426051.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_11 = math.max(var_644_2, arg_641_1.talkMaxDuration)

			if var_644_1 <= arg_641_1.time_ and arg_641_1.time_ < var_644_1 + var_644_11 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_1) / var_644_11

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_1 + var_644_11 and arg_641_1.time_ < var_644_1 + var_644_11 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play426051158 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 426051158
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play426051159(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0
			local var_648_1 = 0.3

			if var_648_0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				local var_648_2 = arg_645_1:FormatText(StoryNameCfg[7].name)

				arg_645_1.leftNameTxt_.text = var_648_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_3 = arg_645_1:GetWordFromCfg(426051158)
				local var_648_4 = arg_645_1:FormatText(var_648_3.content)

				arg_645_1.text_.text = var_648_4

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 12
				local var_648_6 = utf8.len(var_648_4)
				local var_648_7 = var_648_5 <= 0 and var_648_1 or var_648_1 * (var_648_6 / var_648_5)

				if var_648_7 > 0 and var_648_1 < var_648_7 then
					arg_645_1.talkMaxDuration = var_648_7

					if var_648_7 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_7 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_4
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_8 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_8 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_8

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_8 and arg_645_1.time_ < var_648_0 + var_648_8 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play426051159 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 426051159
		arg_649_1.duration_ = 7.27

		local var_649_0 = {
			zh = 5.3,
			ja = 7.266
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play426051160(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0
			local var_652_1 = 0.6

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_2 = arg_649_1:FormatText(StoryNameCfg[595].name)

				arg_649_1.leftNameTxt_.text = var_652_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_3 = arg_649_1:GetWordFromCfg(426051159)
				local var_652_4 = arg_649_1:FormatText(var_652_3.content)

				arg_649_1.text_.text = var_652_4

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_5 = 24
				local var_652_6 = utf8.len(var_652_4)
				local var_652_7 = var_652_5 <= 0 and var_652_1 or var_652_1 * (var_652_6 / var_652_5)

				if var_652_7 > 0 and var_652_1 < var_652_7 then
					arg_649_1.talkMaxDuration = var_652_7

					if var_652_7 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_7 + var_652_0
					end
				end

				arg_649_1.text_.text = var_652_4
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051159", "story_v_out_426051.awb") ~= 0 then
					local var_652_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051159", "story_v_out_426051.awb") / 1000

					if var_652_8 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_8 + var_652_0
					end

					if var_652_3.prefab_name ~= "" and arg_649_1.actors_[var_652_3.prefab_name] ~= nil then
						local var_652_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_3.prefab_name].transform, "story_v_out_426051", "426051159", "story_v_out_426051.awb")

						arg_649_1:RecordAudio("426051159", var_652_9)
						arg_649_1:RecordAudio("426051159", var_652_9)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_out_426051", "426051159", "story_v_out_426051.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_out_426051", "426051159", "story_v_out_426051.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_10 = math.max(var_652_1, arg_649_1.talkMaxDuration)

			if var_652_0 <= arg_649_1.time_ and arg_649_1.time_ < var_652_0 + var_652_10 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_0) / var_652_10

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_0 + var_652_10 and arg_649_1.time_ < var_652_0 + var_652_10 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play426051160 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 426051160
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play426051161(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0
			local var_656_1 = 0.85

			if var_656_0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_0 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				local var_656_2 = arg_653_1:FormatText(StoryNameCfg[7].name)

				arg_653_1.leftNameTxt_.text = var_656_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, true)
				arg_653_1.iconController_:SetSelectedState("hero")

				arg_653_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_653_1.callingController_:SetSelectedState("normal")

				arg_653_1.keyicon_.color = Color.New(1, 1, 1)
				arg_653_1.icon_.color = Color.New(1, 1, 1)

				local var_656_3 = arg_653_1:GetWordFromCfg(426051160)
				local var_656_4 = arg_653_1:FormatText(var_656_3.content)

				arg_653_1.text_.text = var_656_4

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_5 = 34
				local var_656_6 = utf8.len(var_656_4)
				local var_656_7 = var_656_5 <= 0 and var_656_1 or var_656_1 * (var_656_6 / var_656_5)

				if var_656_7 > 0 and var_656_1 < var_656_7 then
					arg_653_1.talkMaxDuration = var_656_7

					if var_656_7 + var_656_0 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_7 + var_656_0
					end
				end

				arg_653_1.text_.text = var_656_4
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_8 = math.max(var_656_1, arg_653_1.talkMaxDuration)

			if var_656_0 <= arg_653_1.time_ and arg_653_1.time_ < var_656_0 + var_656_8 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_0) / var_656_8

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_0 + var_656_8 and arg_653_1.time_ < var_656_0 + var_656_8 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play426051161 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 426051161
		arg_657_1.duration_ = 4.13

		local var_657_0 = {
			zh = 3.366,
			ja = 4.133
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play426051162(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 0
			local var_660_1 = 0.475

			if var_660_0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_0 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_2 = arg_657_1:FormatText(StoryNameCfg[595].name)

				arg_657_1.leftNameTxt_.text = var_660_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_3 = arg_657_1:GetWordFromCfg(426051161)
				local var_660_4 = arg_657_1:FormatText(var_660_3.content)

				arg_657_1.text_.text = var_660_4

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_5 = 19
				local var_660_6 = utf8.len(var_660_4)
				local var_660_7 = var_660_5 <= 0 and var_660_1 or var_660_1 * (var_660_6 / var_660_5)

				if var_660_7 > 0 and var_660_1 < var_660_7 then
					arg_657_1.talkMaxDuration = var_660_7

					if var_660_7 + var_660_0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_7 + var_660_0
					end
				end

				arg_657_1.text_.text = var_660_4
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051161", "story_v_out_426051.awb") ~= 0 then
					local var_660_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051161", "story_v_out_426051.awb") / 1000

					if var_660_8 + var_660_0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_8 + var_660_0
					end

					if var_660_3.prefab_name ~= "" and arg_657_1.actors_[var_660_3.prefab_name] ~= nil then
						local var_660_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_3.prefab_name].transform, "story_v_out_426051", "426051161", "story_v_out_426051.awb")

						arg_657_1:RecordAudio("426051161", var_660_9)
						arg_657_1:RecordAudio("426051161", var_660_9)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_out_426051", "426051161", "story_v_out_426051.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_out_426051", "426051161", "story_v_out_426051.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_10 = math.max(var_660_1, arg_657_1.talkMaxDuration)

			if var_660_0 <= arg_657_1.time_ and arg_657_1.time_ < var_660_0 + var_660_10 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_0) / var_660_10

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_0 + var_660_10 and arg_657_1.time_ < var_660_0 + var_660_10 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play426051162 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 426051162
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play426051163(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = arg_661_1.actors_["1012ui_story"].transform
			local var_664_1 = 0

			if var_664_1 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 then
				arg_661_1.var_.moveOldPos1012ui_story = var_664_0.localPosition
			end

			local var_664_2 = 0.001

			if var_664_1 <= arg_661_1.time_ and arg_661_1.time_ < var_664_1 + var_664_2 then
				local var_664_3 = (arg_661_1.time_ - var_664_1) / var_664_2
				local var_664_4 = Vector3.New(0, 100, 0)

				var_664_0.localPosition = Vector3.Lerp(arg_661_1.var_.moveOldPos1012ui_story, var_664_4, var_664_3)

				local var_664_5 = manager.ui.mainCamera.transform.position - var_664_0.position

				var_664_0.forward = Vector3.New(var_664_5.x, var_664_5.y, var_664_5.z)

				local var_664_6 = var_664_0.localEulerAngles

				var_664_6.z = 0
				var_664_6.x = 0
				var_664_0.localEulerAngles = var_664_6
			end

			if arg_661_1.time_ >= var_664_1 + var_664_2 and arg_661_1.time_ < var_664_1 + var_664_2 + arg_664_0 then
				var_664_0.localPosition = Vector3.New(0, 100, 0)

				local var_664_7 = manager.ui.mainCamera.transform.position - var_664_0.position

				var_664_0.forward = Vector3.New(var_664_7.x, var_664_7.y, var_664_7.z)

				local var_664_8 = var_664_0.localEulerAngles

				var_664_8.z = 0
				var_664_8.x = 0
				var_664_0.localEulerAngles = var_664_8
			end

			local var_664_9 = 0
			local var_664_10 = 0.575

			if var_664_9 < arg_661_1.time_ and arg_661_1.time_ <= var_664_9 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, false)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_11 = arg_661_1:GetWordFromCfg(426051162)
				local var_664_12 = arg_661_1:FormatText(var_664_11.content)

				arg_661_1.text_.text = var_664_12

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_13 = 23
				local var_664_14 = utf8.len(var_664_12)
				local var_664_15 = var_664_13 <= 0 and var_664_10 or var_664_10 * (var_664_14 / var_664_13)

				if var_664_15 > 0 and var_664_10 < var_664_15 then
					arg_661_1.talkMaxDuration = var_664_15

					if var_664_15 + var_664_9 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_15 + var_664_9
					end
				end

				arg_661_1.text_.text = var_664_12
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_16 = math.max(var_664_10, arg_661_1.talkMaxDuration)

			if var_664_9 <= arg_661_1.time_ and arg_661_1.time_ < var_664_9 + var_664_16 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_9) / var_664_16

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_9 + var_664_16 and arg_661_1.time_ < var_664_9 + var_664_16 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_661_1:InitPlayNodeList()
	end,
	Play426051163 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 426051163
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play426051164(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = 0
			local var_668_1 = 0.125

			if var_668_0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_0 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				local var_668_2 = arg_665_1:FormatText(StoryNameCfg[7].name)

				arg_665_1.leftNameTxt_.text = var_668_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, true)
				arg_665_1.iconController_:SetSelectedState("hero")

				arg_665_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_665_1.callingController_:SetSelectedState("normal")

				arg_665_1.keyicon_.color = Color.New(1, 1, 1)
				arg_665_1.icon_.color = Color.New(1, 1, 1)

				local var_668_3 = arg_665_1:GetWordFromCfg(426051163)
				local var_668_4 = arg_665_1:FormatText(var_668_3.content)

				arg_665_1.text_.text = var_668_4

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_5 = 5
				local var_668_6 = utf8.len(var_668_4)
				local var_668_7 = var_668_5 <= 0 and var_668_1 or var_668_1 * (var_668_6 / var_668_5)

				if var_668_7 > 0 and var_668_1 < var_668_7 then
					arg_665_1.talkMaxDuration = var_668_7

					if var_668_7 + var_668_0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_7 + var_668_0
					end
				end

				arg_665_1.text_.text = var_668_4
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_8 = math.max(var_668_1, arg_665_1.talkMaxDuration)

			if var_668_0 <= arg_665_1.time_ and arg_665_1.time_ < var_668_0 + var_668_8 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_0) / var_668_8

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_0 + var_668_8 and arg_665_1.time_ < var_668_0 + var_668_8 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play426051164 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 426051164
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play426051165(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 0
			local var_672_1 = 1.175

			if var_672_0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_0 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_2 = arg_669_1:FormatText(StoryNameCfg[7].name)

				arg_669_1.leftNameTxt_.text = var_672_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_3 = arg_669_1:GetWordFromCfg(426051164)
				local var_672_4 = arg_669_1:FormatText(var_672_3.content)

				arg_669_1.text_.text = var_672_4

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_5 = 47
				local var_672_6 = utf8.len(var_672_4)
				local var_672_7 = var_672_5 <= 0 and var_672_1 or var_672_1 * (var_672_6 / var_672_5)

				if var_672_7 > 0 and var_672_1 < var_672_7 then
					arg_669_1.talkMaxDuration = var_672_7

					if var_672_7 + var_672_0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_7 + var_672_0
					end
				end

				arg_669_1.text_.text = var_672_4
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_8 = math.max(var_672_1, arg_669_1.talkMaxDuration)

			if var_672_0 <= arg_669_1.time_ and arg_669_1.time_ < var_672_0 + var_672_8 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_0) / var_672_8

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_0 + var_672_8 and arg_669_1.time_ < var_672_0 + var_672_8 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play426051165 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 426051165
		arg_673_1.duration_ = 6.37

		local var_673_0 = {
			zh = 5.1,
			ja = 6.366
		}
		local var_673_1 = manager.audio:GetLocalizationFlag()

		if var_673_0[var_673_1] ~= nil then
			arg_673_1.duration_ = var_673_0[var_673_1]
		end

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play426051166(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = arg_673_1.actors_["1012ui_story"].transform
			local var_676_1 = 0

			if var_676_1 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 then
				arg_673_1.var_.moveOldPos1012ui_story = var_676_0.localPosition
			end

			local var_676_2 = 0.001

			if var_676_1 <= arg_673_1.time_ and arg_673_1.time_ < var_676_1 + var_676_2 then
				local var_676_3 = (arg_673_1.time_ - var_676_1) / var_676_2
				local var_676_4 = Vector3.New(0, -1.05, -6.24)

				var_676_0.localPosition = Vector3.Lerp(arg_673_1.var_.moveOldPos1012ui_story, var_676_4, var_676_3)

				local var_676_5 = manager.ui.mainCamera.transform.position - var_676_0.position

				var_676_0.forward = Vector3.New(var_676_5.x, var_676_5.y, var_676_5.z)

				local var_676_6 = var_676_0.localEulerAngles

				var_676_6.z = 0
				var_676_6.x = 0
				var_676_0.localEulerAngles = var_676_6
			end

			if arg_673_1.time_ >= var_676_1 + var_676_2 and arg_673_1.time_ < var_676_1 + var_676_2 + arg_676_0 then
				var_676_0.localPosition = Vector3.New(0, -1.05, -6.24)

				local var_676_7 = manager.ui.mainCamera.transform.position - var_676_0.position

				var_676_0.forward = Vector3.New(var_676_7.x, var_676_7.y, var_676_7.z)

				local var_676_8 = var_676_0.localEulerAngles

				var_676_8.z = 0
				var_676_8.x = 0
				var_676_0.localEulerAngles = var_676_8
			end

			local var_676_9 = 0

			if var_676_9 < arg_673_1.time_ and arg_673_1.time_ <= var_676_9 + arg_676_0 then
				arg_673_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_676_10 = 0

			if var_676_10 < arg_673_1.time_ and arg_673_1.time_ <= var_676_10 + arg_676_0 then
				arg_673_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_676_11 = 0
			local var_676_12 = 0.725

			if var_676_11 < arg_673_1.time_ and arg_673_1.time_ <= var_676_11 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				local var_676_13 = arg_673_1:FormatText(StoryNameCfg[595].name)

				arg_673_1.leftNameTxt_.text = var_676_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_14 = arg_673_1:GetWordFromCfg(426051165)
				local var_676_15 = arg_673_1:FormatText(var_676_14.content)

				arg_673_1.text_.text = var_676_15

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_16 = 29
				local var_676_17 = utf8.len(var_676_15)
				local var_676_18 = var_676_16 <= 0 and var_676_12 or var_676_12 * (var_676_17 / var_676_16)

				if var_676_18 > 0 and var_676_12 < var_676_18 then
					arg_673_1.talkMaxDuration = var_676_18

					if var_676_18 + var_676_11 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_18 + var_676_11
					end
				end

				arg_673_1.text_.text = var_676_15
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051165", "story_v_out_426051.awb") ~= 0 then
					local var_676_19 = manager.audio:GetVoiceLength("story_v_out_426051", "426051165", "story_v_out_426051.awb") / 1000

					if var_676_19 + var_676_11 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_19 + var_676_11
					end

					if var_676_14.prefab_name ~= "" and arg_673_1.actors_[var_676_14.prefab_name] ~= nil then
						local var_676_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_14.prefab_name].transform, "story_v_out_426051", "426051165", "story_v_out_426051.awb")

						arg_673_1:RecordAudio("426051165", var_676_20)
						arg_673_1:RecordAudio("426051165", var_676_20)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_out_426051", "426051165", "story_v_out_426051.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_out_426051", "426051165", "story_v_out_426051.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_21 = math.max(var_676_12, arg_673_1.talkMaxDuration)

			if var_676_11 <= arg_673_1.time_ and arg_673_1.time_ < var_676_11 + var_676_21 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_11) / var_676_21

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_11 + var_676_21 and arg_673_1.time_ < var_676_11 + var_676_21 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_673_1:InitPlayNodeList()
	end,
	Play426051166 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 426051166
		arg_677_1.duration_ = 8.77

		local var_677_0 = {
			zh = 4.866,
			ja = 8.766
		}
		local var_677_1 = manager.audio:GetLocalizationFlag()

		if var_677_0[var_677_1] ~= nil then
			arg_677_1.duration_ = var_677_0[var_677_1]
		end

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play426051167(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = 0
			local var_680_1 = 0.625

			if var_680_0 < arg_677_1.time_ and arg_677_1.time_ <= var_680_0 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				local var_680_2 = arg_677_1:FormatText(StoryNameCfg[595].name)

				arg_677_1.leftNameTxt_.text = var_680_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_3 = arg_677_1:GetWordFromCfg(426051166)
				local var_680_4 = arg_677_1:FormatText(var_680_3.content)

				arg_677_1.text_.text = var_680_4

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_5 = 25
				local var_680_6 = utf8.len(var_680_4)
				local var_680_7 = var_680_5 <= 0 and var_680_1 or var_680_1 * (var_680_6 / var_680_5)

				if var_680_7 > 0 and var_680_1 < var_680_7 then
					arg_677_1.talkMaxDuration = var_680_7

					if var_680_7 + var_680_0 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_7 + var_680_0
					end
				end

				arg_677_1.text_.text = var_680_4
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051166", "story_v_out_426051.awb") ~= 0 then
					local var_680_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051166", "story_v_out_426051.awb") / 1000

					if var_680_8 + var_680_0 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_8 + var_680_0
					end

					if var_680_3.prefab_name ~= "" and arg_677_1.actors_[var_680_3.prefab_name] ~= nil then
						local var_680_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_3.prefab_name].transform, "story_v_out_426051", "426051166", "story_v_out_426051.awb")

						arg_677_1:RecordAudio("426051166", var_680_9)
						arg_677_1:RecordAudio("426051166", var_680_9)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_out_426051", "426051166", "story_v_out_426051.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_out_426051", "426051166", "story_v_out_426051.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_10 = math.max(var_680_1, arg_677_1.talkMaxDuration)

			if var_680_0 <= arg_677_1.time_ and arg_677_1.time_ < var_680_0 + var_680_10 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_0) / var_680_10

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_0 + var_680_10 and arg_677_1.time_ < var_680_0 + var_680_10 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play426051167 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 426051167
		arg_681_1.duration_ = 12.83

		local var_681_0 = {
			zh = 8.866,
			ja = 12.833
		}
		local var_681_1 = manager.audio:GetLocalizationFlag()

		if var_681_0[var_681_1] ~= nil then
			arg_681_1.duration_ = var_681_0[var_681_1]
		end

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play426051168(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = 0

			if var_684_0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_0 + arg_684_0 then
				arg_681_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_684_1 = 0
			local var_684_2 = 0.85

			if var_684_1 < arg_681_1.time_ and arg_681_1.time_ <= var_684_1 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				local var_684_3 = arg_681_1:FormatText(StoryNameCfg[595].name)

				arg_681_1.leftNameTxt_.text = var_684_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_4 = arg_681_1:GetWordFromCfg(426051167)
				local var_684_5 = arg_681_1:FormatText(var_684_4.content)

				arg_681_1.text_.text = var_684_5

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_6 = 34
				local var_684_7 = utf8.len(var_684_5)
				local var_684_8 = var_684_6 <= 0 and var_684_2 or var_684_2 * (var_684_7 / var_684_6)

				if var_684_8 > 0 and var_684_2 < var_684_8 then
					arg_681_1.talkMaxDuration = var_684_8

					if var_684_8 + var_684_1 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_8 + var_684_1
					end
				end

				arg_681_1.text_.text = var_684_5
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051167", "story_v_out_426051.awb") ~= 0 then
					local var_684_9 = manager.audio:GetVoiceLength("story_v_out_426051", "426051167", "story_v_out_426051.awb") / 1000

					if var_684_9 + var_684_1 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_9 + var_684_1
					end

					if var_684_4.prefab_name ~= "" and arg_681_1.actors_[var_684_4.prefab_name] ~= nil then
						local var_684_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_681_1.actors_[var_684_4.prefab_name].transform, "story_v_out_426051", "426051167", "story_v_out_426051.awb")

						arg_681_1:RecordAudio("426051167", var_684_10)
						arg_681_1:RecordAudio("426051167", var_684_10)
					else
						arg_681_1:AudioAction("play", "voice", "story_v_out_426051", "426051167", "story_v_out_426051.awb")
					end

					arg_681_1:RecordHistoryTalkVoice("story_v_out_426051", "426051167", "story_v_out_426051.awb")
				end

				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_11 = math.max(var_684_2, arg_681_1.talkMaxDuration)

			if var_684_1 <= arg_681_1.time_ and arg_681_1.time_ < var_684_1 + var_684_11 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_1) / var_684_11

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_1 + var_684_11 and arg_681_1.time_ < var_684_1 + var_684_11 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	Play426051168 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 426051168
		arg_685_1.duration_ = 5

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play426051169(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 0
			local var_688_1 = 0.725

			if var_688_0 < arg_685_1.time_ and arg_685_1.time_ <= var_688_0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				local var_688_2 = arg_685_1:FormatText(StoryNameCfg[7].name)

				arg_685_1.leftNameTxt_.text = var_688_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, true)
				arg_685_1.iconController_:SetSelectedState("hero")

				arg_685_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_685_1.callingController_:SetSelectedState("normal")

				arg_685_1.keyicon_.color = Color.New(1, 1, 1)
				arg_685_1.icon_.color = Color.New(1, 1, 1)

				local var_688_3 = arg_685_1:GetWordFromCfg(426051168)
				local var_688_4 = arg_685_1:FormatText(var_688_3.content)

				arg_685_1.text_.text = var_688_4

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_5 = 29
				local var_688_6 = utf8.len(var_688_4)
				local var_688_7 = var_688_5 <= 0 and var_688_1 or var_688_1 * (var_688_6 / var_688_5)

				if var_688_7 > 0 and var_688_1 < var_688_7 then
					arg_685_1.talkMaxDuration = var_688_7

					if var_688_7 + var_688_0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_7 + var_688_0
					end
				end

				arg_685_1.text_.text = var_688_4
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_8 = math.max(var_688_1, arg_685_1.talkMaxDuration)

			if var_688_0 <= arg_685_1.time_ and arg_685_1.time_ < var_688_0 + var_688_8 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_0) / var_688_8

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_0 + var_688_8 and arg_685_1.time_ < var_688_0 + var_688_8 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play426051169 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 426051169
		arg_689_1.duration_ = 5

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play426051170(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = 0
			local var_692_1 = 1.125

			if var_692_0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_0 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				local var_692_2 = arg_689_1:FormatText(StoryNameCfg[7].name)

				arg_689_1.leftNameTxt_.text = var_692_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, true)
				arg_689_1.iconController_:SetSelectedState("hero")

				arg_689_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_689_1.callingController_:SetSelectedState("normal")

				arg_689_1.keyicon_.color = Color.New(1, 1, 1)
				arg_689_1.icon_.color = Color.New(1, 1, 1)

				local var_692_3 = arg_689_1:GetWordFromCfg(426051169)
				local var_692_4 = arg_689_1:FormatText(var_692_3.content)

				arg_689_1.text_.text = var_692_4

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_5 = 45
				local var_692_6 = utf8.len(var_692_4)
				local var_692_7 = var_692_5 <= 0 and var_692_1 or var_692_1 * (var_692_6 / var_692_5)

				if var_692_7 > 0 and var_692_1 < var_692_7 then
					arg_689_1.talkMaxDuration = var_692_7

					if var_692_7 + var_692_0 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_7 + var_692_0
					end
				end

				arg_689_1.text_.text = var_692_4
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_8 = math.max(var_692_1, arg_689_1.talkMaxDuration)

			if var_692_0 <= arg_689_1.time_ and arg_689_1.time_ < var_692_0 + var_692_8 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_0) / var_692_8

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_0 + var_692_8 and arg_689_1.time_ < var_692_0 + var_692_8 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play426051170 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 426051170
		arg_693_1.duration_ = 8.07

		local var_693_0 = {
			zh = 4.833,
			ja = 8.066
		}
		local var_693_1 = manager.audio:GetLocalizationFlag()

		if var_693_0[var_693_1] ~= nil then
			arg_693_1.duration_ = var_693_0[var_693_1]
		end

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play426051171(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = 0

			if var_696_0 < arg_693_1.time_ and arg_693_1.time_ <= var_696_0 + arg_696_0 then
				arg_693_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012actionlink/1012action442")
			end

			local var_696_1 = 0
			local var_696_2 = 0.525

			if var_696_1 < arg_693_1.time_ and arg_693_1.time_ <= var_696_1 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				local var_696_3 = arg_693_1:FormatText(StoryNameCfg[595].name)

				arg_693_1.leftNameTxt_.text = var_696_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_4 = arg_693_1:GetWordFromCfg(426051170)
				local var_696_5 = arg_693_1:FormatText(var_696_4.content)

				arg_693_1.text_.text = var_696_5

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_6 = 21
				local var_696_7 = utf8.len(var_696_5)
				local var_696_8 = var_696_6 <= 0 and var_696_2 or var_696_2 * (var_696_7 / var_696_6)

				if var_696_8 > 0 and var_696_2 < var_696_8 then
					arg_693_1.talkMaxDuration = var_696_8

					if var_696_8 + var_696_1 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_8 + var_696_1
					end
				end

				arg_693_1.text_.text = var_696_5
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051170", "story_v_out_426051.awb") ~= 0 then
					local var_696_9 = manager.audio:GetVoiceLength("story_v_out_426051", "426051170", "story_v_out_426051.awb") / 1000

					if var_696_9 + var_696_1 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_9 + var_696_1
					end

					if var_696_4.prefab_name ~= "" and arg_693_1.actors_[var_696_4.prefab_name] ~= nil then
						local var_696_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_693_1.actors_[var_696_4.prefab_name].transform, "story_v_out_426051", "426051170", "story_v_out_426051.awb")

						arg_693_1:RecordAudio("426051170", var_696_10)
						arg_693_1:RecordAudio("426051170", var_696_10)
					else
						arg_693_1:AudioAction("play", "voice", "story_v_out_426051", "426051170", "story_v_out_426051.awb")
					end

					arg_693_1:RecordHistoryTalkVoice("story_v_out_426051", "426051170", "story_v_out_426051.awb")
				end

				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_11 = math.max(var_696_2, arg_693_1.talkMaxDuration)

			if var_696_1 <= arg_693_1.time_ and arg_693_1.time_ < var_696_1 + var_696_11 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_1) / var_696_11

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_1 + var_696_11 and arg_693_1.time_ < var_696_1 + var_696_11 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play426051171 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 426051171
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play426051172(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = arg_697_1.actors_["1012ui_story"].transform
			local var_700_1 = 0

			if var_700_1 < arg_697_1.time_ and arg_697_1.time_ <= var_700_1 + arg_700_0 then
				arg_697_1.var_.moveOldPos1012ui_story = var_700_0.localPosition
			end

			local var_700_2 = 0.001

			if var_700_1 <= arg_697_1.time_ and arg_697_1.time_ < var_700_1 + var_700_2 then
				local var_700_3 = (arg_697_1.time_ - var_700_1) / var_700_2
				local var_700_4 = Vector3.New(0, 100, 0)

				var_700_0.localPosition = Vector3.Lerp(arg_697_1.var_.moveOldPos1012ui_story, var_700_4, var_700_3)

				local var_700_5 = manager.ui.mainCamera.transform.position - var_700_0.position

				var_700_0.forward = Vector3.New(var_700_5.x, var_700_5.y, var_700_5.z)

				local var_700_6 = var_700_0.localEulerAngles

				var_700_6.z = 0
				var_700_6.x = 0
				var_700_0.localEulerAngles = var_700_6
			end

			if arg_697_1.time_ >= var_700_1 + var_700_2 and arg_697_1.time_ < var_700_1 + var_700_2 + arg_700_0 then
				var_700_0.localPosition = Vector3.New(0, 100, 0)

				local var_700_7 = manager.ui.mainCamera.transform.position - var_700_0.position

				var_700_0.forward = Vector3.New(var_700_7.x, var_700_7.y, var_700_7.z)

				local var_700_8 = var_700_0.localEulerAngles

				var_700_8.z = 0
				var_700_8.x = 0
				var_700_0.localEulerAngles = var_700_8
			end

			local var_700_9 = 0.034000001847744
			local var_700_10 = 1

			if var_700_9 < arg_697_1.time_ and arg_697_1.time_ <= var_700_9 + arg_700_0 then
				local var_700_11 = "play"
				local var_700_12 = "effect"

				arg_697_1:AudioAction(var_700_11, var_700_12, "se_story_131", "se_story_131__fallmetal", "")
			end

			local var_700_13 = 0.533333333333333
			local var_700_14 = 1

			if var_700_13 < arg_697_1.time_ and arg_697_1.time_ <= var_700_13 + arg_700_0 then
				local var_700_15 = "play"
				local var_700_16 = "effect"

				arg_697_1:AudioAction(var_700_15, var_700_16, "se_story_144", "se_story_144_door_open", "")
			end

			local var_700_17 = 0
			local var_700_18 = 0.3

			if var_700_17 < arg_697_1.time_ and arg_697_1.time_ <= var_700_17 + arg_700_0 then
				local var_700_19 = "play"
				local var_700_20 = "music"

				arg_697_1:AudioAction(var_700_19, var_700_20, "ui_battle", "ui_battle_stopbgm", "")

				local var_700_21 = ""
				local var_700_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_700_22 ~= "" then
					if arg_697_1.bgmTxt_.text ~= var_700_22 and arg_697_1.bgmTxt_.text ~= "" then
						if arg_697_1.bgmTxt2_.text ~= "" then
							arg_697_1.bgmTxt_.text = arg_697_1.bgmTxt2_.text
						end

						arg_697_1.bgmTxt2_.text = var_700_22

						arg_697_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_697_1.bgmTxt_.text = var_700_22
						arg_697_1.bgmTxt2_.text = var_700_22
					end

					if arg_697_1.bgmTimer then
						arg_697_1.bgmTimer:Stop()

						arg_697_1.bgmTimer = nil
					end

					if arg_697_1.settingData.show_music_name == 1 then
						arg_697_1.musicController:SetSelectedState("show")
						arg_697_1.musicAnimator_:Play("open", 0, 0)

						if arg_697_1.settingData.music_time ~= 0 then
							arg_697_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_697_1.settingData.music_time), function()
								if arg_697_1 == nil or isNil(arg_697_1.bgmTxt_) then
									return
								end

								arg_697_1.musicController:SetSelectedState("hide")
								arg_697_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_700_23 = 0
			local var_700_24 = 1.125

			if var_700_23 < arg_697_1.time_ and arg_697_1.time_ <= var_700_23 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, false)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_25 = arg_697_1:GetWordFromCfg(426051171)
				local var_700_26 = arg_697_1:FormatText(var_700_25.content)

				arg_697_1.text_.text = var_700_26

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_27 = 45
				local var_700_28 = utf8.len(var_700_26)
				local var_700_29 = var_700_27 <= 0 and var_700_24 or var_700_24 * (var_700_28 / var_700_27)

				if var_700_29 > 0 and var_700_24 < var_700_29 then
					arg_697_1.talkMaxDuration = var_700_29

					if var_700_29 + var_700_23 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_29 + var_700_23
					end
				end

				arg_697_1.text_.text = var_700_26
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_30 = math.max(var_700_24, arg_697_1.talkMaxDuration)

			if var_700_23 <= arg_697_1.time_ and arg_697_1.time_ < var_700_23 + var_700_30 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_23) / var_700_30

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_23 + var_700_30 and arg_697_1.time_ < var_700_23 + var_700_30 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_697_1:InitPlayNodeList()
	end,
	Play426051172 = function(arg_702_0, arg_702_1)
		arg_702_1.time_ = 0
		arg_702_1.frameCnt_ = 0
		arg_702_1.state_ = "playing"
		arg_702_1.curTalkId_ = 426051172
		arg_702_1.duration_ = 6.5

		SetActive(arg_702_1.tipsGo_, false)

		function arg_702_1.onSingleLineFinish_()
			arg_702_1.onSingleLineUpdate_ = nil
			arg_702_1.onSingleLineFinish_ = nil
			arg_702_1.state_ = "waiting"
		end

		function arg_702_1.playNext_(arg_704_0)
			if arg_704_0 == 1 then
				arg_702_0:Play426051173(arg_702_1)
			end
		end

		function arg_702_1.onSingleLineUpdate_(arg_705_0)
			local var_705_0 = 0.9

			if var_705_0 < arg_702_1.time_ and arg_702_1.time_ <= var_705_0 + arg_705_0 then
				local var_705_1 = manager.ui.mainCamera.transform.localPosition
				local var_705_2 = Vector3.New(0, 0, 10) + Vector3.New(var_705_1.x, var_705_1.y, 0)
				local var_705_3 = arg_702_1.bgs_.ST2007a

				var_705_3.transform.localPosition = var_705_2
				var_705_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_705_4 = var_705_3:GetComponent("SpriteRenderer")

				if var_705_4 and var_705_4.sprite then
					local var_705_5 = (var_705_3.transform.localPosition - var_705_1).z
					local var_705_6 = manager.ui.mainCameraCom_
					local var_705_7 = 2 * var_705_5 * Mathf.Tan(var_705_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_705_8 = var_705_7 * var_705_6.aspect
					local var_705_9 = var_705_4.sprite.bounds.size.x
					local var_705_10 = var_705_4.sprite.bounds.size.y
					local var_705_11 = var_705_8 / var_705_9
					local var_705_12 = var_705_7 / var_705_10
					local var_705_13 = var_705_12 < var_705_11 and var_705_11 or var_705_12

					var_705_3.transform.localScale = Vector3.New(var_705_13, var_705_13, 0)
				end

				for iter_705_0, iter_705_1 in pairs(arg_702_1.bgs_) do
					if iter_705_0 ~= "ST2007a" then
						iter_705_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_705_14 = 1.5

			if var_705_14 < arg_702_1.time_ and arg_702_1.time_ <= var_705_14 + arg_705_0 then
				arg_702_1.allBtn_.enabled = false
			end

			local var_705_15 = 0.3

			if arg_702_1.time_ >= var_705_14 + var_705_15 and arg_702_1.time_ < var_705_14 + var_705_15 + arg_705_0 then
				arg_702_1.allBtn_.enabled = true
			end

			local var_705_16 = manager.ui.mainCamera.transform
			local var_705_17 = 0.5

			if var_705_17 < arg_702_1.time_ and arg_702_1.time_ <= var_705_17 + arg_705_0 then
				local var_705_18 = arg_702_1.var_.effectkaideng1

				if var_705_18 then
					Object.Destroy(var_705_18)

					arg_702_1.var_.effectkaideng1 = nil
				end
			end

			local var_705_19 = manager.ui.mainCamera.transform
			local var_705_20 = 0

			if var_705_20 < arg_702_1.time_ and arg_702_1.time_ <= var_705_20 + arg_705_0 then
				local var_705_21 = arg_702_1.var_.effectkaimen1
				local var_705_22
				local var_705_23 = var_705_19

				if not var_705_21 then
					var_705_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_705_23)
					var_705_21.name = "kaimen1"
					arg_702_1.var_.effectkaimen1 = var_705_21
				else
					var_705_21.transform:SetParent(var_705_23)
				end

				var_705_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_705_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_705_24 = 0

			if var_705_24 < arg_702_1.time_ and arg_702_1.time_ <= var_705_24 + arg_705_0 then
				arg_702_1.allBtn_.enabled = false
			end

			local var_705_25 = 1.5

			if arg_702_1.time_ >= var_705_24 + var_705_25 and arg_702_1.time_ < var_705_24 + var_705_25 + arg_705_0 then
				arg_702_1.allBtn_.enabled = true
			end

			if arg_702_1.frameCnt_ <= 1 then
				arg_702_1.dialog_:SetActive(false)
			end

			local var_705_26 = 1.5
			local var_705_27 = 0.075

			if var_705_26 < arg_702_1.time_ and arg_702_1.time_ <= var_705_26 + arg_705_0 then
				arg_702_1.talkMaxDuration = 0

				arg_702_1.dialog_:SetActive(true)

				arg_702_1.dialogCg_.alpha = 0

				local var_705_28 = LeanTween.value(arg_702_1.dialog_, 0, 1, 0.3)

				var_705_28:setOnUpdate(LuaHelper.FloatAction(function(arg_706_0)
					arg_702_1.dialogCg_.alpha = arg_706_0
				end))
				var_705_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_702_1.dialog_)
					var_705_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_702_1.duration_ = arg_702_1.duration_ + 0.3

				SetActive(arg_702_1.leftNameGo_, true)

				local var_705_29 = arg_702_1:FormatText(StoryNameCfg[7].name)

				arg_702_1.leftNameTxt_.text = var_705_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_702_1.leftNameTxt_.transform)

				arg_702_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_702_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_702_1:RecordName(arg_702_1.leftNameTxt_.text)
				SetActive(arg_702_1.iconTrs_.gameObject, true)
				arg_702_1.iconController_:SetSelectedState("hero")

				arg_702_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_702_1.callingController_:SetSelectedState("normal")

				arg_702_1.keyicon_.color = Color.New(1, 1, 1)
				arg_702_1.icon_.color = Color.New(1, 1, 1)

				local var_705_30 = arg_702_1:GetWordFromCfg(426051172)
				local var_705_31 = arg_702_1:FormatText(var_705_30.content)

				arg_702_1.text_.text = var_705_31

				LuaForUtil.ClearLinePrefixSymbol(arg_702_1.text_)

				local var_705_32 = 3
				local var_705_33 = utf8.len(var_705_31)
				local var_705_34 = var_705_32 <= 0 and var_705_27 or var_705_27 * (var_705_33 / var_705_32)

				if var_705_34 > 0 and var_705_27 < var_705_34 then
					arg_702_1.talkMaxDuration = var_705_34
					var_705_26 = var_705_26 + 0.3

					if var_705_34 + var_705_26 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_34 + var_705_26
					end
				end

				arg_702_1.text_.text = var_705_31
				arg_702_1.typewritter.percent = 0

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(false)
				arg_702_1:RecordContent(arg_702_1.text_.text)
			end

			local var_705_35 = var_705_26 + 0.3
			local var_705_36 = math.max(var_705_27, arg_702_1.talkMaxDuration)

			if var_705_35 <= arg_702_1.time_ and arg_702_1.time_ < var_705_35 + var_705_36 then
				arg_702_1.typewritter.percent = (arg_702_1.time_ - var_705_35) / var_705_36

				arg_702_1.typewritter:SetDirty()
			end

			if arg_702_1.time_ >= var_705_35 + var_705_36 and arg_702_1.time_ < var_705_35 + var_705_36 + arg_705_0 then
				arg_702_1.typewritter.percent = 1

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(true)
			end
		end

		arg_702_1.nodeConfigList_ = {}

		arg_702_1:InitPlayNodeList()
	end,
	Play426051173 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 426051173
		arg_708_1.duration_ = 5

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play426051174(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			local var_711_0 = 0
			local var_711_1 = 1.275

			if var_711_0 < arg_708_1.time_ and arg_708_1.time_ <= var_711_0 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0
				arg_708_1.dialogCg_.alpha = 1

				arg_708_1.dialog_:SetActive(true)
				SetActive(arg_708_1.leftNameGo_, false)

				arg_708_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_708_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_708_1:RecordName(arg_708_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_708_1.iconTrs_.gameObject, false)
				arg_708_1.callingController_:SetSelectedState("normal")

				local var_711_2 = arg_708_1:GetWordFromCfg(426051173)
				local var_711_3 = arg_708_1:FormatText(var_711_2.content)

				arg_708_1.text_.text = var_711_3

				LuaForUtil.ClearLinePrefixSymbol(arg_708_1.text_)

				local var_711_4 = 51
				local var_711_5 = utf8.len(var_711_3)
				local var_711_6 = var_711_4 <= 0 and var_711_1 or var_711_1 * (var_711_5 / var_711_4)

				if var_711_6 > 0 and var_711_1 < var_711_6 then
					arg_708_1.talkMaxDuration = var_711_6

					if var_711_6 + var_711_0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_6 + var_711_0
					end
				end

				arg_708_1.text_.text = var_711_3
				arg_708_1.typewritter.percent = 0

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(false)
				arg_708_1:RecordContent(arg_708_1.text_.text)
			end

			local var_711_7 = math.max(var_711_1, arg_708_1.talkMaxDuration)

			if var_711_0 <= arg_708_1.time_ and arg_708_1.time_ < var_711_0 + var_711_7 then
				arg_708_1.typewritter.percent = (arg_708_1.time_ - var_711_0) / var_711_7

				arg_708_1.typewritter:SetDirty()
			end

			if arg_708_1.time_ >= var_711_0 + var_711_7 and arg_708_1.time_ < var_711_0 + var_711_7 + arg_711_0 then
				arg_708_1.typewritter.percent = 1

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(true)
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play426051174 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 426051174
		arg_712_1.duration_ = 5

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play426051175(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = 0
			local var_715_1 = 0.1

			if var_715_0 < arg_712_1.time_ and arg_712_1.time_ <= var_715_0 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, true)

				local var_715_2 = arg_712_1:FormatText(StoryNameCfg[7].name)

				arg_712_1.leftNameTxt_.text = var_715_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_712_1.leftNameTxt_.transform)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1.leftNameTxt_.text)
				SetActive(arg_712_1.iconTrs_.gameObject, true)
				arg_712_1.iconController_:SetSelectedState("hero")

				arg_712_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_712_1.callingController_:SetSelectedState("normal")

				arg_712_1.keyicon_.color = Color.New(1, 1, 1)
				arg_712_1.icon_.color = Color.New(1, 1, 1)

				local var_715_3 = arg_712_1:GetWordFromCfg(426051174)
				local var_715_4 = arg_712_1:FormatText(var_715_3.content)

				arg_712_1.text_.text = var_715_4

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_5 = 4
				local var_715_6 = utf8.len(var_715_4)
				local var_715_7 = var_715_5 <= 0 and var_715_1 or var_715_1 * (var_715_6 / var_715_5)

				if var_715_7 > 0 and var_715_1 < var_715_7 then
					arg_712_1.talkMaxDuration = var_715_7

					if var_715_7 + var_715_0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_7 + var_715_0
					end
				end

				arg_712_1.text_.text = var_715_4
				arg_712_1.typewritter.percent = 0

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(false)
				arg_712_1:RecordContent(arg_712_1.text_.text)
			end

			local var_715_8 = math.max(var_715_1, arg_712_1.talkMaxDuration)

			if var_715_0 <= arg_712_1.time_ and arg_712_1.time_ < var_715_0 + var_715_8 then
				arg_712_1.typewritter.percent = (arg_712_1.time_ - var_715_0) / var_715_8

				arg_712_1.typewritter:SetDirty()
			end

			if arg_712_1.time_ >= var_715_0 + var_715_8 and arg_712_1.time_ < var_715_0 + var_715_8 + arg_715_0 then
				arg_712_1.typewritter.percent = 1

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(true)
			end
		end

		arg_712_1.nodeConfigList_ = {}

		arg_712_1:InitPlayNodeList()
	end,
	Play426051175 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 426051175
		arg_716_1.duration_ = 5

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
			arg_716_1.auto_ = false
		end

		function arg_716_1.playNext_(arg_718_0)
			arg_716_1.onStoryFinished_()
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			local var_719_0 = 0
			local var_719_1 = 1.3

			if var_719_0 < arg_716_1.time_ and arg_716_1.time_ <= var_719_0 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0
				arg_716_1.dialogCg_.alpha = 1

				arg_716_1.dialog_:SetActive(true)
				SetActive(arg_716_1.leftNameGo_, false)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_716_1.iconTrs_.gameObject, false)
				arg_716_1.callingController_:SetSelectedState("normal")

				local var_719_2 = arg_716_1:GetWordFromCfg(426051175)
				local var_719_3 = arg_716_1:FormatText(var_719_2.content)

				arg_716_1.text_.text = var_719_3

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_4 = 52
				local var_719_5 = utf8.len(var_719_3)
				local var_719_6 = var_719_4 <= 0 and var_719_1 or var_719_1 * (var_719_5 / var_719_4)

				if var_719_6 > 0 and var_719_1 < var_719_6 then
					arg_716_1.talkMaxDuration = var_719_6

					if var_719_6 + var_719_0 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_6 + var_719_0
					end
				end

				arg_716_1.text_.text = var_719_3
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)
				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_7 = math.max(var_719_1, arg_716_1.talkMaxDuration)

			if var_719_0 <= arg_716_1.time_ and arg_716_1.time_ < var_719_0 + var_719_7 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - var_719_0) / var_719_7

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= var_719_0 + var_719_7 and arg_716_1.time_ < var_719_0 + var_719_7 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2007a",
		"TextureConfig/Background/ST2012"
	},
	voices = {
		"story_v_out_426051.awb"
	}
}
