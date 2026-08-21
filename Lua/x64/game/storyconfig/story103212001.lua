return {
	Play321201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321201001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L15f"

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
				local var_4_5 = arg_1_1.bgs_.L15f

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
					if iter_4_0 ~= "L15f" then
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
			local var_4_25 = 0.2

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

			local var_4_30 = 0.3
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 2
			local var_4_37 = 1.075

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(321201001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 43
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_37 or var_4_37 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_37 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_36 = var_4_36 + 0.3

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_36 + 0.3
			local var_4_45 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321201002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321201002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321201003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.233333333333333
			local var_12_1 = 1

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_140", "se_story_140_rock4", "")
			end

			local var_12_4 = 0
			local var_12_5 = 1.625

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

				local var_12_6 = arg_9_1:GetWordFromCfg(321201002)
				local var_12_7 = arg_9_1:FormatText(var_12_6.content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 65
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
	Play321201003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321201003
		arg_13_1.duration_ = 3.27

		local var_13_0 = {
			zh = 2.766,
			ja = 3.266
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
				arg_13_0:Play321201004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "404001ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["404001ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos404001ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(-0.8, -1.55, -5.5)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos404001ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["404001ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect404001ui_story == nil then
				arg_13_1.var_.characterEffect404001ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect404001ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect404001ui_story then
				arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_20 = 0
			local var_16_21 = 0.225

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[668].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(321201003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201003", "story_v_out_321201.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_321201", "321201003", "story_v_out_321201.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_321201", "321201003", "story_v_out_321201.awb")

						arg_13_1:RecordAudio("321201003", var_16_29)
						arg_13_1:RecordAudio("321201003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321201", "321201003", "story_v_out_321201.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321201", "321201003", "story_v_out_321201.awb")
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
				actorName = "404001ui_story",
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
	Play321201004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321201004
		arg_17_1.duration_ = 3.47

		local var_17_0 = {
			zh = 3.4,
			ja = 3.466
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321201005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1011ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1011ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1011ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0.7, -0.71, -6)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1011ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1011ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1011ui_story == nil then
				arg_17_1.var_.characterEffect1011ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1011ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1011ui_story then
				arg_17_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_20_18 = arg_17_1.actors_["404001ui_story"]
			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 and not isNil(var_20_18) and arg_17_1.var_.characterEffect404001ui_story == nil then
				arg_17_1.var_.characterEffect404001ui_story = var_20_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_20 = 0.200000002980232

			if var_20_19 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_20 and not isNil(var_20_18) then
				local var_20_21 = (arg_17_1.time_ - var_20_19) / var_20_20

				if arg_17_1.var_.characterEffect404001ui_story and not isNil(var_20_18) then
					local var_20_22 = Mathf.Lerp(0, 0.5, var_20_21)

					arg_17_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_17_1.var_.characterEffect404001ui_story.fillRatio = var_20_22
				end
			end

			if arg_17_1.time_ >= var_20_19 + var_20_20 and arg_17_1.time_ < var_20_19 + var_20_20 + arg_20_0 and not isNil(var_20_18) and arg_17_1.var_.characterEffect404001ui_story then
				local var_20_23 = 0.5

				arg_17_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_17_1.var_.characterEffect404001ui_story.fillRatio = var_20_23
			end

			local var_20_24 = 0

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 then
				arg_17_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_20_25 = 0

			if var_20_25 < arg_17_1.time_ and arg_17_1.time_ <= var_20_25 + arg_20_0 then
				arg_17_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_26 = 0
			local var_20_27 = 0.3

			if var_20_26 < arg_17_1.time_ and arg_17_1.time_ <= var_20_26 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_28 = arg_17_1:FormatText(StoryNameCfg[37].name)

				arg_17_1.leftNameTxt_.text = var_20_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_29 = arg_17_1:GetWordFromCfg(321201004)
				local var_20_30 = arg_17_1:FormatText(var_20_29.content)

				arg_17_1.text_.text = var_20_30

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_31 = 12
				local var_20_32 = utf8.len(var_20_30)
				local var_20_33 = var_20_31 <= 0 and var_20_27 or var_20_27 * (var_20_32 / var_20_31)

				if var_20_33 > 0 and var_20_27 < var_20_33 then
					arg_17_1.talkMaxDuration = var_20_33

					if var_20_33 + var_20_26 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_33 + var_20_26
					end
				end

				arg_17_1.text_.text = var_20_30
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201004", "story_v_out_321201.awb") ~= 0 then
					local var_20_34 = manager.audio:GetVoiceLength("story_v_out_321201", "321201004", "story_v_out_321201.awb") / 1000

					if var_20_34 + var_20_26 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_34 + var_20_26
					end

					if var_20_29.prefab_name ~= "" and arg_17_1.actors_[var_20_29.prefab_name] ~= nil then
						local var_20_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_29.prefab_name].transform, "story_v_out_321201", "321201004", "story_v_out_321201.awb")

						arg_17_1:RecordAudio("321201004", var_20_35)
						arg_17_1:RecordAudio("321201004", var_20_35)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321201", "321201004", "story_v_out_321201.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321201", "321201004", "story_v_out_321201.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_36 = math.max(var_20_27, arg_17_1.talkMaxDuration)

			if var_20_26 <= arg_17_1.time_ and arg_17_1.time_ < var_20_26 + var_20_36 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_26) / var_20_36

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_26 + var_20_36 and arg_17_1.time_ < var_20_26 + var_20_36 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play321201005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321201005
		arg_21_1.duration_ = 4.5

		local var_21_0 = {
			zh = 3.133,
			ja = 4.5
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
				arg_21_0:Play321201006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1011ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1011ui_story == nil then
				arg_21_1.var_.characterEffect1011ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1011ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1011ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1011ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1011ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.35

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[1182].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_9 = arg_21_1:GetWordFromCfg(321201005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 14
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201005", "story_v_out_321201.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_321201", "321201005", "story_v_out_321201.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_out_321201", "321201005", "story_v_out_321201.awb")

						arg_21_1:RecordAudio("321201005", var_24_15)
						arg_21_1:RecordAudio("321201005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321201", "321201005", "story_v_out_321201.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321201", "321201005", "story_v_out_321201.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_16 and arg_21_1.time_ < var_24_6 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321201006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321201006
		arg_25_1.duration_ = 9.2

		local var_25_0 = {
			zh = 8.3,
			ja = 9.2
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
				arg_25_0:Play321201007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["404001ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect404001ui_story == nil then
				arg_25_1.var_.characterEffect404001ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect404001ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect404001ui_story then
				arg_25_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_6 = 0
			local var_28_7 = 1

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[668].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(321201006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201006", "story_v_out_321201.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_321201", "321201006", "story_v_out_321201.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_321201", "321201006", "story_v_out_321201.awb")

						arg_25_1:RecordAudio("321201006", var_28_15)
						arg_25_1:RecordAudio("321201006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321201", "321201006", "story_v_out_321201.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321201", "321201006", "story_v_out_321201.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321201007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321201007
		arg_29_1.duration_ = 8.5

		local var_29_0 = {
			zh = 5.366,
			ja = 8.5
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
				arg_29_0:Play321201008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["404001ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos404001ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos404001ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_32_11 = 0
			local var_32_12 = 0.625

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[668].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(321201007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 25
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201007", "story_v_out_321201.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_321201", "321201007", "story_v_out_321201.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_321201", "321201007", "story_v_out_321201.awb")

						arg_29_1:RecordAudio("321201007", var_32_20)
						arg_29_1:RecordAudio("321201007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321201", "321201007", "story_v_out_321201.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321201", "321201007", "story_v_out_321201.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321201008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321201008
		arg_33_1.duration_ = 3.5

		local var_33_0 = {
			zh = 3.5,
			ja = 3.3
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
				arg_33_0:Play321201009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["404001ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect404001ui_story == nil then
				arg_33_1.var_.characterEffect404001ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect404001ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_33_1.var_.characterEffect404001ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect404001ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_33_1.var_.characterEffect404001ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.275

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[1180].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(321201008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201008", "story_v_out_321201.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_321201", "321201008", "story_v_out_321201.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_321201", "321201008", "story_v_out_321201.awb")

						arg_33_1:RecordAudio("321201008", var_36_15)
						arg_33_1:RecordAudio("321201008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321201", "321201008", "story_v_out_321201.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321201", "321201008", "story_v_out_321201.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play321201009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321201009
		arg_37_1.duration_ = 5.63

		local var_37_0 = {
			zh = 4.333,
			ja = 5.633
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
				arg_37_0:Play321201010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["404001ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos404001ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos404001ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["404001ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect404001ui_story == nil then
				arg_37_1.var_.characterEffect404001ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect404001ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect404001ui_story then
				arg_37_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_15 = 0
			local var_40_16 = 0.65

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[668].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(321201009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 26
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201009", "story_v_out_321201.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_321201", "321201009", "story_v_out_321201.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_321201", "321201009", "story_v_out_321201.awb")

						arg_37_1:RecordAudio("321201009", var_40_24)
						arg_37_1:RecordAudio("321201009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321201", "321201009", "story_v_out_321201.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321201", "321201009", "story_v_out_321201.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play321201010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321201010
		arg_41_1.duration_ = 7.3

		local var_41_0 = {
			zh = 4.566,
			ja = 7.3
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
				arg_41_0:Play321201011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["404001ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect404001ui_story == nil then
				arg_41_1.var_.characterEffect404001ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect404001ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_41_1.var_.characterEffect404001ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect404001ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_41_1.var_.characterEffect404001ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.575

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[1180].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(321201010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201010", "story_v_out_321201.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_321201", "321201010", "story_v_out_321201.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_321201", "321201010", "story_v_out_321201.awb")

						arg_41_1:RecordAudio("321201010", var_44_15)
						arg_41_1:RecordAudio("321201010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321201", "321201010", "story_v_out_321201.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321201", "321201010", "story_v_out_321201.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_16 and arg_41_1.time_ < var_44_6 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play321201011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321201011
		arg_45_1.duration_ = 3.07

		local var_45_0 = {
			zh = 1.4,
			ja = 3.066
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
				arg_45_0:Play321201012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.15

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1182].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(321201011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201011", "story_v_out_321201.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201011", "story_v_out_321201.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_321201", "321201011", "story_v_out_321201.awb")

						arg_45_1:RecordAudio("321201011", var_48_9)
						arg_45_1:RecordAudio("321201011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321201", "321201011", "story_v_out_321201.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321201", "321201011", "story_v_out_321201.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play321201012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321201012
		arg_49_1.duration_ = 3.1

		local var_49_0 = {
			zh = 3.1,
			ja = 2.6
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
				arg_49_0:Play321201013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.25

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[1180].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(321201012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 10
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201012", "story_v_out_321201.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201012", "story_v_out_321201.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_321201", "321201012", "story_v_out_321201.awb")

						arg_49_1:RecordAudio("321201012", var_52_9)
						arg_49_1:RecordAudio("321201012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321201", "321201012", "story_v_out_321201.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321201", "321201012", "story_v_out_321201.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play321201013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321201013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play321201014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.125

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(321201013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 45
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play321201014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321201014
		arg_57_1.duration_ = 6.7

		local var_57_0 = {
			zh = 6.7,
			ja = 5.766
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
				arg_57_0:Play321201015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1011ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1011ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0.7, -0.71, -6)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1011ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["1011ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1011ui_story == nil then
				arg_57_1.var_.characterEffect1011ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect1011ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1011ui_story then
				arg_57_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_60_15 = 0
			local var_60_16 = 0.725

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[37].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(321201014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 29
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201014", "story_v_out_321201.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_321201", "321201014", "story_v_out_321201.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_321201", "321201014", "story_v_out_321201.awb")

						arg_57_1:RecordAudio("321201014", var_60_24)
						arg_57_1:RecordAudio("321201014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_321201", "321201014", "story_v_out_321201.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_321201", "321201014", "story_v_out_321201.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play321201015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321201015
		arg_61_1.duration_ = 3.87

		local var_61_0 = {
			zh = 3.1,
			ja = 3.866
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
				arg_61_0:Play321201016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1011ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1011ui_story == nil then
				arg_61_1.var_.characterEffect1011ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1011ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1011ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1011ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1011ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0
			local var_64_7 = 0.3

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[1180].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_9 = arg_61_1:GetWordFromCfg(321201015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 12
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201015", "story_v_out_321201.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_321201", "321201015", "story_v_out_321201.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_out_321201", "321201015", "story_v_out_321201.awb")

						arg_61_1:RecordAudio("321201015", var_64_15)
						arg_61_1:RecordAudio("321201015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321201", "321201015", "story_v_out_321201.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321201", "321201015", "story_v_out_321201.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play321201016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321201016
		arg_65_1.duration_ = 9

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play321201017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 2

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				local var_68_1 = manager.ui.mainCamera.transform.localPosition
				local var_68_2 = Vector3.New(0, 0, 10) + Vector3.New(var_68_1.x, var_68_1.y, 0)
				local var_68_3 = arg_65_1.bgs_.L15f

				var_68_3.transform.localPosition = var_68_2
				var_68_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_4 = var_68_3:GetComponent("SpriteRenderer")

				if var_68_4 and var_68_4.sprite then
					local var_68_5 = (var_68_3.transform.localPosition - var_68_1).z
					local var_68_6 = manager.ui.mainCameraCom_
					local var_68_7 = 2 * var_68_5 * Mathf.Tan(var_68_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_68_8 = var_68_7 * var_68_6.aspect
					local var_68_9 = var_68_4.sprite.bounds.size.x
					local var_68_10 = var_68_4.sprite.bounds.size.y
					local var_68_11 = var_68_8 / var_68_9
					local var_68_12 = var_68_7 / var_68_10
					local var_68_13 = var_68_12 < var_68_11 and var_68_11 or var_68_12

					var_68_3.transform.localScale = Vector3.New(var_68_13, var_68_13, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "L15f" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_14 = 3.999999999999

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			local var_68_15 = 0.3

			if arg_65_1.time_ >= var_68_14 + var_68_15 and arg_65_1.time_ < var_68_14 + var_68_15 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_17 = 2

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17
				local var_68_19 = Color.New(0, 0, 0)

				var_68_19.a = Mathf.Lerp(0, 1, var_68_18)
				arg_65_1.mask_.color = var_68_19
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 then
				local var_68_20 = Color.New(0, 0, 0)

				var_68_20.a = 1
				arg_65_1.mask_.color = var_68_20
			end

			local var_68_21 = 2

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_22 = 2

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_22 then
				local var_68_23 = (arg_65_1.time_ - var_68_21) / var_68_22
				local var_68_24 = Color.New(0, 0, 0)

				var_68_24.a = Mathf.Lerp(1, 0, var_68_23)
				arg_65_1.mask_.color = var_68_24
			end

			if arg_65_1.time_ >= var_68_21 + var_68_22 and arg_65_1.time_ < var_68_21 + var_68_22 + arg_68_0 then
				local var_68_25 = Color.New(0, 0, 0)
				local var_68_26 = 0

				arg_65_1.mask_.enabled = false
				var_68_25.a = var_68_26
				arg_65_1.mask_.color = var_68_25
			end

			local var_68_27 = arg_65_1.actors_["1011ui_story"].transform
			local var_68_28 = 1.96599999815226

			if var_68_28 < arg_65_1.time_ and arg_65_1.time_ <= var_68_28 + arg_68_0 then
				arg_65_1.var_.moveOldPos1011ui_story = var_68_27.localPosition
			end

			local var_68_29 = 0.001

			if var_68_28 <= arg_65_1.time_ and arg_65_1.time_ < var_68_28 + var_68_29 then
				local var_68_30 = (arg_65_1.time_ - var_68_28) / var_68_29
				local var_68_31 = Vector3.New(0, 100, 0)

				var_68_27.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1011ui_story, var_68_31, var_68_30)

				local var_68_32 = manager.ui.mainCamera.transform.position - var_68_27.position

				var_68_27.forward = Vector3.New(var_68_32.x, var_68_32.y, var_68_32.z)

				local var_68_33 = var_68_27.localEulerAngles

				var_68_33.z = 0
				var_68_33.x = 0
				var_68_27.localEulerAngles = var_68_33
			end

			if arg_65_1.time_ >= var_68_28 + var_68_29 and arg_65_1.time_ < var_68_28 + var_68_29 + arg_68_0 then
				var_68_27.localPosition = Vector3.New(0, 100, 0)

				local var_68_34 = manager.ui.mainCamera.transform.position - var_68_27.position

				var_68_27.forward = Vector3.New(var_68_34.x, var_68_34.y, var_68_34.z)

				local var_68_35 = var_68_27.localEulerAngles

				var_68_35.z = 0
				var_68_35.x = 0
				var_68_27.localEulerAngles = var_68_35
			end

			local var_68_36 = arg_65_1.actors_["404001ui_story"].transform
			local var_68_37 = 1.96599999815226

			if var_68_37 < arg_65_1.time_ and arg_65_1.time_ <= var_68_37 + arg_68_0 then
				arg_65_1.var_.moveOldPos404001ui_story = var_68_36.localPosition
			end

			local var_68_38 = 0.001

			if var_68_37 <= arg_65_1.time_ and arg_65_1.time_ < var_68_37 + var_68_38 then
				local var_68_39 = (arg_65_1.time_ - var_68_37) / var_68_38
				local var_68_40 = Vector3.New(0, 100, 0)

				var_68_36.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos404001ui_story, var_68_40, var_68_39)

				local var_68_41 = manager.ui.mainCamera.transform.position - var_68_36.position

				var_68_36.forward = Vector3.New(var_68_41.x, var_68_41.y, var_68_41.z)

				local var_68_42 = var_68_36.localEulerAngles

				var_68_42.z = 0
				var_68_42.x = 0
				var_68_36.localEulerAngles = var_68_42
			end

			if arg_65_1.time_ >= var_68_37 + var_68_38 and arg_65_1.time_ < var_68_37 + var_68_38 + arg_68_0 then
				var_68_36.localPosition = Vector3.New(0, 100, 0)

				local var_68_43 = manager.ui.mainCamera.transform.position - var_68_36.position

				var_68_36.forward = Vector3.New(var_68_43.x, var_68_43.y, var_68_43.z)

				local var_68_44 = var_68_36.localEulerAngles

				var_68_44.z = 0
				var_68_44.x = 0
				var_68_36.localEulerAngles = var_68_44
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_45 = 4
			local var_68_46 = 1.35

			if var_68_45 < arg_65_1.time_ and arg_65_1.time_ <= var_68_45 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_47 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_47:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_48 = arg_65_1:GetWordFromCfg(321201016)
				local var_68_49 = arg_65_1:FormatText(var_68_48.content)

				arg_65_1.text_.text = var_68_49

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_50 = 54
				local var_68_51 = utf8.len(var_68_49)
				local var_68_52 = var_68_50 <= 0 and var_68_46 or var_68_46 * (var_68_51 / var_68_50)

				if var_68_52 > 0 and var_68_46 < var_68_52 then
					arg_65_1.talkMaxDuration = var_68_52
					var_68_45 = var_68_45 + 0.3

					if var_68_52 + var_68_45 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_52 + var_68_45
					end
				end

				arg_65_1.text_.text = var_68_49
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_53 = var_68_45 + 0.3
			local var_68_54 = math.max(var_68_46, arg_65_1.talkMaxDuration)

			if var_68_53 <= arg_65_1.time_ and arg_65_1.time_ < var_68_53 + var_68_54 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_53) / var_68_54

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_53 + var_68_54 and arg_65_1.time_ < var_68_53 + var_68_54 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play321201017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321201017
		arg_71_1.duration_ = 7.03

		local var_71_0 = {
			zh = 7.033,
			ja = 2.733
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
				arg_71_0:Play321201018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.225

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[1183].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(321201017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 9
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201017", "story_v_out_321201.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201017", "story_v_out_321201.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_321201", "321201017", "story_v_out_321201.awb")

						arg_71_1:RecordAudio("321201017", var_74_9)
						arg_71_1:RecordAudio("321201017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_321201", "321201017", "story_v_out_321201.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_321201", "321201017", "story_v_out_321201.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play321201018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321201018
		arg_75_1.duration_ = 7.87

		local var_75_0 = {
			zh = 5.333,
			ja = 7.866
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
				arg_75_0:Play321201019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "2079ui_story"

			if arg_75_1.actors_[var_78_0] == nil then
				local var_78_1 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_78_1) then
					local var_78_2 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_75_1.stage_.transform)

					var_78_2.name = var_78_0
					var_78_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_75_1.actors_[var_78_0] = var_78_2

					local var_78_3 = var_78_2:GetComponentInChildren(typeof(CharacterEffect))

					var_78_3.enabled = true

					local var_78_4 = GameObjectTools.GetOrAddComponent(var_78_2, typeof(DynamicBoneHelper))

					if var_78_4 then
						var_78_4:EnableDynamicBone(false)
					end

					arg_75_1:ShowWeapon(var_78_3.transform, false)

					arg_75_1.var_[var_78_0 .. "Animator"] = var_78_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_75_1.var_[var_78_0 .. "Animator"].applyRootMotion = true
					arg_75_1.var_[var_78_0 .. "LipSync"] = var_78_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_78_5 = arg_75_1.actors_["2079ui_story"]
			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect2079ui_story == nil then
				arg_75_1.var_.characterEffect2079ui_story = var_78_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_7 = 0.2

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_7 and not isNil(var_78_5) then
				local var_78_8 = (arg_75_1.time_ - var_78_6) / var_78_7

				if arg_75_1.var_.characterEffect2079ui_story and not isNil(var_78_5) then
					local var_78_9 = Mathf.Lerp(0, 0.5, var_78_8)

					arg_75_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_75_1.var_.characterEffect2079ui_story.fillRatio = var_78_9
				end
			end

			if arg_75_1.time_ >= var_78_6 + var_78_7 and arg_75_1.time_ < var_78_6 + var_78_7 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect2079ui_story then
				local var_78_10 = 0.5

				arg_75_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_75_1.var_.characterEffect2079ui_story.fillRatio = var_78_10
			end

			local var_78_11 = 0
			local var_78_12 = 0.625

			if var_78_11 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_13 = arg_75_1:FormatText(StoryNameCfg[1182].name)

				arg_75_1.leftNameTxt_.text = var_78_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_14 = arg_75_1:GetWordFromCfg(321201018)
				local var_78_15 = arg_75_1:FormatText(var_78_14.content)

				arg_75_1.text_.text = var_78_15

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_16 = 25
				local var_78_17 = utf8.len(var_78_15)
				local var_78_18 = var_78_16 <= 0 and var_78_12 or var_78_12 * (var_78_17 / var_78_16)

				if var_78_18 > 0 and var_78_12 < var_78_18 then
					arg_75_1.talkMaxDuration = var_78_18

					if var_78_18 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_18 + var_78_11
					end
				end

				arg_75_1.text_.text = var_78_15
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201018", "story_v_out_321201.awb") ~= 0 then
					local var_78_19 = manager.audio:GetVoiceLength("story_v_out_321201", "321201018", "story_v_out_321201.awb") / 1000

					if var_78_19 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_19 + var_78_11
					end

					if var_78_14.prefab_name ~= "" and arg_75_1.actors_[var_78_14.prefab_name] ~= nil then
						local var_78_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_14.prefab_name].transform, "story_v_out_321201", "321201018", "story_v_out_321201.awb")

						arg_75_1:RecordAudio("321201018", var_78_20)
						arg_75_1:RecordAudio("321201018", var_78_20)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_321201", "321201018", "story_v_out_321201.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_321201", "321201018", "story_v_out_321201.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_21 = math.max(var_78_12, arg_75_1.talkMaxDuration)

			if var_78_11 <= arg_75_1.time_ and arg_75_1.time_ < var_78_11 + var_78_21 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_11) / var_78_21

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_11 + var_78_21 and arg_75_1.time_ < var_78_11 + var_78_21 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play321201019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321201019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play321201020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["2079ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos2079ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0, 100, 0)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos2079ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, 100, 0)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = 0
			local var_82_10 = 1.075

			if var_82_9 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_11 = arg_79_1:GetWordFromCfg(321201019)
				local var_82_12 = arg_79_1:FormatText(var_82_11.content)

				arg_79_1.text_.text = var_82_12

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 43
				local var_82_14 = utf8.len(var_82_12)
				local var_82_15 = var_82_13 <= 0 and var_82_10 or var_82_10 * (var_82_14 / var_82_13)

				if var_82_15 > 0 and var_82_10 < var_82_15 then
					arg_79_1.talkMaxDuration = var_82_15

					if var_82_15 + var_82_9 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_15 + var_82_9
					end
				end

				arg_79_1.text_.text = var_82_12
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_10, arg_79_1.talkMaxDuration)

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_9) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_9 + var_82_16 and arg_79_1.time_ < var_82_9 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play321201020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321201020
		arg_83_1.duration_ = 5.43

		local var_83_0 = {
			zh = 5.433,
			ja = 3.666
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321201021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["2079ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos2079ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, -1.28, -5.6)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos2079ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = 0

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 then
				arg_83_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_86_11 = arg_83_1.actors_["2079ui_story"]
			local var_86_12 = 0

			if var_86_12 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 and not isNil(var_86_11) and arg_83_1.var_.characterEffect2079ui_story == nil then
				arg_83_1.var_.characterEffect2079ui_story = var_86_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_13 = 0.2

			if var_86_12 <= arg_83_1.time_ and arg_83_1.time_ < var_86_12 + var_86_13 and not isNil(var_86_11) then
				local var_86_14 = (arg_83_1.time_ - var_86_12) / var_86_13

				if arg_83_1.var_.characterEffect2079ui_story and not isNil(var_86_11) then
					arg_83_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_12 + var_86_13 and arg_83_1.time_ < var_86_12 + var_86_13 + arg_86_0 and not isNil(var_86_11) and arg_83_1.var_.characterEffect2079ui_story then
				arg_83_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_86_15 = 0
			local var_86_16 = 0.225

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_17 = arg_83_1:FormatText(StoryNameCfg[1184].name)

				arg_83_1.leftNameTxt_.text = var_86_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_18 = arg_83_1:GetWordFromCfg(321201020)
				local var_86_19 = arg_83_1:FormatText(var_86_18.content)

				arg_83_1.text_.text = var_86_19

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_20 = 9
				local var_86_21 = utf8.len(var_86_19)
				local var_86_22 = var_86_20 <= 0 and var_86_16 or var_86_16 * (var_86_21 / var_86_20)

				if var_86_22 > 0 and var_86_16 < var_86_22 then
					arg_83_1.talkMaxDuration = var_86_22

					if var_86_22 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_22 + var_86_15
					end
				end

				arg_83_1.text_.text = var_86_19
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201020", "story_v_out_321201.awb") ~= 0 then
					local var_86_23 = manager.audio:GetVoiceLength("story_v_out_321201", "321201020", "story_v_out_321201.awb") / 1000

					if var_86_23 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_23 + var_86_15
					end

					if var_86_18.prefab_name ~= "" and arg_83_1.actors_[var_86_18.prefab_name] ~= nil then
						local var_86_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_18.prefab_name].transform, "story_v_out_321201", "321201020", "story_v_out_321201.awb")

						arg_83_1:RecordAudio("321201020", var_86_24)
						arg_83_1:RecordAudio("321201020", var_86_24)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_321201", "321201020", "story_v_out_321201.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_321201", "321201020", "story_v_out_321201.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_25 = math.max(var_86_16, arg_83_1.talkMaxDuration)

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_25 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_15) / var_86_25

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_15 + var_86_25 and arg_83_1.time_ < var_86_15 + var_86_25 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play321201021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321201021
		arg_87_1.duration_ = 14.53

		local var_87_0 = {
			zh = 13,
			ja = 14.533
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321201022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.05

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[1184].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(321201021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 42
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201021", "story_v_out_321201.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201021", "story_v_out_321201.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_321201", "321201021", "story_v_out_321201.awb")

						arg_87_1:RecordAudio("321201021", var_90_9)
						arg_87_1:RecordAudio("321201021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_321201", "321201021", "story_v_out_321201.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_321201", "321201021", "story_v_out_321201.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play321201022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321201022
		arg_91_1.duration_ = 4.17

		local var_91_0 = {
			zh = 3.1,
			ja = 4.166
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play321201023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["2079ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect2079ui_story == nil then
				arg_91_1.var_.characterEffect2079ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.2

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect2079ui_story and not isNil(var_94_0) then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_91_1.var_.characterEffect2079ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect2079ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_91_1.var_.characterEffect2079ui_story.fillRatio = var_94_5
			end

			local var_94_6 = 0
			local var_94_7 = 0.375

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_8 = arg_91_1:FormatText(StoryNameCfg[1182].name)

				arg_91_1.leftNameTxt_.text = var_94_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_9 = arg_91_1:GetWordFromCfg(321201022)
				local var_94_10 = arg_91_1:FormatText(var_94_9.content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 15
				local var_94_12 = utf8.len(var_94_10)
				local var_94_13 = var_94_11 <= 0 and var_94_7 or var_94_7 * (var_94_12 / var_94_11)

				if var_94_13 > 0 and var_94_7 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201022", "story_v_out_321201.awb") ~= 0 then
					local var_94_14 = manager.audio:GetVoiceLength("story_v_out_321201", "321201022", "story_v_out_321201.awb") / 1000

					if var_94_14 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_6
					end

					if var_94_9.prefab_name ~= "" and arg_91_1.actors_[var_94_9.prefab_name] ~= nil then
						local var_94_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_9.prefab_name].transform, "story_v_out_321201", "321201022", "story_v_out_321201.awb")

						arg_91_1:RecordAudio("321201022", var_94_15)
						arg_91_1:RecordAudio("321201022", var_94_15)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_321201", "321201022", "story_v_out_321201.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_321201", "321201022", "story_v_out_321201.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_16 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_16

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_16 and arg_91_1.time_ < var_94_6 + var_94_16 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play321201023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321201023
		arg_95_1.duration_ = 3.37

		local var_95_0 = {
			zh = 3.366,
			ja = 3.033
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play321201024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["2079ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect2079ui_story == nil then
				arg_95_1.var_.characterEffect2079ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect2079ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect2079ui_story then
				arg_95_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_98_4 = 0
			local var_98_5 = 0.25

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_6 = arg_95_1:FormatText(StoryNameCfg[1184].name)

				arg_95_1.leftNameTxt_.text = var_98_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:GetWordFromCfg(321201023)
				local var_98_8 = arg_95_1:FormatText(var_98_7.content)

				arg_95_1.text_.text = var_98_8

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 10
				local var_98_10 = utf8.len(var_98_8)
				local var_98_11 = var_98_9 <= 0 and var_98_5 or var_98_5 * (var_98_10 / var_98_9)

				if var_98_11 > 0 and var_98_5 < var_98_11 then
					arg_95_1.talkMaxDuration = var_98_11

					if var_98_11 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_8
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201023", "story_v_out_321201.awb") ~= 0 then
					local var_98_12 = manager.audio:GetVoiceLength("story_v_out_321201", "321201023", "story_v_out_321201.awb") / 1000

					if var_98_12 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_12 + var_98_4
					end

					if var_98_7.prefab_name ~= "" and arg_95_1.actors_[var_98_7.prefab_name] ~= nil then
						local var_98_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_7.prefab_name].transform, "story_v_out_321201", "321201023", "story_v_out_321201.awb")

						arg_95_1:RecordAudio("321201023", var_98_13)
						arg_95_1:RecordAudio("321201023", var_98_13)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321201", "321201023", "story_v_out_321201.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321201", "321201023", "story_v_out_321201.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_14 and arg_95_1.time_ < var_98_4 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play321201024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321201024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321201025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["2079ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect2079ui_story == nil then
				arg_99_1.var_.characterEffect2079ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.2

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect2079ui_story and not isNil(var_102_0) then
					local var_102_4 = Mathf.Lerp(0, 0.5, var_102_3)

					arg_99_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_99_1.var_.characterEffect2079ui_story.fillRatio = var_102_4
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect2079ui_story then
				local var_102_5 = 0.5

				arg_99_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_99_1.var_.characterEffect2079ui_story.fillRatio = var_102_5
			end

			local var_102_6 = 0
			local var_102_7 = 0.625

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:GetWordFromCfg(321201024)
				local var_102_9 = arg_99_1:FormatText(var_102_8.content)

				arg_99_1.text_.text = var_102_9

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_10 = 25
				local var_102_11 = utf8.len(var_102_9)
				local var_102_12 = var_102_10 <= 0 and var_102_7 or var_102_7 * (var_102_11 / var_102_10)

				if var_102_12 > 0 and var_102_7 < var_102_12 then
					arg_99_1.talkMaxDuration = var_102_12

					if var_102_12 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_9
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_13 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_13 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_13

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_13 and arg_99_1.time_ < var_102_6 + var_102_13 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play321201025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321201025
		arg_103_1.duration_ = 4.2

		local var_103_0 = {
			zh = 4.2,
			ja = 3.1
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play321201026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.175

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[1184].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(321201025)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 7
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201025", "story_v_out_321201.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201025", "story_v_out_321201.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_321201", "321201025", "story_v_out_321201.awb")

						arg_103_1:RecordAudio("321201025", var_106_9)
						arg_103_1:RecordAudio("321201025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_321201", "321201025", "story_v_out_321201.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_321201", "321201025", "story_v_out_321201.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play321201026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321201026
		arg_107_1.duration_ = 7.93

		local var_107_0 = {
			zh = 5.866,
			ja = 7.933
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play321201027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1011ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos1011ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(0, -0.71, -6)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1011ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["2079ui_story"].transform
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1.var_.moveOldPos2079ui_story = var_110_9.localPosition
			end

			local var_110_11 = 0.001

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11
				local var_110_13 = Vector3.New(0, 100, 0)

				var_110_9.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos2079ui_story, var_110_13, var_110_12)

				local var_110_14 = manager.ui.mainCamera.transform.position - var_110_9.position

				var_110_9.forward = Vector3.New(var_110_14.x, var_110_14.y, var_110_14.z)

				local var_110_15 = var_110_9.localEulerAngles

				var_110_15.z = 0
				var_110_15.x = 0
				var_110_9.localEulerAngles = var_110_15
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 then
				var_110_9.localPosition = Vector3.New(0, 100, 0)

				local var_110_16 = manager.ui.mainCamera.transform.position - var_110_9.position

				var_110_9.forward = Vector3.New(var_110_16.x, var_110_16.y, var_110_16.z)

				local var_110_17 = var_110_9.localEulerAngles

				var_110_17.z = 0
				var_110_17.x = 0
				var_110_9.localEulerAngles = var_110_17
			end

			local var_110_18 = arg_107_1.actors_["1011ui_story"]
			local var_110_19 = 0

			if var_110_19 < arg_107_1.time_ and arg_107_1.time_ <= var_110_19 + arg_110_0 and not isNil(var_110_18) and arg_107_1.var_.characterEffect1011ui_story == nil then
				arg_107_1.var_.characterEffect1011ui_story = var_110_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_20 = 0.200000002980232

			if var_110_19 <= arg_107_1.time_ and arg_107_1.time_ < var_110_19 + var_110_20 and not isNil(var_110_18) then
				local var_110_21 = (arg_107_1.time_ - var_110_19) / var_110_20

				if arg_107_1.var_.characterEffect1011ui_story and not isNil(var_110_18) then
					arg_107_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_19 + var_110_20 and arg_107_1.time_ < var_110_19 + var_110_20 + arg_110_0 and not isNil(var_110_18) and arg_107_1.var_.characterEffect1011ui_story then
				arg_107_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_110_22 = 0

			if var_110_22 < arg_107_1.time_ and arg_107_1.time_ <= var_110_22 + arg_110_0 then
				arg_107_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_110_23 = 0

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 then
				arg_107_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_110_24 = 0
			local var_110_25 = 1

			if var_110_24 < arg_107_1.time_ and arg_107_1.time_ <= var_110_24 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_26 = arg_107_1:FormatText(StoryNameCfg[37].name)

				arg_107_1.leftNameTxt_.text = var_110_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_27 = arg_107_1:GetWordFromCfg(321201026)
				local var_110_28 = arg_107_1:FormatText(var_110_27.content)

				arg_107_1.text_.text = var_110_28

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_29 = 40
				local var_110_30 = utf8.len(var_110_28)
				local var_110_31 = var_110_29 <= 0 and var_110_25 or var_110_25 * (var_110_30 / var_110_29)

				if var_110_31 > 0 and var_110_25 < var_110_31 then
					arg_107_1.talkMaxDuration = var_110_31

					if var_110_31 + var_110_24 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_31 + var_110_24
					end
				end

				arg_107_1.text_.text = var_110_28
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201026", "story_v_out_321201.awb") ~= 0 then
					local var_110_32 = manager.audio:GetVoiceLength("story_v_out_321201", "321201026", "story_v_out_321201.awb") / 1000

					if var_110_32 + var_110_24 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_32 + var_110_24
					end

					if var_110_27.prefab_name ~= "" and arg_107_1.actors_[var_110_27.prefab_name] ~= nil then
						local var_110_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_27.prefab_name].transform, "story_v_out_321201", "321201026", "story_v_out_321201.awb")

						arg_107_1:RecordAudio("321201026", var_110_33)
						arg_107_1:RecordAudio("321201026", var_110_33)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_321201", "321201026", "story_v_out_321201.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_321201", "321201026", "story_v_out_321201.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_34 = math.max(var_110_25, arg_107_1.talkMaxDuration)

			if var_110_24 <= arg_107_1.time_ and arg_107_1.time_ < var_110_24 + var_110_34 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_24) / var_110_34

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_24 + var_110_34 and arg_107_1.time_ < var_110_24 + var_110_34 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play321201027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321201027
		arg_111_1.duration_ = 8.43

		local var_111_0 = {
			zh = 8.433,
			ja = 5.4
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play321201028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1011ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1011ui_story == nil then
				arg_111_1.var_.characterEffect1011ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1011ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1011ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1011ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1011ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0
			local var_114_7 = 0.575

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[1184].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_9 = arg_111_1:GetWordFromCfg(321201027)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 23
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201027", "story_v_out_321201.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_321201", "321201027", "story_v_out_321201.awb") / 1000

					if var_114_14 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_6
					end

					if var_114_9.prefab_name ~= "" and arg_111_1.actors_[var_114_9.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_9.prefab_name].transform, "story_v_out_321201", "321201027", "story_v_out_321201.awb")

						arg_111_1:RecordAudio("321201027", var_114_15)
						arg_111_1:RecordAudio("321201027", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_321201", "321201027", "story_v_out_321201.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_321201", "321201027", "story_v_out_321201.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_16 and arg_111_1.time_ < var_114_6 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play321201028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321201028
		arg_115_1.duration_ = 5.5

		local var_115_0 = {
			zh = 2.933,
			ja = 5.5
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play321201029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.225

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[1184].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:GetWordFromCfg(321201028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 9
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201028", "story_v_out_321201.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201028", "story_v_out_321201.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_321201", "321201028", "story_v_out_321201.awb")

						arg_115_1:RecordAudio("321201028", var_118_9)
						arg_115_1:RecordAudio("321201028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321201", "321201028", "story_v_out_321201.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321201", "321201028", "story_v_out_321201.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play321201029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321201029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play321201030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["2079ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos2079ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0, 100, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos2079ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, 100, 0)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["1011ui_story"].transform
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1.var_.moveOldPos1011ui_story = var_122_9.localPosition
			end

			local var_122_11 = 0.001

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11
				local var_122_13 = Vector3.New(0, 100, 0)

				var_122_9.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1011ui_story, var_122_13, var_122_12)

				local var_122_14 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_14.x, var_122_14.y, var_122_14.z)

				local var_122_15 = var_122_9.localEulerAngles

				var_122_15.z = 0
				var_122_15.x = 0
				var_122_9.localEulerAngles = var_122_15
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 then
				var_122_9.localPosition = Vector3.New(0, 100, 0)

				local var_122_16 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_16.x, var_122_16.y, var_122_16.z)

				local var_122_17 = var_122_9.localEulerAngles

				var_122_17.z = 0
				var_122_17.x = 0
				var_122_9.localEulerAngles = var_122_17
			end

			local var_122_18 = 0
			local var_122_19 = 0.7

			if var_122_18 < arg_119_1.time_ and arg_119_1.time_ <= var_122_18 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_20 = arg_119_1:GetWordFromCfg(321201029)
				local var_122_21 = arg_119_1:FormatText(var_122_20.content)

				arg_119_1.text_.text = var_122_21

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_22 = 28
				local var_122_23 = utf8.len(var_122_21)
				local var_122_24 = var_122_22 <= 0 and var_122_19 or var_122_19 * (var_122_23 / var_122_22)

				if var_122_24 > 0 and var_122_19 < var_122_24 then
					arg_119_1.talkMaxDuration = var_122_24

					if var_122_24 + var_122_18 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_24 + var_122_18
					end
				end

				arg_119_1.text_.text = var_122_21
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_25 = math.max(var_122_19, arg_119_1.talkMaxDuration)

			if var_122_18 <= arg_119_1.time_ and arg_119_1.time_ < var_122_18 + var_122_25 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_18) / var_122_25

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_18 + var_122_25 and arg_119_1.time_ < var_122_18 + var_122_25 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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

		arg_119_1:InitPlayNodeList()
	end,
	Play321201030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321201030
		arg_123_1.duration_ = 8.2

		local var_123_0 = {
			zh = 6.4,
			ja = 8.2
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
				arg_123_0:Play321201031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.7

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[1184].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(321201030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 28
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201030", "story_v_out_321201.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201030", "story_v_out_321201.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_321201", "321201030", "story_v_out_321201.awb")

						arg_123_1:RecordAudio("321201030", var_126_9)
						arg_123_1:RecordAudio("321201030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321201", "321201030", "story_v_out_321201.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321201", "321201030", "story_v_out_321201.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321201031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321201031
		arg_127_1.duration_ = 4.8

		local var_127_0 = {
			zh = 2.166,
			ja = 4.8
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
				arg_127_0:Play321201032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["2079ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect2079ui_story == nil then
				arg_127_1.var_.characterEffect2079ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect2079ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_127_1.var_.characterEffect2079ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect2079ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_127_1.var_.characterEffect2079ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0
			local var_130_7 = 0.275

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_8 = arg_127_1:FormatText(StoryNameCfg[1182].name)

				arg_127_1.leftNameTxt_.text = var_130_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_9 = arg_127_1:GetWordFromCfg(321201031)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 11
				local var_130_12 = utf8.len(var_130_10)
				local var_130_13 = var_130_11 <= 0 and var_130_7 or var_130_7 * (var_130_12 / var_130_11)

				if var_130_13 > 0 and var_130_7 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201031", "story_v_out_321201.awb") ~= 0 then
					local var_130_14 = manager.audio:GetVoiceLength("story_v_out_321201", "321201031", "story_v_out_321201.awb") / 1000

					if var_130_14 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_6
					end

					if var_130_9.prefab_name ~= "" and arg_127_1.actors_[var_130_9.prefab_name] ~= nil then
						local var_130_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_9.prefab_name].transform, "story_v_out_321201", "321201031", "story_v_out_321201.awb")

						arg_127_1:RecordAudio("321201031", var_130_15)
						arg_127_1:RecordAudio("321201031", var_130_15)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_321201", "321201031", "story_v_out_321201.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_321201", "321201031", "story_v_out_321201.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_16 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_16 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_16

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_16 and arg_127_1.time_ < var_130_6 + var_130_16 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play321201032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321201032
		arg_131_1.duration_ = 1.83

		local var_131_0 = {
			zh = 1.233,
			ja = 1.833
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
				arg_131_0:Play321201033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.1

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[1180].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiareporterm")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(321201032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 4
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201032", "story_v_out_321201.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201032", "story_v_out_321201.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_321201", "321201032", "story_v_out_321201.awb")

						arg_131_1:RecordAudio("321201032", var_134_9)
						arg_131_1:RecordAudio("321201032", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_321201", "321201032", "story_v_out_321201.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_321201", "321201032", "story_v_out_321201.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_10 and arg_131_1.time_ < var_134_0 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play321201033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321201033
		arg_135_1.duration_ = 6.63

		local var_135_0 = {
			zh = 4.566,
			ja = 6.633
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
				arg_135_0:Play321201034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["2079ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos2079ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, 100, 0)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos2079ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, 100, 0)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["404001ui_story"].transform
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.var_.moveOldPos404001ui_story = var_138_9.localPosition
			end

			local var_138_11 = 0.001

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11
				local var_138_13 = Vector3.New(0, -1.55, -5.5)

				var_138_9.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos404001ui_story, var_138_13, var_138_12)

				local var_138_14 = manager.ui.mainCamera.transform.position - var_138_9.position

				var_138_9.forward = Vector3.New(var_138_14.x, var_138_14.y, var_138_14.z)

				local var_138_15 = var_138_9.localEulerAngles

				var_138_15.z = 0
				var_138_15.x = 0
				var_138_9.localEulerAngles = var_138_15
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 then
				var_138_9.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_138_16 = manager.ui.mainCamera.transform.position - var_138_9.position

				var_138_9.forward = Vector3.New(var_138_16.x, var_138_16.y, var_138_16.z)

				local var_138_17 = var_138_9.localEulerAngles

				var_138_17.z = 0
				var_138_17.x = 0
				var_138_9.localEulerAngles = var_138_17
			end

			local var_138_18 = arg_135_1.actors_["404001ui_story"]
			local var_138_19 = 0

			if var_138_19 < arg_135_1.time_ and arg_135_1.time_ <= var_138_19 + arg_138_0 and not isNil(var_138_18) and arg_135_1.var_.characterEffect404001ui_story == nil then
				arg_135_1.var_.characterEffect404001ui_story = var_138_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_20 = 0.200000002980232

			if var_138_19 <= arg_135_1.time_ and arg_135_1.time_ < var_138_19 + var_138_20 and not isNil(var_138_18) then
				local var_138_21 = (arg_135_1.time_ - var_138_19) / var_138_20

				if arg_135_1.var_.characterEffect404001ui_story and not isNil(var_138_18) then
					arg_135_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_19 + var_138_20 and arg_135_1.time_ < var_138_19 + var_138_20 + arg_138_0 and not isNil(var_138_18) and arg_135_1.var_.characterEffect404001ui_story then
				arg_135_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_138_22 = 0

			if var_138_22 < arg_135_1.time_ and arg_135_1.time_ <= var_138_22 + arg_138_0 then
				arg_135_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_138_23 = 0

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_138_24 = 0
			local var_138_25 = 0.6

			if var_138_24 < arg_135_1.time_ and arg_135_1.time_ <= var_138_24 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_26 = arg_135_1:FormatText(StoryNameCfg[668].name)

				arg_135_1.leftNameTxt_.text = var_138_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_27 = arg_135_1:GetWordFromCfg(321201033)
				local var_138_28 = arg_135_1:FormatText(var_138_27.content)

				arg_135_1.text_.text = var_138_28

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_29 = 24
				local var_138_30 = utf8.len(var_138_28)
				local var_138_31 = var_138_29 <= 0 and var_138_25 or var_138_25 * (var_138_30 / var_138_29)

				if var_138_31 > 0 and var_138_25 < var_138_31 then
					arg_135_1.talkMaxDuration = var_138_31

					if var_138_31 + var_138_24 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_31 + var_138_24
					end
				end

				arg_135_1.text_.text = var_138_28
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201033", "story_v_out_321201.awb") ~= 0 then
					local var_138_32 = manager.audio:GetVoiceLength("story_v_out_321201", "321201033", "story_v_out_321201.awb") / 1000

					if var_138_32 + var_138_24 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_32 + var_138_24
					end

					if var_138_27.prefab_name ~= "" and arg_135_1.actors_[var_138_27.prefab_name] ~= nil then
						local var_138_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_27.prefab_name].transform, "story_v_out_321201", "321201033", "story_v_out_321201.awb")

						arg_135_1:RecordAudio("321201033", var_138_33)
						arg_135_1:RecordAudio("321201033", var_138_33)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_321201", "321201033", "story_v_out_321201.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_321201", "321201033", "story_v_out_321201.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_34 = math.max(var_138_25, arg_135_1.talkMaxDuration)

			if var_138_24 <= arg_135_1.time_ and arg_135_1.time_ < var_138_24 + var_138_34 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_24) / var_138_34

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_24 + var_138_34 and arg_135_1.time_ < var_138_24 + var_138_34 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play321201034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321201034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play321201035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["404001ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos404001ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, 100, 0)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos404001ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, 100, 0)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["404001ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect404001ui_story == nil then
				arg_139_1.var_.characterEffect404001ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect404001ui_story and not isNil(var_142_9) then
					local var_142_13 = Mathf.Lerp(0, 0.5, var_142_12)

					arg_139_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_139_1.var_.characterEffect404001ui_story.fillRatio = var_142_13
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect404001ui_story then
				local var_142_14 = 0.5

				arg_139_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_139_1.var_.characterEffect404001ui_story.fillRatio = var_142_14
			end

			local var_142_15 = 0
			local var_142_16 = 1.35

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_17 = arg_139_1:GetWordFromCfg(321201034)
				local var_142_18 = arg_139_1:FormatText(var_142_17.content)

				arg_139_1.text_.text = var_142_18

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_19 = 54
				local var_142_20 = utf8.len(var_142_18)
				local var_142_21 = var_142_19 <= 0 and var_142_16 or var_142_16 * (var_142_20 / var_142_19)

				if var_142_21 > 0 and var_142_16 < var_142_21 then
					arg_139_1.talkMaxDuration = var_142_21

					if var_142_21 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_21 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_18
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_22 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_22 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_22

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_22 and arg_139_1.time_ < var_142_15 + var_142_22 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play321201035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321201035
		arg_143_1.duration_ = 2.2

		local var_143_0 = {
			zh = 1.466,
			ja = 2.2
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
				arg_143_0:Play321201036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.225

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[1184].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(321201035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 9
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201035", "story_v_out_321201.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201035", "story_v_out_321201.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_321201", "321201035", "story_v_out_321201.awb")

						arg_143_1:RecordAudio("321201035", var_146_9)
						arg_143_1:RecordAudio("321201035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_321201", "321201035", "story_v_out_321201.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_321201", "321201035", "story_v_out_321201.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321201036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321201036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play321201037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.034000001847744
			local var_150_1 = 1

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				local var_150_2 = "play"
				local var_150_3 = "effect"

				arg_147_1:AudioAction(var_150_2, var_150_3, "se_story_140", "se_story_140_tentacle1", "")
			end

			local var_150_4 = 0
			local var_150_5 = 1.05

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(321201036)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_8 = 42
				local var_150_9 = utf8.len(var_150_7)
				local var_150_10 = var_150_8 <= 0 and var_150_5 or var_150_5 * (var_150_9 / var_150_8)

				if var_150_10 > 0 and var_150_5 < var_150_10 then
					arg_147_1.talkMaxDuration = var_150_10

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_11 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_11 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_11

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_11 and arg_147_1.time_ < var_150_4 + var_150_11 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321201037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321201037
		arg_151_1.duration_ = 4.7

		local var_151_0 = {
			zh = 4.7,
			ja = 3.5
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
				arg_151_0:Play321201038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["2079ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect2079ui_story == nil then
				arg_151_1.var_.characterEffect2079ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect2079ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect2079ui_story then
				arg_151_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_154_4 = 0
			local var_154_5 = 0.25

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_6 = arg_151_1:FormatText(StoryNameCfg[1184].name)

				arg_151_1.leftNameTxt_.text = var_154_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_7 = arg_151_1:GetWordFromCfg(321201037)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 10
				local var_154_10 = utf8.len(var_154_8)
				local var_154_11 = var_154_9 <= 0 and var_154_5 or var_154_5 * (var_154_10 / var_154_9)

				if var_154_11 > 0 and var_154_5 < var_154_11 then
					arg_151_1.talkMaxDuration = var_154_11

					if var_154_11 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201037", "story_v_out_321201.awb") ~= 0 then
					local var_154_12 = manager.audio:GetVoiceLength("story_v_out_321201", "321201037", "story_v_out_321201.awb") / 1000

					if var_154_12 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_4
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_out_321201", "321201037", "story_v_out_321201.awb")

						arg_151_1:RecordAudio("321201037", var_154_13)
						arg_151_1:RecordAudio("321201037", var_154_13)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_321201", "321201037", "story_v_out_321201.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_321201", "321201037", "story_v_out_321201.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_14 and arg_151_1.time_ < var_154_4 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play321201038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321201038
		arg_155_1.duration_ = 4.53

		local var_155_0 = {
			zh = 4.133,
			ja = 4.533
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
				arg_155_0:Play321201039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["404001ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos404001ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, -1.55, -5.5)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos404001ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = arg_155_1.actors_["404001ui_story"]
			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect404001ui_story == nil then
				arg_155_1.var_.characterEffect404001ui_story = var_158_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_11 = 0.200000002980232

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_11 and not isNil(var_158_9) then
				local var_158_12 = (arg_155_1.time_ - var_158_10) / var_158_11

				if arg_155_1.var_.characterEffect404001ui_story and not isNil(var_158_9) then
					arg_155_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_10 + var_158_11 and arg_155_1.time_ < var_158_10 + var_158_11 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect404001ui_story then
				arg_155_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_158_13 = 0

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				arg_155_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action7_1")
			end

			local var_158_14 = 0

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				arg_155_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_158_15 = 0
			local var_158_16 = 0.45

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_17 = arg_155_1:FormatText(StoryNameCfg[668].name)

				arg_155_1.leftNameTxt_.text = var_158_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_18 = arg_155_1:GetWordFromCfg(321201038)
				local var_158_19 = arg_155_1:FormatText(var_158_18.content)

				arg_155_1.text_.text = var_158_19

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_20 = 18
				local var_158_21 = utf8.len(var_158_19)
				local var_158_22 = var_158_20 <= 0 and var_158_16 or var_158_16 * (var_158_21 / var_158_20)

				if var_158_22 > 0 and var_158_16 < var_158_22 then
					arg_155_1.talkMaxDuration = var_158_22

					if var_158_22 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_22 + var_158_15
					end
				end

				arg_155_1.text_.text = var_158_19
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201038", "story_v_out_321201.awb") ~= 0 then
					local var_158_23 = manager.audio:GetVoiceLength("story_v_out_321201", "321201038", "story_v_out_321201.awb") / 1000

					if var_158_23 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_15
					end

					if var_158_18.prefab_name ~= "" and arg_155_1.actors_[var_158_18.prefab_name] ~= nil then
						local var_158_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_18.prefab_name].transform, "story_v_out_321201", "321201038", "story_v_out_321201.awb")

						arg_155_1:RecordAudio("321201038", var_158_24)
						arg_155_1:RecordAudio("321201038", var_158_24)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_321201", "321201038", "story_v_out_321201.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_321201", "321201038", "story_v_out_321201.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_25 = math.max(var_158_16, arg_155_1.talkMaxDuration)

			if var_158_15 <= arg_155_1.time_ and arg_155_1.time_ < var_158_15 + var_158_25 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_15) / var_158_25

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_15 + var_158_25 and arg_155_1.time_ < var_158_15 + var_158_25 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321201039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321201039
		arg_159_1.duration_ = 11.93

		local var_159_0 = {
			zh = 5.9,
			ja = 11.933
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321201040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.675

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[668].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(321201039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 27
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201039", "story_v_out_321201.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201039", "story_v_out_321201.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_321201", "321201039", "story_v_out_321201.awb")

						arg_159_1:RecordAudio("321201039", var_162_9)
						arg_159_1:RecordAudio("321201039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321201", "321201039", "story_v_out_321201.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321201", "321201039", "story_v_out_321201.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play321201040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 321201040
		arg_163_1.duration_ = 13.27

		local var_163_0 = {
			zh = 8.9,
			ja = 13.266
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
				arg_163_0:Play321201041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["404001ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect404001ui_story == nil then
				arg_163_1.var_.characterEffect404001ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect404001ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_163_1.var_.characterEffect404001ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect404001ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_163_1.var_.characterEffect404001ui_story.fillRatio = var_166_5
			end

			local var_166_6 = arg_163_1.actors_["2079ui_story"]
			local var_166_7 = 0

			if var_166_7 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect2079ui_story == nil then
				arg_163_1.var_.characterEffect2079ui_story = var_166_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_8 = 0.2

			if var_166_7 <= arg_163_1.time_ and arg_163_1.time_ < var_166_7 + var_166_8 and not isNil(var_166_6) then
				local var_166_9 = (arg_163_1.time_ - var_166_7) / var_166_8

				if arg_163_1.var_.characterEffect2079ui_story and not isNil(var_166_6) then
					arg_163_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_7 + var_166_8 and arg_163_1.time_ < var_166_7 + var_166_8 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect2079ui_story then
				arg_163_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_166_10 = 0
			local var_166_11 = 1

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_12 = arg_163_1:FormatText(StoryNameCfg[1184].name)

				arg_163_1.leftNameTxt_.text = var_166_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_13 = arg_163_1:GetWordFromCfg(321201040)
				local var_166_14 = arg_163_1:FormatText(var_166_13.content)

				arg_163_1.text_.text = var_166_14

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_15 = 40
				local var_166_16 = utf8.len(var_166_14)
				local var_166_17 = var_166_15 <= 0 and var_166_11 or var_166_11 * (var_166_16 / var_166_15)

				if var_166_17 > 0 and var_166_11 < var_166_17 then
					arg_163_1.talkMaxDuration = var_166_17

					if var_166_17 + var_166_10 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_10
					end
				end

				arg_163_1.text_.text = var_166_14
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201040", "story_v_out_321201.awb") ~= 0 then
					local var_166_18 = manager.audio:GetVoiceLength("story_v_out_321201", "321201040", "story_v_out_321201.awb") / 1000

					if var_166_18 + var_166_10 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_18 + var_166_10
					end

					if var_166_13.prefab_name ~= "" and arg_163_1.actors_[var_166_13.prefab_name] ~= nil then
						local var_166_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_13.prefab_name].transform, "story_v_out_321201", "321201040", "story_v_out_321201.awb")

						arg_163_1:RecordAudio("321201040", var_166_19)
						arg_163_1:RecordAudio("321201040", var_166_19)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_321201", "321201040", "story_v_out_321201.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_321201", "321201040", "story_v_out_321201.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_20 = math.max(var_166_11, arg_163_1.talkMaxDuration)

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_20 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_10) / var_166_20

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_10 + var_166_20 and arg_163_1.time_ < var_166_10 + var_166_20 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play321201041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 321201041
		arg_167_1.duration_ = 2.03

		local var_167_0 = {
			zh = 1.9,
			ja = 2.033
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
				arg_167_0:Play321201042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["404001ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect404001ui_story == nil then
				arg_167_1.var_.characterEffect404001ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect404001ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect404001ui_story then
				arg_167_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_170_4 = arg_167_1.actors_["2079ui_story"]
			local var_170_5 = 0

			if var_170_5 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 and not isNil(var_170_4) and arg_167_1.var_.characterEffect2079ui_story == nil then
				arg_167_1.var_.characterEffect2079ui_story = var_170_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_6 = 0.2

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_6 and not isNil(var_170_4) then
				local var_170_7 = (arg_167_1.time_ - var_170_5) / var_170_6

				if arg_167_1.var_.characterEffect2079ui_story and not isNil(var_170_4) then
					local var_170_8 = Mathf.Lerp(0, 0.5, var_170_7)

					arg_167_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_167_1.var_.characterEffect2079ui_story.fillRatio = var_170_8
				end
			end

			if arg_167_1.time_ >= var_170_5 + var_170_6 and arg_167_1.time_ < var_170_5 + var_170_6 + arg_170_0 and not isNil(var_170_4) and arg_167_1.var_.characterEffect2079ui_story then
				local var_170_9 = 0.5

				arg_167_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_167_1.var_.characterEffect2079ui_story.fillRatio = var_170_9
			end

			local var_170_10 = 0
			local var_170_11 = 0.225

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_12 = arg_167_1:FormatText(StoryNameCfg[668].name)

				arg_167_1.leftNameTxt_.text = var_170_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_13 = arg_167_1:GetWordFromCfg(321201041)
				local var_170_14 = arg_167_1:FormatText(var_170_13.content)

				arg_167_1.text_.text = var_170_14

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_15 = 9
				local var_170_16 = utf8.len(var_170_14)
				local var_170_17 = var_170_15 <= 0 and var_170_11 or var_170_11 * (var_170_16 / var_170_15)

				if var_170_17 > 0 and var_170_11 < var_170_17 then
					arg_167_1.talkMaxDuration = var_170_17

					if var_170_17 + var_170_10 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_17 + var_170_10
					end
				end

				arg_167_1.text_.text = var_170_14
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201041", "story_v_out_321201.awb") ~= 0 then
					local var_170_18 = manager.audio:GetVoiceLength("story_v_out_321201", "321201041", "story_v_out_321201.awb") / 1000

					if var_170_18 + var_170_10 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_18 + var_170_10
					end

					if var_170_13.prefab_name ~= "" and arg_167_1.actors_[var_170_13.prefab_name] ~= nil then
						local var_170_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_13.prefab_name].transform, "story_v_out_321201", "321201041", "story_v_out_321201.awb")

						arg_167_1:RecordAudio("321201041", var_170_19)
						arg_167_1:RecordAudio("321201041", var_170_19)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_321201", "321201041", "story_v_out_321201.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_321201", "321201041", "story_v_out_321201.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_20 = math.max(var_170_11, arg_167_1.talkMaxDuration)

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_20 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_10) / var_170_20

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_10 + var_170_20 and arg_167_1.time_ < var_170_10 + var_170_20 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play321201042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 321201042
		arg_171_1.duration_ = 3.07

		local var_171_0 = {
			zh = 1.366,
			ja = 3.066
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play321201043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["404001ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect404001ui_story == nil then
				arg_171_1.var_.characterEffect404001ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect404001ui_story and not isNil(var_174_0) then
					local var_174_4 = Mathf.Lerp(0, 0.5, var_174_3)

					arg_171_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_171_1.var_.characterEffect404001ui_story.fillRatio = var_174_4
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect404001ui_story then
				local var_174_5 = 0.5

				arg_171_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_171_1.var_.characterEffect404001ui_story.fillRatio = var_174_5
			end

			local var_174_6 = arg_171_1.actors_["2079ui_story"]
			local var_174_7 = 0

			if var_174_7 < arg_171_1.time_ and arg_171_1.time_ <= var_174_7 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect2079ui_story == nil then
				arg_171_1.var_.characterEffect2079ui_story = var_174_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_8 = 0.2

			if var_174_7 <= arg_171_1.time_ and arg_171_1.time_ < var_174_7 + var_174_8 and not isNil(var_174_6) then
				local var_174_9 = (arg_171_1.time_ - var_174_7) / var_174_8

				if arg_171_1.var_.characterEffect2079ui_story and not isNil(var_174_6) then
					arg_171_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_7 + var_174_8 and arg_171_1.time_ < var_174_7 + var_174_8 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect2079ui_story then
				arg_171_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_174_10 = 0
			local var_174_11 = 0.125

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_12 = arg_171_1:FormatText(StoryNameCfg[1184].name)

				arg_171_1.leftNameTxt_.text = var_174_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_13 = arg_171_1:GetWordFromCfg(321201042)
				local var_174_14 = arg_171_1:FormatText(var_174_13.content)

				arg_171_1.text_.text = var_174_14

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_15 = 5
				local var_174_16 = utf8.len(var_174_14)
				local var_174_17 = var_174_15 <= 0 and var_174_11 or var_174_11 * (var_174_16 / var_174_15)

				if var_174_17 > 0 and var_174_11 < var_174_17 then
					arg_171_1.talkMaxDuration = var_174_17

					if var_174_17 + var_174_10 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_17 + var_174_10
					end
				end

				arg_171_1.text_.text = var_174_14
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201042", "story_v_out_321201.awb") ~= 0 then
					local var_174_18 = manager.audio:GetVoiceLength("story_v_out_321201", "321201042", "story_v_out_321201.awb") / 1000

					if var_174_18 + var_174_10 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_18 + var_174_10
					end

					if var_174_13.prefab_name ~= "" and arg_171_1.actors_[var_174_13.prefab_name] ~= nil then
						local var_174_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_13.prefab_name].transform, "story_v_out_321201", "321201042", "story_v_out_321201.awb")

						arg_171_1:RecordAudio("321201042", var_174_19)
						arg_171_1:RecordAudio("321201042", var_174_19)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_321201", "321201042", "story_v_out_321201.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_321201", "321201042", "story_v_out_321201.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_20 = math.max(var_174_11, arg_171_1.talkMaxDuration)

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_20 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_10) / var_174_20

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_10 + var_174_20 and arg_171_1.time_ < var_174_10 + var_174_20 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play321201043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 321201043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play321201044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["2079ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect2079ui_story == nil then
				arg_175_1.var_.characterEffect2079ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect2079ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_175_1.var_.characterEffect2079ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect2079ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_175_1.var_.characterEffect2079ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0
			local var_178_7 = 0.5

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_8 = arg_175_1:GetWordFromCfg(321201043)
				local var_178_9 = arg_175_1:FormatText(var_178_8.content)

				arg_175_1.text_.text = var_178_9

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 20
				local var_178_11 = utf8.len(var_178_9)
				local var_178_12 = var_178_10 <= 0 and var_178_7 or var_178_7 * (var_178_11 / var_178_10)

				if var_178_12 > 0 and var_178_7 < var_178_12 then
					arg_175_1.talkMaxDuration = var_178_12

					if var_178_12 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_9
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_13 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_13 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_13

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_13 and arg_175_1.time_ < var_178_6 + var_178_13 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play321201044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 321201044
		arg_179_1.duration_ = 17.23

		local var_179_0 = {
			zh = 10.4,
			ja = 17.233
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
				arg_179_0:Play321201045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["2079ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect2079ui_story == nil then
				arg_179_1.var_.characterEffect2079ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect2079ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect2079ui_story then
				arg_179_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_182_4 = 0
			local var_182_5 = 1.25

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_6 = arg_179_1:FormatText(StoryNameCfg[1184].name)

				arg_179_1.leftNameTxt_.text = var_182_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_7 = arg_179_1:GetWordFromCfg(321201044)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 50
				local var_182_10 = utf8.len(var_182_8)
				local var_182_11 = var_182_9 <= 0 and var_182_5 or var_182_5 * (var_182_10 / var_182_9)

				if var_182_11 > 0 and var_182_5 < var_182_11 then
					arg_179_1.talkMaxDuration = var_182_11

					if var_182_11 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201044", "story_v_out_321201.awb") ~= 0 then
					local var_182_12 = manager.audio:GetVoiceLength("story_v_out_321201", "321201044", "story_v_out_321201.awb") / 1000

					if var_182_12 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_4
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_321201", "321201044", "story_v_out_321201.awb")

						arg_179_1:RecordAudio("321201044", var_182_13)
						arg_179_1:RecordAudio("321201044", var_182_13)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_321201", "321201044", "story_v_out_321201.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_321201", "321201044", "story_v_out_321201.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_14 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_14

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_14 and arg_179_1.time_ < var_182_4 + var_182_14 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play321201045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 321201045
		arg_183_1.duration_ = 5.43

		local var_183_0 = {
			zh = 3.8,
			ja = 5.433
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
				arg_183_0:Play321201046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.475

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[1184].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(321201045)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 19
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201045", "story_v_out_321201.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201045", "story_v_out_321201.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_321201", "321201045", "story_v_out_321201.awb")

						arg_183_1:RecordAudio("321201045", var_186_9)
						arg_183_1:RecordAudio("321201045", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_321201", "321201045", "story_v_out_321201.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_321201", "321201045", "story_v_out_321201.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play321201046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 321201046
		arg_187_1.duration_ = 5.3

		local var_187_0 = {
			zh = 1.999999999999,
			ja = 5.3
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play321201047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["404001ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect404001ui_story == nil then
				arg_187_1.var_.characterEffect404001ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect404001ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect404001ui_story then
				arg_187_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_190_4 = 0

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action7_2")
			end

			local var_190_5 = 0

			if var_190_5 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				arg_187_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_190_6 = arg_187_1.actors_["2079ui_story"]
			local var_190_7 = 0

			if var_190_7 < arg_187_1.time_ and arg_187_1.time_ <= var_190_7 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect2079ui_story == nil then
				arg_187_1.var_.characterEffect2079ui_story = var_190_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_8 = 0.2

			if var_190_7 <= arg_187_1.time_ and arg_187_1.time_ < var_190_7 + var_190_8 and not isNil(var_190_6) then
				local var_190_9 = (arg_187_1.time_ - var_190_7) / var_190_8

				if arg_187_1.var_.characterEffect2079ui_story and not isNil(var_190_6) then
					local var_190_10 = Mathf.Lerp(0, 0.5, var_190_9)

					arg_187_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_187_1.var_.characterEffect2079ui_story.fillRatio = var_190_10
				end
			end

			if arg_187_1.time_ >= var_190_7 + var_190_8 and arg_187_1.time_ < var_190_7 + var_190_8 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect2079ui_story then
				local var_190_11 = 0.5

				arg_187_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_187_1.var_.characterEffect2079ui_story.fillRatio = var_190_11
			end

			local var_190_12 = 0
			local var_190_13 = 0.15

			if var_190_12 < arg_187_1.time_ and arg_187_1.time_ <= var_190_12 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_14 = arg_187_1:FormatText(StoryNameCfg[668].name)

				arg_187_1.leftNameTxt_.text = var_190_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_15 = arg_187_1:GetWordFromCfg(321201046)
				local var_190_16 = arg_187_1:FormatText(var_190_15.content)

				arg_187_1.text_.text = var_190_16

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_17 = 6
				local var_190_18 = utf8.len(var_190_16)
				local var_190_19 = var_190_17 <= 0 and var_190_13 or var_190_13 * (var_190_18 / var_190_17)

				if var_190_19 > 0 and var_190_13 < var_190_19 then
					arg_187_1.talkMaxDuration = var_190_19

					if var_190_19 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_19 + var_190_12
					end
				end

				arg_187_1.text_.text = var_190_16
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201046", "story_v_out_321201.awb") ~= 0 then
					local var_190_20 = manager.audio:GetVoiceLength("story_v_out_321201", "321201046", "story_v_out_321201.awb") / 1000

					if var_190_20 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_20 + var_190_12
					end

					if var_190_15.prefab_name ~= "" and arg_187_1.actors_[var_190_15.prefab_name] ~= nil then
						local var_190_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_15.prefab_name].transform, "story_v_out_321201", "321201046", "story_v_out_321201.awb")

						arg_187_1:RecordAudio("321201046", var_190_21)
						arg_187_1:RecordAudio("321201046", var_190_21)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_321201", "321201046", "story_v_out_321201.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_321201", "321201046", "story_v_out_321201.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = math.max(var_190_13, arg_187_1.talkMaxDuration)

			if var_190_12 <= arg_187_1.time_ and arg_187_1.time_ < var_190_12 + var_190_22 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_12) / var_190_22

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_12 + var_190_22 and arg_187_1.time_ < var_190_12 + var_190_22 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play321201047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 321201047
		arg_191_1.duration_ = 4.17

		local var_191_0 = {
			zh = 2.033,
			ja = 4.166
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
				arg_191_0:Play321201048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["404001ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect404001ui_story == nil then
				arg_191_1.var_.characterEffect404001ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect404001ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_191_1.var_.characterEffect404001ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect404001ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_191_1.var_.characterEffect404001ui_story.fillRatio = var_194_5
			end

			local var_194_6 = arg_191_1.actors_["2079ui_story"]
			local var_194_7 = 0

			if var_194_7 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect2079ui_story == nil then
				arg_191_1.var_.characterEffect2079ui_story = var_194_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_8 = 0.2

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_8 and not isNil(var_194_6) then
				local var_194_9 = (arg_191_1.time_ - var_194_7) / var_194_8

				if arg_191_1.var_.characterEffect2079ui_story and not isNil(var_194_6) then
					local var_194_10 = Mathf.Lerp(0, 0.5, var_194_9)

					arg_191_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_191_1.var_.characterEffect2079ui_story.fillRatio = var_194_10
				end
			end

			if arg_191_1.time_ >= var_194_7 + var_194_8 and arg_191_1.time_ < var_194_7 + var_194_8 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect2079ui_story then
				local var_194_11 = 0.5

				arg_191_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_191_1.var_.characterEffect2079ui_story.fillRatio = var_194_11
			end

			local var_194_12 = 0
			local var_194_13 = 0.3

			if var_194_12 < arg_191_1.time_ and arg_191_1.time_ <= var_194_12 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_14 = arg_191_1:FormatText(StoryNameCfg[1184].name)

				arg_191_1.leftNameTxt_.text = var_194_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_15 = arg_191_1:GetWordFromCfg(321201047)
				local var_194_16 = arg_191_1:FormatText(var_194_15.content)

				arg_191_1.text_.text = var_194_16

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_17 = 12
				local var_194_18 = utf8.len(var_194_16)
				local var_194_19 = var_194_17 <= 0 and var_194_13 or var_194_13 * (var_194_18 / var_194_17)

				if var_194_19 > 0 and var_194_13 < var_194_19 then
					arg_191_1.talkMaxDuration = var_194_19

					if var_194_19 + var_194_12 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_19 + var_194_12
					end
				end

				arg_191_1.text_.text = var_194_16
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201047", "story_v_out_321201.awb") ~= 0 then
					local var_194_20 = manager.audio:GetVoiceLength("story_v_out_321201", "321201047", "story_v_out_321201.awb") / 1000

					if var_194_20 + var_194_12 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_20 + var_194_12
					end

					if var_194_15.prefab_name ~= "" and arg_191_1.actors_[var_194_15.prefab_name] ~= nil then
						local var_194_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_15.prefab_name].transform, "story_v_out_321201", "321201047", "story_v_out_321201.awb")

						arg_191_1:RecordAudio("321201047", var_194_21)
						arg_191_1:RecordAudio("321201047", var_194_21)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_321201", "321201047", "story_v_out_321201.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_321201", "321201047", "story_v_out_321201.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_22 = math.max(var_194_13, arg_191_1.talkMaxDuration)

			if var_194_12 <= arg_191_1.time_ and arg_191_1.time_ < var_194_12 + var_194_22 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_12) / var_194_22

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_12 + var_194_22 and arg_191_1.time_ < var_194_12 + var_194_22 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play321201048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 321201048
		arg_195_1.duration_ = 4.2

		local var_195_0 = {
			zh = 2.29966666666667,
			ja = 4.19966666666667
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play321201049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["404001ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect404001ui_story == nil then
				arg_195_1.var_.characterEffect404001ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect404001ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect404001ui_story then
				arg_195_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_198_4 = 0

			if var_198_4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_1")
			end

			local var_198_5 = 0

			if var_198_5 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 then
				arg_195_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_198_6 = arg_195_1.actors_["2079ui_story"]
			local var_198_7 = 0

			if var_198_7 < arg_195_1.time_ and arg_195_1.time_ <= var_198_7 + arg_198_0 and not isNil(var_198_6) and arg_195_1.var_.characterEffect2079ui_story == nil then
				arg_195_1.var_.characterEffect2079ui_story = var_198_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_8 = 0.2

			if var_198_7 <= arg_195_1.time_ and arg_195_1.time_ < var_198_7 + var_198_8 and not isNil(var_198_6) then
				local var_198_9 = (arg_195_1.time_ - var_198_7) / var_198_8

				if arg_195_1.var_.characterEffect2079ui_story and not isNil(var_198_6) then
					local var_198_10 = Mathf.Lerp(0, 0.5, var_198_9)

					arg_195_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_195_1.var_.characterEffect2079ui_story.fillRatio = var_198_10
				end
			end

			if arg_195_1.time_ >= var_198_7 + var_198_8 and arg_195_1.time_ < var_198_7 + var_198_8 + arg_198_0 and not isNil(var_198_6) and arg_195_1.var_.characterEffect2079ui_story then
				local var_198_11 = 0.5

				arg_195_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_195_1.var_.characterEffect2079ui_story.fillRatio = var_198_11
			end

			local var_198_12 = 0

			if var_198_12 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 then
				arg_195_1.allBtn_.enabled = false
			end

			local var_198_13 = 0.666666666666667

			if arg_195_1.time_ >= var_198_12 + var_198_13 and arg_195_1.time_ < var_198_12 + var_198_13 + arg_198_0 then
				arg_195_1.allBtn_.enabled = true
			end

			local var_198_14 = 0.666666666666667
			local var_198_15 = 0.15

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_16 = arg_195_1:FormatText(StoryNameCfg[668].name)

				arg_195_1.leftNameTxt_.text = var_198_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_17 = arg_195_1:GetWordFromCfg(321201048)
				local var_198_18 = arg_195_1:FormatText(var_198_17.content)

				arg_195_1.text_.text = var_198_18

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_19 = 6
				local var_198_20 = utf8.len(var_198_18)
				local var_198_21 = var_198_19 <= 0 and var_198_15 or var_198_15 * (var_198_20 / var_198_19)

				if var_198_21 > 0 and var_198_15 < var_198_21 then
					arg_195_1.talkMaxDuration = var_198_21

					if var_198_21 + var_198_14 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_21 + var_198_14
					end
				end

				arg_195_1.text_.text = var_198_18
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201048", "story_v_out_321201.awb") ~= 0 then
					local var_198_22 = manager.audio:GetVoiceLength("story_v_out_321201", "321201048", "story_v_out_321201.awb") / 1000

					if var_198_22 + var_198_14 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_14
					end

					if var_198_17.prefab_name ~= "" and arg_195_1.actors_[var_198_17.prefab_name] ~= nil then
						local var_198_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_17.prefab_name].transform, "story_v_out_321201", "321201048", "story_v_out_321201.awb")

						arg_195_1:RecordAudio("321201048", var_198_23)
						arg_195_1:RecordAudio("321201048", var_198_23)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_321201", "321201048", "story_v_out_321201.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_321201", "321201048", "story_v_out_321201.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_24 = math.max(var_198_15, arg_195_1.talkMaxDuration)

			if var_198_14 <= arg_195_1.time_ and arg_195_1.time_ < var_198_14 + var_198_24 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_14) / var_198_24

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_14 + var_198_24 and arg_195_1.time_ < var_198_14 + var_198_24 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play321201049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 321201049
		arg_199_1.duration_ = 13.4

		local var_199_0 = {
			zh = 11.433,
			ja = 13.4
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play321201050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["404001ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect404001ui_story == nil then
				arg_199_1.var_.characterEffect404001ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect404001ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_199_1.var_.characterEffect404001ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect404001ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_199_1.var_.characterEffect404001ui_story.fillRatio = var_202_5
			end

			local var_202_6 = arg_199_1.actors_["2079ui_story"]
			local var_202_7 = 0

			if var_202_7 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect2079ui_story == nil then
				arg_199_1.var_.characterEffect2079ui_story = var_202_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_8 = 0.2

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_8 and not isNil(var_202_6) then
				local var_202_9 = (arg_199_1.time_ - var_202_7) / var_202_8

				if arg_199_1.var_.characterEffect2079ui_story and not isNil(var_202_6) then
					arg_199_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_7 + var_202_8 and arg_199_1.time_ < var_202_7 + var_202_8 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect2079ui_story then
				arg_199_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_202_10 = 0
			local var_202_11 = 1.55

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_12 = arg_199_1:FormatText(StoryNameCfg[1184].name)

				arg_199_1.leftNameTxt_.text = var_202_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_13 = arg_199_1:GetWordFromCfg(321201049)
				local var_202_14 = arg_199_1:FormatText(var_202_13.content)

				arg_199_1.text_.text = var_202_14

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_15 = 62
				local var_202_16 = utf8.len(var_202_14)
				local var_202_17 = var_202_15 <= 0 and var_202_11 or var_202_11 * (var_202_16 / var_202_15)

				if var_202_17 > 0 and var_202_11 < var_202_17 then
					arg_199_1.talkMaxDuration = var_202_17

					if var_202_17 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_17 + var_202_10
					end
				end

				arg_199_1.text_.text = var_202_14
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201049", "story_v_out_321201.awb") ~= 0 then
					local var_202_18 = manager.audio:GetVoiceLength("story_v_out_321201", "321201049", "story_v_out_321201.awb") / 1000

					if var_202_18 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_18 + var_202_10
					end

					if var_202_13.prefab_name ~= "" and arg_199_1.actors_[var_202_13.prefab_name] ~= nil then
						local var_202_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_13.prefab_name].transform, "story_v_out_321201", "321201049", "story_v_out_321201.awb")

						arg_199_1:RecordAudio("321201049", var_202_19)
						arg_199_1:RecordAudio("321201049", var_202_19)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_321201", "321201049", "story_v_out_321201.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_321201", "321201049", "story_v_out_321201.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_20 = math.max(var_202_11, arg_199_1.talkMaxDuration)

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_20 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_10) / var_202_20

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_10 + var_202_20 and arg_199_1.time_ < var_202_10 + var_202_20 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play321201050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 321201050
		arg_203_1.duration_ = 2.77

		local var_203_0 = {
			zh = 2.4,
			ja = 2.766
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
				arg_203_0:Play321201051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["404001ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect404001ui_story == nil then
				arg_203_1.var_.characterEffect404001ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect404001ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect404001ui_story then
				arg_203_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_206_4 = arg_203_1.actors_["2079ui_story"]
			local var_206_5 = 0

			if var_206_5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect2079ui_story == nil then
				arg_203_1.var_.characterEffect2079ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_6 = 0.2

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_6 and not isNil(var_206_4) then
				local var_206_7 = (arg_203_1.time_ - var_206_5) / var_206_6

				if arg_203_1.var_.characterEffect2079ui_story and not isNil(var_206_4) then
					local var_206_8 = Mathf.Lerp(0, 0.5, var_206_7)

					arg_203_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_203_1.var_.characterEffect2079ui_story.fillRatio = var_206_8
				end
			end

			if arg_203_1.time_ >= var_206_5 + var_206_6 and arg_203_1.time_ < var_206_5 + var_206_6 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect2079ui_story then
				local var_206_9 = 0.5

				arg_203_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_203_1.var_.characterEffect2079ui_story.fillRatio = var_206_9
			end

			local var_206_10 = 0
			local var_206_11 = 0.275

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_12 = arg_203_1:FormatText(StoryNameCfg[668].name)

				arg_203_1.leftNameTxt_.text = var_206_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_13 = arg_203_1:GetWordFromCfg(321201050)
				local var_206_14 = arg_203_1:FormatText(var_206_13.content)

				arg_203_1.text_.text = var_206_14

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_15 = 11
				local var_206_16 = utf8.len(var_206_14)
				local var_206_17 = var_206_15 <= 0 and var_206_11 or var_206_11 * (var_206_16 / var_206_15)

				if var_206_17 > 0 and var_206_11 < var_206_17 then
					arg_203_1.talkMaxDuration = var_206_17

					if var_206_17 + var_206_10 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_17 + var_206_10
					end
				end

				arg_203_1.text_.text = var_206_14
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201050", "story_v_out_321201.awb") ~= 0 then
					local var_206_18 = manager.audio:GetVoiceLength("story_v_out_321201", "321201050", "story_v_out_321201.awb") / 1000

					if var_206_18 + var_206_10 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_18 + var_206_10
					end

					if var_206_13.prefab_name ~= "" and arg_203_1.actors_[var_206_13.prefab_name] ~= nil then
						local var_206_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_13.prefab_name].transform, "story_v_out_321201", "321201050", "story_v_out_321201.awb")

						arg_203_1:RecordAudio("321201050", var_206_19)
						arg_203_1:RecordAudio("321201050", var_206_19)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_321201", "321201050", "story_v_out_321201.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_321201", "321201050", "story_v_out_321201.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_20 = math.max(var_206_11, arg_203_1.talkMaxDuration)

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_20 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_10) / var_206_20

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_10 + var_206_20 and arg_203_1.time_ < var_206_10 + var_206_20 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play321201051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 321201051
		arg_207_1.duration_ = 4.4

		local var_207_0 = {
			zh = 2.7,
			ja = 4.4
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
				arg_207_0:Play321201052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["404001ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect404001ui_story == nil then
				arg_207_1.var_.characterEffect404001ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect404001ui_story and not isNil(var_210_0) then
					local var_210_4 = Mathf.Lerp(0, 0.5, var_210_3)

					arg_207_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_207_1.var_.characterEffect404001ui_story.fillRatio = var_210_4
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect404001ui_story then
				local var_210_5 = 0.5

				arg_207_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_207_1.var_.characterEffect404001ui_story.fillRatio = var_210_5
			end

			local var_210_6 = arg_207_1.actors_["2079ui_story"]
			local var_210_7 = 0

			if var_210_7 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect2079ui_story == nil then
				arg_207_1.var_.characterEffect2079ui_story = var_210_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_8 = 0.2

			if var_210_7 <= arg_207_1.time_ and arg_207_1.time_ < var_210_7 + var_210_8 and not isNil(var_210_6) then
				local var_210_9 = (arg_207_1.time_ - var_210_7) / var_210_8

				if arg_207_1.var_.characterEffect2079ui_story and not isNil(var_210_6) then
					arg_207_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_7 + var_210_8 and arg_207_1.time_ < var_210_7 + var_210_8 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect2079ui_story then
				arg_207_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_210_10 = 0
			local var_210_11 = 0.3

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_12 = arg_207_1:FormatText(StoryNameCfg[1184].name)

				arg_207_1.leftNameTxt_.text = var_210_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_13 = arg_207_1:GetWordFromCfg(321201051)
				local var_210_14 = arg_207_1:FormatText(var_210_13.content)

				arg_207_1.text_.text = var_210_14

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_15 = 12
				local var_210_16 = utf8.len(var_210_14)
				local var_210_17 = var_210_15 <= 0 and var_210_11 or var_210_11 * (var_210_16 / var_210_15)

				if var_210_17 > 0 and var_210_11 < var_210_17 then
					arg_207_1.talkMaxDuration = var_210_17

					if var_210_17 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_17 + var_210_10
					end
				end

				arg_207_1.text_.text = var_210_14
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201051", "story_v_out_321201.awb") ~= 0 then
					local var_210_18 = manager.audio:GetVoiceLength("story_v_out_321201", "321201051", "story_v_out_321201.awb") / 1000

					if var_210_18 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_18 + var_210_10
					end

					if var_210_13.prefab_name ~= "" and arg_207_1.actors_[var_210_13.prefab_name] ~= nil then
						local var_210_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_13.prefab_name].transform, "story_v_out_321201", "321201051", "story_v_out_321201.awb")

						arg_207_1:RecordAudio("321201051", var_210_19)
						arg_207_1:RecordAudio("321201051", var_210_19)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_321201", "321201051", "story_v_out_321201.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_321201", "321201051", "story_v_out_321201.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_20 = math.max(var_210_11, arg_207_1.talkMaxDuration)

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_20 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_10) / var_210_20

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_10 + var_210_20 and arg_207_1.time_ < var_210_10 + var_210_20 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play321201052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 321201052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play321201053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["404001ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos404001ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos404001ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = 0
			local var_214_10 = 0.625

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_11 = arg_211_1:GetWordFromCfg(321201052)
				local var_214_12 = arg_211_1:FormatText(var_214_11.content)

				arg_211_1.text_.text = var_214_12

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 25
				local var_214_14 = utf8.len(var_214_12)
				local var_214_15 = var_214_13 <= 0 and var_214_10 or var_214_10 * (var_214_14 / var_214_13)

				if var_214_15 > 0 and var_214_10 < var_214_15 then
					arg_211_1.talkMaxDuration = var_214_15

					if var_214_15 + var_214_9 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_15 + var_214_9
					end
				end

				arg_211_1.text_.text = var_214_12
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_10, arg_211_1.talkMaxDuration)

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_9) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_9 + var_214_16 and arg_211_1.time_ < var_214_9 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play321201053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 321201053
		arg_215_1.duration_ = 5

		local var_215_0 = {
			zh = 3.7,
			ja = 5
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play321201054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1011ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1011ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, -0.71, -6)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1011ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["1011ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1011ui_story == nil then
				arg_215_1.var_.characterEffect1011ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect1011ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect1011ui_story then
				arg_215_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_218_15 = 0
			local var_218_16 = 0.375

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[37].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(321201053)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 13
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201053", "story_v_out_321201.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_321201", "321201053", "story_v_out_321201.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_321201", "321201053", "story_v_out_321201.awb")

						arg_215_1:RecordAudio("321201053", var_218_24)
						arg_215_1:RecordAudio("321201053", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_321201", "321201053", "story_v_out_321201.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_321201", "321201053", "story_v_out_321201.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_25 and arg_215_1.time_ < var_218_15 + var_218_25 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play321201054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 321201054
		arg_219_1.duration_ = 4.77

		local var_219_0 = {
			zh = 3,
			ja = 4.766
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
				arg_219_0:Play321201055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1011ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos1011ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, -0.71, -6)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1011ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["1011ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1011ui_story == nil then
				arg_219_1.var_.characterEffect1011ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect1011ui_story and not isNil(var_222_9) then
					local var_222_13 = Mathf.Lerp(0, 0.5, var_222_12)

					arg_219_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1011ui_story.fillRatio = var_222_13
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect1011ui_story then
				local var_222_14 = 0.5

				arg_219_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1011ui_story.fillRatio = var_222_14
			end

			local var_222_15 = 0
			local var_222_16 = 0.3

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_17 = arg_219_1:FormatText(StoryNameCfg[668].name)

				arg_219_1.leftNameTxt_.text = var_222_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_18 = arg_219_1:GetWordFromCfg(321201054)
				local var_222_19 = arg_219_1:FormatText(var_222_18.content)

				arg_219_1.text_.text = var_222_19

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_20 = 12
				local var_222_21 = utf8.len(var_222_19)
				local var_222_22 = var_222_20 <= 0 and var_222_16 or var_222_16 * (var_222_21 / var_222_20)

				if var_222_22 > 0 and var_222_16 < var_222_22 then
					arg_219_1.talkMaxDuration = var_222_22

					if var_222_22 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_22 + var_222_15
					end
				end

				arg_219_1.text_.text = var_222_19
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201054", "story_v_out_321201.awb") ~= 0 then
					local var_222_23 = manager.audio:GetVoiceLength("story_v_out_321201", "321201054", "story_v_out_321201.awb") / 1000

					if var_222_23 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_23 + var_222_15
					end

					if var_222_18.prefab_name ~= "" and arg_219_1.actors_[var_222_18.prefab_name] ~= nil then
						local var_222_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_18.prefab_name].transform, "story_v_out_321201", "321201054", "story_v_out_321201.awb")

						arg_219_1:RecordAudio("321201054", var_222_24)
						arg_219_1:RecordAudio("321201054", var_222_24)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_321201", "321201054", "story_v_out_321201.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_321201", "321201054", "story_v_out_321201.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_25 = math.max(var_222_16, arg_219_1.talkMaxDuration)

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_25 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_15) / var_222_25

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_15 + var_222_25 and arg_219_1.time_ < var_222_15 + var_222_25 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play321201055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 321201055
		arg_223_1.duration_ = 3.27

		local var_223_0 = {
			zh = 3.1,
			ja = 3.266
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
			arg_223_1.auto_ = false
		end

		function arg_223_1.playNext_(arg_225_0)
			arg_223_1.onStoryFinished_()
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.325

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[668].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(321201055)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_321201", "321201055", "story_v_out_321201.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_321201", "321201055", "story_v_out_321201.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_321201", "321201055", "story_v_out_321201.awb")

						arg_223_1:RecordAudio("321201055", var_226_9)
						arg_223_1:RecordAudio("321201055", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_321201", "321201055", "story_v_out_321201.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_321201", "321201055", "story_v_out_321201.awb")
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
	assets = {
		"TextureConfig/Background/L15f"
	},
	voices = {
		"story_v_out_321201.awb"
	}
}
