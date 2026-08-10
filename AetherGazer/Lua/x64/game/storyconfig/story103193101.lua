return {
	Play319311001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319311001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319311002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "A08f"

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
				local var_4_5 = arg_1_1.bgs_.A08f

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
					if iter_4_0 ~= "A08f" then
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
			local var_4_35 = 1.125

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

				local var_4_37 = arg_1_1:GetWordFromCfg(319311001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 45
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
	Play319311002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319311002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319311003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.425

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

				local var_12_2 = arg_9_1:GetWordFromCfg(319311002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 57
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
	Play319311003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319311003
		arg_13_1.duration_ = 6.13

		local var_13_0 = {
			zh = 4.166,
			ja = 6.133
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
				arg_13_0:Play319311004(arg_13_1)
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

				local var_16_7 = "10079ui_story"

				arg_13_1:ShowWeapon(arg_13_1.var_[var_16_7 .. "Animator"].transform, false)
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(0, -0.95, -6.05)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10079ui_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_5.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_5.localEulerAngles = var_16_14
			end

			local var_16_15 = arg_13_1.actors_["10079ui_story"]
			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect10079ui_story == nil then
				arg_13_1.var_.characterEffect10079ui_story = var_16_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_17 = 0.200000002980232

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_17 and not isNil(var_16_15) then
				local var_16_18 = (arg_13_1.time_ - var_16_16) / var_16_17

				if arg_13_1.var_.characterEffect10079ui_story and not isNil(var_16_15) then
					arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect10079ui_story then
				arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_16_21 = 0
			local var_16_22 = 0.575

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

				local var_16_24 = arg_13_1:GetWordFromCfg(319311003)
				local var_16_25 = arg_13_1:FormatText(var_16_24.content)

				arg_13_1.text_.text = var_16_25

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_26 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311003", "story_v_out_319311.awb") ~= 0 then
					local var_16_29 = manager.audio:GetVoiceLength("story_v_out_319311", "319311003", "story_v_out_319311.awb") / 1000

					if var_16_29 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_29 + var_16_21
					end

					if var_16_24.prefab_name ~= "" and arg_13_1.actors_[var_16_24.prefab_name] ~= nil then
						local var_16_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_24.prefab_name].transform, "story_v_out_319311", "319311003", "story_v_out_319311.awb")

						arg_13_1:RecordAudio("319311003", var_16_30)
						arg_13_1:RecordAudio("319311003", var_16_30)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319311", "319311003", "story_v_out_319311.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319311", "319311003", "story_v_out_319311.awb")
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
	Play319311004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319311004
		arg_17_1.duration_ = 6.7

		local var_17_0 = {
			zh = 6.033,
			ja = 6.7
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
				arg_17_0:Play319311005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1095ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1095ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1095ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0.7, -0.98, -6.1)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1095ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1095ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect1095ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_20 = arg_17_1.actors_["10079ui_story"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos10079ui_story = var_20_20.localPosition
			end

			local var_20_22 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_21) / var_20_22
				local var_20_24 = Vector3.New(-0.7, -0.95, -6.05)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10079ui_story, var_20_24, var_20_23)

				local var_20_25 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_25.x, var_20_25.y, var_20_25.z)

				local var_20_26 = var_20_20.localEulerAngles

				var_20_26.z = 0
				var_20_26.x = 0
				var_20_20.localEulerAngles = var_20_26
			end

			if arg_17_1.time_ >= var_20_21 + var_20_22 and arg_17_1.time_ < var_20_21 + var_20_22 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_20_27 = manager.ui.mainCamera.transform.position - var_20_20.position

				var_20_20.forward = Vector3.New(var_20_27.x, var_20_27.y, var_20_27.z)

				local var_20_28 = var_20_20.localEulerAngles

				var_20_28.z = 0
				var_20_28.x = 0
				var_20_20.localEulerAngles = var_20_28
			end

			local var_20_29 = arg_17_1.actors_["10079ui_story"]
			local var_20_30 = 0

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect10079ui_story == nil then
				arg_17_1.var_.characterEffect10079ui_story = var_20_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_31 = 0.200000002980232

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_31 and not isNil(var_20_29) then
				local var_20_32 = (arg_17_1.time_ - var_20_30) / var_20_31

				if arg_17_1.var_.characterEffect10079ui_story and not isNil(var_20_29) then
					local var_20_33 = Mathf.Lerp(0, 0.5, var_20_32)

					arg_17_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10079ui_story.fillRatio = var_20_33
				end
			end

			if arg_17_1.time_ >= var_20_30 + var_20_31 and arg_17_1.time_ < var_20_30 + var_20_31 + arg_20_0 and not isNil(var_20_29) and arg_17_1.var_.characterEffect10079ui_story then
				local var_20_34 = 0.5

				arg_17_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10079ui_story.fillRatio = var_20_34
			end

			local var_20_35 = 0
			local var_20_36 = 0.7

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_37 = arg_17_1:FormatText(StoryNameCfg[471].name)

				arg_17_1.leftNameTxt_.text = var_20_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_38 = arg_17_1:GetWordFromCfg(319311004)
				local var_20_39 = arg_17_1:FormatText(var_20_38.content)

				arg_17_1.text_.text = var_20_39

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_40 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311004", "story_v_out_319311.awb") ~= 0 then
					local var_20_43 = manager.audio:GetVoiceLength("story_v_out_319311", "319311004", "story_v_out_319311.awb") / 1000

					if var_20_43 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_43 + var_20_35
					end

					if var_20_38.prefab_name ~= "" and arg_17_1.actors_[var_20_38.prefab_name] ~= nil then
						local var_20_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_38.prefab_name].transform, "story_v_out_319311", "319311004", "story_v_out_319311.awb")

						arg_17_1:RecordAudio("319311004", var_20_44)
						arg_17_1:RecordAudio("319311004", var_20_44)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319311", "319311004", "story_v_out_319311.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319311", "319311004", "story_v_out_319311.awb")
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
				actorName = "1095ui_story",
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

		arg_17_1:InitPlayNodeList()
	end,
	Play319311005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319311005
		arg_21_1.duration_ = 1.43

		local var_21_0 = {
			zh = 1,
			ja = 1.433
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
				arg_21_0:Play319311006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1095ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1095ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1095ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1095ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1095ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.075

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[643].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_9 = arg_21_1:GetWordFromCfg(319311005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311005", "story_v_out_319311.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311005", "story_v_out_319311.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_out_319311", "319311005", "story_v_out_319311.awb")

						arg_21_1:RecordAudio("319311005", var_24_15)
						arg_21_1:RecordAudio("319311005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319311", "319311005", "story_v_out_319311.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319311", "319311005", "story_v_out_319311.awb")
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
	Play319311006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319311006
		arg_25_1.duration_ = 8.4

		local var_25_0 = {
			zh = 6.066,
			ja = 8.4
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
				arg_25_0:Play319311007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "4040ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_25_1.stage_.transform)

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

			local var_28_5 = arg_25_1.actors_["4040ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos4040ui_story = var_28_5.localPosition
			end

			local var_28_7 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7
				local var_28_9 = Vector3.New(0, -1.55, -5.5)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos4040ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_28_12 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_12.x, var_28_12.y, var_28_12.z)

				local var_28_13 = var_28_5.localEulerAngles

				var_28_13.z = 0
				var_28_13.x = 0
				var_28_5.localEulerAngles = var_28_13
			end

			local var_28_14 = arg_25_1.actors_["4040ui_story"]
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect4040ui_story == nil then
				arg_25_1.var_.characterEffect4040ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_16 = 0.200000002980232

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 and not isNil(var_28_14) then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16

				if arg_25_1.var_.characterEffect4040ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect4040ui_story then
				arg_25_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_28_18 = 0

			if var_28_18 < arg_25_1.time_ and arg_25_1.time_ <= var_28_18 + arg_28_0 then
				arg_25_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_20 = arg_25_1.actors_["1095ui_story"].transform
			local var_28_21 = 0

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.var_.moveOldPos1095ui_story = var_28_20.localPosition
			end

			local var_28_22 = 0.001

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_22 then
				local var_28_23 = (arg_25_1.time_ - var_28_21) / var_28_22
				local var_28_24 = Vector3.New(0, 100, 0)

				var_28_20.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1095ui_story, var_28_24, var_28_23)

				local var_28_25 = manager.ui.mainCamera.transform.position - var_28_20.position

				var_28_20.forward = Vector3.New(var_28_25.x, var_28_25.y, var_28_25.z)

				local var_28_26 = var_28_20.localEulerAngles

				var_28_26.z = 0
				var_28_26.x = 0
				var_28_20.localEulerAngles = var_28_26
			end

			if arg_25_1.time_ >= var_28_21 + var_28_22 and arg_25_1.time_ < var_28_21 + var_28_22 + arg_28_0 then
				var_28_20.localPosition = Vector3.New(0, 100, 0)

				local var_28_27 = manager.ui.mainCamera.transform.position - var_28_20.position

				var_28_20.forward = Vector3.New(var_28_27.x, var_28_27.y, var_28_27.z)

				local var_28_28 = var_28_20.localEulerAngles

				var_28_28.z = 0
				var_28_28.x = 0
				var_28_20.localEulerAngles = var_28_28
			end

			local var_28_29 = arg_25_1.actors_["1095ui_story"]
			local var_28_30 = 0

			if var_28_30 < arg_25_1.time_ and arg_25_1.time_ <= var_28_30 + arg_28_0 and not isNil(var_28_29) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = var_28_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_31 = 0.200000002980232

			if var_28_30 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_31 and not isNil(var_28_29) then
				local var_28_32 = (arg_25_1.time_ - var_28_30) / var_28_31

				if arg_25_1.var_.characterEffect1095ui_story and not isNil(var_28_29) then
					local var_28_33 = Mathf.Lerp(0, 0.5, var_28_32)

					arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1095ui_story.fillRatio = var_28_33
				end
			end

			if arg_25_1.time_ >= var_28_30 + var_28_31 and arg_25_1.time_ < var_28_30 + var_28_31 + arg_28_0 and not isNil(var_28_29) and arg_25_1.var_.characterEffect1095ui_story then
				local var_28_34 = 0.5

				arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1095ui_story.fillRatio = var_28_34
			end

			local var_28_35 = arg_25_1.actors_["10079ui_story"].transform
			local var_28_36 = 0

			if var_28_36 < arg_25_1.time_ and arg_25_1.time_ <= var_28_36 + arg_28_0 then
				arg_25_1.var_.moveOldPos10079ui_story = var_28_35.localPosition
			end

			local var_28_37 = 0.001

			if var_28_36 <= arg_25_1.time_ and arg_25_1.time_ < var_28_36 + var_28_37 then
				local var_28_38 = (arg_25_1.time_ - var_28_36) / var_28_37
				local var_28_39 = Vector3.New(0, 100, 0)

				var_28_35.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10079ui_story, var_28_39, var_28_38)

				local var_28_40 = manager.ui.mainCamera.transform.position - var_28_35.position

				var_28_35.forward = Vector3.New(var_28_40.x, var_28_40.y, var_28_40.z)

				local var_28_41 = var_28_35.localEulerAngles

				var_28_41.z = 0
				var_28_41.x = 0
				var_28_35.localEulerAngles = var_28_41
			end

			if arg_25_1.time_ >= var_28_36 + var_28_37 and arg_25_1.time_ < var_28_36 + var_28_37 + arg_28_0 then
				var_28_35.localPosition = Vector3.New(0, 100, 0)

				local var_28_42 = manager.ui.mainCamera.transform.position - var_28_35.position

				var_28_35.forward = Vector3.New(var_28_42.x, var_28_42.y, var_28_42.z)

				local var_28_43 = var_28_35.localEulerAngles

				var_28_43.z = 0
				var_28_43.x = 0
				var_28_35.localEulerAngles = var_28_43
			end

			local var_28_44 = arg_25_1.actors_["10079ui_story"]
			local var_28_45 = 0

			if var_28_45 < arg_25_1.time_ and arg_25_1.time_ <= var_28_45 + arg_28_0 and not isNil(var_28_44) and arg_25_1.var_.characterEffect10079ui_story == nil then
				arg_25_1.var_.characterEffect10079ui_story = var_28_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_46 = 0.200000002980232

			if var_28_45 <= arg_25_1.time_ and arg_25_1.time_ < var_28_45 + var_28_46 and not isNil(var_28_44) then
				local var_28_47 = (arg_25_1.time_ - var_28_45) / var_28_46

				if arg_25_1.var_.characterEffect10079ui_story and not isNil(var_28_44) then
					local var_28_48 = Mathf.Lerp(0, 0.5, var_28_47)

					arg_25_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10079ui_story.fillRatio = var_28_48
				end
			end

			if arg_25_1.time_ >= var_28_45 + var_28_46 and arg_25_1.time_ < var_28_45 + var_28_46 + arg_28_0 and not isNil(var_28_44) and arg_25_1.var_.characterEffect10079ui_story then
				local var_28_49 = 0.5

				arg_25_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10079ui_story.fillRatio = var_28_49
			end

			local var_28_50 = 0
			local var_28_51 = 0.675

			if var_28_50 < arg_25_1.time_ and arg_25_1.time_ <= var_28_50 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_52 = arg_25_1:FormatText(StoryNameCfg[668].name)

				arg_25_1.leftNameTxt_.text = var_28_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_53 = arg_25_1:GetWordFromCfg(319311006)
				local var_28_54 = arg_25_1:FormatText(var_28_53.content)

				arg_25_1.text_.text = var_28_54

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_55 = 27
				local var_28_56 = utf8.len(var_28_54)
				local var_28_57 = var_28_55 <= 0 and var_28_51 or var_28_51 * (var_28_56 / var_28_55)

				if var_28_57 > 0 and var_28_51 < var_28_57 then
					arg_25_1.talkMaxDuration = var_28_57

					if var_28_57 + var_28_50 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_57 + var_28_50
					end
				end

				arg_25_1.text_.text = var_28_54
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311006", "story_v_out_319311.awb") ~= 0 then
					local var_28_58 = manager.audio:GetVoiceLength("story_v_out_319311", "319311006", "story_v_out_319311.awb") / 1000

					if var_28_58 + var_28_50 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_58 + var_28_50
					end

					if var_28_53.prefab_name ~= "" and arg_25_1.actors_[var_28_53.prefab_name] ~= nil then
						local var_28_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_53.prefab_name].transform, "story_v_out_319311", "319311006", "story_v_out_319311.awb")

						arg_25_1:RecordAudio("319311006", var_28_59)
						arg_25_1:RecordAudio("319311006", var_28_59)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319311", "319311006", "story_v_out_319311.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319311", "319311006", "story_v_out_319311.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_60 = math.max(var_28_51, arg_25_1.talkMaxDuration)

			if var_28_50 <= arg_25_1.time_ and arg_25_1.time_ < var_28_50 + var_28_60 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_50) / var_28_60

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_50 + var_28_60 and arg_25_1.time_ < var_28_50 + var_28_60 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
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

		arg_25_1:InitPlayNodeList()
	end,
	Play319311007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319311007
		arg_29_1.duration_ = 3.87

		local var_29_0 = {
			zh = 2.933,
			ja = 3.866
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
				arg_29_0:Play319311008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.3

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[668].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(319311007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 12
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311007", "story_v_out_319311.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_319311", "319311007", "story_v_out_319311.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_319311", "319311007", "story_v_out_319311.awb")

						arg_29_1:RecordAudio("319311007", var_32_9)
						arg_29_1:RecordAudio("319311007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319311", "319311007", "story_v_out_319311.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319311", "319311007", "story_v_out_319311.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319311008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319311008
		arg_33_1.duration_ = 6.7

		local var_33_0 = {
			zh = 3.4,
			ja = 6.7
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
				arg_33_0:Play319311009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1095ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1095ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0.7, -0.98, -6.1)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1095ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1095ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1095ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1095ui_story then
				arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_15 = arg_33_1.actors_["4040ui_story"].transform
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.var_.moveOldPos4040ui_story = var_36_15.localPosition
			end

			local var_36_17 = 0.001

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17
				local var_36_19 = Vector3.New(-0.7, -1.55, -5.5)

				var_36_15.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos4040ui_story, var_36_19, var_36_18)

				local var_36_20 = manager.ui.mainCamera.transform.position - var_36_15.position

				var_36_15.forward = Vector3.New(var_36_20.x, var_36_20.y, var_36_20.z)

				local var_36_21 = var_36_15.localEulerAngles

				var_36_21.z = 0
				var_36_21.x = 0
				var_36_15.localEulerAngles = var_36_21
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 then
				var_36_15.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_36_22 = manager.ui.mainCamera.transform.position - var_36_15.position

				var_36_15.forward = Vector3.New(var_36_22.x, var_36_22.y, var_36_22.z)

				local var_36_23 = var_36_15.localEulerAngles

				var_36_23.z = 0
				var_36_23.x = 0
				var_36_15.localEulerAngles = var_36_23
			end

			local var_36_24 = arg_33_1.actors_["4040ui_story"]
			local var_36_25 = 0

			if var_36_25 < arg_33_1.time_ and arg_33_1.time_ <= var_36_25 + arg_36_0 and not isNil(var_36_24) and arg_33_1.var_.characterEffect4040ui_story == nil then
				arg_33_1.var_.characterEffect4040ui_story = var_36_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_26 = 0.200000002980232

			if var_36_25 <= arg_33_1.time_ and arg_33_1.time_ < var_36_25 + var_36_26 and not isNil(var_36_24) then
				local var_36_27 = (arg_33_1.time_ - var_36_25) / var_36_26

				if arg_33_1.var_.characterEffect4040ui_story and not isNil(var_36_24) then
					local var_36_28 = Mathf.Lerp(0, 0.5, var_36_27)

					arg_33_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_33_1.var_.characterEffect4040ui_story.fillRatio = var_36_28
				end
			end

			if arg_33_1.time_ >= var_36_25 + var_36_26 and arg_33_1.time_ < var_36_25 + var_36_26 + arg_36_0 and not isNil(var_36_24) and arg_33_1.var_.characterEffect4040ui_story then
				local var_36_29 = 0.5

				arg_33_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_33_1.var_.characterEffect4040ui_story.fillRatio = var_36_29
			end

			local var_36_30 = 0
			local var_36_31 = 0.475

			if var_36_30 < arg_33_1.time_ and arg_33_1.time_ <= var_36_30 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_32 = arg_33_1:FormatText(StoryNameCfg[471].name)

				arg_33_1.leftNameTxt_.text = var_36_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_33 = arg_33_1:GetWordFromCfg(319311008)
				local var_36_34 = arg_33_1:FormatText(var_36_33.content)

				arg_33_1.text_.text = var_36_34

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_35 = 19
				local var_36_36 = utf8.len(var_36_34)
				local var_36_37 = var_36_35 <= 0 and var_36_31 or var_36_31 * (var_36_36 / var_36_35)

				if var_36_37 > 0 and var_36_31 < var_36_37 then
					arg_33_1.talkMaxDuration = var_36_37

					if var_36_37 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_37 + var_36_30
					end
				end

				arg_33_1.text_.text = var_36_34
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311008", "story_v_out_319311.awb") ~= 0 then
					local var_36_38 = manager.audio:GetVoiceLength("story_v_out_319311", "319311008", "story_v_out_319311.awb") / 1000

					if var_36_38 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_38 + var_36_30
					end

					if var_36_33.prefab_name ~= "" and arg_33_1.actors_[var_36_33.prefab_name] ~= nil then
						local var_36_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_33.prefab_name].transform, "story_v_out_319311", "319311008", "story_v_out_319311.awb")

						arg_33_1:RecordAudio("319311008", var_36_39)
						arg_33_1:RecordAudio("319311008", var_36_39)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319311", "319311008", "story_v_out_319311.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319311", "319311008", "story_v_out_319311.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_40 = math.max(var_36_31, arg_33_1.talkMaxDuration)

			if var_36_30 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_40 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_30) / var_36_40

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_30 + var_36_40 and arg_33_1.time_ < var_36_30 + var_36_40 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_33_1:InitPlayNodeList()
	end,
	Play319311009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319311009
		arg_37_1.duration_ = 3.47

		local var_37_0 = {
			zh = 2.733,
			ja = 3.466
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
				arg_37_0:Play319311010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1095ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1095ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1095ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1095ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1095ui_story.fillRatio = var_40_5
			end

			local var_40_6 = arg_37_1.actors_["4040ui_story"]
			local var_40_7 = 0

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect4040ui_story == nil then
				arg_37_1.var_.characterEffect4040ui_story = var_40_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_8 = 0.200000002980232

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 and not isNil(var_40_6) then
				local var_40_9 = (arg_37_1.time_ - var_40_7) / var_40_8

				if arg_37_1.var_.characterEffect4040ui_story and not isNil(var_40_6) then
					arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect4040ui_story then
				arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_11 = 0

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_40_12 = 0
			local var_40_13 = 0.175

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_14 = arg_37_1:FormatText(StoryNameCfg[668].name)

				arg_37_1.leftNameTxt_.text = var_40_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:GetWordFromCfg(319311009)
				local var_40_16 = arg_37_1:FormatText(var_40_15.content)

				arg_37_1.text_.text = var_40_16

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 7
				local var_40_18 = utf8.len(var_40_16)
				local var_40_19 = var_40_17 <= 0 and var_40_13 or var_40_13 * (var_40_18 / var_40_17)

				if var_40_19 > 0 and var_40_13 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19

					if var_40_19 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_16
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311009", "story_v_out_319311.awb") ~= 0 then
					local var_40_20 = manager.audio:GetVoiceLength("story_v_out_319311", "319311009", "story_v_out_319311.awb") / 1000

					if var_40_20 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_12
					end

					if var_40_15.prefab_name ~= "" and arg_37_1.actors_[var_40_15.prefab_name] ~= nil then
						local var_40_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_15.prefab_name].transform, "story_v_out_319311", "319311009", "story_v_out_319311.awb")

						arg_37_1:RecordAudio("319311009", var_40_21)
						arg_37_1:RecordAudio("319311009", var_40_21)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319311", "319311009", "story_v_out_319311.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319311", "319311009", "story_v_out_319311.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_22 and arg_37_1.time_ < var_40_12 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319311010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319311010
		arg_41_1.duration_ = 4.5

		local var_41_0 = {
			zh = 2.3,
			ja = 4.5
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
				arg_41_0:Play319311011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.375

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[668].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(319311010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311010", "story_v_out_319311.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_319311", "319311010", "story_v_out_319311.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_319311", "319311010", "story_v_out_319311.awb")

						arg_41_1:RecordAudio("319311010", var_44_9)
						arg_41_1:RecordAudio("319311010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319311", "319311010", "story_v_out_319311.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319311", "319311010", "story_v_out_319311.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319311011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319311011
		arg_45_1.duration_ = 6.8

		local var_45_0 = {
			zh = 6.8,
			ja = 6.5
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
				arg_45_0:Play319311012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1095ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1095ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0.7, -0.98, -6.1)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1095ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1095ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1095ui_story == nil then
				arg_45_1.var_.characterEffect1095ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1095ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1095ui_story then
				arg_45_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_15 = arg_45_1.actors_["4040ui_story"].transform
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.var_.moveOldPos4040ui_story = var_48_15.localPosition
			end

			local var_48_17 = 0.001

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17
				local var_48_19 = Vector3.New(-0.7, -1.55, -5.5)

				var_48_15.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos4040ui_story, var_48_19, var_48_18)

				local var_48_20 = manager.ui.mainCamera.transform.position - var_48_15.position

				var_48_15.forward = Vector3.New(var_48_20.x, var_48_20.y, var_48_20.z)

				local var_48_21 = var_48_15.localEulerAngles

				var_48_21.z = 0
				var_48_21.x = 0
				var_48_15.localEulerAngles = var_48_21
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 then
				var_48_15.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_48_22 = manager.ui.mainCamera.transform.position - var_48_15.position

				var_48_15.forward = Vector3.New(var_48_22.x, var_48_22.y, var_48_22.z)

				local var_48_23 = var_48_15.localEulerAngles

				var_48_23.z = 0
				var_48_23.x = 0
				var_48_15.localEulerAngles = var_48_23
			end

			local var_48_24 = arg_45_1.actors_["4040ui_story"]
			local var_48_25 = 0

			if var_48_25 < arg_45_1.time_ and arg_45_1.time_ <= var_48_25 + arg_48_0 and not isNil(var_48_24) and arg_45_1.var_.characterEffect4040ui_story == nil then
				arg_45_1.var_.characterEffect4040ui_story = var_48_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_26 = 0.200000002980232

			if var_48_25 <= arg_45_1.time_ and arg_45_1.time_ < var_48_25 + var_48_26 and not isNil(var_48_24) then
				local var_48_27 = (arg_45_1.time_ - var_48_25) / var_48_26

				if arg_45_1.var_.characterEffect4040ui_story and not isNil(var_48_24) then
					local var_48_28 = Mathf.Lerp(0, 0.5, var_48_27)

					arg_45_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_45_1.var_.characterEffect4040ui_story.fillRatio = var_48_28
				end
			end

			if arg_45_1.time_ >= var_48_25 + var_48_26 and arg_45_1.time_ < var_48_25 + var_48_26 + arg_48_0 and not isNil(var_48_24) and arg_45_1.var_.characterEffect4040ui_story then
				local var_48_29 = 0.5

				arg_45_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_45_1.var_.characterEffect4040ui_story.fillRatio = var_48_29
			end

			local var_48_30 = 0
			local var_48_31 = 0.75

			if var_48_30 < arg_45_1.time_ and arg_45_1.time_ <= var_48_30 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_32 = arg_45_1:FormatText(StoryNameCfg[471].name)

				arg_45_1.leftNameTxt_.text = var_48_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_33 = arg_45_1:GetWordFromCfg(319311011)
				local var_48_34 = arg_45_1:FormatText(var_48_33.content)

				arg_45_1.text_.text = var_48_34

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_35 = 30
				local var_48_36 = utf8.len(var_48_34)
				local var_48_37 = var_48_35 <= 0 and var_48_31 or var_48_31 * (var_48_36 / var_48_35)

				if var_48_37 > 0 and var_48_31 < var_48_37 then
					arg_45_1.talkMaxDuration = var_48_37

					if var_48_37 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_37 + var_48_30
					end
				end

				arg_45_1.text_.text = var_48_34
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311011", "story_v_out_319311.awb") ~= 0 then
					local var_48_38 = manager.audio:GetVoiceLength("story_v_out_319311", "319311011", "story_v_out_319311.awb") / 1000

					if var_48_38 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_38 + var_48_30
					end

					if var_48_33.prefab_name ~= "" and arg_45_1.actors_[var_48_33.prefab_name] ~= nil then
						local var_48_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_33.prefab_name].transform, "story_v_out_319311", "319311011", "story_v_out_319311.awb")

						arg_45_1:RecordAudio("319311011", var_48_39)
						arg_45_1:RecordAudio("319311011", var_48_39)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319311", "319311011", "story_v_out_319311.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319311", "319311011", "story_v_out_319311.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_40 = math.max(var_48_31, arg_45_1.talkMaxDuration)

			if var_48_30 <= arg_45_1.time_ and arg_45_1.time_ < var_48_30 + var_48_40 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_30) / var_48_40

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_30 + var_48_40 and arg_45_1.time_ < var_48_30 + var_48_40 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
	Play319311012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319311012
		arg_49_1.duration_ = 11.23

		local var_49_0 = {
			zh = 7,
			ja = 11.233
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
				arg_49_0:Play319311013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["4040ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect4040ui_story == nil then
				arg_49_1.var_.characterEffect4040ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect4040ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect4040ui_story then
				arg_49_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1095ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.characterEffect1095ui_story and not isNil(var_52_4) then
					local var_52_8 = Mathf.Lerp(0, 0.5, var_52_7)

					arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1095ui_story.fillRatio = var_52_8
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1095ui_story then
				local var_52_9 = 0.5

				arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1095ui_story.fillRatio = var_52_9
			end

			local var_52_10 = 0
			local var_52_11 = 0.775

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_12 = arg_49_1:FormatText(StoryNameCfg[668].name)

				arg_49_1.leftNameTxt_.text = var_52_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(319311012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 31
				local var_52_16 = utf8.len(var_52_14)
				local var_52_17 = var_52_15 <= 0 and var_52_11 or var_52_11 * (var_52_16 / var_52_15)

				if var_52_17 > 0 and var_52_11 < var_52_17 then
					arg_49_1.talkMaxDuration = var_52_17

					if var_52_17 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_10
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311012", "story_v_out_319311.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311012", "story_v_out_319311.awb") / 1000

					if var_52_18 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_10
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_319311", "319311012", "story_v_out_319311.awb")

						arg_49_1:RecordAudio("319311012", var_52_19)
						arg_49_1:RecordAudio("319311012", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319311", "319311012", "story_v_out_319311.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319311", "319311012", "story_v_out_319311.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_20 = math.max(var_52_11, arg_49_1.talkMaxDuration)

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_20 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_10) / var_52_20

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_10 + var_52_20 and arg_49_1.time_ < var_52_10 + var_52_20 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319311013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319311013
		arg_53_1.duration_ = 4.03

		local var_53_0 = {
			zh = 1.999999999999,
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
				arg_53_0:Play319311014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10079ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10079ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, -0.95, -6.05)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10079ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["10079ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect10079ui_story == nil then
				arg_53_1.var_.characterEffect10079ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect10079ui_story and not isNil(var_56_9) then
					arg_53_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect10079ui_story then
				arg_53_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_56_13 = 0

			if var_56_13 < arg_53_1.time_ and arg_53_1.time_ <= var_56_13 + arg_56_0 then
				arg_53_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_56_14 = 0

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_15 = arg_53_1.actors_["1095ui_story"].transform
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.var_.moveOldPos1095ui_story = var_56_15.localPosition
			end

			local var_56_17 = 0.001

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17
				local var_56_19 = Vector3.New(0, 100, 0)

				var_56_15.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1095ui_story, var_56_19, var_56_18)

				local var_56_20 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_20.x, var_56_20.y, var_56_20.z)

				local var_56_21 = var_56_15.localEulerAngles

				var_56_21.z = 0
				var_56_21.x = 0
				var_56_15.localEulerAngles = var_56_21
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				var_56_15.localPosition = Vector3.New(0, 100, 0)

				local var_56_22 = manager.ui.mainCamera.transform.position - var_56_15.position

				var_56_15.forward = Vector3.New(var_56_22.x, var_56_22.y, var_56_22.z)

				local var_56_23 = var_56_15.localEulerAngles

				var_56_23.z = 0
				var_56_23.x = 0
				var_56_15.localEulerAngles = var_56_23
			end

			local var_56_24 = arg_53_1.actors_["1095ui_story"]
			local var_56_25 = 0

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect1095ui_story == nil then
				arg_53_1.var_.characterEffect1095ui_story = var_56_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_26 = 0.200000002980232

			if var_56_25 <= arg_53_1.time_ and arg_53_1.time_ < var_56_25 + var_56_26 and not isNil(var_56_24) then
				local var_56_27 = (arg_53_1.time_ - var_56_25) / var_56_26

				if arg_53_1.var_.characterEffect1095ui_story and not isNil(var_56_24) then
					local var_56_28 = Mathf.Lerp(0, 0.5, var_56_27)

					arg_53_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1095ui_story.fillRatio = var_56_28
				end
			end

			if arg_53_1.time_ >= var_56_25 + var_56_26 and arg_53_1.time_ < var_56_25 + var_56_26 + arg_56_0 and not isNil(var_56_24) and arg_53_1.var_.characterEffect1095ui_story then
				local var_56_29 = 0.5

				arg_53_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1095ui_story.fillRatio = var_56_29
			end

			local var_56_30 = arg_53_1.actors_["4040ui_story"].transform
			local var_56_31 = 0

			if var_56_31 < arg_53_1.time_ and arg_53_1.time_ <= var_56_31 + arg_56_0 then
				arg_53_1.var_.moveOldPos4040ui_story = var_56_30.localPosition
			end

			local var_56_32 = 0.001

			if var_56_31 <= arg_53_1.time_ and arg_53_1.time_ < var_56_31 + var_56_32 then
				local var_56_33 = (arg_53_1.time_ - var_56_31) / var_56_32
				local var_56_34 = Vector3.New(0, 100, 0)

				var_56_30.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos4040ui_story, var_56_34, var_56_33)

				local var_56_35 = manager.ui.mainCamera.transform.position - var_56_30.position

				var_56_30.forward = Vector3.New(var_56_35.x, var_56_35.y, var_56_35.z)

				local var_56_36 = var_56_30.localEulerAngles

				var_56_36.z = 0
				var_56_36.x = 0
				var_56_30.localEulerAngles = var_56_36
			end

			if arg_53_1.time_ >= var_56_31 + var_56_32 and arg_53_1.time_ < var_56_31 + var_56_32 + arg_56_0 then
				var_56_30.localPosition = Vector3.New(0, 100, 0)

				local var_56_37 = manager.ui.mainCamera.transform.position - var_56_30.position

				var_56_30.forward = Vector3.New(var_56_37.x, var_56_37.y, var_56_37.z)

				local var_56_38 = var_56_30.localEulerAngles

				var_56_38.z = 0
				var_56_38.x = 0
				var_56_30.localEulerAngles = var_56_38
			end

			local var_56_39 = arg_53_1.actors_["4040ui_story"]
			local var_56_40 = 0

			if var_56_40 < arg_53_1.time_ and arg_53_1.time_ <= var_56_40 + arg_56_0 and not isNil(var_56_39) and arg_53_1.var_.characterEffect4040ui_story == nil then
				arg_53_1.var_.characterEffect4040ui_story = var_56_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_41 = 0.200000002980232

			if var_56_40 <= arg_53_1.time_ and arg_53_1.time_ < var_56_40 + var_56_41 and not isNil(var_56_39) then
				local var_56_42 = (arg_53_1.time_ - var_56_40) / var_56_41

				if arg_53_1.var_.characterEffect4040ui_story and not isNil(var_56_39) then
					local var_56_43 = Mathf.Lerp(0, 0.5, var_56_42)

					arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_53_1.var_.characterEffect4040ui_story.fillRatio = var_56_43
				end
			end

			if arg_53_1.time_ >= var_56_40 + var_56_41 and arg_53_1.time_ < var_56_40 + var_56_41 + arg_56_0 and not isNil(var_56_39) and arg_53_1.var_.characterEffect4040ui_story then
				local var_56_44 = 0.5

				arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_53_1.var_.characterEffect4040ui_story.fillRatio = var_56_44
			end

			local var_56_45 = 0
			local var_56_46 = 0.175

			if var_56_45 < arg_53_1.time_ and arg_53_1.time_ <= var_56_45 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_47 = arg_53_1:FormatText(StoryNameCfg[6].name)

				arg_53_1.leftNameTxt_.text = var_56_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_48 = arg_53_1:GetWordFromCfg(319311013)
				local var_56_49 = arg_53_1:FormatText(var_56_48.content)

				arg_53_1.text_.text = var_56_49

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_50 = 7
				local var_56_51 = utf8.len(var_56_49)
				local var_56_52 = var_56_50 <= 0 and var_56_46 or var_56_46 * (var_56_51 / var_56_50)

				if var_56_52 > 0 and var_56_46 < var_56_52 then
					arg_53_1.talkMaxDuration = var_56_52

					if var_56_52 + var_56_45 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_52 + var_56_45
					end
				end

				arg_53_1.text_.text = var_56_49
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311013", "story_v_out_319311.awb") ~= 0 then
					local var_56_53 = manager.audio:GetVoiceLength("story_v_out_319311", "319311013", "story_v_out_319311.awb") / 1000

					if var_56_53 + var_56_45 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_53 + var_56_45
					end

					if var_56_48.prefab_name ~= "" and arg_53_1.actors_[var_56_48.prefab_name] ~= nil then
						local var_56_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_48.prefab_name].transform, "story_v_out_319311", "319311013", "story_v_out_319311.awb")

						arg_53_1:RecordAudio("319311013", var_56_54)
						arg_53_1:RecordAudio("319311013", var_56_54)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319311", "319311013", "story_v_out_319311.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319311", "319311013", "story_v_out_319311.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_55 = math.max(var_56_46, arg_53_1.talkMaxDuration)

			if var_56_45 <= arg_53_1.time_ and arg_53_1.time_ < var_56_45 + var_56_55 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_45) / var_56_55

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_45 + var_56_55 and arg_53_1.time_ < var_56_45 + var_56_55 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_53_1:InitPlayNodeList()
	end,
	Play319311014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319311014
		arg_57_1.duration_ = 2.6

		local var_57_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_57_0:Play319311015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10079ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10079ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, 100, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10079ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, 100, 0)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_60_11 = arg_57_1.actors_["4040ui_story"].transform
			local var_60_12 = 0

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.var_.moveOldPos4040ui_story = var_60_11.localPosition
			end

			local var_60_13 = 0.001

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_13 then
				local var_60_14 = (arg_57_1.time_ - var_60_12) / var_60_13
				local var_60_15 = Vector3.New(0, -1.55, -5.5)

				var_60_11.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos4040ui_story, var_60_15, var_60_14)

				local var_60_16 = manager.ui.mainCamera.transform.position - var_60_11.position

				var_60_11.forward = Vector3.New(var_60_16.x, var_60_16.y, var_60_16.z)

				local var_60_17 = var_60_11.localEulerAngles

				var_60_17.z = 0
				var_60_17.x = 0
				var_60_11.localEulerAngles = var_60_17
			end

			if arg_57_1.time_ >= var_60_12 + var_60_13 and arg_57_1.time_ < var_60_12 + var_60_13 + arg_60_0 then
				var_60_11.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_60_18 = manager.ui.mainCamera.transform.position - var_60_11.position

				var_60_11.forward = Vector3.New(var_60_18.x, var_60_18.y, var_60_18.z)

				local var_60_19 = var_60_11.localEulerAngles

				var_60_19.z = 0
				var_60_19.x = 0
				var_60_11.localEulerAngles = var_60_19
			end

			local var_60_20 = arg_57_1.actors_["4040ui_story"]
			local var_60_21 = 0

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 and not isNil(var_60_20) and arg_57_1.var_.characterEffect4040ui_story == nil then
				arg_57_1.var_.characterEffect4040ui_story = var_60_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_22 = 0.200000002980232

			if var_60_21 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_22 and not isNil(var_60_20) then
				local var_60_23 = (arg_57_1.time_ - var_60_21) / var_60_22

				if arg_57_1.var_.characterEffect4040ui_story and not isNil(var_60_20) then
					arg_57_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_21 + var_60_22 and arg_57_1.time_ < var_60_21 + var_60_22 + arg_60_0 and not isNil(var_60_20) and arg_57_1.var_.characterEffect4040ui_story then
				arg_57_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_60_24 = 0
			local var_60_25 = 0.125

			if var_60_24 < arg_57_1.time_ and arg_57_1.time_ <= var_60_24 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_26 = arg_57_1:FormatText(StoryNameCfg[668].name)

				arg_57_1.leftNameTxt_.text = var_60_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_27 = arg_57_1:GetWordFromCfg(319311014)
				local var_60_28 = arg_57_1:FormatText(var_60_27.content)

				arg_57_1.text_.text = var_60_28

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_29 = 5
				local var_60_30 = utf8.len(var_60_28)
				local var_60_31 = var_60_29 <= 0 and var_60_25 or var_60_25 * (var_60_30 / var_60_29)

				if var_60_31 > 0 and var_60_25 < var_60_31 then
					arg_57_1.talkMaxDuration = var_60_31

					if var_60_31 + var_60_24 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_31 + var_60_24
					end
				end

				arg_57_1.text_.text = var_60_28
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311014", "story_v_out_319311.awb") ~= 0 then
					local var_60_32 = manager.audio:GetVoiceLength("story_v_out_319311", "319311014", "story_v_out_319311.awb") / 1000

					if var_60_32 + var_60_24 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_32 + var_60_24
					end

					if var_60_27.prefab_name ~= "" and arg_57_1.actors_[var_60_27.prefab_name] ~= nil then
						local var_60_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_27.prefab_name].transform, "story_v_out_319311", "319311014", "story_v_out_319311.awb")

						arg_57_1:RecordAudio("319311014", var_60_33)
						arg_57_1:RecordAudio("319311014", var_60_33)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319311", "319311014", "story_v_out_319311.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319311", "319311014", "story_v_out_319311.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_34 = math.max(var_60_25, arg_57_1.talkMaxDuration)

			if var_60_24 <= arg_57_1.time_ and arg_57_1.time_ < var_60_24 + var_60_34 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_24) / var_60_34

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_24 + var_60_34 and arg_57_1.time_ < var_60_24 + var_60_34 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_57_1:InitPlayNodeList()
	end,
	Play319311015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319311015
		arg_61_1.duration_ = 2.73

		local var_61_0 = {
			zh = 2.433,
			ja = 2.733
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
				arg_61_0:Play319311016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1095ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1095ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0.7, -0.98, -6.1)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1095ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1095ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1095ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_14 = arg_61_1.actors_["4040ui_story"]
			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.characterEffect4040ui_story == nil then
				arg_61_1.var_.characterEffect4040ui_story = var_64_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_16 = 0.200000002980232

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_16 and not isNil(var_64_14) then
				local var_64_17 = (arg_61_1.time_ - var_64_15) / var_64_16

				if arg_61_1.var_.characterEffect4040ui_story and not isNil(var_64_14) then
					local var_64_18 = Mathf.Lerp(0, 0.5, var_64_17)

					arg_61_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_61_1.var_.characterEffect4040ui_story.fillRatio = var_64_18
				end
			end

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.characterEffect4040ui_story then
				local var_64_19 = 0.5

				arg_61_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_61_1.var_.characterEffect4040ui_story.fillRatio = var_64_19
			end

			local var_64_20 = arg_61_1.actors_["4040ui_story"].transform
			local var_64_21 = 0

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				arg_61_1.var_.moveOldPos4040ui_story = var_64_20.localPosition
			end

			local var_64_22 = 0.001

			if var_64_21 <= arg_61_1.time_ and arg_61_1.time_ < var_64_21 + var_64_22 then
				local var_64_23 = (arg_61_1.time_ - var_64_21) / var_64_22
				local var_64_24 = Vector3.New(-0.7, -1.55, -5.5)

				var_64_20.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos4040ui_story, var_64_24, var_64_23)

				local var_64_25 = manager.ui.mainCamera.transform.position - var_64_20.position

				var_64_20.forward = Vector3.New(var_64_25.x, var_64_25.y, var_64_25.z)

				local var_64_26 = var_64_20.localEulerAngles

				var_64_26.z = 0
				var_64_26.x = 0
				var_64_20.localEulerAngles = var_64_26
			end

			if arg_61_1.time_ >= var_64_21 + var_64_22 and arg_61_1.time_ < var_64_21 + var_64_22 + arg_64_0 then
				var_64_20.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_64_27 = manager.ui.mainCamera.transform.position - var_64_20.position

				var_64_20.forward = Vector3.New(var_64_27.x, var_64_27.y, var_64_27.z)

				local var_64_28 = var_64_20.localEulerAngles

				var_64_28.z = 0
				var_64_28.x = 0
				var_64_20.localEulerAngles = var_64_28
			end

			local var_64_29 = 0
			local var_64_30 = 0.175

			if var_64_29 < arg_61_1.time_ and arg_61_1.time_ <= var_64_29 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_31 = arg_61_1:FormatText(StoryNameCfg[471].name)

				arg_61_1.leftNameTxt_.text = var_64_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_32 = arg_61_1:GetWordFromCfg(319311015)
				local var_64_33 = arg_61_1:FormatText(var_64_32.content)

				arg_61_1.text_.text = var_64_33

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_34 = 7
				local var_64_35 = utf8.len(var_64_33)
				local var_64_36 = var_64_34 <= 0 and var_64_30 or var_64_30 * (var_64_35 / var_64_34)

				if var_64_36 > 0 and var_64_30 < var_64_36 then
					arg_61_1.talkMaxDuration = var_64_36

					if var_64_36 + var_64_29 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_36 + var_64_29
					end
				end

				arg_61_1.text_.text = var_64_33
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311015", "story_v_out_319311.awb") ~= 0 then
					local var_64_37 = manager.audio:GetVoiceLength("story_v_out_319311", "319311015", "story_v_out_319311.awb") / 1000

					if var_64_37 + var_64_29 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_37 + var_64_29
					end

					if var_64_32.prefab_name ~= "" and arg_61_1.actors_[var_64_32.prefab_name] ~= nil then
						local var_64_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_32.prefab_name].transform, "story_v_out_319311", "319311015", "story_v_out_319311.awb")

						arg_61_1:RecordAudio("319311015", var_64_38)
						arg_61_1:RecordAudio("319311015", var_64_38)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319311", "319311015", "story_v_out_319311.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319311", "319311015", "story_v_out_319311.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_39 = math.max(var_64_30, arg_61_1.talkMaxDuration)

			if var_64_29 <= arg_61_1.time_ and arg_61_1.time_ < var_64_29 + var_64_39 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_29) / var_64_39

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_29 + var_64_39 and arg_61_1.time_ < var_64_29 + var_64_39 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
	Play319311016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319311016
		arg_65_1.duration_ = 4.53

		local var_65_0 = {
			zh = 4.533,
			ja = 1.999999999999
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
				arg_65_0:Play319311017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1095ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1095ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1095ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1095ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1095ui_story.fillRatio = var_68_5
			end

			local var_68_6 = arg_65_1.actors_["4040ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect4040ui_story == nil then
				arg_65_1.var_.characterEffect4040ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.200000002980232

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect4040ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect4040ui_story then
				arg_65_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			local var_68_11 = 0

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_12 = 0
			local var_68_13 = 0.45

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[668].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(319311016)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 18
				local var_68_18 = utf8.len(var_68_16)
				local var_68_19 = var_68_17 <= 0 and var_68_13 or var_68_13 * (var_68_18 / var_68_17)

				if var_68_19 > 0 and var_68_13 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311016", "story_v_out_319311.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_319311", "319311016", "story_v_out_319311.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_319311", "319311016", "story_v_out_319311.awb")

						arg_65_1:RecordAudio("319311016", var_68_21)
						arg_65_1:RecordAudio("319311016", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319311", "319311016", "story_v_out_319311.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319311", "319311016", "story_v_out_319311.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_22 and arg_65_1.time_ < var_68_12 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319311017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319311017
		arg_69_1.duration_ = 13.17

		local var_69_0 = {
			zh = 6.1,
			ja = 13.166
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
				arg_69_0:Play319311018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_2 = 0
			local var_72_3 = 0.75

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_4 = arg_69_1:FormatText(StoryNameCfg[668].name)

				arg_69_1.leftNameTxt_.text = var_72_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_5 = arg_69_1:GetWordFromCfg(319311017)
				local var_72_6 = arg_69_1:FormatText(var_72_5.content)

				arg_69_1.text_.text = var_72_6

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 30
				local var_72_8 = utf8.len(var_72_6)
				local var_72_9 = var_72_7 <= 0 and var_72_3 or var_72_3 * (var_72_8 / var_72_7)

				if var_72_9 > 0 and var_72_3 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_6
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311017", "story_v_out_319311.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_319311", "319311017", "story_v_out_319311.awb") / 1000

					if var_72_10 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_2
					end

					if var_72_5.prefab_name ~= "" and arg_69_1.actors_[var_72_5.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_5.prefab_name].transform, "story_v_out_319311", "319311017", "story_v_out_319311.awb")

						arg_69_1:RecordAudio("319311017", var_72_11)
						arg_69_1:RecordAudio("319311017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319311", "319311017", "story_v_out_319311.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319311", "319311017", "story_v_out_319311.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_12 and arg_69_1.time_ < var_72_2 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319311018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319311018
		arg_73_1.duration_ = 7.33

		local var_73_0 = {
			zh = 4.766,
			ja = 7.333
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
				arg_73_0:Play319311019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.8
			local var_76_1 = 0.2

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				local var_76_2 = "play"
				local var_76_3 = "effect"

				arg_73_1:AudioAction(var_76_2, var_76_3, "se_story_130", "se_story_130_didi", "")
			end

			local var_76_4 = 0
			local var_76_5 = 0.6

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_6 = arg_73_1:FormatText(StoryNameCfg[668].name)

				arg_73_1.leftNameTxt_.text = var_76_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(319311018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 24
				local var_76_10 = utf8.len(var_76_8)
				local var_76_11 = var_76_9 <= 0 and var_76_5 or var_76_5 * (var_76_10 / var_76_9)

				if var_76_11 > 0 and var_76_5 < var_76_11 then
					arg_73_1.talkMaxDuration = var_76_11

					if var_76_11 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311018", "story_v_out_319311.awb") ~= 0 then
					local var_76_12 = manager.audio:GetVoiceLength("story_v_out_319311", "319311018", "story_v_out_319311.awb") / 1000

					if var_76_12 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_4
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_319311", "319311018", "story_v_out_319311.awb")

						arg_73_1:RecordAudio("319311018", var_76_13)
						arg_73_1:RecordAudio("319311018", var_76_13)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319311", "319311018", "story_v_out_319311.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319311", "319311018", "story_v_out_319311.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_14 and arg_73_1.time_ < var_76_4 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319311019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319311019
		arg_77_1.duration_ = 4.63

		local var_77_0 = {
			zh = 4.366,
			ja = 4.633
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
				arg_77_0:Play319311020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["4040ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos4040ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos4040ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["4040ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect4040ui_story == nil then
				arg_77_1.var_.characterEffect4040ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect4040ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect4040ui_story then
				arg_77_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_80_14 = 0
			local var_80_15 = 0.425

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_16 = arg_77_1:FormatText(StoryNameCfg[668].name)

				arg_77_1.leftNameTxt_.text = var_80_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_17 = arg_77_1:GetWordFromCfg(319311019)
				local var_80_18 = arg_77_1:FormatText(var_80_17.content)

				arg_77_1.text_.text = var_80_18

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_19 = 17
				local var_80_20 = utf8.len(var_80_18)
				local var_80_21 = var_80_19 <= 0 and var_80_15 or var_80_15 * (var_80_20 / var_80_19)

				if var_80_21 > 0 and var_80_15 < var_80_21 then
					arg_77_1.talkMaxDuration = var_80_21

					if var_80_21 + var_80_14 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_21 + var_80_14
					end
				end

				arg_77_1.text_.text = var_80_18
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311019", "story_v_out_319311.awb") ~= 0 then
					local var_80_22 = manager.audio:GetVoiceLength("story_v_out_319311", "319311019", "story_v_out_319311.awb") / 1000

					if var_80_22 + var_80_14 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_14
					end

					if var_80_17.prefab_name ~= "" and arg_77_1.actors_[var_80_17.prefab_name] ~= nil then
						local var_80_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_17.prefab_name].transform, "story_v_out_319311", "319311019", "story_v_out_319311.awb")

						arg_77_1:RecordAudio("319311019", var_80_23)
						arg_77_1:RecordAudio("319311019", var_80_23)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319311", "319311019", "story_v_out_319311.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319311", "319311019", "story_v_out_319311.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_24 = math.max(var_80_15, arg_77_1.talkMaxDuration)

			if var_80_14 <= arg_77_1.time_ and arg_77_1.time_ < var_80_14 + var_80_24 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_14) / var_80_24

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_14 + var_80_24 and arg_77_1.time_ < var_80_14 + var_80_24 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play319311020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319311020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play319311021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["4040ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect4040ui_story == nil then
				arg_81_1.var_.characterEffect4040ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect4040ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_81_1.var_.characterEffect4040ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect4040ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_81_1.var_.characterEffect4040ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 1.4

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(319311020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 56
				local var_84_11 = utf8.len(var_84_9)
				local var_84_12 = var_84_10 <= 0 and var_84_7 or var_84_7 * (var_84_11 / var_84_10)

				if var_84_12 > 0 and var_84_7 < var_84_12 then
					arg_81_1.talkMaxDuration = var_84_12

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_13 and arg_81_1.time_ < var_84_6 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play319311021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319311021
		arg_85_1.duration_ = 2.8

		local var_85_0 = {
			zh = 1.766,
			ja = 2.8
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
				arg_85_0:Play319311022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1095ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1095ui_story == nil then
				arg_85_1.var_.characterEffect1095ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1095ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1095ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1095ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1095ui_story.fillRatio = var_88_5
			end

			local var_88_6 = arg_85_1.actors_["4040ui_story"]
			local var_88_7 = 0

			if var_88_7 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect4040ui_story == nil then
				arg_85_1.var_.characterEffect4040ui_story = var_88_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_8 = 0.200000002980232

			if var_88_7 <= arg_85_1.time_ and arg_85_1.time_ < var_88_7 + var_88_8 and not isNil(var_88_6) then
				local var_88_9 = (arg_85_1.time_ - var_88_7) / var_88_8

				if arg_85_1.var_.characterEffect4040ui_story and not isNil(var_88_6) then
					arg_85_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_7 + var_88_8 and arg_85_1.time_ < var_88_7 + var_88_8 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect4040ui_story then
				arg_85_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_88_10 = 0
			local var_88_11 = 0.175

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_12 = arg_85_1:FormatText(StoryNameCfg[668].name)

				arg_85_1.leftNameTxt_.text = var_88_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_13 = arg_85_1:GetWordFromCfg(319311021)
				local var_88_14 = arg_85_1:FormatText(var_88_13.content)

				arg_85_1.text_.text = var_88_14

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_15 = 7
				local var_88_16 = utf8.len(var_88_14)
				local var_88_17 = var_88_15 <= 0 and var_88_11 or var_88_11 * (var_88_16 / var_88_15)

				if var_88_17 > 0 and var_88_11 < var_88_17 then
					arg_85_1.talkMaxDuration = var_88_17

					if var_88_17 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_17 + var_88_10
					end
				end

				arg_85_1.text_.text = var_88_14
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311021", "story_v_out_319311.awb") ~= 0 then
					local var_88_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311021", "story_v_out_319311.awb") / 1000

					if var_88_18 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_18 + var_88_10
					end

					if var_88_13.prefab_name ~= "" and arg_85_1.actors_[var_88_13.prefab_name] ~= nil then
						local var_88_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_13.prefab_name].transform, "story_v_out_319311", "319311021", "story_v_out_319311.awb")

						arg_85_1:RecordAudio("319311021", var_88_19)
						arg_85_1:RecordAudio("319311021", var_88_19)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319311", "319311021", "story_v_out_319311.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319311", "319311021", "story_v_out_319311.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_20 = math.max(var_88_11, arg_85_1.talkMaxDuration)

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_20 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_10) / var_88_20

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_10 + var_88_20 and arg_85_1.time_ < var_88_10 + var_88_20 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play319311022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319311022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319311023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1095ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1095ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, 100, 0)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1095ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, 100, 0)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1095ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1095ui_story == nil then
				arg_89_1.var_.characterEffect1095ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1095ui_story and not isNil(var_92_9) then
					local var_92_13 = Mathf.Lerp(0, 0.5, var_92_12)

					arg_89_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1095ui_story.fillRatio = var_92_13
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1095ui_story then
				local var_92_14 = 0.5

				arg_89_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1095ui_story.fillRatio = var_92_14
			end

			local var_92_15 = arg_89_1.actors_["4040ui_story"].transform
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.var_.moveOldPos4040ui_story = var_92_15.localPosition
			end

			local var_92_17 = 0.001

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17
				local var_92_19 = Vector3.New(0, 100, 0)

				var_92_15.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos4040ui_story, var_92_19, var_92_18)

				local var_92_20 = manager.ui.mainCamera.transform.position - var_92_15.position

				var_92_15.forward = Vector3.New(var_92_20.x, var_92_20.y, var_92_20.z)

				local var_92_21 = var_92_15.localEulerAngles

				var_92_21.z = 0
				var_92_21.x = 0
				var_92_15.localEulerAngles = var_92_21
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 then
				var_92_15.localPosition = Vector3.New(0, 100, 0)

				local var_92_22 = manager.ui.mainCamera.transform.position - var_92_15.position

				var_92_15.forward = Vector3.New(var_92_22.x, var_92_22.y, var_92_22.z)

				local var_92_23 = var_92_15.localEulerAngles

				var_92_23.z = 0
				var_92_23.x = 0
				var_92_15.localEulerAngles = var_92_23
			end

			local var_92_24 = arg_89_1.actors_["4040ui_story"]
			local var_92_25 = 0

			if var_92_25 < arg_89_1.time_ and arg_89_1.time_ <= var_92_25 + arg_92_0 and not isNil(var_92_24) and arg_89_1.var_.characterEffect4040ui_story == nil then
				arg_89_1.var_.characterEffect4040ui_story = var_92_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_26 = 0.200000002980232

			if var_92_25 <= arg_89_1.time_ and arg_89_1.time_ < var_92_25 + var_92_26 and not isNil(var_92_24) then
				local var_92_27 = (arg_89_1.time_ - var_92_25) / var_92_26

				if arg_89_1.var_.characterEffect4040ui_story and not isNil(var_92_24) then
					local var_92_28 = Mathf.Lerp(0, 0.5, var_92_27)

					arg_89_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_89_1.var_.characterEffect4040ui_story.fillRatio = var_92_28
				end
			end

			if arg_89_1.time_ >= var_92_25 + var_92_26 and arg_89_1.time_ < var_92_25 + var_92_26 + arg_92_0 and not isNil(var_92_24) and arg_89_1.var_.characterEffect4040ui_story then
				local var_92_29 = 0.5

				arg_89_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_89_1.var_.characterEffect4040ui_story.fillRatio = var_92_29
			end

			local var_92_30 = 0
			local var_92_31 = 0.975

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_32 = arg_89_1:GetWordFromCfg(319311022)
				local var_92_33 = arg_89_1:FormatText(var_92_32.content)

				arg_89_1.text_.text = var_92_33

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_34 = 39
				local var_92_35 = utf8.len(var_92_33)
				local var_92_36 = var_92_34 <= 0 and var_92_31 or var_92_31 * (var_92_35 / var_92_34)

				if var_92_36 > 0 and var_92_31 < var_92_36 then
					arg_89_1.talkMaxDuration = var_92_36

					if var_92_36 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_36 + var_92_30
					end
				end

				arg_89_1.text_.text = var_92_33
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_37 = math.max(var_92_31, arg_89_1.talkMaxDuration)

			if var_92_30 <= arg_89_1.time_ and arg_89_1.time_ < var_92_30 + var_92_37 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_30) / var_92_37

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_30 + var_92_37 and arg_89_1.time_ < var_92_30 + var_92_37 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_89_1:InitPlayNodeList()
	end,
	Play319311023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319311023
		arg_93_1.duration_ = 5.57

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319311024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = manager.ui.mainCamera.transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				local var_96_2 = arg_93_1.var_.effect919
				local var_96_3
				local var_96_4 = var_96_0

				if not var_96_2 then
					var_96_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), var_96_4)
					var_96_2.name = "919"
					arg_93_1.var_.effect919 = var_96_2
				else
					var_96_2.transform:SetParent(var_96_4)
				end

				var_96_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_96_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_5 = 0.566666666666667
			local var_96_6 = 1.025

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_7 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_7:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(319311023)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 41
				local var_96_11 = utf8.len(var_96_9)
				local var_96_12 = var_96_10 <= 0 and var_96_6 or var_96_6 * (var_96_11 / var_96_10)

				if var_96_12 > 0 and var_96_6 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12
					var_96_5 = var_96_5 + 0.3

					if var_96_12 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = var_96_5 + 0.3
			local var_96_14 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_13 <= arg_93_1.time_ and arg_93_1.time_ < var_96_13 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_13) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_13 + var_96_14 and arg_93_1.time_ < var_96_13 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319311024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319311024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play319311025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = manager.ui.mainCamera.transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				local var_102_2 = arg_99_1.var_.effect919

				if var_102_2 then
					Object.Destroy(var_102_2)

					arg_99_1.var_.effect919 = nil
				end
			end

			local var_102_3 = 0
			local var_102_4 = 1.025

			if var_102_3 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_5 = arg_99_1:GetWordFromCfg(319311024)
				local var_102_6 = arg_99_1:FormatText(var_102_5.content)

				arg_99_1.text_.text = var_102_6

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 41
				local var_102_8 = utf8.len(var_102_6)
				local var_102_9 = var_102_7 <= 0 and var_102_4 or var_102_4 * (var_102_8 / var_102_7)

				if var_102_9 > 0 and var_102_4 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_3
					end
				end

				arg_99_1.text_.text = var_102_6
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_4, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_3) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_10 and arg_99_1.time_ < var_102_3 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play319311025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319311025
		arg_103_1.duration_ = 3.7

		local var_103_0 = {
			zh = 3.066,
			ja = 3.7
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
				arg_103_0:Play319311026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10079ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos10079ui_story = var_106_0.localPosition

				local var_106_2 = "10079ui_story"

				arg_103_1:ShowWeapon(arg_103_1.var_[var_106_2 .. "Animator"].transform, false)
			end

			local var_106_3 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_3 then
				local var_106_4 = (arg_103_1.time_ - var_106_1) / var_106_3
				local var_106_5 = Vector3.New(0, -0.95, -6.05)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10079ui_story, var_106_5, var_106_4)

				local var_106_6 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_6.x, var_106_6.y, var_106_6.z)

				local var_106_7 = var_106_0.localEulerAngles

				var_106_7.z = 0
				var_106_7.x = 0
				var_106_0.localEulerAngles = var_106_7
			end

			if arg_103_1.time_ >= var_106_1 + var_106_3 and arg_103_1.time_ < var_106_1 + var_106_3 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_106_8 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_8.x, var_106_8.y, var_106_8.z)

				local var_106_9 = var_106_0.localEulerAngles

				var_106_9.z = 0
				var_106_9.x = 0
				var_106_0.localEulerAngles = var_106_9
			end

			local var_106_10 = arg_103_1.actors_["10079ui_story"]
			local var_106_11 = 0

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 and not isNil(var_106_10) and arg_103_1.var_.characterEffect10079ui_story == nil then
				arg_103_1.var_.characterEffect10079ui_story = var_106_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_12 = 0.200000002980232

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_12 and not isNil(var_106_10) then
				local var_106_13 = (arg_103_1.time_ - var_106_11) / var_106_12

				if arg_103_1.var_.characterEffect10079ui_story and not isNil(var_106_10) then
					arg_103_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_11 + var_106_12 and arg_103_1.time_ < var_106_11 + var_106_12 + arg_106_0 and not isNil(var_106_10) and arg_103_1.var_.characterEffect10079ui_story then
				arg_103_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_106_14 = 0

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_106_15 = 0

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_106_16 = 0
			local var_106_17 = 0.35

			if var_106_16 < arg_103_1.time_ and arg_103_1.time_ <= var_106_16 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_18 = arg_103_1:FormatText(StoryNameCfg[6].name)

				arg_103_1.leftNameTxt_.text = var_106_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_19 = arg_103_1:GetWordFromCfg(319311025)
				local var_106_20 = arg_103_1:FormatText(var_106_19.content)

				arg_103_1.text_.text = var_106_20

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_21 = 14
				local var_106_22 = utf8.len(var_106_20)
				local var_106_23 = var_106_21 <= 0 and var_106_17 or var_106_17 * (var_106_22 / var_106_21)

				if var_106_23 > 0 and var_106_17 < var_106_23 then
					arg_103_1.talkMaxDuration = var_106_23

					if var_106_23 + var_106_16 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_16
					end
				end

				arg_103_1.text_.text = var_106_20
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311025", "story_v_out_319311.awb") ~= 0 then
					local var_106_24 = manager.audio:GetVoiceLength("story_v_out_319311", "319311025", "story_v_out_319311.awb") / 1000

					if var_106_24 + var_106_16 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_24 + var_106_16
					end

					if var_106_19.prefab_name ~= "" and arg_103_1.actors_[var_106_19.prefab_name] ~= nil then
						local var_106_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_19.prefab_name].transform, "story_v_out_319311", "319311025", "story_v_out_319311.awb")

						arg_103_1:RecordAudio("319311025", var_106_25)
						arg_103_1:RecordAudio("319311025", var_106_25)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_319311", "319311025", "story_v_out_319311.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_319311", "319311025", "story_v_out_319311.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_26 = math.max(var_106_17, arg_103_1.talkMaxDuration)

			if var_106_16 <= arg_103_1.time_ and arg_103_1.time_ < var_106_16 + var_106_26 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_16) / var_106_26

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_16 + var_106_26 and arg_103_1.time_ < var_106_16 + var_106_26 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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

		arg_103_1:InitPlayNodeList()
	end,
	Play319311026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319311026
		arg_107_1.duration_ = 7.97

		local var_107_0 = {
			zh = 5.433,
			ja = 7.966
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
				arg_107_0:Play319311027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10079ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10079ui_story == nil then
				arg_107_1.var_.characterEffect10079ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect10079ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10079ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect10079ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10079ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 1

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				local var_110_8 = "stop"
				local var_110_9 = "effect"

				arg_107_1:AudioAction(var_110_8, var_110_9, "se_story_130", "se_story_130_didi", "")
			end

			local var_110_10 = 0
			local var_110_11 = 0.425

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_12 = arg_107_1:FormatText(StoryNameCfg[696].name)

				arg_107_1.leftNameTxt_.text = var_110_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_13 = arg_107_1:GetWordFromCfg(319311026)
				local var_110_14 = arg_107_1:FormatText(var_110_13.content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_15 = 17
				local var_110_16 = utf8.len(var_110_14)
				local var_110_17 = var_110_15 <= 0 and var_110_11 or var_110_11 * (var_110_16 / var_110_15)

				if var_110_17 > 0 and var_110_11 < var_110_17 then
					arg_107_1.talkMaxDuration = var_110_17

					if var_110_17 + var_110_10 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_10
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311026", "story_v_out_319311.awb") ~= 0 then
					local var_110_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311026", "story_v_out_319311.awb") / 1000

					if var_110_18 + var_110_10 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_18 + var_110_10
					end

					if var_110_13.prefab_name ~= "" and arg_107_1.actors_[var_110_13.prefab_name] ~= nil then
						local var_110_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_13.prefab_name].transform, "story_v_out_319311", "319311026", "story_v_out_319311.awb")

						arg_107_1:RecordAudio("319311026", var_110_19)
						arg_107_1:RecordAudio("319311026", var_110_19)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_319311", "319311026", "story_v_out_319311.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_319311", "319311026", "story_v_out_319311.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_20 = math.max(var_110_11, arg_107_1.talkMaxDuration)

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_20 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_10) / var_110_20

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_10 + var_110_20 and arg_107_1.time_ < var_110_10 + var_110_20 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play319311027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319311027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play319311028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 1.45

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(319311027)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 58
				local var_114_5 = utf8.len(var_114_3)
				local var_114_6 = var_114_4 <= 0 and var_114_1 or var_114_1 * (var_114_5 / var_114_4)

				if var_114_6 > 0 and var_114_1 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_7 and arg_111_1.time_ < var_114_0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319311028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319311028
		arg_115_1.duration_ = 6.67

		local var_115_0 = {
			zh = 4.7,
			ja = 6.666
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
				arg_115_0:Play319311029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10079ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos10079ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0, 100, 0)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10079ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, 100, 0)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["10079ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect10079ui_story == nil then
				arg_115_1.var_.characterEffect10079ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect10079ui_story and not isNil(var_118_9) then
					local var_118_13 = Mathf.Lerp(0, 0.5, var_118_12)

					arg_115_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10079ui_story.fillRatio = var_118_13
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect10079ui_story then
				local var_118_14 = 0.5

				arg_115_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10079ui_story.fillRatio = var_118_14
			end

			local var_118_15 = arg_115_1.actors_["4040ui_story"].transform
			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.var_.moveOldPos4040ui_story = var_118_15.localPosition
			end

			local var_118_17 = 0.001

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_17 then
				local var_118_18 = (arg_115_1.time_ - var_118_16) / var_118_17
				local var_118_19 = Vector3.New(0, -1.55, -5.5)

				var_118_15.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos4040ui_story, var_118_19, var_118_18)

				local var_118_20 = manager.ui.mainCamera.transform.position - var_118_15.position

				var_118_15.forward = Vector3.New(var_118_20.x, var_118_20.y, var_118_20.z)

				local var_118_21 = var_118_15.localEulerAngles

				var_118_21.z = 0
				var_118_21.x = 0
				var_118_15.localEulerAngles = var_118_21
			end

			if arg_115_1.time_ >= var_118_16 + var_118_17 and arg_115_1.time_ < var_118_16 + var_118_17 + arg_118_0 then
				var_118_15.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_118_22 = manager.ui.mainCamera.transform.position - var_118_15.position

				var_118_15.forward = Vector3.New(var_118_22.x, var_118_22.y, var_118_22.z)

				local var_118_23 = var_118_15.localEulerAngles

				var_118_23.z = 0
				var_118_23.x = 0
				var_118_15.localEulerAngles = var_118_23
			end

			local var_118_24 = arg_115_1.actors_["4040ui_story"]
			local var_118_25 = 0

			if var_118_25 < arg_115_1.time_ and arg_115_1.time_ <= var_118_25 + arg_118_0 and not isNil(var_118_24) and arg_115_1.var_.characterEffect4040ui_story == nil then
				arg_115_1.var_.characterEffect4040ui_story = var_118_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_26 = 0.200000002980232

			if var_118_25 <= arg_115_1.time_ and arg_115_1.time_ < var_118_25 + var_118_26 and not isNil(var_118_24) then
				local var_118_27 = (arg_115_1.time_ - var_118_25) / var_118_26

				if arg_115_1.var_.characterEffect4040ui_story and not isNil(var_118_24) then
					arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_25 + var_118_26 and arg_115_1.time_ < var_118_25 + var_118_26 + arg_118_0 and not isNil(var_118_24) and arg_115_1.var_.characterEffect4040ui_story then
				arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_118_28 = 0

			if var_118_28 < arg_115_1.time_ and arg_115_1.time_ <= var_118_28 + arg_118_0 then
				arg_115_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_118_29 = 0

			if var_118_29 < arg_115_1.time_ and arg_115_1.time_ <= var_118_29 + arg_118_0 then
				arg_115_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_30 = 0
			local var_118_31 = 0.525

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_32 = arg_115_1:FormatText(StoryNameCfg[668].name)

				arg_115_1.leftNameTxt_.text = var_118_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_33 = arg_115_1:GetWordFromCfg(319311028)
				local var_118_34 = arg_115_1:FormatText(var_118_33.content)

				arg_115_1.text_.text = var_118_34

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_35 = 21
				local var_118_36 = utf8.len(var_118_34)
				local var_118_37 = var_118_35 <= 0 and var_118_31 or var_118_31 * (var_118_36 / var_118_35)

				if var_118_37 > 0 and var_118_31 < var_118_37 then
					arg_115_1.talkMaxDuration = var_118_37

					if var_118_37 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_37 + var_118_30
					end
				end

				arg_115_1.text_.text = var_118_34
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311028", "story_v_out_319311.awb") ~= 0 then
					local var_118_38 = manager.audio:GetVoiceLength("story_v_out_319311", "319311028", "story_v_out_319311.awb") / 1000

					if var_118_38 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_38 + var_118_30
					end

					if var_118_33.prefab_name ~= "" and arg_115_1.actors_[var_118_33.prefab_name] ~= nil then
						local var_118_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_33.prefab_name].transform, "story_v_out_319311", "319311028", "story_v_out_319311.awb")

						arg_115_1:RecordAudio("319311028", var_118_39)
						arg_115_1:RecordAudio("319311028", var_118_39)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319311", "319311028", "story_v_out_319311.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319311", "319311028", "story_v_out_319311.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_40 = math.max(var_118_31, arg_115_1.talkMaxDuration)

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_40 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_30) / var_118_40

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_30 + var_118_40 and arg_115_1.time_ < var_118_30 + var_118_40 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_115_1:InitPlayNodeList()
	end,
	Play319311029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319311029
		arg_119_1.duration_ = 2.93

		local var_119_0 = {
			zh = 2.633,
			ja = 2.933
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
				arg_119_0:Play319311030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["4040ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect4040ui_story == nil then
				arg_119_1.var_.characterEffect4040ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect4040ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_119_1.var_.characterEffect4040ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect4040ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_119_1.var_.characterEffect4040ui_story.fillRatio = var_122_5
			end

			local var_122_6 = arg_119_1.actors_["10079ui_story"]
			local var_122_7 = 0

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect10079ui_story == nil then
				arg_119_1.var_.characterEffect10079ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_8 = 0.200000002980232

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 and not isNil(var_122_6) then
				local var_122_9 = (arg_119_1.time_ - var_122_7) / var_122_8

				if arg_119_1.var_.characterEffect10079ui_story and not isNil(var_122_6) then
					arg_119_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect10079ui_story then
				arg_119_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_122_11 = arg_119_1.actors_["4040ui_story"].transform
			local var_122_12 = 0

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.var_.moveOldPos4040ui_story = var_122_11.localPosition
			end

			local var_122_13 = 0.001

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_13 then
				local var_122_14 = (arg_119_1.time_ - var_122_12) / var_122_13
				local var_122_15 = Vector3.New(-0.7, -1.55, -5.5)

				var_122_11.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos4040ui_story, var_122_15, var_122_14)

				local var_122_16 = manager.ui.mainCamera.transform.position - var_122_11.position

				var_122_11.forward = Vector3.New(var_122_16.x, var_122_16.y, var_122_16.z)

				local var_122_17 = var_122_11.localEulerAngles

				var_122_17.z = 0
				var_122_17.x = 0
				var_122_11.localEulerAngles = var_122_17
			end

			if arg_119_1.time_ >= var_122_12 + var_122_13 and arg_119_1.time_ < var_122_12 + var_122_13 + arg_122_0 then
				var_122_11.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_122_18 = manager.ui.mainCamera.transform.position - var_122_11.position

				var_122_11.forward = Vector3.New(var_122_18.x, var_122_18.y, var_122_18.z)

				local var_122_19 = var_122_11.localEulerAngles

				var_122_19.z = 0
				var_122_19.x = 0
				var_122_11.localEulerAngles = var_122_19
			end

			local var_122_20 = arg_119_1.actors_["10079ui_story"].transform
			local var_122_21 = 0

			if var_122_21 < arg_119_1.time_ and arg_119_1.time_ <= var_122_21 + arg_122_0 then
				arg_119_1.var_.moveOldPos10079ui_story = var_122_20.localPosition
			end

			local var_122_22 = 0.001

			if var_122_21 <= arg_119_1.time_ and arg_119_1.time_ < var_122_21 + var_122_22 then
				local var_122_23 = (arg_119_1.time_ - var_122_21) / var_122_22
				local var_122_24 = Vector3.New(0.7, -0.95, -6.05)

				var_122_20.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10079ui_story, var_122_24, var_122_23)

				local var_122_25 = manager.ui.mainCamera.transform.position - var_122_20.position

				var_122_20.forward = Vector3.New(var_122_25.x, var_122_25.y, var_122_25.z)

				local var_122_26 = var_122_20.localEulerAngles

				var_122_26.z = 0
				var_122_26.x = 0
				var_122_20.localEulerAngles = var_122_26
			end

			if arg_119_1.time_ >= var_122_21 + var_122_22 and arg_119_1.time_ < var_122_21 + var_122_22 + arg_122_0 then
				var_122_20.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_122_27 = manager.ui.mainCamera.transform.position - var_122_20.position

				var_122_20.forward = Vector3.New(var_122_27.x, var_122_27.y, var_122_27.z)

				local var_122_28 = var_122_20.localEulerAngles

				var_122_28.z = 0
				var_122_28.x = 0
				var_122_20.localEulerAngles = var_122_28
			end

			local var_122_29 = 0

			if var_122_29 < arg_119_1.time_ and arg_119_1.time_ <= var_122_29 + arg_122_0 then
				arg_119_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_122_30 = 0
			local var_122_31 = 0.3

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_32 = arg_119_1:FormatText(StoryNameCfg[6].name)

				arg_119_1.leftNameTxt_.text = var_122_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_33 = arg_119_1:GetWordFromCfg(319311029)
				local var_122_34 = arg_119_1:FormatText(var_122_33.content)

				arg_119_1.text_.text = var_122_34

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_35 = 12
				local var_122_36 = utf8.len(var_122_34)
				local var_122_37 = var_122_35 <= 0 and var_122_31 or var_122_31 * (var_122_36 / var_122_35)

				if var_122_37 > 0 and var_122_31 < var_122_37 then
					arg_119_1.talkMaxDuration = var_122_37

					if var_122_37 + var_122_30 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_37 + var_122_30
					end
				end

				arg_119_1.text_.text = var_122_34
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311029", "story_v_out_319311.awb") ~= 0 then
					local var_122_38 = manager.audio:GetVoiceLength("story_v_out_319311", "319311029", "story_v_out_319311.awb") / 1000

					if var_122_38 + var_122_30 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_38 + var_122_30
					end

					if var_122_33.prefab_name ~= "" and arg_119_1.actors_[var_122_33.prefab_name] ~= nil then
						local var_122_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_33.prefab_name].transform, "story_v_out_319311", "319311029", "story_v_out_319311.awb")

						arg_119_1:RecordAudio("319311029", var_122_39)
						arg_119_1:RecordAudio("319311029", var_122_39)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319311", "319311029", "story_v_out_319311.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319311", "319311029", "story_v_out_319311.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_40 = math.max(var_122_31, arg_119_1.talkMaxDuration)

			if var_122_30 <= arg_119_1.time_ and arg_119_1.time_ < var_122_30 + var_122_40 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_30) / var_122_40

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_30 + var_122_40 and arg_119_1.time_ < var_122_30 + var_122_40 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play319311030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319311030
		arg_123_1.duration_ = 9.97

		local var_123_0 = {
			zh = 7.3,
			ja = 9.966
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
				arg_123_0:Play319311031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["4040ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect4040ui_story == nil then
				arg_123_1.var_.characterEffect4040ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect4040ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect4040ui_story then
				arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_126_4 = arg_123_1.actors_["10079ui_story"]
			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect10079ui_story == nil then
				arg_123_1.var_.characterEffect10079ui_story = var_126_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.200000002980232

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 and not isNil(var_126_4) then
				local var_126_7 = (arg_123_1.time_ - var_126_5) / var_126_6

				if arg_123_1.var_.characterEffect10079ui_story and not isNil(var_126_4) then
					local var_126_8 = Mathf.Lerp(0, 0.5, var_126_7)

					arg_123_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10079ui_story.fillRatio = var_126_8
				end
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect10079ui_story then
				local var_126_9 = 0.5

				arg_123_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10079ui_story.fillRatio = var_126_9
			end

			local var_126_10 = arg_123_1.actors_["4040ui_story"].transform
			local var_126_11 = 0

			if var_126_11 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1.var_.moveOldPos4040ui_story = var_126_10.localPosition
			end

			local var_126_12 = 0.001

			if var_126_11 <= arg_123_1.time_ and arg_123_1.time_ < var_126_11 + var_126_12 then
				local var_126_13 = (arg_123_1.time_ - var_126_11) / var_126_12
				local var_126_14 = Vector3.New(-0.7, -1.55, -5.5)

				var_126_10.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos4040ui_story, var_126_14, var_126_13)

				local var_126_15 = manager.ui.mainCamera.transform.position - var_126_10.position

				var_126_10.forward = Vector3.New(var_126_15.x, var_126_15.y, var_126_15.z)

				local var_126_16 = var_126_10.localEulerAngles

				var_126_16.z = 0
				var_126_16.x = 0
				var_126_10.localEulerAngles = var_126_16
			end

			if arg_123_1.time_ >= var_126_11 + var_126_12 and arg_123_1.time_ < var_126_11 + var_126_12 + arg_126_0 then
				var_126_10.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_126_17 = manager.ui.mainCamera.transform.position - var_126_10.position

				var_126_10.forward = Vector3.New(var_126_17.x, var_126_17.y, var_126_17.z)

				local var_126_18 = var_126_10.localEulerAngles

				var_126_18.z = 0
				var_126_18.x = 0
				var_126_10.localEulerAngles = var_126_18
			end

			local var_126_19 = arg_123_1.actors_["4040ui_story"]
			local var_126_20 = 0

			if var_126_20 < arg_123_1.time_ and arg_123_1.time_ <= var_126_20 + arg_126_0 and not isNil(var_126_19) and arg_123_1.var_.characterEffect4040ui_story == nil then
				arg_123_1.var_.characterEffect4040ui_story = var_126_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_21 = 0.200000002980232

			if var_126_20 <= arg_123_1.time_ and arg_123_1.time_ < var_126_20 + var_126_21 and not isNil(var_126_19) then
				local var_126_22 = (arg_123_1.time_ - var_126_20) / var_126_21

				if arg_123_1.var_.characterEffect4040ui_story and not isNil(var_126_19) then
					arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_20 + var_126_21 and arg_123_1.time_ < var_126_20 + var_126_21 + arg_126_0 and not isNil(var_126_19) and arg_123_1.var_.characterEffect4040ui_story then
				arg_123_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_126_23 = 0

			if var_126_23 < arg_123_1.time_ and arg_123_1.time_ <= var_126_23 + arg_126_0 then
				arg_123_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_126_24 = 0

			if var_126_24 < arg_123_1.time_ and arg_123_1.time_ <= var_126_24 + arg_126_0 then
				arg_123_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_25 = 0
			local var_126_26 = 0.6

			if var_126_25 < arg_123_1.time_ and arg_123_1.time_ <= var_126_25 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_27 = arg_123_1:FormatText(StoryNameCfg[668].name)

				arg_123_1.leftNameTxt_.text = var_126_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_28 = arg_123_1:GetWordFromCfg(319311030)
				local var_126_29 = arg_123_1:FormatText(var_126_28.content)

				arg_123_1.text_.text = var_126_29

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_30 = 24
				local var_126_31 = utf8.len(var_126_29)
				local var_126_32 = var_126_30 <= 0 and var_126_26 or var_126_26 * (var_126_31 / var_126_30)

				if var_126_32 > 0 and var_126_26 < var_126_32 then
					arg_123_1.talkMaxDuration = var_126_32

					if var_126_32 + var_126_25 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_32 + var_126_25
					end
				end

				arg_123_1.text_.text = var_126_29
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311030", "story_v_out_319311.awb") ~= 0 then
					local var_126_33 = manager.audio:GetVoiceLength("story_v_out_319311", "319311030", "story_v_out_319311.awb") / 1000

					if var_126_33 + var_126_25 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_33 + var_126_25
					end

					if var_126_28.prefab_name ~= "" and arg_123_1.actors_[var_126_28.prefab_name] ~= nil then
						local var_126_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_28.prefab_name].transform, "story_v_out_319311", "319311030", "story_v_out_319311.awb")

						arg_123_1:RecordAudio("319311030", var_126_34)
						arg_123_1:RecordAudio("319311030", var_126_34)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319311", "319311030", "story_v_out_319311.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319311", "319311030", "story_v_out_319311.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_35 = math.max(var_126_26, arg_123_1.talkMaxDuration)

			if var_126_25 <= arg_123_1.time_ and arg_123_1.time_ < var_126_25 + var_126_35 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_25) / var_126_35

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_25 + var_126_35 and arg_123_1.time_ < var_126_25 + var_126_35 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play319311031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319311031
		arg_127_1.duration_ = 6.93

		local var_127_0 = {
			zh = 5.3,
			ja = 6.933
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
				arg_127_0:Play319311032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["4040ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect4040ui_story == nil then
				arg_127_1.var_.characterEffect4040ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect4040ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_127_1.var_.characterEffect4040ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect4040ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_127_1.var_.characterEffect4040ui_story.fillRatio = var_130_5
			end

			local var_130_6 = arg_127_1.actors_["10079ui_story"]
			local var_130_7 = 0

			if var_130_7 < arg_127_1.time_ and arg_127_1.time_ <= var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect10079ui_story == nil then
				arg_127_1.var_.characterEffect10079ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.200000002980232

			if var_130_7 <= arg_127_1.time_ and arg_127_1.time_ < var_130_7 + var_130_8 and not isNil(var_130_6) then
				local var_130_9 = (arg_127_1.time_ - var_130_7) / var_130_8

				if arg_127_1.var_.characterEffect10079ui_story and not isNil(var_130_6) then
					arg_127_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_7 + var_130_8 and arg_127_1.time_ < var_130_7 + var_130_8 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect10079ui_story then
				arg_127_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_130_10 = 0
			local var_130_11 = 0.55

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_12 = arg_127_1:FormatText(StoryNameCfg[6].name)

				arg_127_1.leftNameTxt_.text = var_130_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_13 = arg_127_1:GetWordFromCfg(319311031)
				local var_130_14 = arg_127_1:FormatText(var_130_13.content)

				arg_127_1.text_.text = var_130_14

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_15 = 22
				local var_130_16 = utf8.len(var_130_14)
				local var_130_17 = var_130_15 <= 0 and var_130_11 or var_130_11 * (var_130_16 / var_130_15)

				if var_130_17 > 0 and var_130_11 < var_130_17 then
					arg_127_1.talkMaxDuration = var_130_17

					if var_130_17 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_17 + var_130_10
					end
				end

				arg_127_1.text_.text = var_130_14
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311031", "story_v_out_319311.awb") ~= 0 then
					local var_130_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311031", "story_v_out_319311.awb") / 1000

					if var_130_18 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_10
					end

					if var_130_13.prefab_name ~= "" and arg_127_1.actors_[var_130_13.prefab_name] ~= nil then
						local var_130_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_13.prefab_name].transform, "story_v_out_319311", "319311031", "story_v_out_319311.awb")

						arg_127_1:RecordAudio("319311031", var_130_19)
						arg_127_1:RecordAudio("319311031", var_130_19)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319311", "319311031", "story_v_out_319311.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319311", "319311031", "story_v_out_319311.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_20 = math.max(var_130_11, arg_127_1.talkMaxDuration)

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_20 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_10) / var_130_20

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_10 + var_130_20 and arg_127_1.time_ < var_130_10 + var_130_20 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319311032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319311032
		arg_131_1.duration_ = 6.33

		local var_131_0 = {
			zh = 6.333,
			ja = 5.733
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
				arg_131_0:Play319311033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10079ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10079ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0.7, -0.95, -6.05)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10079ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["10079ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect10079ui_story == nil then
				arg_131_1.var_.characterEffect10079ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect10079ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect10079ui_story then
				arg_131_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_15 = 0
			local var_134_16 = 0.8

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[6].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(319311032)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 32
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311032", "story_v_out_319311.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_319311", "319311032", "story_v_out_319311.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_319311", "319311032", "story_v_out_319311.awb")

						arg_131_1:RecordAudio("319311032", var_134_24)
						arg_131_1:RecordAudio("319311032", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319311", "319311032", "story_v_out_319311.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319311", "319311032", "story_v_out_319311.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play319311033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319311033
		arg_135_1.duration_ = 2

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play319311034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1095ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1095ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, -0.98, -6.1)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1095ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["1095ui_story"]
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect1095ui_story == nil then
				arg_135_1.var_.characterEffect1095ui_story = var_138_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 and not isNil(var_138_9) then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11

				if arg_135_1.var_.characterEffect1095ui_story and not isNil(var_138_9) then
					arg_135_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect1095ui_story then
				arg_135_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_138_13 = 0

			if var_138_13 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_138_14 = 0

			if var_138_14 < arg_135_1.time_ and arg_135_1.time_ <= var_138_14 + arg_138_0 then
				arg_135_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_15 = arg_135_1.actors_["4040ui_story"].transform
			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.var_.moveOldPos4040ui_story = var_138_15.localPosition
			end

			local var_138_17 = 0.001

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17
				local var_138_19 = Vector3.New(0, 100, 0)

				var_138_15.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos4040ui_story, var_138_19, var_138_18)

				local var_138_20 = manager.ui.mainCamera.transform.position - var_138_15.position

				var_138_15.forward = Vector3.New(var_138_20.x, var_138_20.y, var_138_20.z)

				local var_138_21 = var_138_15.localEulerAngles

				var_138_21.z = 0
				var_138_21.x = 0
				var_138_15.localEulerAngles = var_138_21
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 then
				var_138_15.localPosition = Vector3.New(0, 100, 0)

				local var_138_22 = manager.ui.mainCamera.transform.position - var_138_15.position

				var_138_15.forward = Vector3.New(var_138_22.x, var_138_22.y, var_138_22.z)

				local var_138_23 = var_138_15.localEulerAngles

				var_138_23.z = 0
				var_138_23.x = 0
				var_138_15.localEulerAngles = var_138_23
			end

			local var_138_24 = arg_135_1.actors_["4040ui_story"]
			local var_138_25 = 0

			if var_138_25 < arg_135_1.time_ and arg_135_1.time_ <= var_138_25 + arg_138_0 and not isNil(var_138_24) and arg_135_1.var_.characterEffect4040ui_story == nil then
				arg_135_1.var_.characterEffect4040ui_story = var_138_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_26 = 0.200000002980232

			if var_138_25 <= arg_135_1.time_ and arg_135_1.time_ < var_138_25 + var_138_26 and not isNil(var_138_24) then
				local var_138_27 = (arg_135_1.time_ - var_138_25) / var_138_26

				if arg_135_1.var_.characterEffect4040ui_story and not isNil(var_138_24) then
					local var_138_28 = Mathf.Lerp(0, 0.5, var_138_27)

					arg_135_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_135_1.var_.characterEffect4040ui_story.fillRatio = var_138_28
				end
			end

			if arg_135_1.time_ >= var_138_25 + var_138_26 and arg_135_1.time_ < var_138_25 + var_138_26 + arg_138_0 and not isNil(var_138_24) and arg_135_1.var_.characterEffect4040ui_story then
				local var_138_29 = 0.5

				arg_135_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_135_1.var_.characterEffect4040ui_story.fillRatio = var_138_29
			end

			local var_138_30 = arg_135_1.actors_["10079ui_story"].transform
			local var_138_31 = 0

			if var_138_31 < arg_135_1.time_ and arg_135_1.time_ <= var_138_31 + arg_138_0 then
				arg_135_1.var_.moveOldPos10079ui_story = var_138_30.localPosition
			end

			local var_138_32 = 0.001

			if var_138_31 <= arg_135_1.time_ and arg_135_1.time_ < var_138_31 + var_138_32 then
				local var_138_33 = (arg_135_1.time_ - var_138_31) / var_138_32
				local var_138_34 = Vector3.New(0, 100, 0)

				var_138_30.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10079ui_story, var_138_34, var_138_33)

				local var_138_35 = manager.ui.mainCamera.transform.position - var_138_30.position

				var_138_30.forward = Vector3.New(var_138_35.x, var_138_35.y, var_138_35.z)

				local var_138_36 = var_138_30.localEulerAngles

				var_138_36.z = 0
				var_138_36.x = 0
				var_138_30.localEulerAngles = var_138_36
			end

			if arg_135_1.time_ >= var_138_31 + var_138_32 and arg_135_1.time_ < var_138_31 + var_138_32 + arg_138_0 then
				var_138_30.localPosition = Vector3.New(0, 100, 0)

				local var_138_37 = manager.ui.mainCamera.transform.position - var_138_30.position

				var_138_30.forward = Vector3.New(var_138_37.x, var_138_37.y, var_138_37.z)

				local var_138_38 = var_138_30.localEulerAngles

				var_138_38.z = 0
				var_138_38.x = 0
				var_138_30.localEulerAngles = var_138_38
			end

			local var_138_39 = arg_135_1.actors_["10079ui_story"]
			local var_138_40 = 0

			if var_138_40 < arg_135_1.time_ and arg_135_1.time_ <= var_138_40 + arg_138_0 and not isNil(var_138_39) and arg_135_1.var_.characterEffect10079ui_story == nil then
				arg_135_1.var_.characterEffect10079ui_story = var_138_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_41 = 0.200000002980232

			if var_138_40 <= arg_135_1.time_ and arg_135_1.time_ < var_138_40 + var_138_41 and not isNil(var_138_39) then
				local var_138_42 = (arg_135_1.time_ - var_138_40) / var_138_41

				if arg_135_1.var_.characterEffect10079ui_story and not isNil(var_138_39) then
					local var_138_43 = Mathf.Lerp(0, 0.5, var_138_42)

					arg_135_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10079ui_story.fillRatio = var_138_43
				end
			end

			if arg_135_1.time_ >= var_138_40 + var_138_41 and arg_135_1.time_ < var_138_40 + var_138_41 + arg_138_0 and not isNil(var_138_39) and arg_135_1.var_.characterEffect10079ui_story then
				local var_138_44 = 0.5

				arg_135_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10079ui_story.fillRatio = var_138_44
			end

			local var_138_45 = 0
			local var_138_46 = 0.225

			if var_138_45 < arg_135_1.time_ and arg_135_1.time_ <= var_138_45 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_47 = arg_135_1:FormatText(StoryNameCfg[471].name)

				arg_135_1.leftNameTxt_.text = var_138_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_48 = arg_135_1:GetWordFromCfg(319311033)
				local var_138_49 = arg_135_1:FormatText(var_138_48.content)

				arg_135_1.text_.text = var_138_49

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_50 = 9
				local var_138_51 = utf8.len(var_138_49)
				local var_138_52 = var_138_50 <= 0 and var_138_46 or var_138_46 * (var_138_51 / var_138_50)

				if var_138_52 > 0 and var_138_46 < var_138_52 then
					arg_135_1.talkMaxDuration = var_138_52

					if var_138_52 + var_138_45 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_52 + var_138_45
					end
				end

				arg_135_1.text_.text = var_138_49
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311033", "story_v_out_319311.awb") ~= 0 then
					local var_138_53 = manager.audio:GetVoiceLength("story_v_out_319311", "319311033", "story_v_out_319311.awb") / 1000

					if var_138_53 + var_138_45 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_53 + var_138_45
					end

					if var_138_48.prefab_name ~= "" and arg_135_1.actors_[var_138_48.prefab_name] ~= nil then
						local var_138_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_48.prefab_name].transform, "story_v_out_319311", "319311033", "story_v_out_319311.awb")

						arg_135_1:RecordAudio("319311033", var_138_54)
						arg_135_1:RecordAudio("319311033", var_138_54)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319311", "319311033", "story_v_out_319311.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319311", "319311033", "story_v_out_319311.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_55 = math.max(var_138_46, arg_135_1.talkMaxDuration)

			if var_138_45 <= arg_135_1.time_ and arg_135_1.time_ < var_138_45 + var_138_55 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_45) / var_138_55

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_45 + var_138_55 and arg_135_1.time_ < var_138_45 + var_138_55 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_135_1:InitPlayNodeList()
	end,
	Play319311034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319311034
		arg_139_1.duration_ = 2.27

		local var_139_0 = {
			zh = 2.266,
			ja = 1.533
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
				arg_139_0:Play319311035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10079ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10079ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, -0.95, -6.05)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10079ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["10079ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10079ui_story == nil then
				arg_139_1.var_.characterEffect10079ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect10079ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect10079ui_story then
				arg_139_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_142_13 = arg_139_1.actors_["1095ui_story"].transform
			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1.var_.moveOldPos1095ui_story = var_142_13.localPosition
			end

			local var_142_15 = 0.001

			if var_142_14 <= arg_139_1.time_ and arg_139_1.time_ < var_142_14 + var_142_15 then
				local var_142_16 = (arg_139_1.time_ - var_142_14) / var_142_15
				local var_142_17 = Vector3.New(0, 100, 0)

				var_142_13.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1095ui_story, var_142_17, var_142_16)

				local var_142_18 = manager.ui.mainCamera.transform.position - var_142_13.position

				var_142_13.forward = Vector3.New(var_142_18.x, var_142_18.y, var_142_18.z)

				local var_142_19 = var_142_13.localEulerAngles

				var_142_19.z = 0
				var_142_19.x = 0
				var_142_13.localEulerAngles = var_142_19
			end

			if arg_139_1.time_ >= var_142_14 + var_142_15 and arg_139_1.time_ < var_142_14 + var_142_15 + arg_142_0 then
				var_142_13.localPosition = Vector3.New(0, 100, 0)

				local var_142_20 = manager.ui.mainCamera.transform.position - var_142_13.position

				var_142_13.forward = Vector3.New(var_142_20.x, var_142_20.y, var_142_20.z)

				local var_142_21 = var_142_13.localEulerAngles

				var_142_21.z = 0
				var_142_21.x = 0
				var_142_13.localEulerAngles = var_142_21
			end

			local var_142_22 = arg_139_1.actors_["1095ui_story"]
			local var_142_23 = 0

			if var_142_23 < arg_139_1.time_ and arg_139_1.time_ <= var_142_23 + arg_142_0 and not isNil(var_142_22) and arg_139_1.var_.characterEffect1095ui_story == nil then
				arg_139_1.var_.characterEffect1095ui_story = var_142_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_24 = 0.200000002980232

			if var_142_23 <= arg_139_1.time_ and arg_139_1.time_ < var_142_23 + var_142_24 and not isNil(var_142_22) then
				local var_142_25 = (arg_139_1.time_ - var_142_23) / var_142_24

				if arg_139_1.var_.characterEffect1095ui_story and not isNil(var_142_22) then
					local var_142_26 = Mathf.Lerp(0, 0.5, var_142_25)

					arg_139_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1095ui_story.fillRatio = var_142_26
				end
			end

			if arg_139_1.time_ >= var_142_23 + var_142_24 and arg_139_1.time_ < var_142_23 + var_142_24 + arg_142_0 and not isNil(var_142_22) and arg_139_1.var_.characterEffect1095ui_story then
				local var_142_27 = 0.5

				arg_139_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1095ui_story.fillRatio = var_142_27
			end

			local var_142_28 = 0
			local var_142_29 = 0.15

			if var_142_28 < arg_139_1.time_ and arg_139_1.time_ <= var_142_28 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_30 = arg_139_1:FormatText(StoryNameCfg[6].name)

				arg_139_1.leftNameTxt_.text = var_142_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_31 = arg_139_1:GetWordFromCfg(319311034)
				local var_142_32 = arg_139_1:FormatText(var_142_31.content)

				arg_139_1.text_.text = var_142_32

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_33 = 6
				local var_142_34 = utf8.len(var_142_32)
				local var_142_35 = var_142_33 <= 0 and var_142_29 or var_142_29 * (var_142_34 / var_142_33)

				if var_142_35 > 0 and var_142_29 < var_142_35 then
					arg_139_1.talkMaxDuration = var_142_35

					if var_142_35 + var_142_28 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_35 + var_142_28
					end
				end

				arg_139_1.text_.text = var_142_32
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311034", "story_v_out_319311.awb") ~= 0 then
					local var_142_36 = manager.audio:GetVoiceLength("story_v_out_319311", "319311034", "story_v_out_319311.awb") / 1000

					if var_142_36 + var_142_28 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_36 + var_142_28
					end

					if var_142_31.prefab_name ~= "" and arg_139_1.actors_[var_142_31.prefab_name] ~= nil then
						local var_142_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_31.prefab_name].transform, "story_v_out_319311", "319311034", "story_v_out_319311.awb")

						arg_139_1:RecordAudio("319311034", var_142_37)
						arg_139_1:RecordAudio("319311034", var_142_37)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319311", "319311034", "story_v_out_319311.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319311", "319311034", "story_v_out_319311.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_38 = math.max(var_142_29, arg_139_1.talkMaxDuration)

			if var_142_28 <= arg_139_1.time_ and arg_139_1.time_ < var_142_28 + var_142_38 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_28) / var_142_38

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_28 + var_142_38 and arg_139_1.time_ < var_142_28 + var_142_38 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319311035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319311035
		arg_143_1.duration_ = 2.83

		local var_143_0 = {
			zh = 2,
			ja = 2.833
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
				arg_143_0:Play319311036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10079ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10079ui_story == nil then
				arg_143_1.var_.characterEffect10079ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect10079ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10079ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10079ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10079ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 0.125

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[696].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_9 = arg_143_1:GetWordFromCfg(319311035)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 5
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311035", "story_v_out_319311.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311035", "story_v_out_319311.awb") / 1000

					if var_146_14 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_6
					end

					if var_146_9.prefab_name ~= "" and arg_143_1.actors_[var_146_9.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_9.prefab_name].transform, "story_v_out_319311", "319311035", "story_v_out_319311.awb")

						arg_143_1:RecordAudio("319311035", var_146_15)
						arg_143_1:RecordAudio("319311035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319311", "319311035", "story_v_out_319311.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319311", "319311035", "story_v_out_319311.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_16 and arg_143_1.time_ < var_146_6 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play319311036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319311036
		arg_147_1.duration_ = 11.73

		local var_147_0 = {
			zh = 9,
			ja = 11.733
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
				arg_147_0:Play319311037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				local var_150_2 = "stop"
				local var_150_3 = "effect"

				arg_147_1:AudioAction(var_150_2, var_150_3, "se_story_130", "se_story_130_didi", "")
			end

			local var_150_4 = manager.ui.mainCamera.transform
			local var_150_5 = 0

			if var_150_5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				local var_150_6 = arg_147_1.var_.effect996
				local var_150_7
				local var_150_8 = var_150_4

				if not var_150_6 then
					var_150_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_150_8)
					var_150_6.name = "996"
					arg_147_1.var_.effect996 = var_150_6
				else
					var_150_6.transform:SetParent(var_150_8)
				end

				var_150_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_150_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_150_9 = 1
			local var_150_10 = 0.6

			if var_150_9 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_11 = arg_147_1:FormatText(StoryNameCfg[696].name)

				arg_147_1.leftNameTxt_.text = var_150_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_12 = arg_147_1:GetWordFromCfg(319311036)
				local var_150_13 = arg_147_1:FormatText(var_150_12.content)

				arg_147_1.text_.text = var_150_13

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_14 = 24
				local var_150_15 = utf8.len(var_150_13)
				local var_150_16 = var_150_14 <= 0 and var_150_10 or var_150_10 * (var_150_15 / var_150_14)

				if var_150_16 > 0 and var_150_10 < var_150_16 then
					arg_147_1.talkMaxDuration = var_150_16

					if var_150_16 + var_150_9 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_9
					end
				end

				arg_147_1.text_.text = var_150_13
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311036", "story_v_out_319311.awb") ~= 0 then
					local var_150_17 = manager.audio:GetVoiceLength("story_v_out_319311", "319311036", "story_v_out_319311.awb") / 1000

					if var_150_17 + var_150_9 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_17 + var_150_9
					end

					if var_150_12.prefab_name ~= "" and arg_147_1.actors_[var_150_12.prefab_name] ~= nil then
						local var_150_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_12.prefab_name].transform, "story_v_out_319311", "319311036", "story_v_out_319311.awb")

						arg_147_1:RecordAudio("319311036", var_150_18)
						arg_147_1:RecordAudio("319311036", var_150_18)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319311", "319311036", "story_v_out_319311.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319311", "319311036", "story_v_out_319311.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_19 = math.max(var_150_10, arg_147_1.talkMaxDuration)

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_19 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_9) / var_150_19

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_9 + var_150_19 and arg_147_1.time_ < var_150_9 + var_150_19 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319311037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319311037
		arg_151_1.duration_ = 3.73

		local var_151_0 = {
			zh = 3.733,
			ja = 3.366
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
				arg_151_0:Play319311038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10079ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10079ui_story == nil then
				arg_151_1.var_.characterEffect10079ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10079ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10079ui_story then
				arg_151_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_154_4 = 0

			if var_154_4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4125")
			end

			local var_154_5 = 0

			if var_154_5 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_154_6 = 0
			local var_154_7 = 0.325

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[6].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_9 = arg_151_1:GetWordFromCfg(319311037)
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

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311037", "story_v_out_319311.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311037", "story_v_out_319311.awb") / 1000

					if var_154_14 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_6
					end

					if var_154_9.prefab_name ~= "" and arg_151_1.actors_[var_154_9.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_9.prefab_name].transform, "story_v_out_319311", "319311037", "story_v_out_319311.awb")

						arg_151_1:RecordAudio("319311037", var_154_15)
						arg_151_1:RecordAudio("319311037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319311", "319311037", "story_v_out_319311.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319311", "319311037", "story_v_out_319311.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_16 and arg_151_1.time_ < var_154_6 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319311038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319311038
		arg_155_1.duration_ = 8.37

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play319311039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10079ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10079ui_story == nil then
				arg_155_1.var_.characterEffect10079ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect10079ui_story and not isNil(var_158_0) then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10079ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10079ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10079ui_story.fillRatio = var_158_5
			end

			local var_158_6 = 0

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				local var_158_7 = manager.ui.mainCamera.transform.localPosition
				local var_158_8 = Vector3.New(0, 0, 10) + Vector3.New(var_158_7.x, var_158_7.y, 0)
				local var_158_9 = arg_155_1.bgs_.A08f

				var_158_9.transform.localPosition = var_158_8
				var_158_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_10 = var_158_9:GetComponent("SpriteRenderer")

				if var_158_10 and var_158_10.sprite then
					local var_158_11 = (var_158_9.transform.localPosition - var_158_7).z
					local var_158_12 = manager.ui.mainCameraCom_
					local var_158_13 = 2 * var_158_11 * Mathf.Tan(var_158_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_158_14 = var_158_13 * var_158_12.aspect
					local var_158_15 = var_158_10.sprite.bounds.size.x
					local var_158_16 = var_158_10.sprite.bounds.size.y
					local var_158_17 = var_158_14 / var_158_15
					local var_158_18 = var_158_13 / var_158_16
					local var_158_19 = var_158_18 < var_158_17 and var_158_17 or var_158_18

					var_158_9.transform.localScale = Vector3.New(var_158_19, var_158_19, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "A08f" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_20 = 0.6

			if var_158_20 < arg_155_1.time_ and arg_155_1.time_ <= var_158_20 + arg_158_0 then
				local var_158_21 = manager.ui.mainCamera.transform.localPosition
				local var_158_22 = Vector3.New(0, 0, 10) + Vector3.New(var_158_21.x, var_158_21.y, 0)
				local var_158_23 = arg_155_1.bgs_.A08f

				var_158_23.transform.localPosition = var_158_22
				var_158_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_24 = var_158_23:GetComponent("SpriteRenderer")

				if var_158_24 and var_158_24.sprite then
					local var_158_25 = (var_158_23.transform.localPosition - var_158_21).z
					local var_158_26 = manager.ui.mainCameraCom_
					local var_158_27 = 2 * var_158_25 * Mathf.Tan(var_158_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_158_28 = var_158_27 * var_158_26.aspect
					local var_158_29 = var_158_24.sprite.bounds.size.x
					local var_158_30 = var_158_24.sprite.bounds.size.y
					local var_158_31 = var_158_28 / var_158_29
					local var_158_32 = var_158_27 / var_158_30
					local var_158_33 = var_158_32 < var_158_31 and var_158_31 or var_158_32

					var_158_23.transform.localScale = Vector3.New(var_158_33, var_158_33, 0)
				end

				for iter_158_2, iter_158_3 in pairs(arg_155_1.bgs_) do
					if iter_158_2 ~= "A08f" then
						iter_158_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_34 = 1.33333333333333

			if var_158_34 < arg_155_1.time_ and arg_155_1.time_ <= var_158_34 + arg_158_0 then
				local var_158_35 = manager.ui.mainCamera.transform.localPosition
				local var_158_36 = Vector3.New(0, 0, 10) + Vector3.New(var_158_35.x, var_158_35.y, 0)
				local var_158_37 = arg_155_1.bgs_.A08f

				var_158_37.transform.localPosition = var_158_36
				var_158_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_38 = var_158_37:GetComponent("SpriteRenderer")

				if var_158_38 and var_158_38.sprite then
					local var_158_39 = (var_158_37.transform.localPosition - var_158_35).z
					local var_158_40 = manager.ui.mainCameraCom_
					local var_158_41 = 2 * var_158_39 * Mathf.Tan(var_158_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_158_42 = var_158_41 * var_158_40.aspect
					local var_158_43 = var_158_38.sprite.bounds.size.x
					local var_158_44 = var_158_38.sprite.bounds.size.y
					local var_158_45 = var_158_42 / var_158_43
					local var_158_46 = var_158_41 / var_158_44
					local var_158_47 = var_158_46 < var_158_45 and var_158_45 or var_158_46

					var_158_37.transform.localScale = Vector3.New(var_158_47, var_158_47, 0)
				end

				for iter_158_4, iter_158_5 in pairs(arg_155_1.bgs_) do
					if iter_158_4 ~= "A08f" then
						iter_158_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_48 = 2.1

			if var_158_48 < arg_155_1.time_ and arg_155_1.time_ <= var_158_48 + arg_158_0 then
				local var_158_49 = manager.ui.mainCamera.transform.localPosition
				local var_158_50 = Vector3.New(0, 0, 10) + Vector3.New(var_158_49.x, var_158_49.y, 0)
				local var_158_51 = arg_155_1.bgs_.A08f

				var_158_51.transform.localPosition = var_158_50
				var_158_51.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_52 = var_158_51:GetComponent("SpriteRenderer")

				if var_158_52 and var_158_52.sprite then
					local var_158_53 = (var_158_51.transform.localPosition - var_158_49).z
					local var_158_54 = manager.ui.mainCameraCom_
					local var_158_55 = 2 * var_158_53 * Mathf.Tan(var_158_54.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_158_56 = var_158_55 * var_158_54.aspect
					local var_158_57 = var_158_52.sprite.bounds.size.x
					local var_158_58 = var_158_52.sprite.bounds.size.y
					local var_158_59 = var_158_56 / var_158_57
					local var_158_60 = var_158_55 / var_158_58
					local var_158_61 = var_158_60 < var_158_59 and var_158_59 or var_158_60

					var_158_51.transform.localScale = Vector3.New(var_158_61, var_158_61, 0)
				end

				for iter_158_6, iter_158_7 in pairs(arg_155_1.bgs_) do
					if iter_158_6 ~= "A08f" then
						iter_158_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_62 = 0

			if var_158_62 < arg_155_1.time_ and arg_155_1.time_ <= var_158_62 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_63 = 0.6

			if var_158_62 <= arg_155_1.time_ and arg_155_1.time_ < var_158_62 + var_158_63 then
				local var_158_64 = (arg_155_1.time_ - var_158_62) / var_158_63
				local var_158_65 = Color.New(0, 0, 0)

				var_158_65.a = Mathf.Lerp(0, 1, var_158_64)
				arg_155_1.mask_.color = var_158_65
			end

			if arg_155_1.time_ >= var_158_62 + var_158_63 and arg_155_1.time_ < var_158_62 + var_158_63 + arg_158_0 then
				local var_158_66 = Color.New(0, 0, 0)

				var_158_66.a = 1
				arg_155_1.mask_.color = var_158_66
			end

			local var_158_67 = 0.6

			if var_158_67 < arg_155_1.time_ and arg_155_1.time_ <= var_158_67 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_68 = 0.733333333333333

			if var_158_67 <= arg_155_1.time_ and arg_155_1.time_ < var_158_67 + var_158_68 then
				local var_158_69 = (arg_155_1.time_ - var_158_67) / var_158_68
				local var_158_70 = Color.New(0, 0, 0)

				var_158_70.a = Mathf.Lerp(1, 0, var_158_69)
				arg_155_1.mask_.color = var_158_70
			end

			if arg_155_1.time_ >= var_158_67 + var_158_68 and arg_155_1.time_ < var_158_67 + var_158_68 + arg_158_0 then
				local var_158_71 = Color.New(0, 0, 0)
				local var_158_72 = 0

				arg_155_1.mask_.enabled = false
				var_158_71.a = var_158_72
				arg_155_1.mask_.color = var_158_71
			end

			local var_158_73 = 1.33333333333333

			if var_158_73 < arg_155_1.time_ and arg_155_1.time_ <= var_158_73 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_74 = 0.766666666666667

			if var_158_73 <= arg_155_1.time_ and arg_155_1.time_ < var_158_73 + var_158_74 then
				local var_158_75 = (arg_155_1.time_ - var_158_73) / var_158_74
				local var_158_76 = Color.New(0, 0, 0)

				var_158_76.a = Mathf.Lerp(0, 1, var_158_75)
				arg_155_1.mask_.color = var_158_76
			end

			if arg_155_1.time_ >= var_158_73 + var_158_74 and arg_155_1.time_ < var_158_73 + var_158_74 + arg_158_0 then
				local var_158_77 = Color.New(0, 0, 0)

				var_158_77.a = 1
				arg_155_1.mask_.color = var_158_77
			end

			local var_158_78 = 2.1

			if var_158_78 < arg_155_1.time_ and arg_155_1.time_ <= var_158_78 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_79 = 1.1

			if var_158_78 <= arg_155_1.time_ and arg_155_1.time_ < var_158_78 + var_158_79 then
				local var_158_80 = (arg_155_1.time_ - var_158_78) / var_158_79
				local var_158_81 = Color.New(0, 0, 0)

				var_158_81.a = Mathf.Lerp(1, 0, var_158_80)
				arg_155_1.mask_.color = var_158_81
			end

			if arg_155_1.time_ >= var_158_78 + var_158_79 and arg_155_1.time_ < var_158_78 + var_158_79 + arg_158_0 then
				local var_158_82 = Color.New(0, 0, 0)
				local var_158_83 = 0

				arg_155_1.mask_.enabled = false
				var_158_82.a = var_158_83
				arg_155_1.mask_.color = var_158_82
			end

			local var_158_84 = arg_155_1.actors_["10079ui_story"].transform
			local var_158_85 = 0

			if var_158_85 < arg_155_1.time_ and arg_155_1.time_ <= var_158_85 + arg_158_0 then
				arg_155_1.var_.moveOldPos10079ui_story = var_158_84.localPosition
			end

			local var_158_86 = 0.001

			if var_158_85 <= arg_155_1.time_ and arg_155_1.time_ < var_158_85 + var_158_86 then
				local var_158_87 = (arg_155_1.time_ - var_158_85) / var_158_86
				local var_158_88 = Vector3.New(0, 100, 0)

				var_158_84.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10079ui_story, var_158_88, var_158_87)

				local var_158_89 = manager.ui.mainCamera.transform.position - var_158_84.position

				var_158_84.forward = Vector3.New(var_158_89.x, var_158_89.y, var_158_89.z)

				local var_158_90 = var_158_84.localEulerAngles

				var_158_90.z = 0
				var_158_90.x = 0
				var_158_84.localEulerAngles = var_158_90
			end

			if arg_155_1.time_ >= var_158_85 + var_158_86 and arg_155_1.time_ < var_158_85 + var_158_86 + arg_158_0 then
				var_158_84.localPosition = Vector3.New(0, 100, 0)

				local var_158_91 = manager.ui.mainCamera.transform.position - var_158_84.position

				var_158_84.forward = Vector3.New(var_158_91.x, var_158_91.y, var_158_91.z)

				local var_158_92 = var_158_84.localEulerAngles

				var_158_92.z = 0
				var_158_92.x = 0
				var_158_84.localEulerAngles = var_158_92
			end

			local var_158_93 = manager.ui.mainCamera.transform
			local var_158_94 = 0.766666666666667

			if var_158_94 < arg_155_1.time_ and arg_155_1.time_ <= var_158_94 + arg_158_0 then
				local var_158_95 = arg_155_1.var_.effect996

				if var_158_95 then
					Object.Destroy(var_158_95)

					arg_155_1.var_.effect996 = nil
				end
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_96 = 3.36666666666667
			local var_158_97 = 1.025

			if var_158_96 < arg_155_1.time_ and arg_155_1.time_ <= var_158_96 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_98 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_98:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_98:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_98:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_99 = arg_155_1:GetWordFromCfg(319311038)
				local var_158_100 = arg_155_1:FormatText(var_158_99.content)

				arg_155_1.text_.text = var_158_100

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_101 = 41
				local var_158_102 = utf8.len(var_158_100)
				local var_158_103 = var_158_101 <= 0 and var_158_97 or var_158_97 * (var_158_102 / var_158_101)

				if var_158_103 > 0 and var_158_97 < var_158_103 then
					arg_155_1.talkMaxDuration = var_158_103
					var_158_96 = var_158_96 + 0.3

					if var_158_103 + var_158_96 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_103 + var_158_96
					end
				end

				arg_155_1.text_.text = var_158_100
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_104 = var_158_96 + 0.3
			local var_158_105 = math.max(var_158_97, arg_155_1.talkMaxDuration)

			if var_158_104 <= arg_155_1.time_ and arg_155_1.time_ < var_158_104 + var_158_105 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_104) / var_158_105

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_104 + var_158_105 and arg_155_1.time_ < var_158_104 + var_158_105 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play319311039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319311039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play319311040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 1.15

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

				local var_164_2 = arg_161_1:GetWordFromCfg(319311039)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 46
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
	Play319311040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319311040
		arg_165_1.duration_ = 9.67

		local var_165_0 = {
			zh = 5.733,
			ja = 9.666
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
				arg_165_0:Play319311041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1095ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1095ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0, -0.98, -6.1)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1095ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1095ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1095ui_story == nil then
				arg_165_1.var_.characterEffect1095ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1095ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1095ui_story then
				arg_165_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_168_13 = 0

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_15 = arg_165_1.actors_["10079ui_story"].transform
			local var_168_16 = 0

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.var_.moveOldPos10079ui_story = var_168_15.localPosition
			end

			local var_168_17 = 0.001

			if var_168_16 <= arg_165_1.time_ and arg_165_1.time_ < var_168_16 + var_168_17 then
				local var_168_18 = (arg_165_1.time_ - var_168_16) / var_168_17
				local var_168_19 = Vector3.New(0, 100, 0)

				var_168_15.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10079ui_story, var_168_19, var_168_18)

				local var_168_20 = manager.ui.mainCamera.transform.position - var_168_15.position

				var_168_15.forward = Vector3.New(var_168_20.x, var_168_20.y, var_168_20.z)

				local var_168_21 = var_168_15.localEulerAngles

				var_168_21.z = 0
				var_168_21.x = 0
				var_168_15.localEulerAngles = var_168_21
			end

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 then
				var_168_15.localPosition = Vector3.New(0, 100, 0)

				local var_168_22 = manager.ui.mainCamera.transform.position - var_168_15.position

				var_168_15.forward = Vector3.New(var_168_22.x, var_168_22.y, var_168_22.z)

				local var_168_23 = var_168_15.localEulerAngles

				var_168_23.z = 0
				var_168_23.x = 0
				var_168_15.localEulerAngles = var_168_23
			end

			local var_168_24 = arg_165_1.actors_["10079ui_story"]
			local var_168_25 = 0

			if var_168_25 < arg_165_1.time_ and arg_165_1.time_ <= var_168_25 + arg_168_0 and not isNil(var_168_24) and arg_165_1.var_.characterEffect10079ui_story == nil then
				arg_165_1.var_.characterEffect10079ui_story = var_168_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_26 = 0.200000002980232

			if var_168_25 <= arg_165_1.time_ and arg_165_1.time_ < var_168_25 + var_168_26 and not isNil(var_168_24) then
				local var_168_27 = (arg_165_1.time_ - var_168_25) / var_168_26

				if arg_165_1.var_.characterEffect10079ui_story and not isNil(var_168_24) then
					local var_168_28 = Mathf.Lerp(0, 0.5, var_168_27)

					arg_165_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10079ui_story.fillRatio = var_168_28
				end
			end

			if arg_165_1.time_ >= var_168_25 + var_168_26 and arg_165_1.time_ < var_168_25 + var_168_26 + arg_168_0 and not isNil(var_168_24) and arg_165_1.var_.characterEffect10079ui_story then
				local var_168_29 = 0.5

				arg_165_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10079ui_story.fillRatio = var_168_29
			end

			local var_168_30 = 0
			local var_168_31 = 0.525

			if var_168_30 < arg_165_1.time_ and arg_165_1.time_ <= var_168_30 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_32 = arg_165_1:FormatText(StoryNameCfg[471].name)

				arg_165_1.leftNameTxt_.text = var_168_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_33 = arg_165_1:GetWordFromCfg(319311040)
				local var_168_34 = arg_165_1:FormatText(var_168_33.content)

				arg_165_1.text_.text = var_168_34

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_35 = 21
				local var_168_36 = utf8.len(var_168_34)
				local var_168_37 = var_168_35 <= 0 and var_168_31 or var_168_31 * (var_168_36 / var_168_35)

				if var_168_37 > 0 and var_168_31 < var_168_37 then
					arg_165_1.talkMaxDuration = var_168_37

					if var_168_37 + var_168_30 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_37 + var_168_30
					end
				end

				arg_165_1.text_.text = var_168_34
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311040", "story_v_out_319311.awb") ~= 0 then
					local var_168_38 = manager.audio:GetVoiceLength("story_v_out_319311", "319311040", "story_v_out_319311.awb") / 1000

					if var_168_38 + var_168_30 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_38 + var_168_30
					end

					if var_168_33.prefab_name ~= "" and arg_165_1.actors_[var_168_33.prefab_name] ~= nil then
						local var_168_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_33.prefab_name].transform, "story_v_out_319311", "319311040", "story_v_out_319311.awb")

						arg_165_1:RecordAudio("319311040", var_168_39)
						arg_165_1:RecordAudio("319311040", var_168_39)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_319311", "319311040", "story_v_out_319311.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_319311", "319311040", "story_v_out_319311.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_40 = math.max(var_168_31, arg_165_1.talkMaxDuration)

			if var_168_30 <= arg_165_1.time_ and arg_165_1.time_ < var_168_30 + var_168_40 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_30) / var_168_40

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_30 + var_168_40 and arg_165_1.time_ < var_168_30 + var_168_40 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_165_1:InitPlayNodeList()
	end,
	Play319311041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319311041
		arg_169_1.duration_ = 5.63

		local var_169_0 = {
			zh = 5.633,
			ja = 5.066
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
				arg_169_0:Play319311042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["4040ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos4040ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos4040ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["4040ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect4040ui_story == nil then
				arg_169_1.var_.characterEffect4040ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect4040ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect4040ui_story then
				arg_169_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_172_13 = arg_169_1.actors_["1095ui_story"].transform
			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1.var_.moveOldPos1095ui_story = var_172_13.localPosition
			end

			local var_172_15 = 0.001

			if var_172_14 <= arg_169_1.time_ and arg_169_1.time_ < var_172_14 + var_172_15 then
				local var_172_16 = (arg_169_1.time_ - var_172_14) / var_172_15
				local var_172_17 = Vector3.New(0.7, -0.98, -6.1)

				var_172_13.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1095ui_story, var_172_17, var_172_16)

				local var_172_18 = manager.ui.mainCamera.transform.position - var_172_13.position

				var_172_13.forward = Vector3.New(var_172_18.x, var_172_18.y, var_172_18.z)

				local var_172_19 = var_172_13.localEulerAngles

				var_172_19.z = 0
				var_172_19.x = 0
				var_172_13.localEulerAngles = var_172_19
			end

			if arg_169_1.time_ >= var_172_14 + var_172_15 and arg_169_1.time_ < var_172_14 + var_172_15 + arg_172_0 then
				var_172_13.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_172_20 = manager.ui.mainCamera.transform.position - var_172_13.position

				var_172_13.forward = Vector3.New(var_172_20.x, var_172_20.y, var_172_20.z)

				local var_172_21 = var_172_13.localEulerAngles

				var_172_21.z = 0
				var_172_21.x = 0
				var_172_13.localEulerAngles = var_172_21
			end

			local var_172_22 = arg_169_1.actors_["1095ui_story"]
			local var_172_23 = 0

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 and not isNil(var_172_22) and arg_169_1.var_.characterEffect1095ui_story == nil then
				arg_169_1.var_.characterEffect1095ui_story = var_172_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_24 = 0.200000002980232

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_24 and not isNil(var_172_22) then
				local var_172_25 = (arg_169_1.time_ - var_172_23) / var_172_24

				if arg_169_1.var_.characterEffect1095ui_story and not isNil(var_172_22) then
					local var_172_26 = Mathf.Lerp(0, 0.5, var_172_25)

					arg_169_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1095ui_story.fillRatio = var_172_26
				end
			end

			if arg_169_1.time_ >= var_172_23 + var_172_24 and arg_169_1.time_ < var_172_23 + var_172_24 + arg_172_0 and not isNil(var_172_22) and arg_169_1.var_.characterEffect1095ui_story then
				local var_172_27 = 0.5

				arg_169_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1095ui_story.fillRatio = var_172_27
			end

			local var_172_28 = 0
			local var_172_29 = 0.625

			if var_172_28 < arg_169_1.time_ and arg_169_1.time_ <= var_172_28 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_30 = arg_169_1:FormatText(StoryNameCfg[668].name)

				arg_169_1.leftNameTxt_.text = var_172_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_31 = arg_169_1:GetWordFromCfg(319311041)
				local var_172_32 = arg_169_1:FormatText(var_172_31.content)

				arg_169_1.text_.text = var_172_32

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_33 = 25
				local var_172_34 = utf8.len(var_172_32)
				local var_172_35 = var_172_33 <= 0 and var_172_29 or var_172_29 * (var_172_34 / var_172_33)

				if var_172_35 > 0 and var_172_29 < var_172_35 then
					arg_169_1.talkMaxDuration = var_172_35

					if var_172_35 + var_172_28 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_35 + var_172_28
					end
				end

				arg_169_1.text_.text = var_172_32
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311041", "story_v_out_319311.awb") ~= 0 then
					local var_172_36 = manager.audio:GetVoiceLength("story_v_out_319311", "319311041", "story_v_out_319311.awb") / 1000

					if var_172_36 + var_172_28 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_36 + var_172_28
					end

					if var_172_31.prefab_name ~= "" and arg_169_1.actors_[var_172_31.prefab_name] ~= nil then
						local var_172_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_31.prefab_name].transform, "story_v_out_319311", "319311041", "story_v_out_319311.awb")

						arg_169_1:RecordAudio("319311041", var_172_37)
						arg_169_1:RecordAudio("319311041", var_172_37)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319311", "319311041", "story_v_out_319311.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319311", "319311041", "story_v_out_319311.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_38 = math.max(var_172_29, arg_169_1.talkMaxDuration)

			if var_172_28 <= arg_169_1.time_ and arg_169_1.time_ < var_172_28 + var_172_38 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_28) / var_172_38

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_28 + var_172_38 and arg_169_1.time_ < var_172_28 + var_172_38 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play319311042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319311042
		arg_173_1.duration_ = 2.4

		local var_173_0 = {
			zh = 1.866,
			ja = 2.4
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
				arg_173_0:Play319311043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["4040ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect4040ui_story == nil then
				arg_173_1.var_.characterEffect4040ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect4040ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_173_1.var_.characterEffect4040ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect4040ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_173_1.var_.characterEffect4040ui_story.fillRatio = var_176_5
			end

			local var_176_6 = arg_173_1.actors_["1095ui_story"]
			local var_176_7 = 0

			if var_176_7 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1095ui_story == nil then
				arg_173_1.var_.characterEffect1095ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_8 = 0.200000002980232

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_8 and not isNil(var_176_6) then
				local var_176_9 = (arg_173_1.time_ - var_176_7) / var_176_8

				if arg_173_1.var_.characterEffect1095ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_7 + var_176_8 and arg_173_1.time_ < var_176_7 + var_176_8 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect1095ui_story then
				arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_176_10 = 0
			local var_176_11 = 0.175

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_12 = arg_173_1:FormatText(StoryNameCfg[471].name)

				arg_173_1.leftNameTxt_.text = var_176_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_13 = arg_173_1:GetWordFromCfg(319311042)
				local var_176_14 = arg_173_1:FormatText(var_176_13.content)

				arg_173_1.text_.text = var_176_14

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_15 = 7
				local var_176_16 = utf8.len(var_176_14)
				local var_176_17 = var_176_15 <= 0 and var_176_11 or var_176_11 * (var_176_16 / var_176_15)

				if var_176_17 > 0 and var_176_11 < var_176_17 then
					arg_173_1.talkMaxDuration = var_176_17

					if var_176_17 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_17 + var_176_10
					end
				end

				arg_173_1.text_.text = var_176_14
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311042", "story_v_out_319311.awb") ~= 0 then
					local var_176_18 = manager.audio:GetVoiceLength("story_v_out_319311", "319311042", "story_v_out_319311.awb") / 1000

					if var_176_18 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_18 + var_176_10
					end

					if var_176_13.prefab_name ~= "" and arg_173_1.actors_[var_176_13.prefab_name] ~= nil then
						local var_176_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_13.prefab_name].transform, "story_v_out_319311", "319311042", "story_v_out_319311.awb")

						arg_173_1:RecordAudio("319311042", var_176_19)
						arg_173_1:RecordAudio("319311042", var_176_19)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319311", "319311042", "story_v_out_319311.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319311", "319311042", "story_v_out_319311.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_20 = math.max(var_176_11, arg_173_1.talkMaxDuration)

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_20 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_10) / var_176_20

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_10 + var_176_20 and arg_173_1.time_ < var_176_10 + var_176_20 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play319311043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319311043
		arg_177_1.duration_ = 4.33

		local var_177_0 = {
			zh = 4.333,
			ja = 2.4
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
				arg_177_0:Play319311044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10079ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10079ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, -0.95, -6.05)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10079ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["10079ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect10079ui_story == nil then
				arg_177_1.var_.characterEffect10079ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect10079ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect10079ui_story then
				arg_177_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_180_13 = 0

			if var_180_13 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_15 = arg_177_1.actors_["1095ui_story"].transform
			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.var_.moveOldPos1095ui_story = var_180_15.localPosition
			end

			local var_180_17 = 0.001

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_17 then
				local var_180_18 = (arg_177_1.time_ - var_180_16) / var_180_17
				local var_180_19 = Vector3.New(0, 100, 0)

				var_180_15.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1095ui_story, var_180_19, var_180_18)

				local var_180_20 = manager.ui.mainCamera.transform.position - var_180_15.position

				var_180_15.forward = Vector3.New(var_180_20.x, var_180_20.y, var_180_20.z)

				local var_180_21 = var_180_15.localEulerAngles

				var_180_21.z = 0
				var_180_21.x = 0
				var_180_15.localEulerAngles = var_180_21
			end

			if arg_177_1.time_ >= var_180_16 + var_180_17 and arg_177_1.time_ < var_180_16 + var_180_17 + arg_180_0 then
				var_180_15.localPosition = Vector3.New(0, 100, 0)

				local var_180_22 = manager.ui.mainCamera.transform.position - var_180_15.position

				var_180_15.forward = Vector3.New(var_180_22.x, var_180_22.y, var_180_22.z)

				local var_180_23 = var_180_15.localEulerAngles

				var_180_23.z = 0
				var_180_23.x = 0
				var_180_15.localEulerAngles = var_180_23
			end

			local var_180_24 = arg_177_1.actors_["1095ui_story"]
			local var_180_25 = 0

			if var_180_25 < arg_177_1.time_ and arg_177_1.time_ <= var_180_25 + arg_180_0 and not isNil(var_180_24) and arg_177_1.var_.characterEffect1095ui_story == nil then
				arg_177_1.var_.characterEffect1095ui_story = var_180_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_26 = 0.200000002980232

			if var_180_25 <= arg_177_1.time_ and arg_177_1.time_ < var_180_25 + var_180_26 and not isNil(var_180_24) then
				local var_180_27 = (arg_177_1.time_ - var_180_25) / var_180_26

				if arg_177_1.var_.characterEffect1095ui_story and not isNil(var_180_24) then
					local var_180_28 = Mathf.Lerp(0, 0.5, var_180_27)

					arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1095ui_story.fillRatio = var_180_28
				end
			end

			if arg_177_1.time_ >= var_180_25 + var_180_26 and arg_177_1.time_ < var_180_25 + var_180_26 + arg_180_0 and not isNil(var_180_24) and arg_177_1.var_.characterEffect1095ui_story then
				local var_180_29 = 0.5

				arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1095ui_story.fillRatio = var_180_29
			end

			local var_180_30 = arg_177_1.actors_["4040ui_story"].transform
			local var_180_31 = 0

			if var_180_31 < arg_177_1.time_ and arg_177_1.time_ <= var_180_31 + arg_180_0 then
				arg_177_1.var_.moveOldPos4040ui_story = var_180_30.localPosition
			end

			local var_180_32 = 0.001

			if var_180_31 <= arg_177_1.time_ and arg_177_1.time_ < var_180_31 + var_180_32 then
				local var_180_33 = (arg_177_1.time_ - var_180_31) / var_180_32
				local var_180_34 = Vector3.New(0, 100, 0)

				var_180_30.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos4040ui_story, var_180_34, var_180_33)

				local var_180_35 = manager.ui.mainCamera.transform.position - var_180_30.position

				var_180_30.forward = Vector3.New(var_180_35.x, var_180_35.y, var_180_35.z)

				local var_180_36 = var_180_30.localEulerAngles

				var_180_36.z = 0
				var_180_36.x = 0
				var_180_30.localEulerAngles = var_180_36
			end

			if arg_177_1.time_ >= var_180_31 + var_180_32 and arg_177_1.time_ < var_180_31 + var_180_32 + arg_180_0 then
				var_180_30.localPosition = Vector3.New(0, 100, 0)

				local var_180_37 = manager.ui.mainCamera.transform.position - var_180_30.position

				var_180_30.forward = Vector3.New(var_180_37.x, var_180_37.y, var_180_37.z)

				local var_180_38 = var_180_30.localEulerAngles

				var_180_38.z = 0
				var_180_38.x = 0
				var_180_30.localEulerAngles = var_180_38
			end

			local var_180_39 = arg_177_1.actors_["4040ui_story"]
			local var_180_40 = 0

			if var_180_40 < arg_177_1.time_ and arg_177_1.time_ <= var_180_40 + arg_180_0 and not isNil(var_180_39) and arg_177_1.var_.characterEffect4040ui_story == nil then
				arg_177_1.var_.characterEffect4040ui_story = var_180_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_41 = 0.200000002980232

			if var_180_40 <= arg_177_1.time_ and arg_177_1.time_ < var_180_40 + var_180_41 and not isNil(var_180_39) then
				local var_180_42 = (arg_177_1.time_ - var_180_40) / var_180_41

				if arg_177_1.var_.characterEffect4040ui_story and not isNil(var_180_39) then
					local var_180_43 = Mathf.Lerp(0, 0.5, var_180_42)

					arg_177_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_177_1.var_.characterEffect4040ui_story.fillRatio = var_180_43
				end
			end

			if arg_177_1.time_ >= var_180_40 + var_180_41 and arg_177_1.time_ < var_180_40 + var_180_41 + arg_180_0 and not isNil(var_180_39) and arg_177_1.var_.characterEffect4040ui_story then
				local var_180_44 = 0.5

				arg_177_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_177_1.var_.characterEffect4040ui_story.fillRatio = var_180_44
			end

			local var_180_45 = 0
			local var_180_46 = 0.425

			if var_180_45 < arg_177_1.time_ and arg_177_1.time_ <= var_180_45 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_47 = arg_177_1:FormatText(StoryNameCfg[6].name)

				arg_177_1.leftNameTxt_.text = var_180_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_48 = arg_177_1:GetWordFromCfg(319311043)
				local var_180_49 = arg_177_1:FormatText(var_180_48.content)

				arg_177_1.text_.text = var_180_49

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_50 = 17
				local var_180_51 = utf8.len(var_180_49)
				local var_180_52 = var_180_50 <= 0 and var_180_46 or var_180_46 * (var_180_51 / var_180_50)

				if var_180_52 > 0 and var_180_46 < var_180_52 then
					arg_177_1.talkMaxDuration = var_180_52

					if var_180_52 + var_180_45 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_52 + var_180_45
					end
				end

				arg_177_1.text_.text = var_180_49
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311043", "story_v_out_319311.awb") ~= 0 then
					local var_180_53 = manager.audio:GetVoiceLength("story_v_out_319311", "319311043", "story_v_out_319311.awb") / 1000

					if var_180_53 + var_180_45 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_53 + var_180_45
					end

					if var_180_48.prefab_name ~= "" and arg_177_1.actors_[var_180_48.prefab_name] ~= nil then
						local var_180_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_48.prefab_name].transform, "story_v_out_319311", "319311043", "story_v_out_319311.awb")

						arg_177_1:RecordAudio("319311043", var_180_54)
						arg_177_1:RecordAudio("319311043", var_180_54)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319311", "319311043", "story_v_out_319311.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319311", "319311043", "story_v_out_319311.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_55 = math.max(var_180_46, arg_177_1.talkMaxDuration)

			if var_180_45 <= arg_177_1.time_ and arg_177_1.time_ < var_180_45 + var_180_55 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_45) / var_180_55

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_45 + var_180_55 and arg_177_1.time_ < var_180_45 + var_180_55 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_177_1:InitPlayNodeList()
	end,
	Play319311044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319311044
		arg_181_1.duration_ = 8

		local var_181_0 = {
			zh = 8,
			ja = 7.533
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
				arg_181_0:Play319311045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["4040ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos4040ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, -1.55, -5.5)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos4040ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["4040ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect4040ui_story == nil then
				arg_181_1.var_.characterEffect4040ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect4040ui_story and not isNil(var_184_9) then
					arg_181_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect4040ui_story then
				arg_181_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_184_13 = arg_181_1.actors_["10079ui_story"].transform
			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				arg_181_1.var_.moveOldPos10079ui_story = var_184_13.localPosition
			end

			local var_184_15 = 0.001

			if var_184_14 <= arg_181_1.time_ and arg_181_1.time_ < var_184_14 + var_184_15 then
				local var_184_16 = (arg_181_1.time_ - var_184_14) / var_184_15
				local var_184_17 = Vector3.New(0, 100, 0)

				var_184_13.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10079ui_story, var_184_17, var_184_16)

				local var_184_18 = manager.ui.mainCamera.transform.position - var_184_13.position

				var_184_13.forward = Vector3.New(var_184_18.x, var_184_18.y, var_184_18.z)

				local var_184_19 = var_184_13.localEulerAngles

				var_184_19.z = 0
				var_184_19.x = 0
				var_184_13.localEulerAngles = var_184_19
			end

			if arg_181_1.time_ >= var_184_14 + var_184_15 and arg_181_1.time_ < var_184_14 + var_184_15 + arg_184_0 then
				var_184_13.localPosition = Vector3.New(0, 100, 0)

				local var_184_20 = manager.ui.mainCamera.transform.position - var_184_13.position

				var_184_13.forward = Vector3.New(var_184_20.x, var_184_20.y, var_184_20.z)

				local var_184_21 = var_184_13.localEulerAngles

				var_184_21.z = 0
				var_184_21.x = 0
				var_184_13.localEulerAngles = var_184_21
			end

			local var_184_22 = arg_181_1.actors_["10079ui_story"]
			local var_184_23 = 0

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.characterEffect10079ui_story == nil then
				arg_181_1.var_.characterEffect10079ui_story = var_184_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_24 = 0.200000002980232

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_24 and not isNil(var_184_22) then
				local var_184_25 = (arg_181_1.time_ - var_184_23) / var_184_24

				if arg_181_1.var_.characterEffect10079ui_story and not isNil(var_184_22) then
					local var_184_26 = Mathf.Lerp(0, 0.5, var_184_25)

					arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10079ui_story.fillRatio = var_184_26
				end
			end

			if arg_181_1.time_ >= var_184_23 + var_184_24 and arg_181_1.time_ < var_184_23 + var_184_24 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.characterEffect10079ui_story then
				local var_184_27 = 0.5

				arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10079ui_story.fillRatio = var_184_27
			end

			local var_184_28 = 0

			if var_184_28 < arg_181_1.time_ and arg_181_1.time_ <= var_184_28 + arg_184_0 then
				arg_181_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_184_29 = 0

			if var_184_29 < arg_181_1.time_ and arg_181_1.time_ <= var_184_29 + arg_184_0 then
				arg_181_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_30 = 0
			local var_184_31 = 0.85

			if var_184_30 < arg_181_1.time_ and arg_181_1.time_ <= var_184_30 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_32 = arg_181_1:FormatText(StoryNameCfg[668].name)

				arg_181_1.leftNameTxt_.text = var_184_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_33 = arg_181_1:GetWordFromCfg(319311044)
				local var_184_34 = arg_181_1:FormatText(var_184_33.content)

				arg_181_1.text_.text = var_184_34

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_35 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311044", "story_v_out_319311.awb") ~= 0 then
					local var_184_38 = manager.audio:GetVoiceLength("story_v_out_319311", "319311044", "story_v_out_319311.awb") / 1000

					if var_184_38 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_38 + var_184_30
					end

					if var_184_33.prefab_name ~= "" and arg_181_1.actors_[var_184_33.prefab_name] ~= nil then
						local var_184_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_33.prefab_name].transform, "story_v_out_319311", "319311044", "story_v_out_319311.awb")

						arg_181_1:RecordAudio("319311044", var_184_39)
						arg_181_1:RecordAudio("319311044", var_184_39)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_319311", "319311044", "story_v_out_319311.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_319311", "319311044", "story_v_out_319311.awb")
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

		arg_181_1:InitPlayNodeList()
	end,
	Play319311045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319311045
		arg_185_1.duration_ = 2

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319311046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10079ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10079ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(0, -0.95, -6.05)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10079ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["10079ui_story"]
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect10079ui_story == nil then
				arg_185_1.var_.characterEffect10079ui_story = var_188_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_11 = 0.200000002980232

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 and not isNil(var_188_9) then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11

				if arg_185_1.var_.characterEffect10079ui_story and not isNil(var_188_9) then
					arg_185_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect10079ui_story then
				arg_185_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_188_13 = 0

			if var_188_13 < arg_185_1.time_ and arg_185_1.time_ <= var_188_13 + arg_188_0 then
				arg_185_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_188_15 = arg_185_1.actors_["4040ui_story"].transform
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.var_.moveOldPos4040ui_story = var_188_15.localPosition
			end

			local var_188_17 = 0.001

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17
				local var_188_19 = Vector3.New(0, 100, 0)

				var_188_15.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos4040ui_story, var_188_19, var_188_18)

				local var_188_20 = manager.ui.mainCamera.transform.position - var_188_15.position

				var_188_15.forward = Vector3.New(var_188_20.x, var_188_20.y, var_188_20.z)

				local var_188_21 = var_188_15.localEulerAngles

				var_188_21.z = 0
				var_188_21.x = 0
				var_188_15.localEulerAngles = var_188_21
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 then
				var_188_15.localPosition = Vector3.New(0, 100, 0)

				local var_188_22 = manager.ui.mainCamera.transform.position - var_188_15.position

				var_188_15.forward = Vector3.New(var_188_22.x, var_188_22.y, var_188_22.z)

				local var_188_23 = var_188_15.localEulerAngles

				var_188_23.z = 0
				var_188_23.x = 0
				var_188_15.localEulerAngles = var_188_23
			end

			local var_188_24 = arg_185_1.actors_["4040ui_story"]
			local var_188_25 = 0

			if var_188_25 < arg_185_1.time_ and arg_185_1.time_ <= var_188_25 + arg_188_0 and not isNil(var_188_24) and arg_185_1.var_.characterEffect4040ui_story == nil then
				arg_185_1.var_.characterEffect4040ui_story = var_188_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_26 = 0.200000002980232

			if var_188_25 <= arg_185_1.time_ and arg_185_1.time_ < var_188_25 + var_188_26 and not isNil(var_188_24) then
				local var_188_27 = (arg_185_1.time_ - var_188_25) / var_188_26

				if arg_185_1.var_.characterEffect4040ui_story and not isNil(var_188_24) then
					local var_188_28 = Mathf.Lerp(0, 0.5, var_188_27)

					arg_185_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_185_1.var_.characterEffect4040ui_story.fillRatio = var_188_28
				end
			end

			if arg_185_1.time_ >= var_188_25 + var_188_26 and arg_185_1.time_ < var_188_25 + var_188_26 + arg_188_0 and not isNil(var_188_24) and arg_185_1.var_.characterEffect4040ui_story then
				local var_188_29 = 0.5

				arg_185_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_185_1.var_.characterEffect4040ui_story.fillRatio = var_188_29
			end

			local var_188_30 = 0
			local var_188_31 = 0.075

			if var_188_30 < arg_185_1.time_ and arg_185_1.time_ <= var_188_30 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_32 = arg_185_1:FormatText(StoryNameCfg[6].name)

				arg_185_1.leftNameTxt_.text = var_188_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_33 = arg_185_1:GetWordFromCfg(319311045)
				local var_188_34 = arg_185_1:FormatText(var_188_33.content)

				arg_185_1.text_.text = var_188_34

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_35 = 3
				local var_188_36 = utf8.len(var_188_34)
				local var_188_37 = var_188_35 <= 0 and var_188_31 or var_188_31 * (var_188_36 / var_188_35)

				if var_188_37 > 0 and var_188_31 < var_188_37 then
					arg_185_1.talkMaxDuration = var_188_37

					if var_188_37 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_37 + var_188_30
					end
				end

				arg_185_1.text_.text = var_188_34
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311045", "story_v_out_319311.awb") ~= 0 then
					local var_188_38 = manager.audio:GetVoiceLength("story_v_out_319311", "319311045", "story_v_out_319311.awb") / 1000

					if var_188_38 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_38 + var_188_30
					end

					if var_188_33.prefab_name ~= "" and arg_185_1.actors_[var_188_33.prefab_name] ~= nil then
						local var_188_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_33.prefab_name].transform, "story_v_out_319311", "319311045", "story_v_out_319311.awb")

						arg_185_1:RecordAudio("319311045", var_188_39)
						arg_185_1:RecordAudio("319311045", var_188_39)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319311", "319311045", "story_v_out_319311.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319311", "319311045", "story_v_out_319311.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_40 = math.max(var_188_31, arg_185_1.talkMaxDuration)

			if var_188_30 <= arg_185_1.time_ and arg_185_1.time_ < var_188_30 + var_188_40 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_30) / var_188_40

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_30 + var_188_40 and arg_185_1.time_ < var_188_30 + var_188_40 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_185_1:InitPlayNodeList()
	end,
	Play319311046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319311046
		arg_189_1.duration_ = 3.3

		local var_189_0 = {
			zh = 2.566,
			ja = 3.3
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
				arg_189_0:Play319311047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1095ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1095ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0.7, -0.98, -6.1)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1095ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["1095ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1095ui_story == nil then
				arg_189_1.var_.characterEffect1095ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect1095ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1095ui_story then
				arg_189_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_192_13 = 0

			if var_192_13 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_15 = arg_189_1.actors_["10079ui_story"].transform
			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.var_.moveOldPos10079ui_story = var_192_15.localPosition
			end

			local var_192_17 = 0.001

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_17 then
				local var_192_18 = (arg_189_1.time_ - var_192_16) / var_192_17
				local var_192_19 = Vector3.New(-0.7, -0.95, -6.05)

				var_192_15.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10079ui_story, var_192_19, var_192_18)

				local var_192_20 = manager.ui.mainCamera.transform.position - var_192_15.position

				var_192_15.forward = Vector3.New(var_192_20.x, var_192_20.y, var_192_20.z)

				local var_192_21 = var_192_15.localEulerAngles

				var_192_21.z = 0
				var_192_21.x = 0
				var_192_15.localEulerAngles = var_192_21
			end

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 then
				var_192_15.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_192_22 = manager.ui.mainCamera.transform.position - var_192_15.position

				var_192_15.forward = Vector3.New(var_192_22.x, var_192_22.y, var_192_22.z)

				local var_192_23 = var_192_15.localEulerAngles

				var_192_23.z = 0
				var_192_23.x = 0
				var_192_15.localEulerAngles = var_192_23
			end

			local var_192_24 = arg_189_1.actors_["10079ui_story"]
			local var_192_25 = 0

			if var_192_25 < arg_189_1.time_ and arg_189_1.time_ <= var_192_25 + arg_192_0 and not isNil(var_192_24) and arg_189_1.var_.characterEffect10079ui_story == nil then
				arg_189_1.var_.characterEffect10079ui_story = var_192_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_26 = 0.200000002980232

			if var_192_25 <= arg_189_1.time_ and arg_189_1.time_ < var_192_25 + var_192_26 and not isNil(var_192_24) then
				local var_192_27 = (arg_189_1.time_ - var_192_25) / var_192_26

				if arg_189_1.var_.characterEffect10079ui_story and not isNil(var_192_24) then
					local var_192_28 = Mathf.Lerp(0, 0.5, var_192_27)

					arg_189_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10079ui_story.fillRatio = var_192_28
				end
			end

			if arg_189_1.time_ >= var_192_25 + var_192_26 and arg_189_1.time_ < var_192_25 + var_192_26 + arg_192_0 and not isNil(var_192_24) and arg_189_1.var_.characterEffect10079ui_story then
				local var_192_29 = 0.5

				arg_189_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10079ui_story.fillRatio = var_192_29
			end

			local var_192_30 = 0
			local var_192_31 = 0.175

			if var_192_30 < arg_189_1.time_ and arg_189_1.time_ <= var_192_30 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_32 = arg_189_1:FormatText(StoryNameCfg[471].name)

				arg_189_1.leftNameTxt_.text = var_192_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_33 = arg_189_1:GetWordFromCfg(319311046)
				local var_192_34 = arg_189_1:FormatText(var_192_33.content)

				arg_189_1.text_.text = var_192_34

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_35 = 7
				local var_192_36 = utf8.len(var_192_34)
				local var_192_37 = var_192_35 <= 0 and var_192_31 or var_192_31 * (var_192_36 / var_192_35)

				if var_192_37 > 0 and var_192_31 < var_192_37 then
					arg_189_1.talkMaxDuration = var_192_37

					if var_192_37 + var_192_30 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_37 + var_192_30
					end
				end

				arg_189_1.text_.text = var_192_34
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311046", "story_v_out_319311.awb") ~= 0 then
					local var_192_38 = manager.audio:GetVoiceLength("story_v_out_319311", "319311046", "story_v_out_319311.awb") / 1000

					if var_192_38 + var_192_30 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_38 + var_192_30
					end

					if var_192_33.prefab_name ~= "" and arg_189_1.actors_[var_192_33.prefab_name] ~= nil then
						local var_192_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_33.prefab_name].transform, "story_v_out_319311", "319311046", "story_v_out_319311.awb")

						arg_189_1:RecordAudio("319311046", var_192_39)
						arg_189_1:RecordAudio("319311046", var_192_39)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_319311", "319311046", "story_v_out_319311.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_319311", "319311046", "story_v_out_319311.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_40 = math.max(var_192_31, arg_189_1.talkMaxDuration)

			if var_192_30 <= arg_189_1.time_ and arg_189_1.time_ < var_192_30 + var_192_40 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_30) / var_192_40

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_30 + var_192_40 and arg_189_1.time_ < var_192_30 + var_192_40 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_189_1:InitPlayNodeList()
	end,
	Play319311047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319311047
		arg_193_1.duration_ = 8.13

		local var_193_0 = {
			zh = 8.133,
			ja = 7.466
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
				arg_193_0:Play319311048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.9

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[471].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(319311047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311047", "story_v_out_319311.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_319311", "319311047", "story_v_out_319311.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_319311", "319311047", "story_v_out_319311.awb")

						arg_193_1:RecordAudio("319311047", var_196_9)
						arg_193_1:RecordAudio("319311047", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319311", "319311047", "story_v_out_319311.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319311", "319311047", "story_v_out_319311.awb")
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
	Play319311048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319311048
		arg_197_1.duration_ = 4.87

		local var_197_0 = {
			zh = 2.6,
			ja = 4.866
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
				arg_197_0:Play319311049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["4040ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos4040ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, -1.55, -5.5)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos4040ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["4040ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect4040ui_story == nil then
				arg_197_1.var_.characterEffect4040ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect4040ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect4040ui_story then
				arg_197_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_200_13 = arg_197_1.actors_["1095ui_story"].transform
			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1.var_.moveOldPos1095ui_story = var_200_13.localPosition
			end

			local var_200_15 = 0.001

			if var_200_14 <= arg_197_1.time_ and arg_197_1.time_ < var_200_14 + var_200_15 then
				local var_200_16 = (arg_197_1.time_ - var_200_14) / var_200_15
				local var_200_17 = Vector3.New(0, 100, 0)

				var_200_13.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1095ui_story, var_200_17, var_200_16)

				local var_200_18 = manager.ui.mainCamera.transform.position - var_200_13.position

				var_200_13.forward = Vector3.New(var_200_18.x, var_200_18.y, var_200_18.z)

				local var_200_19 = var_200_13.localEulerAngles

				var_200_19.z = 0
				var_200_19.x = 0
				var_200_13.localEulerAngles = var_200_19
			end

			if arg_197_1.time_ >= var_200_14 + var_200_15 and arg_197_1.time_ < var_200_14 + var_200_15 + arg_200_0 then
				var_200_13.localPosition = Vector3.New(0, 100, 0)

				local var_200_20 = manager.ui.mainCamera.transform.position - var_200_13.position

				var_200_13.forward = Vector3.New(var_200_20.x, var_200_20.y, var_200_20.z)

				local var_200_21 = var_200_13.localEulerAngles

				var_200_21.z = 0
				var_200_21.x = 0
				var_200_13.localEulerAngles = var_200_21
			end

			local var_200_22 = arg_197_1.actors_["1095ui_story"]
			local var_200_23 = 0

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 and not isNil(var_200_22) and arg_197_1.var_.characterEffect1095ui_story == nil then
				arg_197_1.var_.characterEffect1095ui_story = var_200_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_24 = 0.200000002980232

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_24 and not isNil(var_200_22) then
				local var_200_25 = (arg_197_1.time_ - var_200_23) / var_200_24

				if arg_197_1.var_.characterEffect1095ui_story and not isNil(var_200_22) then
					local var_200_26 = Mathf.Lerp(0, 0.5, var_200_25)

					arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1095ui_story.fillRatio = var_200_26
				end
			end

			if arg_197_1.time_ >= var_200_23 + var_200_24 and arg_197_1.time_ < var_200_23 + var_200_24 + arg_200_0 and not isNil(var_200_22) and arg_197_1.var_.characterEffect1095ui_story then
				local var_200_27 = 0.5

				arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1095ui_story.fillRatio = var_200_27
			end

			local var_200_28 = arg_197_1.actors_["10079ui_story"].transform
			local var_200_29 = 0

			if var_200_29 < arg_197_1.time_ and arg_197_1.time_ <= var_200_29 + arg_200_0 then
				arg_197_1.var_.moveOldPos10079ui_story = var_200_28.localPosition
			end

			local var_200_30 = 0.001

			if var_200_29 <= arg_197_1.time_ and arg_197_1.time_ < var_200_29 + var_200_30 then
				local var_200_31 = (arg_197_1.time_ - var_200_29) / var_200_30
				local var_200_32 = Vector3.New(0, 100, 0)

				var_200_28.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10079ui_story, var_200_32, var_200_31)

				local var_200_33 = manager.ui.mainCamera.transform.position - var_200_28.position

				var_200_28.forward = Vector3.New(var_200_33.x, var_200_33.y, var_200_33.z)

				local var_200_34 = var_200_28.localEulerAngles

				var_200_34.z = 0
				var_200_34.x = 0
				var_200_28.localEulerAngles = var_200_34
			end

			if arg_197_1.time_ >= var_200_29 + var_200_30 and arg_197_1.time_ < var_200_29 + var_200_30 + arg_200_0 then
				var_200_28.localPosition = Vector3.New(0, 100, 0)

				local var_200_35 = manager.ui.mainCamera.transform.position - var_200_28.position

				var_200_28.forward = Vector3.New(var_200_35.x, var_200_35.y, var_200_35.z)

				local var_200_36 = var_200_28.localEulerAngles

				var_200_36.z = 0
				var_200_36.x = 0
				var_200_28.localEulerAngles = var_200_36
			end

			local var_200_37 = arg_197_1.actors_["10079ui_story"]
			local var_200_38 = 0

			if var_200_38 < arg_197_1.time_ and arg_197_1.time_ <= var_200_38 + arg_200_0 and not isNil(var_200_37) and arg_197_1.var_.characterEffect10079ui_story == nil then
				arg_197_1.var_.characterEffect10079ui_story = var_200_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_39 = 0.200000002980232

			if var_200_38 <= arg_197_1.time_ and arg_197_1.time_ < var_200_38 + var_200_39 and not isNil(var_200_37) then
				local var_200_40 = (arg_197_1.time_ - var_200_38) / var_200_39

				if arg_197_1.var_.characterEffect10079ui_story and not isNil(var_200_37) then
					local var_200_41 = Mathf.Lerp(0, 0.5, var_200_40)

					arg_197_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10079ui_story.fillRatio = var_200_41
				end
			end

			if arg_197_1.time_ >= var_200_38 + var_200_39 and arg_197_1.time_ < var_200_38 + var_200_39 + arg_200_0 and not isNil(var_200_37) and arg_197_1.var_.characterEffect10079ui_story then
				local var_200_42 = 0.5

				arg_197_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10079ui_story.fillRatio = var_200_42
			end

			local var_200_43 = 0

			if var_200_43 < arg_197_1.time_ and arg_197_1.time_ <= var_200_43 + arg_200_0 then
				arg_197_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_200_44 = 0

			if var_200_44 < arg_197_1.time_ and arg_197_1.time_ <= var_200_44 + arg_200_0 then
				arg_197_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_200_45 = 0
			local var_200_46 = 0.125

			if var_200_45 < arg_197_1.time_ and arg_197_1.time_ <= var_200_45 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_47 = arg_197_1:FormatText(StoryNameCfg[668].name)

				arg_197_1.leftNameTxt_.text = var_200_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_48 = arg_197_1:GetWordFromCfg(319311048)
				local var_200_49 = arg_197_1:FormatText(var_200_48.content)

				arg_197_1.text_.text = var_200_49

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_50 = 5
				local var_200_51 = utf8.len(var_200_49)
				local var_200_52 = var_200_50 <= 0 and var_200_46 or var_200_46 * (var_200_51 / var_200_50)

				if var_200_52 > 0 and var_200_46 < var_200_52 then
					arg_197_1.talkMaxDuration = var_200_52

					if var_200_52 + var_200_45 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_52 + var_200_45
					end
				end

				arg_197_1.text_.text = var_200_49
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311048", "story_v_out_319311.awb") ~= 0 then
					local var_200_53 = manager.audio:GetVoiceLength("story_v_out_319311", "319311048", "story_v_out_319311.awb") / 1000

					if var_200_53 + var_200_45 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_53 + var_200_45
					end

					if var_200_48.prefab_name ~= "" and arg_197_1.actors_[var_200_48.prefab_name] ~= nil then
						local var_200_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_48.prefab_name].transform, "story_v_out_319311", "319311048", "story_v_out_319311.awb")

						arg_197_1:RecordAudio("319311048", var_200_54)
						arg_197_1:RecordAudio("319311048", var_200_54)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_319311", "319311048", "story_v_out_319311.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_319311", "319311048", "story_v_out_319311.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_55 = math.max(var_200_46, arg_197_1.talkMaxDuration)

			if var_200_45 <= arg_197_1.time_ and arg_197_1.time_ < var_200_45 + var_200_55 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_45) / var_200_55

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_45 + var_200_55 and arg_197_1.time_ < var_200_45 + var_200_55 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
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

		arg_197_1:InitPlayNodeList()
	end,
	Play319311049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319311049
		arg_201_1.duration_ = 5.2

		local var_201_0 = {
			zh = 5.2,
			ja = 5.066
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
				arg_201_0:Play319311050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10079ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10079ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(0, -0.95, -6.05)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10079ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = arg_201_1.actors_["10079ui_story"]
			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect10079ui_story == nil then
				arg_201_1.var_.characterEffect10079ui_story = var_204_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_11 = 0.200000002980232

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 and not isNil(var_204_9) then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11

				if arg_201_1.var_.characterEffect10079ui_story and not isNil(var_204_9) then
					arg_201_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect10079ui_story then
				arg_201_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_204_13 = 0

			if var_204_13 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 then
				arg_201_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_204_14 = 0

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				arg_201_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_204_15 = arg_201_1.actors_["4040ui_story"].transform
			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.var_.moveOldPos4040ui_story = var_204_15.localPosition
			end

			local var_204_17 = 0.001

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17
				local var_204_19 = Vector3.New(0, 100, 0)

				var_204_15.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos4040ui_story, var_204_19, var_204_18)

				local var_204_20 = manager.ui.mainCamera.transform.position - var_204_15.position

				var_204_15.forward = Vector3.New(var_204_20.x, var_204_20.y, var_204_20.z)

				local var_204_21 = var_204_15.localEulerAngles

				var_204_21.z = 0
				var_204_21.x = 0
				var_204_15.localEulerAngles = var_204_21
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 then
				var_204_15.localPosition = Vector3.New(0, 100, 0)

				local var_204_22 = manager.ui.mainCamera.transform.position - var_204_15.position

				var_204_15.forward = Vector3.New(var_204_22.x, var_204_22.y, var_204_22.z)

				local var_204_23 = var_204_15.localEulerAngles

				var_204_23.z = 0
				var_204_23.x = 0
				var_204_15.localEulerAngles = var_204_23
			end

			local var_204_24 = arg_201_1.actors_["4040ui_story"]
			local var_204_25 = 0

			if var_204_25 < arg_201_1.time_ and arg_201_1.time_ <= var_204_25 + arg_204_0 and not isNil(var_204_24) and arg_201_1.var_.characterEffect4040ui_story == nil then
				arg_201_1.var_.characterEffect4040ui_story = var_204_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_26 = 0.200000002980232

			if var_204_25 <= arg_201_1.time_ and arg_201_1.time_ < var_204_25 + var_204_26 and not isNil(var_204_24) then
				local var_204_27 = (arg_201_1.time_ - var_204_25) / var_204_26

				if arg_201_1.var_.characterEffect4040ui_story and not isNil(var_204_24) then
					local var_204_28 = Mathf.Lerp(0, 0.5, var_204_27)

					arg_201_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_201_1.var_.characterEffect4040ui_story.fillRatio = var_204_28
				end
			end

			if arg_201_1.time_ >= var_204_25 + var_204_26 and arg_201_1.time_ < var_204_25 + var_204_26 + arg_204_0 and not isNil(var_204_24) and arg_201_1.var_.characterEffect4040ui_story then
				local var_204_29 = 0.5

				arg_201_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_201_1.var_.characterEffect4040ui_story.fillRatio = var_204_29
			end

			local var_204_30 = 0
			local var_204_31 = 0.675

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_32 = arg_201_1:FormatText(StoryNameCfg[6].name)

				arg_201_1.leftNameTxt_.text = var_204_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_33 = arg_201_1:GetWordFromCfg(319311049)
				local var_204_34 = arg_201_1:FormatText(var_204_33.content)

				arg_201_1.text_.text = var_204_34

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_35 = 27
				local var_204_36 = utf8.len(var_204_34)
				local var_204_37 = var_204_35 <= 0 and var_204_31 or var_204_31 * (var_204_36 / var_204_35)

				if var_204_37 > 0 and var_204_31 < var_204_37 then
					arg_201_1.talkMaxDuration = var_204_37

					if var_204_37 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_37 + var_204_30
					end
				end

				arg_201_1.text_.text = var_204_34
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311049", "story_v_out_319311.awb") ~= 0 then
					local var_204_38 = manager.audio:GetVoiceLength("story_v_out_319311", "319311049", "story_v_out_319311.awb") / 1000

					if var_204_38 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_38 + var_204_30
					end

					if var_204_33.prefab_name ~= "" and arg_201_1.actors_[var_204_33.prefab_name] ~= nil then
						local var_204_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_33.prefab_name].transform, "story_v_out_319311", "319311049", "story_v_out_319311.awb")

						arg_201_1:RecordAudio("319311049", var_204_39)
						arg_201_1:RecordAudio("319311049", var_204_39)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_319311", "319311049", "story_v_out_319311.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_319311", "319311049", "story_v_out_319311.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_40 = math.max(var_204_31, arg_201_1.talkMaxDuration)

			if var_204_30 <= arg_201_1.time_ and arg_201_1.time_ < var_204_30 + var_204_40 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_30) / var_204_40

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_30 + var_204_40 and arg_201_1.time_ < var_204_30 + var_204_40 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_201_1:InitPlayNodeList()
	end,
	Play319311050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319311050
		arg_205_1.duration_ = 9.7

		local var_205_0 = {
			zh = 4.766,
			ja = 9.7
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play319311051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.6

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

				local var_208_3 = arg_205_1:GetWordFromCfg(319311050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311050", "story_v_out_319311.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_319311", "319311050", "story_v_out_319311.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_319311", "319311050", "story_v_out_319311.awb")

						arg_205_1:RecordAudio("319311050", var_208_9)
						arg_205_1:RecordAudio("319311050", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_319311", "319311050", "story_v_out_319311.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_319311", "319311050", "story_v_out_319311.awb")
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
	Play319311051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319311051
		arg_209_1.duration_ = 6.23

		local var_209_0 = {
			zh = 4.166,
			ja = 6.233
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
				arg_209_0:Play319311052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1095ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1095ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, -0.98, -6.1)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1095ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["1095ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1095ui_story == nil then
				arg_209_1.var_.characterEffect1095ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect1095ui_story and not isNil(var_212_9) then
					arg_209_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1095ui_story then
				arg_209_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_212_13 = 0

			if var_212_13 < arg_209_1.time_ and arg_209_1.time_ <= var_212_13 + arg_212_0 then
				arg_209_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_212_14 = 0

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_15 = arg_209_1.actors_["10079ui_story"].transform
			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.var_.moveOldPos10079ui_story = var_212_15.localPosition
			end

			local var_212_17 = 0.001

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17
				local var_212_19 = Vector3.New(0, 100, 0)

				var_212_15.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10079ui_story, var_212_19, var_212_18)

				local var_212_20 = manager.ui.mainCamera.transform.position - var_212_15.position

				var_212_15.forward = Vector3.New(var_212_20.x, var_212_20.y, var_212_20.z)

				local var_212_21 = var_212_15.localEulerAngles

				var_212_21.z = 0
				var_212_21.x = 0
				var_212_15.localEulerAngles = var_212_21
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				var_212_15.localPosition = Vector3.New(0, 100, 0)

				local var_212_22 = manager.ui.mainCamera.transform.position - var_212_15.position

				var_212_15.forward = Vector3.New(var_212_22.x, var_212_22.y, var_212_22.z)

				local var_212_23 = var_212_15.localEulerAngles

				var_212_23.z = 0
				var_212_23.x = 0
				var_212_15.localEulerAngles = var_212_23
			end

			local var_212_24 = arg_209_1.actors_["10079ui_story"]
			local var_212_25 = 0

			if var_212_25 < arg_209_1.time_ and arg_209_1.time_ <= var_212_25 + arg_212_0 and not isNil(var_212_24) and arg_209_1.var_.characterEffect10079ui_story == nil then
				arg_209_1.var_.characterEffect10079ui_story = var_212_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_26 = 0.200000002980232

			if var_212_25 <= arg_209_1.time_ and arg_209_1.time_ < var_212_25 + var_212_26 and not isNil(var_212_24) then
				local var_212_27 = (arg_209_1.time_ - var_212_25) / var_212_26

				if arg_209_1.var_.characterEffect10079ui_story and not isNil(var_212_24) then
					local var_212_28 = Mathf.Lerp(0, 0.5, var_212_27)

					arg_209_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10079ui_story.fillRatio = var_212_28
				end
			end

			if arg_209_1.time_ >= var_212_25 + var_212_26 and arg_209_1.time_ < var_212_25 + var_212_26 + arg_212_0 and not isNil(var_212_24) and arg_209_1.var_.characterEffect10079ui_story then
				local var_212_29 = 0.5

				arg_209_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10079ui_story.fillRatio = var_212_29
			end

			local var_212_30 = 0
			local var_212_31 = 0.425

			if var_212_30 < arg_209_1.time_ and arg_209_1.time_ <= var_212_30 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_32 = arg_209_1:FormatText(StoryNameCfg[471].name)

				arg_209_1.leftNameTxt_.text = var_212_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_33 = arg_209_1:GetWordFromCfg(319311051)
				local var_212_34 = arg_209_1:FormatText(var_212_33.content)

				arg_209_1.text_.text = var_212_34

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_35 = 17
				local var_212_36 = utf8.len(var_212_34)
				local var_212_37 = var_212_35 <= 0 and var_212_31 or var_212_31 * (var_212_36 / var_212_35)

				if var_212_37 > 0 and var_212_31 < var_212_37 then
					arg_209_1.talkMaxDuration = var_212_37

					if var_212_37 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_37 + var_212_30
					end
				end

				arg_209_1.text_.text = var_212_34
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311051", "story_v_out_319311.awb") ~= 0 then
					local var_212_38 = manager.audio:GetVoiceLength("story_v_out_319311", "319311051", "story_v_out_319311.awb") / 1000

					if var_212_38 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_38 + var_212_30
					end

					if var_212_33.prefab_name ~= "" and arg_209_1.actors_[var_212_33.prefab_name] ~= nil then
						local var_212_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_33.prefab_name].transform, "story_v_out_319311", "319311051", "story_v_out_319311.awb")

						arg_209_1:RecordAudio("319311051", var_212_39)
						arg_209_1:RecordAudio("319311051", var_212_39)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_319311", "319311051", "story_v_out_319311.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_319311", "319311051", "story_v_out_319311.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_40 = math.max(var_212_31, arg_209_1.talkMaxDuration)

			if var_212_30 <= arg_209_1.time_ and arg_209_1.time_ < var_212_30 + var_212_40 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_30) / var_212_40

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_30 + var_212_40 and arg_209_1.time_ < var_212_30 + var_212_40 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_209_1:InitPlayNodeList()
	end,
	Play319311052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319311052
		arg_213_1.duration_ = 5.5

		local var_213_0 = {
			zh = 5.1,
			ja = 5.5
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
				arg_213_0:Play319311053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1095ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1095ui_story == nil then
				arg_213_1.var_.characterEffect1095ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1095ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1095ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1095ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1095ui_story.fillRatio = var_216_5
			end

			local var_216_6 = 0
			local var_216_7 = 0.675

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_8 = arg_213_1:FormatText(StoryNameCfg[694].name)

				arg_213_1.leftNameTxt_.text = var_216_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_9 = arg_213_1:GetWordFromCfg(319311052)
				local var_216_10 = arg_213_1:FormatText(var_216_9.content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 27
				local var_216_12 = utf8.len(var_216_10)
				local var_216_13 = var_216_11 <= 0 and var_216_7 or var_216_7 * (var_216_12 / var_216_11)

				if var_216_13 > 0 and var_216_7 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_10
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311052", "story_v_out_319311.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_319311", "319311052", "story_v_out_319311.awb") / 1000

					if var_216_14 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_6
					end

					if var_216_9.prefab_name ~= "" and arg_213_1.actors_[var_216_9.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_9.prefab_name].transform, "story_v_out_319311", "319311052", "story_v_out_319311.awb")

						arg_213_1:RecordAudio("319311052", var_216_15)
						arg_213_1:RecordAudio("319311052", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_319311", "319311052", "story_v_out_319311.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_319311", "319311052", "story_v_out_319311.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_16 and arg_213_1.time_ < var_216_6 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play319311053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319311053
		arg_217_1.duration_ = 7.07

		local var_217_0 = {
			zh = 6.466,
			ja = 7.066
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
				arg_217_0:Play319311054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1095ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1095ui_story == nil then
				arg_217_1.var_.characterEffect1095ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1095ui_story and not isNil(var_220_0) then
					arg_217_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1095ui_story then
				arg_217_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_220_4 = 0
			local var_220_5 = 0.675

			if var_220_4 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_6 = arg_217_1:FormatText(StoryNameCfg[471].name)

				arg_217_1.leftNameTxt_.text = var_220_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(319311053)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311053", "story_v_out_319311.awb") ~= 0 then
					local var_220_12 = manager.audio:GetVoiceLength("story_v_out_319311", "319311053", "story_v_out_319311.awb") / 1000

					if var_220_12 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_4
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_319311", "319311053", "story_v_out_319311.awb")

						arg_217_1:RecordAudio("319311053", var_220_13)
						arg_217_1:RecordAudio("319311053", var_220_13)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_319311", "319311053", "story_v_out_319311.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_319311", "319311053", "story_v_out_319311.awb")
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
	Play319311054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319311054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play319311055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1095ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1095ui_story == nil then
				arg_221_1.var_.characterEffect1095ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1095ui_story and not isNil(var_224_0) then
					local var_224_4 = Mathf.Lerp(0, 0.5, var_224_3)

					arg_221_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1095ui_story.fillRatio = var_224_4
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1095ui_story then
				local var_224_5 = 0.5

				arg_221_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1095ui_story.fillRatio = var_224_5
			end

			local var_224_6 = 0
			local var_224_7 = 0.875

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_8 = arg_221_1:GetWordFromCfg(319311054)
				local var_224_9 = arg_221_1:FormatText(var_224_8.content)

				arg_221_1.text_.text = var_224_9

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 35
				local var_224_11 = utf8.len(var_224_9)
				local var_224_12 = var_224_10 <= 0 and var_224_7 or var_224_7 * (var_224_11 / var_224_10)

				if var_224_12 > 0 and var_224_7 < var_224_12 then
					arg_221_1.talkMaxDuration = var_224_12

					if var_224_12 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_12 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_9
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_13 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_13 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_13

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_13 and arg_221_1.time_ < var_224_6 + var_224_13 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play319311055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319311055
		arg_225_1.duration_ = 5.9

		local var_225_0 = {
			zh = 2.866,
			ja = 5.9
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play319311056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1095ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1095ui_story == nil then
				arg_225_1.var_.characterEffect1095ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1095ui_story and not isNil(var_228_0) then
					arg_225_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1095ui_story then
				arg_225_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_228_4 = 0

			if var_228_4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_228_5 = 0
			local var_228_6 = 0.275

			if var_228_5 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_7 = arg_225_1:FormatText(StoryNameCfg[471].name)

				arg_225_1.leftNameTxt_.text = var_228_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(319311055)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 11
				local var_228_11 = utf8.len(var_228_9)
				local var_228_12 = var_228_10 <= 0 and var_228_6 or var_228_6 * (var_228_11 / var_228_10)

				if var_228_12 > 0 and var_228_6 < var_228_12 then
					arg_225_1.talkMaxDuration = var_228_12

					if var_228_12 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_5
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311055", "story_v_out_319311.awb") ~= 0 then
					local var_228_13 = manager.audio:GetVoiceLength("story_v_out_319311", "319311055", "story_v_out_319311.awb") / 1000

					if var_228_13 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_5
					end

					if var_228_8.prefab_name ~= "" and arg_225_1.actors_[var_228_8.prefab_name] ~= nil then
						local var_228_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_8.prefab_name].transform, "story_v_out_319311", "319311055", "story_v_out_319311.awb")

						arg_225_1:RecordAudio("319311055", var_228_14)
						arg_225_1:RecordAudio("319311055", var_228_14)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_319311", "319311055", "story_v_out_319311.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_319311", "319311055", "story_v_out_319311.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_15 = math.max(var_228_6, arg_225_1.talkMaxDuration)

			if var_228_5 <= arg_225_1.time_ and arg_225_1.time_ < var_228_5 + var_228_15 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_5) / var_228_15

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_5 + var_228_15 and arg_225_1.time_ < var_228_5 + var_228_15 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play319311056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319311056
		arg_229_1.duration_ = 2.73

		local var_229_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
			arg_229_1.auto_ = false
		end

		function arg_229_1.playNext_(arg_231_0)
			arg_229_1.onStoryFinished_()
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["4040ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos4040ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(0, -1.55, -5.5)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos4040ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = arg_229_1.actors_["4040ui_story"]
			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect4040ui_story == nil then
				arg_229_1.var_.characterEffect4040ui_story = var_232_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_11 = 0.200000002980232

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_11 and not isNil(var_232_9) then
				local var_232_12 = (arg_229_1.time_ - var_232_10) / var_232_11

				if arg_229_1.var_.characterEffect4040ui_story and not isNil(var_232_9) then
					arg_229_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_10 + var_232_11 and arg_229_1.time_ < var_232_10 + var_232_11 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect4040ui_story then
				arg_229_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_232_13 = arg_229_1.actors_["1095ui_story"].transform
			local var_232_14 = 0

			if var_232_14 < arg_229_1.time_ and arg_229_1.time_ <= var_232_14 + arg_232_0 then
				arg_229_1.var_.moveOldPos1095ui_story = var_232_13.localPosition
			end

			local var_232_15 = 0.001

			if var_232_14 <= arg_229_1.time_ and arg_229_1.time_ < var_232_14 + var_232_15 then
				local var_232_16 = (arg_229_1.time_ - var_232_14) / var_232_15
				local var_232_17 = Vector3.New(0, 100, 0)

				var_232_13.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1095ui_story, var_232_17, var_232_16)

				local var_232_18 = manager.ui.mainCamera.transform.position - var_232_13.position

				var_232_13.forward = Vector3.New(var_232_18.x, var_232_18.y, var_232_18.z)

				local var_232_19 = var_232_13.localEulerAngles

				var_232_19.z = 0
				var_232_19.x = 0
				var_232_13.localEulerAngles = var_232_19
			end

			if arg_229_1.time_ >= var_232_14 + var_232_15 and arg_229_1.time_ < var_232_14 + var_232_15 + arg_232_0 then
				var_232_13.localPosition = Vector3.New(0, 100, 0)

				local var_232_20 = manager.ui.mainCamera.transform.position - var_232_13.position

				var_232_13.forward = Vector3.New(var_232_20.x, var_232_20.y, var_232_20.z)

				local var_232_21 = var_232_13.localEulerAngles

				var_232_21.z = 0
				var_232_21.x = 0
				var_232_13.localEulerAngles = var_232_21
			end

			local var_232_22 = arg_229_1.actors_["1095ui_story"]
			local var_232_23 = 0

			if var_232_23 < arg_229_1.time_ and arg_229_1.time_ <= var_232_23 + arg_232_0 and not isNil(var_232_22) and arg_229_1.var_.characterEffect1095ui_story == nil then
				arg_229_1.var_.characterEffect1095ui_story = var_232_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_24 = 0.200000002980232

			if var_232_23 <= arg_229_1.time_ and arg_229_1.time_ < var_232_23 + var_232_24 and not isNil(var_232_22) then
				local var_232_25 = (arg_229_1.time_ - var_232_23) / var_232_24

				if arg_229_1.var_.characterEffect1095ui_story and not isNil(var_232_22) then
					local var_232_26 = Mathf.Lerp(0, 0.5, var_232_25)

					arg_229_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1095ui_story.fillRatio = var_232_26
				end
			end

			if arg_229_1.time_ >= var_232_23 + var_232_24 and arg_229_1.time_ < var_232_23 + var_232_24 + arg_232_0 and not isNil(var_232_22) and arg_229_1.var_.characterEffect1095ui_story then
				local var_232_27 = 0.5

				arg_229_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1095ui_story.fillRatio = var_232_27
			end

			local var_232_28 = arg_229_1.actors_["10079ui_story"].transform
			local var_232_29 = 0

			if var_232_29 < arg_229_1.time_ and arg_229_1.time_ <= var_232_29 + arg_232_0 then
				arg_229_1.var_.moveOldPos10079ui_story = var_232_28.localPosition
			end

			local var_232_30 = 0.001

			if var_232_29 <= arg_229_1.time_ and arg_229_1.time_ < var_232_29 + var_232_30 then
				local var_232_31 = (arg_229_1.time_ - var_232_29) / var_232_30
				local var_232_32 = Vector3.New(0, 100, 0)

				var_232_28.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10079ui_story, var_232_32, var_232_31)

				local var_232_33 = manager.ui.mainCamera.transform.position - var_232_28.position

				var_232_28.forward = Vector3.New(var_232_33.x, var_232_33.y, var_232_33.z)

				local var_232_34 = var_232_28.localEulerAngles

				var_232_34.z = 0
				var_232_34.x = 0
				var_232_28.localEulerAngles = var_232_34
			end

			if arg_229_1.time_ >= var_232_29 + var_232_30 and arg_229_1.time_ < var_232_29 + var_232_30 + arg_232_0 then
				var_232_28.localPosition = Vector3.New(0, 100, 0)

				local var_232_35 = manager.ui.mainCamera.transform.position - var_232_28.position

				var_232_28.forward = Vector3.New(var_232_35.x, var_232_35.y, var_232_35.z)

				local var_232_36 = var_232_28.localEulerAngles

				var_232_36.z = 0
				var_232_36.x = 0
				var_232_28.localEulerAngles = var_232_36
			end

			local var_232_37 = arg_229_1.actors_["10079ui_story"]
			local var_232_38 = 0

			if var_232_38 < arg_229_1.time_ and arg_229_1.time_ <= var_232_38 + arg_232_0 and not isNil(var_232_37) and arg_229_1.var_.characterEffect10079ui_story == nil then
				arg_229_1.var_.characterEffect10079ui_story = var_232_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_39 = 0.200000002980232

			if var_232_38 <= arg_229_1.time_ and arg_229_1.time_ < var_232_38 + var_232_39 and not isNil(var_232_37) then
				local var_232_40 = (arg_229_1.time_ - var_232_38) / var_232_39

				if arg_229_1.var_.characterEffect10079ui_story and not isNil(var_232_37) then
					local var_232_41 = Mathf.Lerp(0, 0.5, var_232_40)

					arg_229_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10079ui_story.fillRatio = var_232_41
				end
			end

			if arg_229_1.time_ >= var_232_38 + var_232_39 and arg_229_1.time_ < var_232_38 + var_232_39 + arg_232_0 and not isNil(var_232_37) and arg_229_1.var_.characterEffect10079ui_story then
				local var_232_42 = 0.5

				arg_229_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10079ui_story.fillRatio = var_232_42
			end

			local var_232_43 = 0

			if var_232_43 < arg_229_1.time_ and arg_229_1.time_ <= var_232_43 + arg_232_0 then
				arg_229_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_232_44 = 0

			if var_232_44 < arg_229_1.time_ and arg_229_1.time_ <= var_232_44 + arg_232_0 then
				arg_229_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_45 = 0
			local var_232_46 = 0.075

			if var_232_45 < arg_229_1.time_ and arg_229_1.time_ <= var_232_45 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_47 = arg_229_1:FormatText(StoryNameCfg[668].name)

				arg_229_1.leftNameTxt_.text = var_232_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_48 = arg_229_1:GetWordFromCfg(319311056)
				local var_232_49 = arg_229_1:FormatText(var_232_48.content)

				arg_229_1.text_.text = var_232_49

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_50 = 3
				local var_232_51 = utf8.len(var_232_49)
				local var_232_52 = var_232_50 <= 0 and var_232_46 or var_232_46 * (var_232_51 / var_232_50)

				if var_232_52 > 0 and var_232_46 < var_232_52 then
					arg_229_1.talkMaxDuration = var_232_52

					if var_232_52 + var_232_45 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_52 + var_232_45
					end
				end

				arg_229_1.text_.text = var_232_49
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319311", "319311056", "story_v_out_319311.awb") ~= 0 then
					local var_232_53 = manager.audio:GetVoiceLength("story_v_out_319311", "319311056", "story_v_out_319311.awb") / 1000

					if var_232_53 + var_232_45 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_53 + var_232_45
					end

					if var_232_48.prefab_name ~= "" and arg_229_1.actors_[var_232_48.prefab_name] ~= nil then
						local var_232_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_48.prefab_name].transform, "story_v_out_319311", "319311056", "story_v_out_319311.awb")

						arg_229_1:RecordAudio("319311056", var_232_54)
						arg_229_1:RecordAudio("319311056", var_232_54)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319311", "319311056", "story_v_out_319311.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319311", "319311056", "story_v_out_319311.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_55 = math.max(var_232_46, arg_229_1.talkMaxDuration)

			if var_232_45 <= arg_229_1.time_ and arg_229_1.time_ < var_232_45 + var_232_55 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_45) / var_232_55

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_45 + var_232_55 and arg_229_1.time_ < var_232_45 + var_232_55 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
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

		arg_229_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A08f"
	},
	voices = {
		"story_v_out_319311.awb"
	}
}
