return {
	Play1109503001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109503001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109503002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F02a_1"

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
				local var_4_5 = arg_1_1.bgs_.F02a_1

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
					if iter_4_0 ~= "F02a_1" then
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
			local var_4_23 = 0.7

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

			local var_4_28 = 0.833333333333333
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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

			local var_4_34 = 1.999999999999
			local var_4_35 = 0.875

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

				local var_4_37 = arg_1_1:GetWordFromCfg(1109503001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 35
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
	Play1109503002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109503002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109503003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.675

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

				local var_12_2 = arg_9_1:GetWordFromCfg(1109503002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 27
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
	Play1109503003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109503003
		arg_13_1.duration_ = 7.5

		local var_13_0 = {
			zh = 4.033,
			ja = 7.5
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
				arg_13_0:Play1109503004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10058ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "10058ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["10058ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos10058ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -0.98, -6.1)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10058ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["10058ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10058ui_story == nil then
				arg_13_1.var_.characterEffect10058ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect10058ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect10058ui_story then
				arg_13_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_16_20 = 0
			local var_16_21 = 0.45

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[471].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(1109503003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 18
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503003", "story_v_side_new_1109503.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503003", "story_v_side_new_1109503.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_side_new_1109503", "1109503003", "story_v_side_new_1109503.awb")

						arg_13_1:RecordAudio("1109503003", var_16_29)
						arg_13_1:RecordAudio("1109503003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503003", "story_v_side_new_1109503.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503003", "story_v_side_new_1109503.awb")
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
				actorName = "10058ui_story",
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
	Play1109503004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109503004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1109503005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10058ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10058ui_story == nil then
				arg_17_1.var_.characterEffect10058ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.0166666666666667

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10058ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10058ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10058ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10058ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.275

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_9 = arg_17_1:GetWordFromCfg(1109503004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 11
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_14 and arg_17_1.time_ < var_20_6 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1109503005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109503005
		arg_21_1.duration_ = 3.3

		local var_21_0 = {
			zh = 3.2,
			ja = 3.3
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
				arg_21_0:Play1109503006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10058ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10058ui_story == nil then
				arg_21_1.var_.characterEffect10058ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect10058ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10058ui_story then
				arg_21_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_24_4 = 0

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_24_5 = 0
			local var_24_6 = 0.325

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_7 = arg_21_1:FormatText(StoryNameCfg[471].name)

				arg_21_1.leftNameTxt_.text = var_24_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(1109503005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 13
				local var_24_11 = utf8.len(var_24_9)
				local var_24_12 = var_24_10 <= 0 and var_24_6 or var_24_6 * (var_24_11 / var_24_10)

				if var_24_12 > 0 and var_24_6 < var_24_12 then
					arg_21_1.talkMaxDuration = var_24_12

					if var_24_12 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503005", "story_v_side_new_1109503.awb") ~= 0 then
					local var_24_13 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503005", "story_v_side_new_1109503.awb") / 1000

					if var_24_13 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_5
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_side_new_1109503", "1109503005", "story_v_side_new_1109503.awb")

						arg_21_1:RecordAudio("1109503005", var_24_14)
						arg_21_1:RecordAudio("1109503005", var_24_14)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503005", "story_v_side_new_1109503.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503005", "story_v_side_new_1109503.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_15 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_15 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_15

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_15 and arg_21_1.time_ < var_24_5 + var_24_15 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1109503006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109503006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109503007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10058ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect10058ui_story == nil then
				arg_25_1.var_.characterEffect10058ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect10058ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10058ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect10058ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10058ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.175

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

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(1109503006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 7
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
	Play1109503007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109503007
		arg_29_1.duration_ = 3.67

		local var_29_0 = {
			zh = 2.633,
			ja = 3.666
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
				arg_29_0:Play1109503008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10058ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10058ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, -0.98, -6.1)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10058ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["10058ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10058ui_story == nil then
				arg_29_1.var_.characterEffect10058ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect10058ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10058ui_story then
				arg_29_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_32_13 = 0
			local var_32_14 = 0.2

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_15 = arg_29_1:FormatText(StoryNameCfg[471].name)

				arg_29_1.leftNameTxt_.text = var_32_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_16 = arg_29_1:GetWordFromCfg(1109503007)
				local var_32_17 = arg_29_1:FormatText(var_32_16.content)

				arg_29_1.text_.text = var_32_17

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_18 = 8
				local var_32_19 = utf8.len(var_32_17)
				local var_32_20 = var_32_18 <= 0 and var_32_14 or var_32_14 * (var_32_19 / var_32_18)

				if var_32_20 > 0 and var_32_14 < var_32_20 then
					arg_29_1.talkMaxDuration = var_32_20

					if var_32_20 + var_32_13 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_13
					end
				end

				arg_29_1.text_.text = var_32_17
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503007", "story_v_side_new_1109503.awb") ~= 0 then
					local var_32_21 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503007", "story_v_side_new_1109503.awb") / 1000

					if var_32_21 + var_32_13 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_21 + var_32_13
					end

					if var_32_16.prefab_name ~= "" and arg_29_1.actors_[var_32_16.prefab_name] ~= nil then
						local var_32_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_16.prefab_name].transform, "story_v_side_new_1109503", "1109503007", "story_v_side_new_1109503.awb")

						arg_29_1:RecordAudio("1109503007", var_32_22)
						arg_29_1:RecordAudio("1109503007", var_32_22)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503007", "story_v_side_new_1109503.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503007", "story_v_side_new_1109503.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_23 = math.max(var_32_14, arg_29_1.talkMaxDuration)

			if var_32_13 <= arg_29_1.time_ and arg_29_1.time_ < var_32_13 + var_32_23 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_13) / var_32_23

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_13 + var_32_23 and arg_29_1.time_ < var_32_13 + var_32_23 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109503008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109503008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109503009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10058ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10058ui_story == nil then
				arg_33_1.var_.characterEffect10058ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10058ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10058ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10058ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10058ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.55

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

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(1109503008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 22
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
	Play1109503009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109503009
		arg_37_1.duration_ = 3.63

		local var_37_0 = {
			zh = 3.633,
			ja = 3.6
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
				arg_37_0:Play1109503010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10058ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10058ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -0.98, -6.1)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10058ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["10058ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10058ui_story == nil then
				arg_37_1.var_.characterEffect10058ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect10058ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10058ui_story then
				arg_37_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_40_14 = 0
			local var_40_15 = 0.325

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_16 = arg_37_1:FormatText(StoryNameCfg[471].name)

				arg_37_1.leftNameTxt_.text = var_40_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_17 = arg_37_1:GetWordFromCfg(1109503009)
				local var_40_18 = arg_37_1:FormatText(var_40_17.content)

				arg_37_1.text_.text = var_40_18

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_19 = 13
				local var_40_20 = utf8.len(var_40_18)
				local var_40_21 = var_40_19 <= 0 and var_40_15 or var_40_15 * (var_40_20 / var_40_19)

				if var_40_21 > 0 and var_40_15 < var_40_21 then
					arg_37_1.talkMaxDuration = var_40_21

					if var_40_21 + var_40_14 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_21 + var_40_14
					end
				end

				arg_37_1.text_.text = var_40_18
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503009", "story_v_side_new_1109503.awb") ~= 0 then
					local var_40_22 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503009", "story_v_side_new_1109503.awb") / 1000

					if var_40_22 + var_40_14 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_14
					end

					if var_40_17.prefab_name ~= "" and arg_37_1.actors_[var_40_17.prefab_name] ~= nil then
						local var_40_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_17.prefab_name].transform, "story_v_side_new_1109503", "1109503009", "story_v_side_new_1109503.awb")

						arg_37_1:RecordAudio("1109503009", var_40_23)
						arg_37_1:RecordAudio("1109503009", var_40_23)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503009", "story_v_side_new_1109503.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503009", "story_v_side_new_1109503.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_24 = math.max(var_40_15, arg_37_1.talkMaxDuration)

			if var_40_14 <= arg_37_1.time_ and arg_37_1.time_ < var_40_14 + var_40_24 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_14) / var_40_24

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_14 + var_40_24 and arg_37_1.time_ < var_40_14 + var_40_24 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109503010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109503010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1109503011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10058ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10058ui_story == nil then
				arg_41_1.var_.characterEffect10058ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10058ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10058ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10058ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10058ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.05

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

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(1109503010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 2
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
	Play1109503011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109503011
		arg_45_1.duration_ = 15.27

		local var_45_0 = {
			zh = 10.766,
			ja = 15.266
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
				arg_45_0:Play1109503012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10058ui_story"].transform
			local var_48_1 = 1.466

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10058ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10058ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, 100, 0)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_10 = 1.5

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 then
				local var_48_11 = (arg_45_1.time_ - var_48_9) / var_48_10
				local var_48_12 = Color.New(0, 0, 0)

				var_48_12.a = Mathf.Lerp(0, 1, var_48_11)
				arg_45_1.mask_.color = var_48_12
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 then
				local var_48_13 = Color.New(0, 0, 0)

				var_48_13.a = 1
				arg_45_1.mask_.color = var_48_13
			end

			local var_48_14 = 1.5

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_15 = 1.5

			if var_48_14 <= arg_45_1.time_ and arg_45_1.time_ < var_48_14 + var_48_15 then
				local var_48_16 = (arg_45_1.time_ - var_48_14) / var_48_15
				local var_48_17 = Color.New(0, 0, 0)

				var_48_17.a = Mathf.Lerp(1, 0, var_48_16)
				arg_45_1.mask_.color = var_48_17
			end

			if arg_45_1.time_ >= var_48_14 + var_48_15 and arg_45_1.time_ < var_48_14 + var_48_15 + arg_48_0 then
				local var_48_18 = Color.New(0, 0, 0)
				local var_48_19 = 0

				arg_45_1.mask_.enabled = false
				var_48_18.a = var_48_19
				arg_45_1.mask_.color = var_48_18
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_20 = 3
			local var_48_21 = 1.1

			if var_48_20 < arg_45_1.time_ and arg_45_1.time_ <= var_48_20 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_22 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_22:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_23 = arg_45_1:FormatText(StoryNameCfg[426].name)

				arg_45_1.leftNameTxt_.text = var_48_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_24 = arg_45_1:GetWordFromCfg(1109503011)
				local var_48_25 = arg_45_1:FormatText(var_48_24.content)

				arg_45_1.text_.text = var_48_25

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_26 = 44
				local var_48_27 = utf8.len(var_48_25)
				local var_48_28 = var_48_26 <= 0 and var_48_21 or var_48_21 * (var_48_27 / var_48_26)

				if var_48_28 > 0 and var_48_21 < var_48_28 then
					arg_45_1.talkMaxDuration = var_48_28
					var_48_20 = var_48_20 + 0.3

					if var_48_28 + var_48_20 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_28 + var_48_20
					end
				end

				arg_45_1.text_.text = var_48_25
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503011", "story_v_side_new_1109503.awb") ~= 0 then
					local var_48_29 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503011", "story_v_side_new_1109503.awb") / 1000

					if var_48_29 + var_48_20 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_29 + var_48_20
					end

					if var_48_24.prefab_name ~= "" and arg_45_1.actors_[var_48_24.prefab_name] ~= nil then
						local var_48_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_24.prefab_name].transform, "story_v_side_new_1109503", "1109503011", "story_v_side_new_1109503.awb")

						arg_45_1:RecordAudio("1109503011", var_48_30)
						arg_45_1:RecordAudio("1109503011", var_48_30)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503011", "story_v_side_new_1109503.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503011", "story_v_side_new_1109503.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_31 = var_48_20 + 0.3
			local var_48_32 = math.max(var_48_21, arg_45_1.talkMaxDuration)

			if var_48_31 <= arg_45_1.time_ and arg_45_1.time_ < var_48_31 + var_48_32 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_31) / var_48_32

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_31 + var_48_32 and arg_45_1.time_ < var_48_31 + var_48_32 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.466,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play1109503012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1109503012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1109503013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.65

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(1109503012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 26
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_8 and arg_51_1.time_ < var_54_0 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1109503013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1109503013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1109503014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 1.75

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(1109503013)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 70
				local var_58_5 = utf8.len(var_58_3)
				local var_58_6 = var_58_4 <= 0 and var_58_1 or var_58_1 * (var_58_5 / var_58_4)

				if var_58_6 > 0 and var_58_1 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_7 and arg_55_1.time_ < var_58_0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1109503014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1109503014
		arg_59_1.duration_ = 14.17

		local var_59_0 = {
			zh = 9.666,
			ja = 14.166
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
				arg_59_0:Play1109503015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10058ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect10058ui_story == nil then
				arg_59_1.var_.characterEffect10058ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect10058ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10058ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect10058ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10058ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0
			local var_62_7 = 1.1

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[426].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_9 = arg_59_1:GetWordFromCfg(1109503014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 44
				local var_62_12 = utf8.len(var_62_10)
				local var_62_13 = var_62_11 <= 0 and var_62_7 or var_62_7 * (var_62_12 / var_62_11)

				if var_62_13 > 0 and var_62_7 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503014", "story_v_side_new_1109503.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503014", "story_v_side_new_1109503.awb") / 1000

					if var_62_14 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_6
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_side_new_1109503", "1109503014", "story_v_side_new_1109503.awb")

						arg_59_1:RecordAudio("1109503014", var_62_15)
						arg_59_1:RecordAudio("1109503014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503014", "story_v_side_new_1109503.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503014", "story_v_side_new_1109503.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_16 and arg_59_1.time_ < var_62_6 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1109503015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1109503015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1109503016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.1

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[7].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(1109503015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 4
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_8 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_8 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_8

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_8 and arg_63_1.time_ < var_66_0 + var_66_8 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1109503016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1109503016
		arg_67_1.duration_ = 1.5

		local var_67_0 = {
			zh = 1.266,
			ja = 1.5
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
				arg_67_0:Play1109503017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["10058ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos10058ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, -0.98, -6.1)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10058ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["10058ui_story"]
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect10058ui_story == nil then
				arg_67_1.var_.characterEffect10058ui_story = var_70_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_11 = 0.200000002980232

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 and not isNil(var_70_9) then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11

				if arg_67_1.var_.characterEffect10058ui_story and not isNil(var_70_9) then
					arg_67_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect10058ui_story then
				arg_67_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_70_13 = 0
			local var_70_14 = 0.1

			if var_70_13 < arg_67_1.time_ and arg_67_1.time_ <= var_70_13 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_15 = arg_67_1:FormatText(StoryNameCfg[471].name)

				arg_67_1.leftNameTxt_.text = var_70_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_16 = arg_67_1:GetWordFromCfg(1109503016)
				local var_70_17 = arg_67_1:FormatText(var_70_16.content)

				arg_67_1.text_.text = var_70_17

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_18 = 4
				local var_70_19 = utf8.len(var_70_17)
				local var_70_20 = var_70_18 <= 0 and var_70_14 or var_70_14 * (var_70_19 / var_70_18)

				if var_70_20 > 0 and var_70_14 < var_70_20 then
					arg_67_1.talkMaxDuration = var_70_20

					if var_70_20 + var_70_13 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_20 + var_70_13
					end
				end

				arg_67_1.text_.text = var_70_17
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503016", "story_v_side_new_1109503.awb") ~= 0 then
					local var_70_21 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503016", "story_v_side_new_1109503.awb") / 1000

					if var_70_21 + var_70_13 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_21 + var_70_13
					end

					if var_70_16.prefab_name ~= "" and arg_67_1.actors_[var_70_16.prefab_name] ~= nil then
						local var_70_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_16.prefab_name].transform, "story_v_side_new_1109503", "1109503016", "story_v_side_new_1109503.awb")

						arg_67_1:RecordAudio("1109503016", var_70_22)
						arg_67_1:RecordAudio("1109503016", var_70_22)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503016", "story_v_side_new_1109503.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503016", "story_v_side_new_1109503.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_23 = math.max(var_70_14, arg_67_1.talkMaxDuration)

			if var_70_13 <= arg_67_1.time_ and arg_67_1.time_ < var_70_13 + var_70_23 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_13) / var_70_23

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_13 + var_70_23 and arg_67_1.time_ < var_70_13 + var_70_23 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play1109503017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1109503017
		arg_71_1.duration_ = 1.67

		local var_71_0 = {
			zh = 1.4,
			ja = 1.666
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
				arg_71_0:Play1109503018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10058ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10058ui_story == nil then
				arg_71_1.var_.characterEffect10058ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect10058ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10058ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10058ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10058ui_story.fillRatio = var_74_5
			end

			local var_74_6 = 0
			local var_74_7 = 0.125

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_8 = arg_71_1:FormatText(StoryNameCfg[426].name)

				arg_71_1.leftNameTxt_.text = var_74_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_9 = arg_71_1:GetWordFromCfg(1109503017)
				local var_74_10 = arg_71_1:FormatText(var_74_9.content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 5
				local var_74_12 = utf8.len(var_74_10)
				local var_74_13 = var_74_11 <= 0 and var_74_7 or var_74_7 * (var_74_12 / var_74_11)

				if var_74_13 > 0 and var_74_7 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503017", "story_v_side_new_1109503.awb") ~= 0 then
					local var_74_14 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503017", "story_v_side_new_1109503.awb") / 1000

					if var_74_14 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_6
					end

					if var_74_9.prefab_name ~= "" and arg_71_1.actors_[var_74_9.prefab_name] ~= nil then
						local var_74_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_9.prefab_name].transform, "story_v_side_new_1109503", "1109503017", "story_v_side_new_1109503.awb")

						arg_71_1:RecordAudio("1109503017", var_74_15)
						arg_71_1:RecordAudio("1109503017", var_74_15)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503017", "story_v_side_new_1109503.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503017", "story_v_side_new_1109503.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_16 and arg_71_1.time_ < var_74_6 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play1109503018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1109503018
		arg_75_1.duration_ = 1

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"

			SetActive(arg_75_1.choicesGo_, true)

			for iter_76_0, iter_76_1 in ipairs(arg_75_1.choices_) do
				local var_76_0 = iter_76_0 <= 1

				SetActive(iter_76_1.go, var_76_0)
			end

			arg_75_1.choices_[1].txt.text = arg_75_1:FormatText(StoryChoiceCfg[733].name)
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1109503019(arg_75_1)
			end

			arg_75_1:RecordChoiceLog(1109503018, 733)
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			return
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1109503019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1109503019
		arg_79_1.duration_ = 2.57

		local var_79_0 = {
			zh = 2.066,
			ja = 2.566
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
				arg_79_0:Play1109503020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10058ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10058ui_story == nil then
				arg_79_1.var_.characterEffect10058ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect10058ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10058ui_story then
				arg_79_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_82_4 = 0

			if var_82_4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_82_5 = 0
			local var_82_6 = 0.225

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_7 = arg_79_1:FormatText(StoryNameCfg[471].name)

				arg_79_1.leftNameTxt_.text = var_82_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:GetWordFromCfg(1109503019)
				local var_82_9 = arg_79_1:FormatText(var_82_8.content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 9
				local var_82_11 = utf8.len(var_82_9)
				local var_82_12 = var_82_10 <= 0 and var_82_6 or var_82_6 * (var_82_11 / var_82_10)

				if var_82_12 > 0 and var_82_6 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503019", "story_v_side_new_1109503.awb") ~= 0 then
					local var_82_13 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503019", "story_v_side_new_1109503.awb") / 1000

					if var_82_13 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_5
					end

					if var_82_8.prefab_name ~= "" and arg_79_1.actors_[var_82_8.prefab_name] ~= nil then
						local var_82_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_8.prefab_name].transform, "story_v_side_new_1109503", "1109503019", "story_v_side_new_1109503.awb")

						arg_79_1:RecordAudio("1109503019", var_82_14)
						arg_79_1:RecordAudio("1109503019", var_82_14)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503019", "story_v_side_new_1109503.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503019", "story_v_side_new_1109503.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_15 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_15 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_15

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_15 and arg_79_1.time_ < var_82_5 + var_82_15 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1109503020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1109503020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1109503021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10058ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos10058ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10058ui_story, var_86_4, var_86_3)

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

			local var_86_9 = 0
			local var_86_10 = 0.65

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_11 = arg_83_1:GetWordFromCfg(1109503020)
				local var_86_12 = arg_83_1:FormatText(var_86_11.content)

				arg_83_1.text_.text = var_86_12

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 26
				local var_86_14 = utf8.len(var_86_12)
				local var_86_15 = var_86_13 <= 0 and var_86_10 or var_86_10 * (var_86_14 / var_86_13)

				if var_86_15 > 0 and var_86_10 < var_86_15 then
					arg_83_1.talkMaxDuration = var_86_15

					if var_86_15 + var_86_9 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_15 + var_86_9
					end
				end

				arg_83_1.text_.text = var_86_12
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_10, arg_83_1.talkMaxDuration)

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_9) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_9 + var_86_16 and arg_83_1.time_ < var_86_9 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play1109503021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1109503021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1109503022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.2

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[7].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(1109503021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 8
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
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_8 and arg_87_1.time_ < var_90_0 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1109503022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1109503022
		arg_91_1.duration_ = 4.73

		local var_91_0 = {
			zh = 2.6,
			ja = 4.733
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
				arg_91_0:Play1109503023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10058ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos10058ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, -0.98, -6.1)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10058ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["10058ui_story"]
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect10058ui_story == nil then
				arg_91_1.var_.characterEffect10058ui_story = var_94_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 and not isNil(var_94_9) then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11

				if arg_91_1.var_.characterEffect10058ui_story and not isNil(var_94_9) then
					arg_91_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect10058ui_story then
				arg_91_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_94_13 = 0

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action424")
			end

			local var_94_14 = 0

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_94_15 = 0
			local var_94_16 = 0.275

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_17 = arg_91_1:FormatText(StoryNameCfg[471].name)

				arg_91_1.leftNameTxt_.text = var_94_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_18 = arg_91_1:GetWordFromCfg(1109503022)
				local var_94_19 = arg_91_1:FormatText(var_94_18.content)

				arg_91_1.text_.text = var_94_19

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_20 = 11
				local var_94_21 = utf8.len(var_94_19)
				local var_94_22 = var_94_20 <= 0 and var_94_16 or var_94_16 * (var_94_21 / var_94_20)

				if var_94_22 > 0 and var_94_16 < var_94_22 then
					arg_91_1.talkMaxDuration = var_94_22

					if var_94_22 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_22 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_19
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503022", "story_v_side_new_1109503.awb") ~= 0 then
					local var_94_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503022", "story_v_side_new_1109503.awb") / 1000

					if var_94_23 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_15
					end

					if var_94_18.prefab_name ~= "" and arg_91_1.actors_[var_94_18.prefab_name] ~= nil then
						local var_94_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_18.prefab_name].transform, "story_v_side_new_1109503", "1109503022", "story_v_side_new_1109503.awb")

						arg_91_1:RecordAudio("1109503022", var_94_24)
						arg_91_1:RecordAudio("1109503022", var_94_24)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503022", "story_v_side_new_1109503.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503022", "story_v_side_new_1109503.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_25 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_25 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_15) / var_94_25

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_15 + var_94_25 and arg_91_1.time_ < var_94_15 + var_94_25 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play1109503023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1109503023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1109503024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10058ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10058ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0, 100, 0)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10058ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, 100, 0)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = 0
			local var_98_10 = 0.75

			if var_98_9 < arg_95_1.time_ and arg_95_1.time_ <= var_98_9 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_11 = arg_95_1:GetWordFromCfg(1109503023)
				local var_98_12 = arg_95_1:FormatText(var_98_11.content)

				arg_95_1.text_.text = var_98_12

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 30
				local var_98_14 = utf8.len(var_98_12)
				local var_98_15 = var_98_13 <= 0 and var_98_10 or var_98_10 * (var_98_14 / var_98_13)

				if var_98_15 > 0 and var_98_10 < var_98_15 then
					arg_95_1.talkMaxDuration = var_98_15

					if var_98_15 + var_98_9 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_15 + var_98_9
					end
				end

				arg_95_1.text_.text = var_98_12
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_10, arg_95_1.talkMaxDuration)

			if var_98_9 <= arg_95_1.time_ and arg_95_1.time_ < var_98_9 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_9) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_9 + var_98_16 and arg_95_1.time_ < var_98_9 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play1109503024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1109503024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1109503025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.675

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[7].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(1109503024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 27
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_8 and arg_99_1.time_ < var_102_0 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1109503025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1109503025
		arg_103_1.duration_ = 5.63

		local var_103_0 = {
			zh = 5.066,
			ja = 5.633
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
				arg_103_0:Play1109503026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10058ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10058ui_story == nil then
				arg_103_1.var_.characterEffect10058ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect10058ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10058ui_story then
				arg_103_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_106_4 = arg_103_1.actors_["10058ui_story"].transform
			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.var_.moveOldPos10058ui_story = var_106_4.localPosition
			end

			local var_106_6 = 0.001

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 then
				local var_106_7 = (arg_103_1.time_ - var_106_5) / var_106_6
				local var_106_8 = Vector3.New(0, -0.98, -6.1)

				var_106_4.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10058ui_story, var_106_8, var_106_7)

				local var_106_9 = manager.ui.mainCamera.transform.position - var_106_4.position

				var_106_4.forward = Vector3.New(var_106_9.x, var_106_9.y, var_106_9.z)

				local var_106_10 = var_106_4.localEulerAngles

				var_106_10.z = 0
				var_106_10.x = 0
				var_106_4.localEulerAngles = var_106_10
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 then
				var_106_4.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_106_11 = manager.ui.mainCamera.transform.position - var_106_4.position

				var_106_4.forward = Vector3.New(var_106_11.x, var_106_11.y, var_106_11.z)

				local var_106_12 = var_106_4.localEulerAngles

				var_106_12.z = 0
				var_106_12.x = 0
				var_106_4.localEulerAngles = var_106_12
			end

			local var_106_13 = 0

			if var_106_13 < arg_103_1.time_ and arg_103_1.time_ <= var_106_13 + arg_106_0 then
				arg_103_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_106_14 = 0

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_106_15 = 0
			local var_106_16 = 0.725

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[471].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(1109503025)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 29
				local var_106_21 = utf8.len(var_106_19)
				local var_106_22 = var_106_20 <= 0 and var_106_16 or var_106_16 * (var_106_21 / var_106_20)

				if var_106_22 > 0 and var_106_16 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_19
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503025", "story_v_side_new_1109503.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503025", "story_v_side_new_1109503.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_side_new_1109503", "1109503025", "story_v_side_new_1109503.awb")

						arg_103_1:RecordAudio("1109503025", var_106_24)
						arg_103_1:RecordAudio("1109503025", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503025", "story_v_side_new_1109503.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503025", "story_v_side_new_1109503.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_25 and arg_103_1.time_ < var_106_15 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play1109503026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1109503026
		arg_107_1.duration_ = 7.2

		local var_107_0 = {
			zh = 5.033,
			ja = 7.2
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
				arg_107_0:Play1109503027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10058ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10058ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(0, 100, 0)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10058ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, 100, 0)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = 0
			local var_110_10 = 0.65

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_11 = arg_107_1:FormatText(StoryNameCfg[426].name)

				arg_107_1.leftNameTxt_.text = var_110_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_12 = arg_107_1:GetWordFromCfg(1109503026)
				local var_110_13 = arg_107_1:FormatText(var_110_12.content)

				arg_107_1.text_.text = var_110_13

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_14 = 26
				local var_110_15 = utf8.len(var_110_13)
				local var_110_16 = var_110_14 <= 0 and var_110_10 or var_110_10 * (var_110_15 / var_110_14)

				if var_110_16 > 0 and var_110_10 < var_110_16 then
					arg_107_1.talkMaxDuration = var_110_16

					if var_110_16 + var_110_9 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_16 + var_110_9
					end
				end

				arg_107_1.text_.text = var_110_13
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503026", "story_v_side_new_1109503.awb") ~= 0 then
					local var_110_17 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503026", "story_v_side_new_1109503.awb") / 1000

					if var_110_17 + var_110_9 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_9
					end

					if var_110_12.prefab_name ~= "" and arg_107_1.actors_[var_110_12.prefab_name] ~= nil then
						local var_110_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_12.prefab_name].transform, "story_v_side_new_1109503", "1109503026", "story_v_side_new_1109503.awb")

						arg_107_1:RecordAudio("1109503026", var_110_18)
						arg_107_1:RecordAudio("1109503026", var_110_18)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503026", "story_v_side_new_1109503.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503026", "story_v_side_new_1109503.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_19 = math.max(var_110_10, arg_107_1.talkMaxDuration)

			if var_110_9 <= arg_107_1.time_ and arg_107_1.time_ < var_110_9 + var_110_19 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_9) / var_110_19

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_9 + var_110_19 and arg_107_1.time_ < var_110_9 + var_110_19 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play1109503027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1109503027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1109503028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.4

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[7].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(1109503027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 16
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_8 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_8 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_8

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_8 and arg_111_1.time_ < var_114_0 + var_114_8 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1109503028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1109503028
		arg_115_1.duration_ = 8.17

		local var_115_0 = {
			zh = 3.066,
			ja = 8.166
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
				arg_115_0:Play1109503029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10058ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos10058ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0, -0.98, -6.1)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10058ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["10058ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect10058ui_story == nil then
				arg_115_1.var_.characterEffect10058ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect10058ui_story and not isNil(var_118_9) then
					arg_115_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect10058ui_story then
				arg_115_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_118_13 = 0
			local var_118_14 = 0.425

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_15 = arg_115_1:FormatText(StoryNameCfg[471].name)

				arg_115_1.leftNameTxt_.text = var_118_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_16 = arg_115_1:GetWordFromCfg(1109503028)
				local var_118_17 = arg_115_1:FormatText(var_118_16.content)

				arg_115_1.text_.text = var_118_17

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_18 = 17
				local var_118_19 = utf8.len(var_118_17)
				local var_118_20 = var_118_18 <= 0 and var_118_14 or var_118_14 * (var_118_19 / var_118_18)

				if var_118_20 > 0 and var_118_14 < var_118_20 then
					arg_115_1.talkMaxDuration = var_118_20

					if var_118_20 + var_118_13 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_13
					end
				end

				arg_115_1.text_.text = var_118_17
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503028", "story_v_side_new_1109503.awb") ~= 0 then
					local var_118_21 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503028", "story_v_side_new_1109503.awb") / 1000

					if var_118_21 + var_118_13 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_21 + var_118_13
					end

					if var_118_16.prefab_name ~= "" and arg_115_1.actors_[var_118_16.prefab_name] ~= nil then
						local var_118_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_16.prefab_name].transform, "story_v_side_new_1109503", "1109503028", "story_v_side_new_1109503.awb")

						arg_115_1:RecordAudio("1109503028", var_118_22)
						arg_115_1:RecordAudio("1109503028", var_118_22)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503028", "story_v_side_new_1109503.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503028", "story_v_side_new_1109503.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_23 = math.max(var_118_14, arg_115_1.talkMaxDuration)

			if var_118_13 <= arg_115_1.time_ and arg_115_1.time_ < var_118_13 + var_118_23 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_13) / var_118_23

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_13 + var_118_23 and arg_115_1.time_ < var_118_13 + var_118_23 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109503029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1109503029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1109503030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10058ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10058ui_story == nil then
				arg_119_1.var_.characterEffect10058ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect10058ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10058ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect10058ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10058ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 0.875

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_8 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_9 = arg_119_1:GetWordFromCfg(1109503029)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 35
				local var_122_12 = utf8.len(var_122_10)
				local var_122_13 = var_122_11 <= 0 and var_122_7 or var_122_7 * (var_122_12 / var_122_11)

				if var_122_13 > 0 and var_122_7 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_10
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1109503030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1109503030
		arg_123_1.duration_ = 3.77

		local var_123_0 = {
			zh = 2.833,
			ja = 3.766
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
				arg_123_0:Play1109503031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10058ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10058ui_story == nil then
				arg_123_1.var_.characterEffect10058ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect10058ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10058ui_story then
				arg_123_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_126_4 = 0
			local var_126_5 = 0.25

			if var_126_4 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_6 = arg_123_1:FormatText(StoryNameCfg[471].name)

				arg_123_1.leftNameTxt_.text = var_126_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_7 = arg_123_1:GetWordFromCfg(1109503030)
				local var_126_8 = arg_123_1:FormatText(var_126_7.content)

				arg_123_1.text_.text = var_126_8

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 10
				local var_126_10 = utf8.len(var_126_8)
				local var_126_11 = var_126_9 <= 0 and var_126_5 or var_126_5 * (var_126_10 / var_126_9)

				if var_126_11 > 0 and var_126_5 < var_126_11 then
					arg_123_1.talkMaxDuration = var_126_11

					if var_126_11 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_8
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503030", "story_v_side_new_1109503.awb") ~= 0 then
					local var_126_12 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503030", "story_v_side_new_1109503.awb") / 1000

					if var_126_12 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_4
					end

					if var_126_7.prefab_name ~= "" and arg_123_1.actors_[var_126_7.prefab_name] ~= nil then
						local var_126_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_7.prefab_name].transform, "story_v_side_new_1109503", "1109503030", "story_v_side_new_1109503.awb")

						arg_123_1:RecordAudio("1109503030", var_126_13)
						arg_123_1:RecordAudio("1109503030", var_126_13)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503030", "story_v_side_new_1109503.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503030", "story_v_side_new_1109503.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_14 and arg_123_1.time_ < var_126_4 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1109503031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1109503031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1109503032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10058ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10058ui_story == nil then
				arg_127_1.var_.characterEffect10058ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect10058ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10058ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10058ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10058ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0
			local var_130_7 = 0.575

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_8 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_9 = arg_127_1:GetWordFromCfg(1109503031)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 23
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
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1109503032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1109503032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1109503033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1.05

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(1109503032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 41
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
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1109503033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1109503033
		arg_135_1.duration_ = 7.43

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1109503034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = "STblack"

			if arg_135_1.bgs_[var_138_0] == nil then
				local var_138_1 = Object.Instantiate(arg_135_1.paintGo_)

				var_138_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_138_0)
				var_138_1.name = var_138_0
				var_138_1.transform.parent = arg_135_1.stage_.transform
				var_138_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.bgs_[var_138_0] = var_138_1
			end

			local var_138_2 = 1.83333333333333

			if var_138_2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				local var_138_3 = manager.ui.mainCamera.transform.localPosition
				local var_138_4 = Vector3.New(0, 0, 10) + Vector3.New(var_138_3.x, var_138_3.y, 0)
				local var_138_5 = arg_135_1.bgs_.STblack

				var_138_5.transform.localPosition = var_138_4
				var_138_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_6 = var_138_5:GetComponent("SpriteRenderer")

				if var_138_6 and var_138_6.sprite then
					local var_138_7 = (var_138_5.transform.localPosition - var_138_3).z
					local var_138_8 = manager.ui.mainCameraCom_
					local var_138_9 = 2 * var_138_7 * Mathf.Tan(var_138_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_138_10 = var_138_9 * var_138_8.aspect
					local var_138_11 = var_138_6.sprite.bounds.size.x
					local var_138_12 = var_138_6.sprite.bounds.size.y
					local var_138_13 = var_138_10 / var_138_11
					local var_138_14 = var_138_9 / var_138_12
					local var_138_15 = var_138_14 < var_138_13 and var_138_13 or var_138_14

					var_138_5.transform.localScale = Vector3.New(var_138_15, var_138_15, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "STblack" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_16 = 2.43333333333333

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			local var_138_17 = 0.3

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_18 = 0

			if var_138_18 < arg_135_1.time_ and arg_135_1.time_ <= var_138_18 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_19 = 1.83333333333333

			if var_138_18 <= arg_135_1.time_ and arg_135_1.time_ < var_138_18 + var_138_19 then
				local var_138_20 = (arg_135_1.time_ - var_138_18) / var_138_19
				local var_138_21 = Color.New(0, 0, 0)

				var_138_21.a = Mathf.Lerp(0, 1, var_138_20)
				arg_135_1.mask_.color = var_138_21
			end

			if arg_135_1.time_ >= var_138_18 + var_138_19 and arg_135_1.time_ < var_138_18 + var_138_19 + arg_138_0 then
				local var_138_22 = Color.New(0, 0, 0)

				var_138_22.a = 1
				arg_135_1.mask_.color = var_138_22
			end

			local var_138_23 = 1.83333333333333

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_24 = 1.96666666666667

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_24 then
				local var_138_25 = (arg_135_1.time_ - var_138_23) / var_138_24
				local var_138_26 = Color.New(0, 0, 0)

				var_138_26.a = Mathf.Lerp(1, 0, var_138_25)
				arg_135_1.mask_.color = var_138_26
			end

			if arg_135_1.time_ >= var_138_23 + var_138_24 and arg_135_1.time_ < var_138_23 + var_138_24 + arg_138_0 then
				local var_138_27 = Color.New(0, 0, 0)
				local var_138_28 = 0

				arg_135_1.mask_.enabled = false
				var_138_27.a = var_138_28
				arg_135_1.mask_.color = var_138_27
			end

			local var_138_29 = arg_135_1.actors_["10058ui_story"].transform
			local var_138_30 = 1.96599999815226

			if var_138_30 < arg_135_1.time_ and arg_135_1.time_ <= var_138_30 + arg_138_0 then
				arg_135_1.var_.moveOldPos10058ui_story = var_138_29.localPosition
			end

			local var_138_31 = 0.001

			if var_138_30 <= arg_135_1.time_ and arg_135_1.time_ < var_138_30 + var_138_31 then
				local var_138_32 = (arg_135_1.time_ - var_138_30) / var_138_31
				local var_138_33 = Vector3.New(0, 100, 0)

				var_138_29.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10058ui_story, var_138_33, var_138_32)

				local var_138_34 = manager.ui.mainCamera.transform.position - var_138_29.position

				var_138_29.forward = Vector3.New(var_138_34.x, var_138_34.y, var_138_34.z)

				local var_138_35 = var_138_29.localEulerAngles

				var_138_35.z = 0
				var_138_35.x = 0
				var_138_29.localEulerAngles = var_138_35
			end

			if arg_135_1.time_ >= var_138_30 + var_138_31 and arg_135_1.time_ < var_138_30 + var_138_31 + arg_138_0 then
				var_138_29.localPosition = Vector3.New(0, 100, 0)

				local var_138_36 = manager.ui.mainCamera.transform.position - var_138_29.position

				var_138_29.forward = Vector3.New(var_138_36.x, var_138_36.y, var_138_36.z)

				local var_138_37 = var_138_29.localEulerAngles

				var_138_37.z = 0
				var_138_37.x = 0
				var_138_29.localEulerAngles = var_138_37
			end

			local var_138_38 = arg_135_1.actors_["10058ui_story"]
			local var_138_39 = 1.96599999815226

			if var_138_39 < arg_135_1.time_ and arg_135_1.time_ <= var_138_39 + arg_138_0 and not isNil(var_138_38) and arg_135_1.var_.characterEffect10058ui_story == nil then
				arg_135_1.var_.characterEffect10058ui_story = var_138_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_40 = 0.034000001847744

			if var_138_39 <= arg_135_1.time_ and arg_135_1.time_ < var_138_39 + var_138_40 and not isNil(var_138_38) then
				local var_138_41 = (arg_135_1.time_ - var_138_39) / var_138_40

				if arg_135_1.var_.characterEffect10058ui_story and not isNil(var_138_38) then
					local var_138_42 = Mathf.Lerp(0, 0.5, var_138_41)

					arg_135_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10058ui_story.fillRatio = var_138_42
				end
			end

			if arg_135_1.time_ >= var_138_39 + var_138_40 and arg_135_1.time_ < var_138_39 + var_138_40 + arg_138_0 and not isNil(var_138_38) and arg_135_1.var_.characterEffect10058ui_story then
				local var_138_43 = 0.5

				arg_135_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10058ui_story.fillRatio = var_138_43
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_44 = 2.43333333333333
			local var_138_45 = 0.6

			if var_138_44 < arg_135_1.time_ and arg_135_1.time_ <= var_138_44 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_46 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_46:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_47 = arg_135_1:GetWordFromCfg(1109503033)
				local var_138_48 = arg_135_1:FormatText(var_138_47.content)

				arg_135_1.text_.text = var_138_48

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_49 = 24
				local var_138_50 = utf8.len(var_138_48)
				local var_138_51 = var_138_49 <= 0 and var_138_45 or var_138_45 * (var_138_50 / var_138_49)

				if var_138_51 > 0 and var_138_45 < var_138_51 then
					arg_135_1.talkMaxDuration = var_138_51
					var_138_44 = var_138_44 + 0.3

					if var_138_51 + var_138_44 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_51 + var_138_44
					end
				end

				arg_135_1.text_.text = var_138_48
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_52 = var_138_44 + 0.3
			local var_138_53 = math.max(var_138_45, arg_135_1.talkMaxDuration)

			if var_138_52 <= arg_135_1.time_ and arg_135_1.time_ < var_138_52 + var_138_53 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_52) / var_138_53

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_52 + var_138_53 and arg_135_1.time_ < var_138_52 + var_138_53 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play1109503034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1109503034
		arg_141_1.duration_ = 7

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1109503035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				local var_144_1 = manager.ui.mainCamera.transform.localPosition
				local var_144_2 = Vector3.New(0, 0, 10) + Vector3.New(var_144_1.x, var_144_1.y, 0)
				local var_144_3 = arg_141_1.bgs_.F02a_1

				var_144_3.transform.localPosition = var_144_2
				var_144_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_4 = var_144_3:GetComponent("SpriteRenderer")

				if var_144_4 and var_144_4.sprite then
					local var_144_5 = (var_144_3.transform.localPosition - var_144_1).z
					local var_144_6 = manager.ui.mainCameraCom_
					local var_144_7 = 2 * var_144_5 * Mathf.Tan(var_144_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_144_8 = var_144_7 * var_144_6.aspect
					local var_144_9 = var_144_4.sprite.bounds.size.x
					local var_144_10 = var_144_4.sprite.bounds.size.y
					local var_144_11 = var_144_8 / var_144_9
					local var_144_12 = var_144_7 / var_144_10
					local var_144_13 = var_144_12 < var_144_11 and var_144_11 or var_144_12

					var_144_3.transform.localScale = Vector3.New(var_144_13, var_144_13, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "F02a_1" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_15 = 2

			if var_144_14 <= arg_141_1.time_ and arg_141_1.time_ < var_144_14 + var_144_15 then
				local var_144_16 = (arg_141_1.time_ - var_144_14) / var_144_15
				local var_144_17 = Color.New(0, 0, 0)

				var_144_17.a = Mathf.Lerp(1, 0, var_144_16)
				arg_141_1.mask_.color = var_144_17
			end

			if arg_141_1.time_ >= var_144_14 + var_144_15 and arg_141_1.time_ < var_144_14 + var_144_15 + arg_144_0 then
				local var_144_18 = Color.New(0, 0, 0)
				local var_144_19 = 0

				arg_141_1.mask_.enabled = false
				var_144_18.a = var_144_19
				arg_141_1.mask_.color = var_144_18
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_20 = 2
			local var_144_21 = 0.275

			if var_144_20 < arg_141_1.time_ and arg_141_1.time_ <= var_144_20 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_22 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_22:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_23 = arg_141_1:FormatText(StoryNameCfg[7].name)

				arg_141_1.leftNameTxt_.text = var_144_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_24 = arg_141_1:GetWordFromCfg(1109503034)
				local var_144_25 = arg_141_1:FormatText(var_144_24.content)

				arg_141_1.text_.text = var_144_25

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_26 = 11
				local var_144_27 = utf8.len(var_144_25)
				local var_144_28 = var_144_26 <= 0 and var_144_21 or var_144_21 * (var_144_27 / var_144_26)

				if var_144_28 > 0 and var_144_21 < var_144_28 then
					arg_141_1.talkMaxDuration = var_144_28
					var_144_20 = var_144_20 + 0.3

					if var_144_28 + var_144_20 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_28 + var_144_20
					end
				end

				arg_141_1.text_.text = var_144_25
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_29 = var_144_20 + 0.3
			local var_144_30 = math.max(var_144_21, arg_141_1.talkMaxDuration)

			if var_144_29 <= arg_141_1.time_ and arg_141_1.time_ < var_144_29 + var_144_30 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_29) / var_144_30

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_29 + var_144_30 and arg_141_1.time_ < var_144_29 + var_144_30 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1109503035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1109503035
		arg_147_1.duration_ = 4.43

		local var_147_0 = {
			zh = 2.533,
			ja = 4.433
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
				arg_147_0:Play1109503036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10058ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10058ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, -0.98, -6.1)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10058ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["10058ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect10058ui_story == nil then
				arg_147_1.var_.characterEffect10058ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect10058ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect10058ui_story then
				arg_147_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_150_15 = 0
			local var_150_16 = 0.225

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[471].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(1109503035)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 9
				local var_150_21 = utf8.len(var_150_19)
				local var_150_22 = var_150_20 <= 0 and var_150_16 or var_150_16 * (var_150_21 / var_150_20)

				if var_150_22 > 0 and var_150_16 < var_150_22 then
					arg_147_1.talkMaxDuration = var_150_22

					if var_150_22 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_22 + var_150_15
					end
				end

				arg_147_1.text_.text = var_150_19
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503035", "story_v_side_new_1109503.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503035", "story_v_side_new_1109503.awb") / 1000

					if var_150_23 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_15
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_side_new_1109503", "1109503035", "story_v_side_new_1109503.awb")

						arg_147_1:RecordAudio("1109503035", var_150_24)
						arg_147_1:RecordAudio("1109503035", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503035", "story_v_side_new_1109503.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503035", "story_v_side_new_1109503.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_25 = math.max(var_150_16, arg_147_1.talkMaxDuration)

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_25 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_15) / var_150_25

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_15 + var_150_25 and arg_147_1.time_ < var_150_15 + var_150_25 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109503036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109503036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1109503037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10058ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10058ui_story == nil then
				arg_151_1.var_.characterEffect10058ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10058ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10058ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10058ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10058ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.4

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

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(1109503036)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 16
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
	Play1109503037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109503037
		arg_155_1.duration_ = 8.6

		local var_155_0 = {
			zh = 3.9,
			ja = 8.6
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
				arg_155_0:Play1109503038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10058ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10058ui_story == nil then
				arg_155_1.var_.characterEffect10058ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect10058ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10058ui_story then
				arg_155_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_158_4 = arg_155_1.actors_["10058ui_story"].transform
			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.var_.moveOldPos10058ui_story = var_158_4.localPosition
			end

			local var_158_6 = 0.001

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_6 then
				local var_158_7 = (arg_155_1.time_ - var_158_5) / var_158_6
				local var_158_8 = Vector3.New(0, -0.98, -6.1)

				var_158_4.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10058ui_story, var_158_8, var_158_7)

				local var_158_9 = manager.ui.mainCamera.transform.position - var_158_4.position

				var_158_4.forward = Vector3.New(var_158_9.x, var_158_9.y, var_158_9.z)

				local var_158_10 = var_158_4.localEulerAngles

				var_158_10.z = 0
				var_158_10.x = 0
				var_158_4.localEulerAngles = var_158_10
			end

			if arg_155_1.time_ >= var_158_5 + var_158_6 and arg_155_1.time_ < var_158_5 + var_158_6 + arg_158_0 then
				var_158_4.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_158_11 = manager.ui.mainCamera.transform.position - var_158_4.position

				var_158_4.forward = Vector3.New(var_158_11.x, var_158_11.y, var_158_11.z)

				local var_158_12 = var_158_4.localEulerAngles

				var_158_12.z = 0
				var_158_12.x = 0
				var_158_4.localEulerAngles = var_158_12
			end

			local var_158_13 = 0

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				arg_155_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_158_14 = 0

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				arg_155_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_158_15 = 0
			local var_158_16 = 0.475

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_17 = arg_155_1:FormatText(StoryNameCfg[471].name)

				arg_155_1.leftNameTxt_.text = var_158_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_18 = arg_155_1:GetWordFromCfg(1109503037)
				local var_158_19 = arg_155_1:FormatText(var_158_18.content)

				arg_155_1.text_.text = var_158_19

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503037", "story_v_side_new_1109503.awb") ~= 0 then
					local var_158_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503037", "story_v_side_new_1109503.awb") / 1000

					if var_158_23 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_15
					end

					if var_158_18.prefab_name ~= "" and arg_155_1.actors_[var_158_18.prefab_name] ~= nil then
						local var_158_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_18.prefab_name].transform, "story_v_side_new_1109503", "1109503037", "story_v_side_new_1109503.awb")

						arg_155_1:RecordAudio("1109503037", var_158_24)
						arg_155_1:RecordAudio("1109503037", var_158_24)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503037", "story_v_side_new_1109503.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503037", "story_v_side_new_1109503.awb")
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
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play1109503038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109503038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109503039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10058ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10058ui_story == nil then
				arg_159_1.var_.characterEffect10058ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect10058ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10058ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10058ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10058ui_story.fillRatio = var_162_5
			end

			local var_162_6 = 0
			local var_162_7 = 0.15

			if var_162_6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_8 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_9 = arg_159_1:GetWordFromCfg(1109503038)
				local var_162_10 = arg_159_1:FormatText(var_162_9.content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 6
				local var_162_12 = utf8.len(var_162_10)
				local var_162_13 = var_162_11 <= 0 and var_162_7 or var_162_7 * (var_162_12 / var_162_11)

				if var_162_13 > 0 and var_162_7 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1109503039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1109503039
		arg_163_1.duration_ = 6.9

		local var_163_0 = {
			zh = 3.9,
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
				arg_163_0:Play1109503040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10058ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10058ui_story == nil then
				arg_163_1.var_.characterEffect10058ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect10058ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect10058ui_story then
				arg_163_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_166_4 = 0
			local var_166_5 = 0.475

			if var_166_4 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_6 = arg_163_1:FormatText(StoryNameCfg[471].name)

				arg_163_1.leftNameTxt_.text = var_166_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:GetWordFromCfg(1109503039)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 19
				local var_166_10 = utf8.len(var_166_8)
				local var_166_11 = var_166_9 <= 0 and var_166_5 or var_166_5 * (var_166_10 / var_166_9)

				if var_166_11 > 0 and var_166_5 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503039", "story_v_side_new_1109503.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503039", "story_v_side_new_1109503.awb") / 1000

					if var_166_12 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_4
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_side_new_1109503", "1109503039", "story_v_side_new_1109503.awb")

						arg_163_1:RecordAudio("1109503039", var_166_13)
						arg_163_1:RecordAudio("1109503039", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503039", "story_v_side_new_1109503.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503039", "story_v_side_new_1109503.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_14 and arg_163_1.time_ < var_166_4 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1109503040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1109503040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1109503041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10058ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10058ui_story == nil then
				arg_167_1.var_.characterEffect10058ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10058ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10058ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10058ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10058ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0
			local var_170_7 = 0.35

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_9 = arg_167_1:GetWordFromCfg(1109503040)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 14
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_7 or var_170_7 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_7 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1109503041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1109503041
		arg_171_1.duration_ = 7.83

		local var_171_0 = {
			zh = 3.333,
			ja = 7.833
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
				arg_171_0:Play1109503042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10058ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10058ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, -0.98, -6.1)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10058ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["10058ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10058ui_story == nil then
				arg_171_1.var_.characterEffect10058ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect10058ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10058ui_story then
				arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_174_15 = 0
			local var_174_16 = 0.375

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[471].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(1109503041)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 15
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503041", "story_v_side_new_1109503.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503041", "story_v_side_new_1109503.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_side_new_1109503", "1109503041", "story_v_side_new_1109503.awb")

						arg_171_1:RecordAudio("1109503041", var_174_24)
						arg_171_1:RecordAudio("1109503041", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503041", "story_v_side_new_1109503.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503041", "story_v_side_new_1109503.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109503042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1109503042
		arg_175_1.duration_ = 1

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"

			SetActive(arg_175_1.choicesGo_, true)

			for iter_176_0, iter_176_1 in ipairs(arg_175_1.choices_) do
				local var_176_0 = iter_176_0 <= 1

				SetActive(iter_176_1.go, var_176_0)
			end

			arg_175_1.choices_[1].txt.text = arg_175_1:FormatText(StoryChoiceCfg[724].name)
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1109503043(arg_175_1)
			end

			arg_175_1:RecordChoiceLog(1109503042, 724)
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_1 = 0.5

			if arg_175_1.time_ >= var_178_0 + var_178_1 and arg_175_1.time_ < var_178_0 + var_178_1 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_2 = arg_175_1.actors_["10058ui_story"]
			local var_178_3 = 0

			if var_178_3 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.characterEffect10058ui_story == nil then
				arg_175_1.var_.characterEffect10058ui_story = var_178_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_4 = 0.2

			if var_178_3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_3 + var_178_4 and not isNil(var_178_2) then
				local var_178_5 = (arg_175_1.time_ - var_178_3) / var_178_4

				if arg_175_1.var_.characterEffect10058ui_story and not isNil(var_178_2) then
					local var_178_6 = Mathf.Lerp(0, 0.5, var_178_5)

					arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10058ui_story.fillRatio = var_178_6
				end
			end

			if arg_175_1.time_ >= var_178_3 + var_178_4 and arg_175_1.time_ < var_178_3 + var_178_4 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.characterEffect10058ui_story then
				local var_178_7 = 0.5

				arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10058ui_story.fillRatio = var_178_7
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1109503043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1109503043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1109503044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.5

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:GetWordFromCfg(1109503043)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 20
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1109503044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1109503044
		arg_183_1.duration_ = 13.27

		local var_183_0 = {
			zh = 9.2,
			ja = 13.266
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
				arg_183_0:Play1109503045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10058ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10058ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, -0.98, -6.1)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10058ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["10058ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect10058ui_story == nil then
				arg_183_1.var_.characterEffect10058ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect10058ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect10058ui_story then
				arg_183_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_186_15 = 0
			local var_186_16 = 1.05

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[471].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(1109503044)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 42
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503044", "story_v_side_new_1109503.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503044", "story_v_side_new_1109503.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_side_new_1109503", "1109503044", "story_v_side_new_1109503.awb")

						arg_183_1:RecordAudio("1109503044", var_186_24)
						arg_183_1:RecordAudio("1109503044", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503044", "story_v_side_new_1109503.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503044", "story_v_side_new_1109503.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109503045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109503045
		arg_187_1.duration_ = 5.8

		local var_187_0 = {
			zh = 5.066,
			ja = 5.8
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
				arg_187_0:Play1109503046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10058ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10058ui_story == nil then
				arg_187_1.var_.characterEffect10058ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect10058ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10058ui_story then
				arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_190_4 = 0

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = false

				arg_187_1:SetGaussion(false)
			end

			local var_190_5 = 2

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_5 then
				local var_190_6 = (arg_187_1.time_ - var_190_4) / var_190_5
				local var_190_7 = Color.New(1, 1, 1)

				var_190_7.a = Mathf.Lerp(1, 0, var_190_6)
				arg_187_1.mask_.color = var_190_7
			end

			if arg_187_1.time_ >= var_190_4 + var_190_5 and arg_187_1.time_ < var_190_4 + var_190_5 + arg_190_0 then
				local var_190_8 = Color.New(1, 1, 1)
				local var_190_9 = 0

				arg_187_1.mask_.enabled = false
				var_190_8.a = var_190_9
				arg_187_1.mask_.color = var_190_8
			end

			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_190_11 = 0

			arg_187_1.isInRecall_ = false

			if var_190_11 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				arg_187_1.screenFilterGo_:SetActive(true)

				arg_187_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_190_0, iter_190_1 in pairs(arg_187_1.actors_) do
					local var_190_12 = iter_190_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_190_2, iter_190_3 in ipairs(var_190_12) do
						if iter_190_3.color.r > 0.51 then
							iter_190_3.color = Color.New(1, 1, 1)
						else
							iter_190_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_190_13 = 0.1

			if var_190_11 <= arg_187_1.time_ and arg_187_1.time_ < var_190_11 + var_190_13 then
				local var_190_14 = (arg_187_1.time_ - var_190_11) / var_190_13

				arg_187_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_190_14)
			end

			if arg_187_1.time_ >= var_190_11 + var_190_13 and arg_187_1.time_ < var_190_11 + var_190_13 + arg_190_0 then
				arg_187_1.screenFilterEffect_.weight = 1
			end

			local var_190_15 = "ST04b"

			if arg_187_1.bgs_[var_190_15] == nil then
				local var_190_16 = Object.Instantiate(arg_187_1.paintGo_)

				var_190_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_190_15)
				var_190_16.name = var_190_15
				var_190_16.transform.parent = arg_187_1.stage_.transform
				var_190_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.bgs_[var_190_15] = var_190_16
			end

			local var_190_17 = 0

			if var_190_17 < arg_187_1.time_ and arg_187_1.time_ <= var_190_17 + arg_190_0 then
				local var_190_18 = manager.ui.mainCamera.transform.localPosition
				local var_190_19 = Vector3.New(0, 0, 10) + Vector3.New(var_190_18.x, var_190_18.y, 0)
				local var_190_20 = arg_187_1.bgs_.ST04b

				var_190_20.transform.localPosition = var_190_19
				var_190_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_21 = var_190_20:GetComponent("SpriteRenderer")

				if var_190_21 and var_190_21.sprite then
					local var_190_22 = (var_190_20.transform.localPosition - var_190_18).z
					local var_190_23 = manager.ui.mainCameraCom_
					local var_190_24 = 2 * var_190_22 * Mathf.Tan(var_190_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_190_25 = var_190_24 * var_190_23.aspect
					local var_190_26 = var_190_21.sprite.bounds.size.x
					local var_190_27 = var_190_21.sprite.bounds.size.y
					local var_190_28 = var_190_25 / var_190_26
					local var_190_29 = var_190_24 / var_190_27
					local var_190_30 = var_190_29 < var_190_28 and var_190_28 or var_190_29

					var_190_20.transform.localScale = Vector3.New(var_190_30, var_190_30, 0)
				end

				for iter_190_4, iter_190_5 in pairs(arg_187_1.bgs_) do
					if iter_190_4 ~= "ST04b" then
						iter_190_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_31 = 0
			local var_190_32 = 0.525

			if var_190_31 < arg_187_1.time_ and arg_187_1.time_ <= var_190_31 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_33 = arg_187_1:FormatText(StoryNameCfg[471].name)

				arg_187_1.leftNameTxt_.text = var_190_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_34 = arg_187_1:GetWordFromCfg(1109503045)
				local var_190_35 = arg_187_1:FormatText(var_190_34.content)

				arg_187_1.text_.text = var_190_35

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_36 = 21
				local var_190_37 = utf8.len(var_190_35)
				local var_190_38 = var_190_36 <= 0 and var_190_32 or var_190_32 * (var_190_37 / var_190_36)

				if var_190_38 > 0 and var_190_32 < var_190_38 then
					arg_187_1.talkMaxDuration = var_190_38

					if var_190_38 + var_190_31 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_38 + var_190_31
					end
				end

				arg_187_1.text_.text = var_190_35
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503045", "story_v_side_new_1109503.awb") ~= 0 then
					local var_190_39 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503045", "story_v_side_new_1109503.awb") / 1000

					if var_190_39 + var_190_31 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_39 + var_190_31
					end

					if var_190_34.prefab_name ~= "" and arg_187_1.actors_[var_190_34.prefab_name] ~= nil then
						local var_190_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_34.prefab_name].transform, "story_v_side_new_1109503", "1109503045", "story_v_side_new_1109503.awb")

						arg_187_1:RecordAudio("1109503045", var_190_40)
						arg_187_1:RecordAudio("1109503045", var_190_40)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503045", "story_v_side_new_1109503.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503045", "story_v_side_new_1109503.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_41 = math.max(var_190_32, arg_187_1.talkMaxDuration)

			if var_190_31 <= arg_187_1.time_ and arg_187_1.time_ < var_190_31 + var_190_41 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_31) / var_190_41

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_31 + var_190_41 and arg_187_1.time_ < var_190_31 + var_190_41 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109503046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1109503046
		arg_191_1.duration_ = 4.77

		local var_191_0 = {
			zh = 2.9,
			ja = 4.766
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
				arg_191_0:Play1109503047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_194_1 = 0
			local var_194_2 = 0.325

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_3 = arg_191_1:FormatText(StoryNameCfg[471].name)

				arg_191_1.leftNameTxt_.text = var_194_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(1109503046)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_6 = 13
				local var_194_7 = utf8.len(var_194_5)
				local var_194_8 = var_194_6 <= 0 and var_194_2 or var_194_2 * (var_194_7 / var_194_6)

				if var_194_8 > 0 and var_194_2 < var_194_8 then
					arg_191_1.talkMaxDuration = var_194_8

					if var_194_8 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503046", "story_v_side_new_1109503.awb") ~= 0 then
					local var_194_9 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503046", "story_v_side_new_1109503.awb") / 1000

					if var_194_9 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_1
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_side_new_1109503", "1109503046", "story_v_side_new_1109503.awb")

						arg_191_1:RecordAudio("1109503046", var_194_10)
						arg_191_1:RecordAudio("1109503046", var_194_10)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503046", "story_v_side_new_1109503.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503046", "story_v_side_new_1109503.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_11 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_11 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_11

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_11 and arg_191_1.time_ < var_194_1 + var_194_11 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1109503047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1109503047
		arg_195_1.duration_ = 9

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1109503048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10058ui_story"]
			local var_198_1 = 2

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect10058ui_story == nil then
				arg_195_1.var_.characterEffect10058ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect10058ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10058ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect10058ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10058ui_story.fillRatio = var_198_5
			end

			local var_198_6 = 0

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_7 = 2

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_7 then
				local var_198_8 = (arg_195_1.time_ - var_198_6) / var_198_7
				local var_198_9 = Color.New(0, 0, 0)

				var_198_9.a = Mathf.Lerp(0, 1, var_198_8)
				arg_195_1.mask_.color = var_198_9
			end

			if arg_195_1.time_ >= var_198_6 + var_198_7 and arg_195_1.time_ < var_198_6 + var_198_7 + arg_198_0 then
				local var_198_10 = Color.New(0, 0, 0)

				var_198_10.a = 1
				arg_195_1.mask_.color = var_198_10
			end

			local var_198_11 = 2

			if var_198_11 < arg_195_1.time_ and arg_195_1.time_ <= var_198_11 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = false

				arg_195_1:SetGaussion(false)
			end

			local var_198_12 = 2

			if var_198_11 <= arg_195_1.time_ and arg_195_1.time_ < var_198_11 + var_198_12 then
				local var_198_13 = (arg_195_1.time_ - var_198_11) / var_198_12
				local var_198_14 = Color.New(0, 0, 0)

				var_198_14.a = Mathf.Lerp(1, 0, var_198_13)
				arg_195_1.mask_.color = var_198_14
			end

			if arg_195_1.time_ >= var_198_11 + var_198_12 and arg_195_1.time_ < var_198_11 + var_198_12 + arg_198_0 then
				local var_198_15 = Color.New(0, 0, 0)
				local var_198_16 = 0

				arg_195_1.mask_.enabled = false
				var_198_15.a = var_198_16
				arg_195_1.mask_.color = var_198_15
			end

			local var_198_17 = 2

			if var_198_17 < arg_195_1.time_ and arg_195_1.time_ <= var_198_17 + arg_198_0 then
				arg_195_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_198_18 = 2

			arg_195_1.isInRecall_ = false

			if var_198_18 < arg_195_1.time_ and arg_195_1.time_ <= var_198_18 + arg_198_0 then
				arg_195_1.screenFilterGo_:SetActive(false)

				for iter_198_0, iter_198_1 in pairs(arg_195_1.actors_) do
					local var_198_19 = iter_198_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_198_2, iter_198_3 in ipairs(var_198_19) do
						if iter_198_3.color.r > 0.51 then
							iter_198_3.color = Color.New(1, 1, 1)
						else
							iter_198_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_198_20 = 0.0166666666666667

			if var_198_18 <= arg_195_1.time_ and arg_195_1.time_ < var_198_18 + var_198_20 then
				local var_198_21 = (arg_195_1.time_ - var_198_18) / var_198_20

				arg_195_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_198_21)
			end

			if arg_195_1.time_ >= var_198_18 + var_198_20 and arg_195_1.time_ < var_198_18 + var_198_20 + arg_198_0 then
				arg_195_1.screenFilterEffect_.weight = 0
			end

			local var_198_22 = 2.01666666666667

			if var_198_22 < arg_195_1.time_ and arg_195_1.time_ <= var_198_22 + arg_198_0 then
				local var_198_23 = manager.ui.mainCamera.transform.localPosition
				local var_198_24 = Vector3.New(0, 0, 10) + Vector3.New(var_198_23.x, var_198_23.y, 0)
				local var_198_25 = arg_195_1.bgs_.F02a_1

				var_198_25.transform.localPosition = var_198_24
				var_198_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_198_26 = var_198_25:GetComponent("SpriteRenderer")

				if var_198_26 and var_198_26.sprite then
					local var_198_27 = (var_198_25.transform.localPosition - var_198_23).z
					local var_198_28 = manager.ui.mainCameraCom_
					local var_198_29 = 2 * var_198_27 * Mathf.Tan(var_198_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_198_30 = var_198_29 * var_198_28.aspect
					local var_198_31 = var_198_26.sprite.bounds.size.x
					local var_198_32 = var_198_26.sprite.bounds.size.y
					local var_198_33 = var_198_30 / var_198_31
					local var_198_34 = var_198_29 / var_198_32
					local var_198_35 = var_198_34 < var_198_33 and var_198_33 or var_198_34

					var_198_25.transform.localScale = Vector3.New(var_198_35, var_198_35, 0)
				end

				for iter_198_4, iter_198_5 in pairs(arg_195_1.bgs_) do
					if iter_198_4 ~= "F02a_1" then
						iter_198_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_36 = 4
			local var_198_37 = 0.65

			if var_198_36 < arg_195_1.time_ and arg_195_1.time_ <= var_198_36 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_38 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_38:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_39 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_40 = arg_195_1:GetWordFromCfg(1109503047)
				local var_198_41 = arg_195_1:FormatText(var_198_40.content)

				arg_195_1.text_.text = var_198_41

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_42 = 26
				local var_198_43 = utf8.len(var_198_41)
				local var_198_44 = var_198_42 <= 0 and var_198_37 or var_198_37 * (var_198_43 / var_198_42)

				if var_198_44 > 0 and var_198_37 < var_198_44 then
					arg_195_1.talkMaxDuration = var_198_44
					var_198_36 = var_198_36 + 0.3

					if var_198_44 + var_198_36 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_44 + var_198_36
					end
				end

				arg_195_1.text_.text = var_198_41
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_45 = var_198_36 + 0.3
			local var_198_46 = math.max(var_198_37, arg_195_1.talkMaxDuration)

			if var_198_45 <= arg_195_1.time_ and arg_195_1.time_ < var_198_45 + var_198_46 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_45) / var_198_46

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_45 + var_198_46 and arg_195_1.time_ < var_198_45 + var_198_46 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1109503048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1109503048
		arg_201_1.duration_ = 5.5

		local var_201_0 = {
			zh = 3.7,
			ja = 5.5
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
				arg_201_0:Play1109503049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10058ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10058ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(0, 100, 0)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10058ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, 100, 0)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = 0
			local var_204_10 = 0.475

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_11 = arg_201_1:FormatText(StoryNameCfg[426].name)

				arg_201_1.leftNameTxt_.text = var_204_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_12 = arg_201_1:GetWordFromCfg(1109503048)
				local var_204_13 = arg_201_1:FormatText(var_204_12.content)

				arg_201_1.text_.text = var_204_13

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_14 = 19
				local var_204_15 = utf8.len(var_204_13)
				local var_204_16 = var_204_14 <= 0 and var_204_10 or var_204_10 * (var_204_15 / var_204_14)

				if var_204_16 > 0 and var_204_10 < var_204_16 then
					arg_201_1.talkMaxDuration = var_204_16

					if var_204_16 + var_204_9 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_16 + var_204_9
					end
				end

				arg_201_1.text_.text = var_204_13
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503048", "story_v_side_new_1109503.awb") ~= 0 then
					local var_204_17 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503048", "story_v_side_new_1109503.awb") / 1000

					if var_204_17 + var_204_9 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_17 + var_204_9
					end

					if var_204_12.prefab_name ~= "" and arg_201_1.actors_[var_204_12.prefab_name] ~= nil then
						local var_204_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_12.prefab_name].transform, "story_v_side_new_1109503", "1109503048", "story_v_side_new_1109503.awb")

						arg_201_1:RecordAudio("1109503048", var_204_18)
						arg_201_1:RecordAudio("1109503048", var_204_18)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503048", "story_v_side_new_1109503.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503048", "story_v_side_new_1109503.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_19 = math.max(var_204_10, arg_201_1.talkMaxDuration)

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_19 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_9) / var_204_19

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_9 + var_204_19 and arg_201_1.time_ < var_204_9 + var_204_19 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play1109503049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1109503049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1109503050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.2

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

				local var_208_3 = arg_205_1:GetWordFromCfg(1109503049)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 8
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
	Play1109503050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1109503050
		arg_209_1.duration_ = 7.5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1109503051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_1 = 1.25

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_1 then
				local var_212_2 = (arg_209_1.time_ - var_212_0) / var_212_1
				local var_212_3 = Color.New(0, 0, 0)

				var_212_3.a = Mathf.Lerp(0, 1, var_212_2)
				arg_209_1.mask_.color = var_212_3
			end

			if arg_209_1.time_ >= var_212_0 + var_212_1 and arg_209_1.time_ < var_212_0 + var_212_1 + arg_212_0 then
				local var_212_4 = Color.New(0, 0, 0)

				var_212_4.a = 1
				arg_209_1.mask_.color = var_212_4
			end

			local var_212_5 = 1.25

			if var_212_5 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_6 = 1.25

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_6 then
				local var_212_7 = (arg_209_1.time_ - var_212_5) / var_212_6
				local var_212_8 = Color.New(0, 0, 0)

				var_212_8.a = Mathf.Lerp(1, 0, var_212_7)
				arg_209_1.mask_.color = var_212_8
			end

			if arg_209_1.time_ >= var_212_5 + var_212_6 and arg_209_1.time_ < var_212_5 + var_212_6 + arg_212_0 then
				local var_212_9 = Color.New(0, 0, 0)
				local var_212_10 = 0

				arg_209_1.mask_.enabled = false
				var_212_9.a = var_212_10
				arg_209_1.mask_.color = var_212_9
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_11 = 2.499999999999
			local var_212_12 = 1.25

			if var_212_11 < arg_209_1.time_ and arg_209_1.time_ <= var_212_11 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_13 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_13:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_14 = arg_209_1:GetWordFromCfg(1109503050)
				local var_212_15 = arg_209_1:FormatText(var_212_14.content)

				arg_209_1.text_.text = var_212_15

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_16 = 50
				local var_212_17 = utf8.len(var_212_15)
				local var_212_18 = var_212_16 <= 0 and var_212_12 or var_212_12 * (var_212_17 / var_212_16)

				if var_212_18 > 0 and var_212_12 < var_212_18 then
					arg_209_1.talkMaxDuration = var_212_18
					var_212_11 = var_212_11 + 0.3

					if var_212_18 + var_212_11 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_18 + var_212_11
					end
				end

				arg_209_1.text_.text = var_212_15
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_19 = var_212_11 + 0.3
			local var_212_20 = math.max(var_212_12, arg_209_1.talkMaxDuration)

			if var_212_19 <= arg_209_1.time_ and arg_209_1.time_ < var_212_19 + var_212_20 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_19) / var_212_20

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_19 + var_212_20 and arg_209_1.time_ < var_212_19 + var_212_20 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1109503051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1109503051
		arg_215_1.duration_ = 7

		local var_215_0 = {
			zh = 7,
			ja = 5.166
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
				arg_215_0:Play1109503052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.875

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[426].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(1109503051)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503051", "story_v_side_new_1109503.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503051", "story_v_side_new_1109503.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_side_new_1109503", "1109503051", "story_v_side_new_1109503.awb")

						arg_215_1:RecordAudio("1109503051", var_218_9)
						arg_215_1:RecordAudio("1109503051", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503051", "story_v_side_new_1109503.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503051", "story_v_side_new_1109503.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1109503052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1109503052
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1109503053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.775

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[7].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(1109503052)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 31
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
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1109503053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1109503053
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1109503054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 1.075

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(1109503053)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 43
				local var_226_5 = utf8.len(var_226_3)
				local var_226_6 = var_226_4 <= 0 and var_226_1 or var_226_1 * (var_226_5 / var_226_4)

				if var_226_6 > 0 and var_226_1 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_7 and arg_223_1.time_ < var_226_0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1109503054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1109503054
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1109503055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.2

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[7].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(1109503054)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 8
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
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_8 and arg_227_1.time_ < var_230_0 + var_230_8 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1109503055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1109503055
		arg_231_1.duration_ = 12.8

		local var_231_0 = {
			zh = 7.4,
			ja = 12.8
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
				arg_231_0:Play1109503056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.95

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[426].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(1109503055)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503055", "story_v_side_new_1109503.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503055", "story_v_side_new_1109503.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_side_new_1109503", "1109503055", "story_v_side_new_1109503.awb")

						arg_231_1:RecordAudio("1109503055", var_234_9)
						arg_231_1:RecordAudio("1109503055", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503055", "story_v_side_new_1109503.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503055", "story_v_side_new_1109503.awb")
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
	Play1109503056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1109503056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1109503057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.4

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[7].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(1109503056)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 16
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_8 and arg_235_1.time_ < var_238_0 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1109503057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1109503057
		arg_239_1.duration_ = 7.63

		local var_239_0 = {
			zh = 7.633,
			ja = 6.2
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1109503058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.95

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[426].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(1109503057)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 38
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503057", "story_v_side_new_1109503.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503057", "story_v_side_new_1109503.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_side_new_1109503", "1109503057", "story_v_side_new_1109503.awb")

						arg_239_1:RecordAudio("1109503057", var_242_9)
						arg_239_1:RecordAudio("1109503057", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503057", "story_v_side_new_1109503.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503057", "story_v_side_new_1109503.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1109503058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1109503058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1109503059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = manager.ui.mainCamera.transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.shakeOldPos = var_246_0.localPosition
			end

			local var_246_2 = 0.6

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / 0.066
				local var_246_4, var_246_5 = math.modf(var_246_3)

				var_246_0.localPosition = Vector3.New(var_246_5 * 0.13, var_246_5 * 0.13, var_246_5 * 0.13) + arg_243_1.var_.shakeOldPos
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = arg_243_1.var_.shakeOldPos
			end

			local var_246_6 = 0

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.allBtn_.enabled = false
			end

			local var_246_7 = 0.6

			if arg_243_1.time_ >= var_246_6 + var_246_7 and arg_243_1.time_ < var_246_6 + var_246_7 + arg_246_0 then
				arg_243_1.allBtn_.enabled = true
			end

			local var_246_8 = 0
			local var_246_9 = 0.7

			if var_246_8 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_10 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_11 = arg_243_1:GetWordFromCfg(1109503058)
				local var_246_12 = arg_243_1:FormatText(var_246_11.content)

				arg_243_1.text_.text = var_246_12

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 28
				local var_246_14 = utf8.len(var_246_12)
				local var_246_15 = var_246_13 <= 0 and var_246_9 or var_246_9 * (var_246_14 / var_246_13)

				if var_246_15 > 0 and var_246_9 < var_246_15 then
					arg_243_1.talkMaxDuration = var_246_15

					if var_246_15 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_15 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_12
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_9, arg_243_1.talkMaxDuration)

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_8) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_8 + var_246_16 and arg_243_1.time_ < var_246_8 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1109503059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1109503059
		arg_247_1.duration_ = 4.07

		local var_247_0 = {
			zh = 2.466,
			ja = 4.066
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
				arg_247_0:Play1109503060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10058ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10058ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0, -0.98, -6.1)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10058ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["10058ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10058ui_story == nil then
				arg_247_1.var_.characterEffect10058ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect10058ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10058ui_story then
				arg_247_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 then
				arg_247_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_250_15 = 0
			local var_250_16 = 0.325

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[471].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(1109503059)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 13
				local var_250_21 = utf8.len(var_250_19)
				local var_250_22 = var_250_20 <= 0 and var_250_16 or var_250_16 * (var_250_21 / var_250_20)

				if var_250_22 > 0 and var_250_16 < var_250_22 then
					arg_247_1.talkMaxDuration = var_250_22

					if var_250_22 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503059", "story_v_side_new_1109503.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503059", "story_v_side_new_1109503.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_side_new_1109503", "1109503059", "story_v_side_new_1109503.awb")

						arg_247_1:RecordAudio("1109503059", var_250_24)
						arg_247_1:RecordAudio("1109503059", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503059", "story_v_side_new_1109503.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503059", "story_v_side_new_1109503.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_25 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_25 and arg_247_1.time_ < var_250_15 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play1109503060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1109503060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1109503061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10058ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect10058ui_story == nil then
				arg_251_1.var_.characterEffect10058ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.1

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect10058ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10058ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect10058ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10058ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 0.4

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

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_9 = arg_251_1:GetWordFromCfg(1109503060)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 16
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
	Play1109503061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1109503061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1109503062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10058ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos10058ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0, 100, 0)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10058ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0, 100, 0)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = 0
			local var_258_10 = 0.725

			if var_258_9 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_11 = arg_255_1:GetWordFromCfg(1109503061)
				local var_258_12 = arg_255_1:FormatText(var_258_11.content)

				arg_255_1.text_.text = var_258_12

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_13 = 29
				local var_258_14 = utf8.len(var_258_12)
				local var_258_15 = var_258_13 <= 0 and var_258_10 or var_258_10 * (var_258_14 / var_258_13)

				if var_258_15 > 0 and var_258_10 < var_258_15 then
					arg_255_1.talkMaxDuration = var_258_15

					if var_258_15 + var_258_9 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_15 + var_258_9
					end
				end

				arg_255_1.text_.text = var_258_12
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_10, arg_255_1.talkMaxDuration)

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_9) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_9 + var_258_16 and arg_255_1.time_ < var_258_9 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play1109503062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1109503062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1109503063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.925

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_2 = arg_259_1:GetWordFromCfg(1109503062)
				local var_262_3 = arg_259_1:FormatText(var_262_2.content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 37
				local var_262_5 = utf8.len(var_262_3)
				local var_262_6 = var_262_4 <= 0 and var_262_1 or var_262_1 * (var_262_5 / var_262_4)

				if var_262_6 > 0 and var_262_1 < var_262_6 then
					arg_259_1.talkMaxDuration = var_262_6

					if var_262_6 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_7 and arg_259_1.time_ < var_262_0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1109503063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1109503063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1109503064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.75

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_2 = arg_263_1:GetWordFromCfg(1109503063)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 30
				local var_266_5 = utf8.len(var_266_3)
				local var_266_6 = var_266_4 <= 0 and var_266_1 or var_266_1 * (var_266_5 / var_266_4)

				if var_266_6 > 0 and var_266_1 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_7 and arg_263_1.time_ < var_266_0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1109503064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1109503064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1109503065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.2

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[7].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:GetWordFromCfg(1109503064)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 8
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_8 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_8 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_8

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_8 and arg_267_1.time_ < var_270_0 + var_270_8 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1109503065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1109503065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1109503066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.55

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_2 = arg_271_1:GetWordFromCfg(1109503065)
				local var_274_3 = arg_271_1:FormatText(var_274_2.content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 22
				local var_274_5 = utf8.len(var_274_3)
				local var_274_6 = var_274_4 <= 0 and var_274_1 or var_274_1 * (var_274_5 / var_274_4)

				if var_274_6 > 0 and var_274_1 < var_274_6 then
					arg_271_1.talkMaxDuration = var_274_6

					if var_274_6 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_7 and arg_271_1.time_ < var_274_0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1109503066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1109503066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1109503067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.175

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[7].name)

				arg_275_1.leftNameTxt_.text = var_278_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:GetWordFromCfg(1109503066)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 7
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_8 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_8 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_8

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_8 and arg_275_1.time_ < var_278_0 + var_278_8 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1109503067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1109503067
		arg_279_1.duration_ = 7.43

		local var_279_0 = {
			zh = 7.433,
			ja = 5.333
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1109503068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10058ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect10058ui_story == nil then
				arg_279_1.var_.characterEffect10058ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect10058ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect10058ui_story then
				arg_279_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_282_4 = arg_279_1.actors_["10058ui_story"].transform
			local var_282_5 = 0

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.var_.moveOldPos10058ui_story = var_282_4.localPosition
			end

			local var_282_6 = 0.001

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_6 then
				local var_282_7 = (arg_279_1.time_ - var_282_5) / var_282_6
				local var_282_8 = Vector3.New(0, -0.98, -6.1)

				var_282_4.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10058ui_story, var_282_8, var_282_7)

				local var_282_9 = manager.ui.mainCamera.transform.position - var_282_4.position

				var_282_4.forward = Vector3.New(var_282_9.x, var_282_9.y, var_282_9.z)

				local var_282_10 = var_282_4.localEulerAngles

				var_282_10.z = 0
				var_282_10.x = 0
				var_282_4.localEulerAngles = var_282_10
			end

			if arg_279_1.time_ >= var_282_5 + var_282_6 and arg_279_1.time_ < var_282_5 + var_282_6 + arg_282_0 then
				var_282_4.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_282_11 = manager.ui.mainCamera.transform.position - var_282_4.position

				var_282_4.forward = Vector3.New(var_282_11.x, var_282_11.y, var_282_11.z)

				local var_282_12 = var_282_4.localEulerAngles

				var_282_12.z = 0
				var_282_12.x = 0
				var_282_4.localEulerAngles = var_282_12
			end

			local var_282_13 = 0

			if var_282_13 < arg_279_1.time_ and arg_279_1.time_ <= var_282_13 + arg_282_0 then
				arg_279_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_282_14 = 0

			if var_282_14 < arg_279_1.time_ and arg_279_1.time_ <= var_282_14 + arg_282_0 then
				arg_279_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_282_15 = 0
			local var_282_16 = 0.55

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[471].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(1109503067)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 22
				local var_282_21 = utf8.len(var_282_19)
				local var_282_22 = var_282_20 <= 0 and var_282_16 or var_282_16 * (var_282_21 / var_282_20)

				if var_282_22 > 0 and var_282_16 < var_282_22 then
					arg_279_1.talkMaxDuration = var_282_22

					if var_282_22 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_19
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503067", "story_v_side_new_1109503.awb") ~= 0 then
					local var_282_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503067", "story_v_side_new_1109503.awb") / 1000

					if var_282_23 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_15
					end

					if var_282_18.prefab_name ~= "" and arg_279_1.actors_[var_282_18.prefab_name] ~= nil then
						local var_282_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_18.prefab_name].transform, "story_v_side_new_1109503", "1109503067", "story_v_side_new_1109503.awb")

						arg_279_1:RecordAudio("1109503067", var_282_24)
						arg_279_1:RecordAudio("1109503067", var_282_24)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503067", "story_v_side_new_1109503.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503067", "story_v_side_new_1109503.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_25 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_25 and arg_279_1.time_ < var_282_15 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play1109503068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1109503068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1109503069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10058ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect10058ui_story == nil then
				arg_283_1.var_.characterEffect10058ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect10058ui_story and not isNil(var_286_0) then
					local var_286_4 = Mathf.Lerp(0, 0.5, var_286_3)

					arg_283_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_283_1.var_.characterEffect10058ui_story.fillRatio = var_286_4
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect10058ui_story then
				local var_286_5 = 0.5

				arg_283_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_283_1.var_.characterEffect10058ui_story.fillRatio = var_286_5
			end

			local var_286_6 = 0
			local var_286_7 = 0.2

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_8 = arg_283_1:FormatText(StoryNameCfg[7].name)

				arg_283_1.leftNameTxt_.text = var_286_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_9 = arg_283_1:GetWordFromCfg(1109503068)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 8
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
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_14 and arg_283_1.time_ < var_286_6 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1109503069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1109503069
		arg_287_1.duration_ = 11.93

		local var_287_0 = {
			zh = 7.066,
			ja = 11.933
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1109503070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10058ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos10058ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(0, -0.98, -6.1)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10058ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["10058ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect10058ui_story == nil then
				arg_287_1.var_.characterEffect10058ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect10058ui_story and not isNil(var_290_9) then
					arg_287_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect10058ui_story then
				arg_287_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_290_13 = 0

			if var_290_13 < arg_287_1.time_ and arg_287_1.time_ <= var_290_13 + arg_290_0 then
				arg_287_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_290_14 = 0
			local var_290_15 = 0.85

			if var_290_14 < arg_287_1.time_ and arg_287_1.time_ <= var_290_14 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_16 = arg_287_1:FormatText(StoryNameCfg[471].name)

				arg_287_1.leftNameTxt_.text = var_290_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_17 = arg_287_1:GetWordFromCfg(1109503069)
				local var_290_18 = arg_287_1:FormatText(var_290_17.content)

				arg_287_1.text_.text = var_290_18

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_19 = 34
				local var_290_20 = utf8.len(var_290_18)
				local var_290_21 = var_290_19 <= 0 and var_290_15 or var_290_15 * (var_290_20 / var_290_19)

				if var_290_21 > 0 and var_290_15 < var_290_21 then
					arg_287_1.talkMaxDuration = var_290_21

					if var_290_21 + var_290_14 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_21 + var_290_14
					end
				end

				arg_287_1.text_.text = var_290_18
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503069", "story_v_side_new_1109503.awb") ~= 0 then
					local var_290_22 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503069", "story_v_side_new_1109503.awb") / 1000

					if var_290_22 + var_290_14 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_14
					end

					if var_290_17.prefab_name ~= "" and arg_287_1.actors_[var_290_17.prefab_name] ~= nil then
						local var_290_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_17.prefab_name].transform, "story_v_side_new_1109503", "1109503069", "story_v_side_new_1109503.awb")

						arg_287_1:RecordAudio("1109503069", var_290_23)
						arg_287_1:RecordAudio("1109503069", var_290_23)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503069", "story_v_side_new_1109503.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503069", "story_v_side_new_1109503.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_24 = math.max(var_290_15, arg_287_1.talkMaxDuration)

			if var_290_14 <= arg_287_1.time_ and arg_287_1.time_ < var_290_14 + var_290_24 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_14) / var_290_24

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_14 + var_290_24 and arg_287_1.time_ < var_290_14 + var_290_24 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play1109503070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1109503070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1109503071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10058ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos10058ui_story = var_294_0.localPosition
			end

			local var_294_2 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2
				local var_294_4 = Vector3.New(0, 100, 0)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10058ui_story, var_294_4, var_294_3)

				local var_294_5 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_5.x, var_294_5.y, var_294_5.z)

				local var_294_6 = var_294_0.localEulerAngles

				var_294_6.z = 0
				var_294_6.x = 0
				var_294_0.localEulerAngles = var_294_6
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0, 100, 0)

				local var_294_7 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_7.x, var_294_7.y, var_294_7.z)

				local var_294_8 = var_294_0.localEulerAngles

				var_294_8.z = 0
				var_294_8.x = 0
				var_294_0.localEulerAngles = var_294_8
			end

			local var_294_9 = 0
			local var_294_10 = 0.525

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_11 = arg_291_1:GetWordFromCfg(1109503070)
				local var_294_12 = arg_291_1:FormatText(var_294_11.content)

				arg_291_1.text_.text = var_294_12

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_13 = 21
				local var_294_14 = utf8.len(var_294_12)
				local var_294_15 = var_294_13 <= 0 and var_294_10 or var_294_10 * (var_294_14 / var_294_13)

				if var_294_15 > 0 and var_294_10 < var_294_15 then
					arg_291_1.talkMaxDuration = var_294_15

					if var_294_15 + var_294_9 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_15 + var_294_9
					end
				end

				arg_291_1.text_.text = var_294_12
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_16 = math.max(var_294_10, arg_291_1.talkMaxDuration)

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_16 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_9) / var_294_16

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_9 + var_294_16 and arg_291_1.time_ < var_294_9 + var_294_16 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play1109503071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1109503071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1109503072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.175

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[7].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(1109503071)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 7
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_8 and arg_295_1.time_ < var_298_0 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1109503072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1109503072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1109503073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.7

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				local var_302_2 = "play"
				local var_302_3 = "music"

				arg_299_1:AudioAction(var_302_2, var_302_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_302_4 = ""
				local var_302_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_302_5 ~= "" then
					if arg_299_1.bgmTxt_.text ~= var_302_5 and arg_299_1.bgmTxt_.text ~= "" then
						if arg_299_1.bgmTxt2_.text ~= "" then
							arg_299_1.bgmTxt_.text = arg_299_1.bgmTxt2_.text
						end

						arg_299_1.bgmTxt2_.text = var_302_5

						arg_299_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_299_1.bgmTxt_.text = var_302_5
						arg_299_1.bgmTxt2_.text = var_302_5
					end

					if arg_299_1.bgmTimer then
						arg_299_1.bgmTimer:Stop()

						arg_299_1.bgmTimer = nil
					end

					if arg_299_1.settingData.show_music_name == 1 then
						arg_299_1.musicController:SetSelectedState("show")
						arg_299_1.musicAnimator_:Play("open", 0, 0)

						if arg_299_1.settingData.music_time ~= 0 then
							arg_299_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_299_1.settingData.music_time), function()
								if arg_299_1 == nil or isNil(arg_299_1.bgmTxt_) then
									return
								end

								arg_299_1.musicController:SetSelectedState("hide")
								arg_299_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_302_6 = 0
			local var_302_7 = 0.85

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_8 = arg_299_1:GetWordFromCfg(1109503072)
				local var_302_9 = arg_299_1:FormatText(var_302_8.content)

				arg_299_1.text_.text = var_302_9

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_10 = 34
				local var_302_11 = utf8.len(var_302_9)
				local var_302_12 = var_302_10 <= 0 and var_302_7 or var_302_7 * (var_302_11 / var_302_10)

				if var_302_12 > 0 and var_302_7 < var_302_12 then
					arg_299_1.talkMaxDuration = var_302_12

					if var_302_12 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_12 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_9
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_13 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_13 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_13

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_13 and arg_299_1.time_ < var_302_6 + var_302_13 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1109503073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1109503073
		arg_304_1.duration_ = 7.5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1109503074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_1 = 1.25

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_1 then
				local var_307_2 = (arg_304_1.time_ - var_307_0) / var_307_1
				local var_307_3 = Color.New(0, 0, 0)

				var_307_3.a = Mathf.Lerp(0, 1, var_307_2)
				arg_304_1.mask_.color = var_307_3
			end

			if arg_304_1.time_ >= var_307_0 + var_307_1 and arg_304_1.time_ < var_307_0 + var_307_1 + arg_307_0 then
				local var_307_4 = Color.New(0, 0, 0)

				var_307_4.a = 1
				arg_304_1.mask_.color = var_307_4
			end

			local var_307_5 = 1.25

			if var_307_5 < arg_304_1.time_ and arg_304_1.time_ <= var_307_5 + arg_307_0 then
				arg_304_1.mask_.enabled = true
				arg_304_1.mask_.raycastTarget = true

				arg_304_1:SetGaussion(false)
			end

			local var_307_6 = 1.25

			if var_307_5 <= arg_304_1.time_ and arg_304_1.time_ < var_307_5 + var_307_6 then
				local var_307_7 = (arg_304_1.time_ - var_307_5) / var_307_6
				local var_307_8 = Color.New(0, 0, 0)

				var_307_8.a = Mathf.Lerp(1, 0, var_307_7)
				arg_304_1.mask_.color = var_307_8
			end

			if arg_304_1.time_ >= var_307_5 + var_307_6 and arg_304_1.time_ < var_307_5 + var_307_6 + arg_307_0 then
				local var_307_9 = Color.New(0, 0, 0)
				local var_307_10 = 0

				arg_304_1.mask_.enabled = false
				var_307_9.a = var_307_10
				arg_304_1.mask_.color = var_307_9
			end

			if arg_304_1.frameCnt_ <= 1 then
				arg_304_1.dialog_:SetActive(false)
			end

			local var_307_11 = 2.5
			local var_307_12 = 0.95

			if var_307_11 < arg_304_1.time_ and arg_304_1.time_ <= var_307_11 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0

				arg_304_1.dialog_:SetActive(true)

				arg_304_1.dialogCg_.alpha = 0

				local var_307_13 = LeanTween.value(arg_304_1.dialog_, 0, 1, 0.3)

				var_307_13:setOnUpdate(LuaHelper.FloatAction(function(arg_308_0)
					arg_304_1.dialogCg_.alpha = arg_308_0
				end))
				var_307_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_304_1.dialog_)
					var_307_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_304_1.duration_ = arg_304_1.duration_ + 0.3

				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_14 = arg_304_1:GetWordFromCfg(1109503073)
				local var_307_15 = arg_304_1:FormatText(var_307_14.content)

				arg_304_1.text_.text = var_307_15

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_16 = 38
				local var_307_17 = utf8.len(var_307_15)
				local var_307_18 = var_307_16 <= 0 and var_307_12 or var_307_12 * (var_307_17 / var_307_16)

				if var_307_18 > 0 and var_307_12 < var_307_18 then
					arg_304_1.talkMaxDuration = var_307_18
					var_307_11 = var_307_11 + 0.3

					if var_307_18 + var_307_11 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_18 + var_307_11
					end
				end

				arg_304_1.text_.text = var_307_15
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_19 = var_307_11 + 0.3
			local var_307_20 = math.max(var_307_12, arg_304_1.talkMaxDuration)

			if var_307_19 <= arg_304_1.time_ and arg_304_1.time_ < var_307_19 + var_307_20 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_19) / var_307_20

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_19 + var_307_20 and arg_304_1.time_ < var_307_19 + var_307_20 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1109503074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1109503074
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1109503075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = "F02a"

			if arg_310_1.bgs_[var_313_0] == nil then
				local var_313_1 = Object.Instantiate(arg_310_1.paintGo_)

				var_313_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_313_0)
				var_313_1.name = var_313_0
				var_313_1.transform.parent = arg_310_1.stage_.transform
				var_313_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_310_1.bgs_[var_313_0] = var_313_1
			end

			local var_313_2 = 0

			if var_313_2 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				local var_313_3 = manager.ui.mainCamera.transform.localPosition
				local var_313_4 = Vector3.New(0, 0, 10) + Vector3.New(var_313_3.x, var_313_3.y, 0)
				local var_313_5 = arg_310_1.bgs_.F02a

				var_313_5.transform.localPosition = var_313_4
				var_313_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_313_6 = var_313_5:GetComponent("SpriteRenderer")

				if var_313_6 and var_313_6.sprite then
					local var_313_7 = (var_313_5.transform.localPosition - var_313_3).z
					local var_313_8 = manager.ui.mainCameraCom_
					local var_313_9 = 2 * var_313_7 * Mathf.Tan(var_313_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_313_10 = var_313_9 * var_313_8.aspect
					local var_313_11 = var_313_6.sprite.bounds.size.x
					local var_313_12 = var_313_6.sprite.bounds.size.y
					local var_313_13 = var_313_10 / var_313_11
					local var_313_14 = var_313_9 / var_313_12
					local var_313_15 = var_313_14 < var_313_13 and var_313_13 or var_313_14

					var_313_5.transform.localScale = Vector3.New(var_313_15, var_313_15, 0)
				end

				for iter_313_0, iter_313_1 in pairs(arg_310_1.bgs_) do
					if iter_313_0 ~= "F02a" then
						iter_313_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_313_16 = 0
			local var_313_17 = 0.7

			if var_313_16 < arg_310_1.time_ and arg_310_1.time_ <= var_313_16 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0

				arg_310_1.dialog_:SetActive(true)

				arg_310_1.dialogCg_.alpha = 0

				local var_313_18 = LeanTween.value(arg_310_1.dialog_, 0, 1, 0.3)

				var_313_18:setOnUpdate(LuaHelper.FloatAction(function(arg_314_0)
					arg_310_1.dialogCg_.alpha = arg_314_0
				end))
				var_313_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_310_1.dialog_)
					var_313_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_310_1.duration_ = arg_310_1.duration_ + 0.3

				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_19 = arg_310_1:GetWordFromCfg(1109503074)
				local var_313_20 = arg_310_1:FormatText(var_313_19.content)

				arg_310_1.text_.text = var_313_20

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_21 = 28
				local var_313_22 = utf8.len(var_313_20)
				local var_313_23 = var_313_21 <= 0 and var_313_17 or var_313_17 * (var_313_22 / var_313_21)

				if var_313_23 > 0 and var_313_17 < var_313_23 then
					arg_310_1.talkMaxDuration = var_313_23
					var_313_16 = var_313_16 + 0.3

					if var_313_23 + var_313_16 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_23 + var_313_16
					end
				end

				arg_310_1.text_.text = var_313_20
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_24 = var_313_16 + 0.3
			local var_313_25 = math.max(var_313_17, arg_310_1.talkMaxDuration)

			if var_313_24 <= arg_310_1.time_ and arg_310_1.time_ < var_313_24 + var_313_25 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_24) / var_313_25

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_24 + var_313_25 and arg_310_1.time_ < var_313_24 + var_313_25 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1109503075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1109503075
		arg_316_1.duration_ = 7.03

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1109503076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 2.03333333333333

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				local var_319_1 = manager.ui.mainCamera.transform.localPosition
				local var_319_2 = Vector3.New(0, 0, 10) + Vector3.New(var_319_1.x, var_319_1.y, 0)
				local var_319_3 = arg_316_1.bgs_.STblack

				var_319_3.transform.localPosition = var_319_2
				var_319_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_319_4 = var_319_3:GetComponent("SpriteRenderer")

				if var_319_4 and var_319_4.sprite then
					local var_319_5 = (var_319_3.transform.localPosition - var_319_1).z
					local var_319_6 = manager.ui.mainCameraCom_
					local var_319_7 = 2 * var_319_5 * Mathf.Tan(var_319_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_319_8 = var_319_7 * var_319_6.aspect
					local var_319_9 = var_319_4.sprite.bounds.size.x
					local var_319_10 = var_319_4.sprite.bounds.size.y
					local var_319_11 = var_319_8 / var_319_9
					local var_319_12 = var_319_7 / var_319_10
					local var_319_13 = var_319_12 < var_319_11 and var_319_11 or var_319_12

					var_319_3.transform.localScale = Vector3.New(var_319_13, var_319_13, 0)
				end

				for iter_319_0, iter_319_1 in pairs(arg_316_1.bgs_) do
					if iter_319_0 ~= "STblack" then
						iter_319_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_319_14 = arg_316_1.actors_["10058ui_story"].transform
			local var_319_15 = 1.96599999815226

			if var_319_15 < arg_316_1.time_ and arg_316_1.time_ <= var_319_15 + arg_319_0 then
				arg_316_1.var_.moveOldPos10058ui_story = var_319_14.localPosition
			end

			local var_319_16 = 0.001

			if var_319_15 <= arg_316_1.time_ and arg_316_1.time_ < var_319_15 + var_319_16 then
				local var_319_17 = (arg_316_1.time_ - var_319_15) / var_319_16
				local var_319_18 = Vector3.New(0, 100, 0)

				var_319_14.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10058ui_story, var_319_18, var_319_17)

				local var_319_19 = manager.ui.mainCamera.transform.position - var_319_14.position

				var_319_14.forward = Vector3.New(var_319_19.x, var_319_19.y, var_319_19.z)

				local var_319_20 = var_319_14.localEulerAngles

				var_319_20.z = 0
				var_319_20.x = 0
				var_319_14.localEulerAngles = var_319_20
			end

			if arg_316_1.time_ >= var_319_15 + var_319_16 and arg_316_1.time_ < var_319_15 + var_319_16 + arg_319_0 then
				var_319_14.localPosition = Vector3.New(0, 100, 0)

				local var_319_21 = manager.ui.mainCamera.transform.position - var_319_14.position

				var_319_14.forward = Vector3.New(var_319_21.x, var_319_21.y, var_319_21.z)

				local var_319_22 = var_319_14.localEulerAngles

				var_319_22.z = 0
				var_319_22.x = 0
				var_319_14.localEulerAngles = var_319_22
			end

			local var_319_23 = arg_316_1.actors_["10058ui_story"]
			local var_319_24 = 1.96599999815226

			if var_319_24 < arg_316_1.time_ and arg_316_1.time_ <= var_319_24 + arg_319_0 and not isNil(var_319_23) and arg_316_1.var_.characterEffect10058ui_story == nil then
				arg_316_1.var_.characterEffect10058ui_story = var_319_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_25 = 0.034000001847744

			if var_319_24 <= arg_316_1.time_ and arg_316_1.time_ < var_319_24 + var_319_25 and not isNil(var_319_23) then
				local var_319_26 = (arg_316_1.time_ - var_319_24) / var_319_25

				if arg_316_1.var_.characterEffect10058ui_story and not isNil(var_319_23) then
					local var_319_27 = Mathf.Lerp(0, 0.5, var_319_26)

					arg_316_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_316_1.var_.characterEffect10058ui_story.fillRatio = var_319_27
				end
			end

			if arg_316_1.time_ >= var_319_24 + var_319_25 and arg_316_1.time_ < var_319_24 + var_319_25 + arg_319_0 and not isNil(var_319_23) and arg_316_1.var_.characterEffect10058ui_story then
				local var_319_28 = 0.5

				arg_316_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_316_1.var_.characterEffect10058ui_story.fillRatio = var_319_28
			end

			local var_319_29 = 0

			if var_319_29 < arg_316_1.time_ and arg_316_1.time_ <= var_319_29 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_30 = 2.03333333333333

			if var_319_29 <= arg_316_1.time_ and arg_316_1.time_ < var_319_29 + var_319_30 then
				local var_319_31 = (arg_316_1.time_ - var_319_29) / var_319_30
				local var_319_32 = Color.New(0, 0, 0)

				var_319_32.a = Mathf.Lerp(0, 1, var_319_31)
				arg_316_1.mask_.color = var_319_32
			end

			if arg_316_1.time_ >= var_319_29 + var_319_30 and arg_316_1.time_ < var_319_29 + var_319_30 + arg_319_0 then
				local var_319_33 = Color.New(0, 0, 0)

				var_319_33.a = 1
				arg_316_1.mask_.color = var_319_33
			end

			local var_319_34 = 2.03333333333333

			if var_319_34 < arg_316_1.time_ and arg_316_1.time_ <= var_319_34 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_35 = 2.23333333333333

			if var_319_34 <= arg_316_1.time_ and arg_316_1.time_ < var_319_34 + var_319_35 then
				local var_319_36 = (arg_316_1.time_ - var_319_34) / var_319_35
				local var_319_37 = Color.New(0, 0, 0)

				var_319_37.a = Mathf.Lerp(1, 0, var_319_36)
				arg_316_1.mask_.color = var_319_37
			end

			if arg_316_1.time_ >= var_319_34 + var_319_35 and arg_316_1.time_ < var_319_34 + var_319_35 + arg_319_0 then
				local var_319_38 = Color.New(0, 0, 0)
				local var_319_39 = 0

				arg_316_1.mask_.enabled = false
				var_319_38.a = var_319_39
				arg_316_1.mask_.color = var_319_38
			end

			if arg_316_1.frameCnt_ <= 1 then
				arg_316_1.dialog_:SetActive(false)
			end

			local var_319_40 = 2.03333333333333
			local var_319_41 = 0.65

			if var_319_40 < arg_316_1.time_ and arg_316_1.time_ <= var_319_40 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0

				arg_316_1.dialog_:SetActive(true)

				arg_316_1.dialogCg_.alpha = 0

				local var_319_42 = LeanTween.value(arg_316_1.dialog_, 0, 1, 0.3)

				var_319_42:setOnUpdate(LuaHelper.FloatAction(function(arg_320_0)
					arg_316_1.dialogCg_.alpha = arg_320_0
				end))
				var_319_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_316_1.dialog_)
					var_319_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_316_1.duration_ = arg_316_1.duration_ + 0.3

				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_43 = arg_316_1:GetWordFromCfg(1109503075)
				local var_319_44 = arg_316_1:FormatText(var_319_43.content)

				arg_316_1.text_.text = var_319_44

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_45 = 26
				local var_319_46 = utf8.len(var_319_44)
				local var_319_47 = var_319_45 <= 0 and var_319_41 or var_319_41 * (var_319_46 / var_319_45)

				if var_319_47 > 0 and var_319_41 < var_319_47 then
					arg_316_1.talkMaxDuration = var_319_47
					var_319_40 = var_319_40 + 0.3

					if var_319_47 + var_319_40 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_47 + var_319_40
					end
				end

				arg_316_1.text_.text = var_319_44
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_48 = var_319_40 + 0.3
			local var_319_49 = math.max(var_319_41, arg_316_1.talkMaxDuration)

			if var_319_48 <= arg_316_1.time_ and arg_316_1.time_ < var_319_48 + var_319_49 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_48) / var_319_49

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_48 + var_319_49 and arg_316_1.time_ < var_319_48 + var_319_49 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play1109503076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1109503076
		arg_322_1.duration_ = 7

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1109503077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				local var_325_1 = manager.ui.mainCamera.transform.localPosition
				local var_325_2 = Vector3.New(0, 0, 10) + Vector3.New(var_325_1.x, var_325_1.y, 0)
				local var_325_3 = arg_322_1.bgs_.F02a_1

				var_325_3.transform.localPosition = var_325_2
				var_325_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_325_4 = var_325_3:GetComponent("SpriteRenderer")

				if var_325_4 and var_325_4.sprite then
					local var_325_5 = (var_325_3.transform.localPosition - var_325_1).z
					local var_325_6 = manager.ui.mainCameraCom_
					local var_325_7 = 2 * var_325_5 * Mathf.Tan(var_325_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_325_8 = var_325_7 * var_325_6.aspect
					local var_325_9 = var_325_4.sprite.bounds.size.x
					local var_325_10 = var_325_4.sprite.bounds.size.y
					local var_325_11 = var_325_8 / var_325_9
					local var_325_12 = var_325_7 / var_325_10
					local var_325_13 = var_325_12 < var_325_11 and var_325_11 or var_325_12

					var_325_3.transform.localScale = Vector3.New(var_325_13, var_325_13, 0)
				end

				for iter_325_0, iter_325_1 in pairs(arg_322_1.bgs_) do
					if iter_325_0 ~= "F02a_1" then
						iter_325_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_325_14 = 0

			if var_325_14 < arg_322_1.time_ and arg_322_1.time_ <= var_325_14 + arg_325_0 then
				arg_322_1.allBtn_.enabled = false
			end

			local var_325_15 = 0.3

			if arg_322_1.time_ >= var_325_14 + var_325_15 and arg_322_1.time_ < var_325_14 + var_325_15 + arg_325_0 then
				arg_322_1.allBtn_.enabled = true
			end

			local var_325_16 = 0

			if var_325_16 < arg_322_1.time_ and arg_322_1.time_ <= var_325_16 + arg_325_0 then
				arg_322_1.mask_.enabled = true
				arg_322_1.mask_.raycastTarget = true

				arg_322_1:SetGaussion(false)
			end

			local var_325_17 = 2

			if var_325_16 <= arg_322_1.time_ and arg_322_1.time_ < var_325_16 + var_325_17 then
				local var_325_18 = (arg_322_1.time_ - var_325_16) / var_325_17
				local var_325_19 = Color.New(0, 0, 0)

				var_325_19.a = Mathf.Lerp(1, 0, var_325_18)
				arg_322_1.mask_.color = var_325_19
			end

			if arg_322_1.time_ >= var_325_16 + var_325_17 and arg_322_1.time_ < var_325_16 + var_325_17 + arg_325_0 then
				local var_325_20 = Color.New(0, 0, 0)
				local var_325_21 = 0

				arg_322_1.mask_.enabled = false
				var_325_20.a = var_325_21
				arg_322_1.mask_.color = var_325_20
			end

			local var_325_22 = arg_322_1.actors_["10058ui_story"].transform
			local var_325_23 = 0

			if var_325_23 < arg_322_1.time_ and arg_322_1.time_ <= var_325_23 + arg_325_0 then
				arg_322_1.var_.moveOldPos10058ui_story = var_325_22.localPosition
			end

			local var_325_24 = 0.001

			if var_325_23 <= arg_322_1.time_ and arg_322_1.time_ < var_325_23 + var_325_24 then
				local var_325_25 = (arg_322_1.time_ - var_325_23) / var_325_24
				local var_325_26 = Vector3.New(0, 100, 0)

				var_325_22.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10058ui_story, var_325_26, var_325_25)

				local var_325_27 = manager.ui.mainCamera.transform.position - var_325_22.position

				var_325_22.forward = Vector3.New(var_325_27.x, var_325_27.y, var_325_27.z)

				local var_325_28 = var_325_22.localEulerAngles

				var_325_28.z = 0
				var_325_28.x = 0
				var_325_22.localEulerAngles = var_325_28
			end

			if arg_322_1.time_ >= var_325_23 + var_325_24 and arg_322_1.time_ < var_325_23 + var_325_24 + arg_325_0 then
				var_325_22.localPosition = Vector3.New(0, 100, 0)

				local var_325_29 = manager.ui.mainCamera.transform.position - var_325_22.position

				var_325_22.forward = Vector3.New(var_325_29.x, var_325_29.y, var_325_29.z)

				local var_325_30 = var_325_22.localEulerAngles

				var_325_30.z = 0
				var_325_30.x = 0
				var_325_22.localEulerAngles = var_325_30
			end

			local var_325_31 = arg_322_1.actors_["10058ui_story"]
			local var_325_32 = 0

			if var_325_32 < arg_322_1.time_ and arg_322_1.time_ <= var_325_32 + arg_325_0 and not isNil(var_325_31) and arg_322_1.var_.characterEffect10058ui_story == nil then
				arg_322_1.var_.characterEffect10058ui_story = var_325_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_33 = 0.200000002980232

			if var_325_32 <= arg_322_1.time_ and arg_322_1.time_ < var_325_32 + var_325_33 and not isNil(var_325_31) then
				local var_325_34 = (arg_322_1.time_ - var_325_32) / var_325_33

				if arg_322_1.var_.characterEffect10058ui_story and not isNil(var_325_31) then
					local var_325_35 = Mathf.Lerp(0, 0.5, var_325_34)

					arg_322_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_322_1.var_.characterEffect10058ui_story.fillRatio = var_325_35
				end
			end

			if arg_322_1.time_ >= var_325_32 + var_325_33 and arg_322_1.time_ < var_325_32 + var_325_33 + arg_325_0 and not isNil(var_325_31) and arg_322_1.var_.characterEffect10058ui_story then
				local var_325_36 = 0.5

				arg_322_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_322_1.var_.characterEffect10058ui_story.fillRatio = var_325_36
			end

			local var_325_37 = 0
			local var_325_38 = 0.3

			if var_325_37 < arg_322_1.time_ and arg_322_1.time_ <= var_325_37 + arg_325_0 then
				local var_325_39 = "play"
				local var_325_40 = "music"

				arg_322_1:AudioAction(var_325_39, var_325_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_325_41 = ""
				local var_325_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_325_42 ~= "" then
					if arg_322_1.bgmTxt_.text ~= var_325_42 and arg_322_1.bgmTxt_.text ~= "" then
						if arg_322_1.bgmTxt2_.text ~= "" then
							arg_322_1.bgmTxt_.text = arg_322_1.bgmTxt2_.text
						end

						arg_322_1.bgmTxt2_.text = var_325_42

						arg_322_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_322_1.bgmTxt_.text = var_325_42
						arg_322_1.bgmTxt2_.text = var_325_42
					end

					if arg_322_1.bgmTimer then
						arg_322_1.bgmTimer:Stop()

						arg_322_1.bgmTimer = nil
					end

					if arg_322_1.settingData.show_music_name == 1 then
						arg_322_1.musicController:SetSelectedState("show")
						arg_322_1.musicAnimator_:Play("open", 0, 0)

						if arg_322_1.settingData.music_time ~= 0 then
							arg_322_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_322_1.settingData.music_time), function()
								if arg_322_1 == nil or isNil(arg_322_1.bgmTxt_) then
									return
								end

								arg_322_1.musicController:SetSelectedState("hide")
								arg_322_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_325_43 = 0.433333333333333
			local var_325_44 = 1

			if var_325_43 < arg_322_1.time_ and arg_322_1.time_ <= var_325_43 + arg_325_0 then
				local var_325_45 = "play"
				local var_325_46 = "music"

				arg_322_1:AudioAction(var_325_45, var_325_46, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_325_47 = ""
				local var_325_48 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_325_48 ~= "" then
					if arg_322_1.bgmTxt_.text ~= var_325_48 and arg_322_1.bgmTxt_.text ~= "" then
						if arg_322_1.bgmTxt2_.text ~= "" then
							arg_322_1.bgmTxt_.text = arg_322_1.bgmTxt2_.text
						end

						arg_322_1.bgmTxt2_.text = var_325_48

						arg_322_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_322_1.bgmTxt_.text = var_325_48
						arg_322_1.bgmTxt2_.text = var_325_48
					end

					if arg_322_1.bgmTimer then
						arg_322_1.bgmTimer:Stop()

						arg_322_1.bgmTimer = nil
					end

					if arg_322_1.settingData.show_music_name == 1 then
						arg_322_1.musicController:SetSelectedState("show")
						arg_322_1.musicAnimator_:Play("open", 0, 0)

						if arg_322_1.settingData.music_time ~= 0 then
							arg_322_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_322_1.settingData.music_time), function()
								if arg_322_1 == nil or isNil(arg_322_1.bgmTxt_) then
									return
								end

								arg_322_1.musicController:SetSelectedState("hide")
								arg_322_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_322_1.frameCnt_ <= 1 then
				arg_322_1.dialog_:SetActive(false)
			end

			local var_325_49 = 1.999999999999
			local var_325_50 = 0.25

			if var_325_49 < arg_322_1.time_ and arg_322_1.time_ <= var_325_49 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0

				arg_322_1.dialog_:SetActive(true)

				arg_322_1.dialogCg_.alpha = 0

				local var_325_51 = LeanTween.value(arg_322_1.dialog_, 0, 1, 0.3)

				var_325_51:setOnUpdate(LuaHelper.FloatAction(function(arg_328_0)
					arg_322_1.dialogCg_.alpha = arg_328_0
				end))
				var_325_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_322_1.dialog_)
					var_325_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_322_1.duration_ = arg_322_1.duration_ + 0.3

				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_52 = arg_322_1:FormatText(StoryNameCfg[7].name)

				arg_322_1.leftNameTxt_.text = var_325_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_53 = arg_322_1:GetWordFromCfg(1109503076)
				local var_325_54 = arg_322_1:FormatText(var_325_53.content)

				arg_322_1.text_.text = var_325_54

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_55 = 10
				local var_325_56 = utf8.len(var_325_54)
				local var_325_57 = var_325_55 <= 0 and var_325_50 or var_325_50 * (var_325_56 / var_325_55)

				if var_325_57 > 0 and var_325_50 < var_325_57 then
					arg_322_1.talkMaxDuration = var_325_57
					var_325_49 = var_325_49 + 0.3

					if var_325_57 + var_325_49 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_57 + var_325_49
					end
				end

				arg_322_1.text_.text = var_325_54
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_58 = var_325_49 + 0.3
			local var_325_59 = math.max(var_325_50, arg_322_1.talkMaxDuration)

			if var_325_58 <= arg_322_1.time_ and arg_322_1.time_ < var_325_58 + var_325_59 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_58) / var_325_59

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_58 + var_325_59 and arg_322_1.time_ < var_325_58 + var_325_59 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play1109503077 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1109503077
		arg_330_1.duration_ = 0.5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"

			SetActive(arg_330_1.choicesGo_, true)

			for iter_331_0, iter_331_1 in ipairs(arg_330_1.choices_) do
				local var_331_0 = iter_331_0 <= 3

				SetActive(iter_331_1.go, var_331_0)
			end

			arg_330_1.choices_[1].txt.text = arg_330_1:FormatText(StoryChoiceCfg[725].name)
			arg_330_1.choices_[2].txt.text = arg_330_1:FormatText(StoryChoiceCfg[726].name)
			arg_330_1.choices_[3].txt.text = arg_330_1:FormatText(StoryChoiceCfg[727].name)
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1109503078(arg_330_1)
			end

			if arg_332_0 == 2 then
				arg_330_0:Play1109503078(arg_330_1)
			end

			if arg_332_0 == 3 then
				arg_330_0:Play1109503078(arg_330_1)
			end

			arg_330_1:RecordChoiceLog(1109503077, 725, 726, 727)
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.allBtn_.enabled = false
			end

			local var_333_1 = 0.5

			if arg_330_1.time_ >= var_333_0 + var_333_1 and arg_330_1.time_ < var_333_0 + var_333_1 + arg_333_0 then
				arg_330_1.allBtn_.enabled = true
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1109503078 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1109503078
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1109503079(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 1.15

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0

				arg_334_1.dialog_:SetActive(true)

				arg_334_1.dialogCg_.alpha = 0

				local var_337_2 = LeanTween.value(arg_334_1.dialog_, 0, 1, 0.3)

				var_337_2:setOnUpdate(LuaHelper.FloatAction(function(arg_338_0)
					arg_334_1.dialogCg_.alpha = arg_338_0
				end))
				var_337_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_334_1.dialog_)
					var_337_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_334_1.duration_ = arg_334_1.duration_ + 0.3

				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_3 = arg_334_1:GetWordFromCfg(1109503078)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 46
				local var_337_6 = utf8.len(var_337_4)
				local var_337_7 = var_337_5 <= 0 and var_337_1 or var_337_1 * (var_337_6 / var_337_5)

				if var_337_7 > 0 and var_337_1 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7
					var_337_0 = var_337_0 + 0.3

					if var_337_7 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_8 = var_337_0 + 0.3
			local var_337_9 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_8 <= arg_334_1.time_ and arg_334_1.time_ < var_337_8 + var_337_9 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_8) / var_337_9

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_8 + var_337_9 and arg_334_1.time_ < var_337_8 + var_337_9 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1109503079 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1109503079
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1109503080(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 0.65

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_2 = arg_340_1:GetWordFromCfg(1109503079)
				local var_343_3 = arg_340_1:FormatText(var_343_2.content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 26
				local var_343_5 = utf8.len(var_343_3)
				local var_343_6 = var_343_4 <= 0 and var_343_1 or var_343_1 * (var_343_5 / var_343_4)

				if var_343_6 > 0 and var_343_1 < var_343_6 then
					arg_340_1.talkMaxDuration = var_343_6

					if var_343_6 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_6 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_3
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_7 and arg_340_1.time_ < var_343_0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1109503080 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1109503080
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1109503081(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.075

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_2 = arg_344_1:FormatText(StoryNameCfg[7].name)

				arg_344_1.leftNameTxt_.text = var_347_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_3 = arg_344_1:GetWordFromCfg(1109503080)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 3
				local var_347_6 = utf8.len(var_347_4)
				local var_347_7 = var_347_5 <= 0 and var_347_1 or var_347_1 * (var_347_6 / var_347_5)

				if var_347_7 > 0 and var_347_1 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_8 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_8 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_8

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_8 and arg_344_1.time_ < var_347_0 + var_347_8 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1109503081 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1109503081
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1109503082(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.625

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_2 = arg_348_1:GetWordFromCfg(1109503081)
				local var_351_3 = arg_348_1:FormatText(var_351_2.content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 25
				local var_351_5 = utf8.len(var_351_3)
				local var_351_6 = var_351_4 <= 0 and var_351_1 or var_351_1 * (var_351_5 / var_351_4)

				if var_351_6 > 0 and var_351_1 < var_351_6 then
					arg_348_1.talkMaxDuration = var_351_6

					if var_351_6 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_6 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_7 and arg_348_1.time_ < var_351_0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1109503082 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1109503082
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1109503083(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 0.15

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[7].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:GetWordFromCfg(1109503082)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 6
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_8 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_8 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_8

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_8 and arg_352_1.time_ < var_355_0 + var_355_8 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1109503083 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1109503083
		arg_356_1.duration_ = 2.3

		local var_356_0 = {
			zh = 1.999999999999,
			ja = 2.3
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1109503084(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["10058ui_story"].transform
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.var_.moveOldPos10058ui_story = var_359_0.localPosition
			end

			local var_359_2 = 0.001

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2
				local var_359_4 = Vector3.New(0, -0.98, -6.1)

				var_359_0.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos10058ui_story, var_359_4, var_359_3)

				local var_359_5 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_5.x, var_359_5.y, var_359_5.z)

				local var_359_6 = var_359_0.localEulerAngles

				var_359_6.z = 0
				var_359_6.x = 0
				var_359_0.localEulerAngles = var_359_6
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 then
				var_359_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_359_7 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_7.x, var_359_7.y, var_359_7.z)

				local var_359_8 = var_359_0.localEulerAngles

				var_359_8.z = 0
				var_359_8.x = 0
				var_359_0.localEulerAngles = var_359_8
			end

			local var_359_9 = arg_356_1.actors_["10058ui_story"]
			local var_359_10 = 0

			if var_359_10 < arg_356_1.time_ and arg_356_1.time_ <= var_359_10 + arg_359_0 and not isNil(var_359_9) and arg_356_1.var_.characterEffect10058ui_story == nil then
				arg_356_1.var_.characterEffect10058ui_story = var_359_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_11 = 0.200000002980232

			if var_359_10 <= arg_356_1.time_ and arg_356_1.time_ < var_359_10 + var_359_11 and not isNil(var_359_9) then
				local var_359_12 = (arg_356_1.time_ - var_359_10) / var_359_11

				if arg_356_1.var_.characterEffect10058ui_story and not isNil(var_359_9) then
					arg_356_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_10 + var_359_11 and arg_356_1.time_ < var_359_10 + var_359_11 + arg_359_0 and not isNil(var_359_9) and arg_356_1.var_.characterEffect10058ui_story then
				arg_356_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_359_13 = 0

			if var_359_13 < arg_356_1.time_ and arg_356_1.time_ <= var_359_13 + arg_359_0 then
				arg_356_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_359_14 = 0

			if var_359_14 < arg_356_1.time_ and arg_356_1.time_ <= var_359_14 + arg_359_0 then
				arg_356_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_359_15 = 0
			local var_359_16 = 0.05

			if var_359_15 < arg_356_1.time_ and arg_356_1.time_ <= var_359_15 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_17 = arg_356_1:FormatText(StoryNameCfg[471].name)

				arg_356_1.leftNameTxt_.text = var_359_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_18 = arg_356_1:GetWordFromCfg(1109503083)
				local var_359_19 = arg_356_1:FormatText(var_359_18.content)

				arg_356_1.text_.text = var_359_19

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_20 = 2
				local var_359_21 = utf8.len(var_359_19)
				local var_359_22 = var_359_20 <= 0 and var_359_16 or var_359_16 * (var_359_21 / var_359_20)

				if var_359_22 > 0 and var_359_16 < var_359_22 then
					arg_356_1.talkMaxDuration = var_359_22

					if var_359_22 + var_359_15 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_22 + var_359_15
					end
				end

				arg_356_1.text_.text = var_359_19
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503083", "story_v_side_new_1109503.awb") ~= 0 then
					local var_359_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503083", "story_v_side_new_1109503.awb") / 1000

					if var_359_23 + var_359_15 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_23 + var_359_15
					end

					if var_359_18.prefab_name ~= "" and arg_356_1.actors_[var_359_18.prefab_name] ~= nil then
						local var_359_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_18.prefab_name].transform, "story_v_side_new_1109503", "1109503083", "story_v_side_new_1109503.awb")

						arg_356_1:RecordAudio("1109503083", var_359_24)
						arg_356_1:RecordAudio("1109503083", var_359_24)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503083", "story_v_side_new_1109503.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503083", "story_v_side_new_1109503.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_25 = math.max(var_359_16, arg_356_1.talkMaxDuration)

			if var_359_15 <= arg_356_1.time_ and arg_356_1.time_ < var_359_15 + var_359_25 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_15) / var_359_25

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_15 + var_359_25 and arg_356_1.time_ < var_359_15 + var_359_25 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play1109503084 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1109503084
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1109503085(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["10058ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10058ui_story == nil then
				arg_360_1.var_.characterEffect10058ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect10058ui_story and not isNil(var_363_0) then
					local var_363_4 = Mathf.Lerp(0, 0.5, var_363_3)

					arg_360_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_360_1.var_.characterEffect10058ui_story.fillRatio = var_363_4
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10058ui_story then
				local var_363_5 = 0.5

				arg_360_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_360_1.var_.characterEffect10058ui_story.fillRatio = var_363_5
			end

			local var_363_6 = 0
			local var_363_7 = 0.45

			if var_363_6 < arg_360_1.time_ and arg_360_1.time_ <= var_363_6 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_8 = arg_360_1:GetWordFromCfg(1109503084)
				local var_363_9 = arg_360_1:FormatText(var_363_8.content)

				arg_360_1.text_.text = var_363_9

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_10 = 18
				local var_363_11 = utf8.len(var_363_9)
				local var_363_12 = var_363_10 <= 0 and var_363_7 or var_363_7 * (var_363_11 / var_363_10)

				if var_363_12 > 0 and var_363_7 < var_363_12 then
					arg_360_1.talkMaxDuration = var_363_12

					if var_363_12 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_12 + var_363_6
					end
				end

				arg_360_1.text_.text = var_363_9
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_13 = math.max(var_363_7, arg_360_1.talkMaxDuration)

			if var_363_6 <= arg_360_1.time_ and arg_360_1.time_ < var_363_6 + var_363_13 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_6) / var_363_13

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_6 + var_363_13 and arg_360_1.time_ < var_363_6 + var_363_13 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1109503085 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1109503085
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1109503086(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["10058ui_story"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10058ui_story == nil then
				arg_364_1.var_.characterEffect10058ui_story = var_367_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.characterEffect10058ui_story and not isNil(var_367_0) then
					local var_367_4 = Mathf.Lerp(0, 0.5, var_367_3)

					arg_364_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_364_1.var_.characterEffect10058ui_story.fillRatio = var_367_4
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10058ui_story then
				local var_367_5 = 0.5

				arg_364_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_364_1.var_.characterEffect10058ui_story.fillRatio = var_367_5
			end

			local var_367_6 = 0
			local var_367_7 = 0.7

			if var_367_6 < arg_364_1.time_ and arg_364_1.time_ <= var_367_6 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_8 = arg_364_1:FormatText(StoryNameCfg[7].name)

				arg_364_1.leftNameTxt_.text = var_367_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_9 = arg_364_1:GetWordFromCfg(1109503085)
				local var_367_10 = arg_364_1:FormatText(var_367_9.content)

				arg_364_1.text_.text = var_367_10

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_11 = 28
				local var_367_12 = utf8.len(var_367_10)
				local var_367_13 = var_367_11 <= 0 and var_367_7 or var_367_7 * (var_367_12 / var_367_11)

				if var_367_13 > 0 and var_367_7 < var_367_13 then
					arg_364_1.talkMaxDuration = var_367_13

					if var_367_13 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_13 + var_367_6
					end
				end

				arg_364_1.text_.text = var_367_10
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_14 = math.max(var_367_7, arg_364_1.talkMaxDuration)

			if var_367_6 <= arg_364_1.time_ and arg_364_1.time_ < var_367_6 + var_367_14 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_6) / var_367_14

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_6 + var_367_14 and arg_364_1.time_ < var_367_6 + var_367_14 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1109503086 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1109503086
		arg_368_1.duration_ = 5.13

		local var_368_0 = {
			zh = 3.666,
			ja = 5.133
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1109503087(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["10058ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10058ui_story == nil then
				arg_368_1.var_.characterEffect10058ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect10058ui_story and not isNil(var_371_0) then
					arg_368_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10058ui_story then
				arg_368_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_371_4 = 0
			local var_371_5 = 0.525

			if var_371_4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_6 = arg_368_1:FormatText(StoryNameCfg[471].name)

				arg_368_1.leftNameTxt_.text = var_371_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_7 = arg_368_1:GetWordFromCfg(1109503086)
				local var_371_8 = arg_368_1:FormatText(var_371_7.content)

				arg_368_1.text_.text = var_371_8

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_9 = 21
				local var_371_10 = utf8.len(var_371_8)
				local var_371_11 = var_371_9 <= 0 and var_371_5 or var_371_5 * (var_371_10 / var_371_9)

				if var_371_11 > 0 and var_371_5 < var_371_11 then
					arg_368_1.talkMaxDuration = var_371_11

					if var_371_11 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_11 + var_371_4
					end
				end

				arg_368_1.text_.text = var_371_8
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503086", "story_v_side_new_1109503.awb") ~= 0 then
					local var_371_12 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503086", "story_v_side_new_1109503.awb") / 1000

					if var_371_12 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_12 + var_371_4
					end

					if var_371_7.prefab_name ~= "" and arg_368_1.actors_[var_371_7.prefab_name] ~= nil then
						local var_371_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_7.prefab_name].transform, "story_v_side_new_1109503", "1109503086", "story_v_side_new_1109503.awb")

						arg_368_1:RecordAudio("1109503086", var_371_13)
						arg_368_1:RecordAudio("1109503086", var_371_13)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503086", "story_v_side_new_1109503.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503086", "story_v_side_new_1109503.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_14 = math.max(var_371_5, arg_368_1.talkMaxDuration)

			if var_371_4 <= arg_368_1.time_ and arg_368_1.time_ < var_371_4 + var_371_14 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_4) / var_371_14

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_4 + var_371_14 and arg_368_1.time_ < var_371_4 + var_371_14 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1109503087 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1109503087
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1109503088(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["10058ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10058ui_story == nil then
				arg_372_1.var_.characterEffect10058ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect10058ui_story and not isNil(var_375_0) then
					local var_375_4 = Mathf.Lerp(0, 0.5, var_375_3)

					arg_372_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_372_1.var_.characterEffect10058ui_story.fillRatio = var_375_4
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10058ui_story then
				local var_375_5 = 0.5

				arg_372_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_372_1.var_.characterEffect10058ui_story.fillRatio = var_375_5
			end

			local var_375_6 = 0
			local var_375_7 = 0.35

			if var_375_6 < arg_372_1.time_ and arg_372_1.time_ <= var_375_6 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_8 = arg_372_1:FormatText(StoryNameCfg[7].name)

				arg_372_1.leftNameTxt_.text = var_375_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_9 = arg_372_1:GetWordFromCfg(1109503087)
				local var_375_10 = arg_372_1:FormatText(var_375_9.content)

				arg_372_1.text_.text = var_375_10

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_11 = 14
				local var_375_12 = utf8.len(var_375_10)
				local var_375_13 = var_375_11 <= 0 and var_375_7 or var_375_7 * (var_375_12 / var_375_11)

				if var_375_13 > 0 and var_375_7 < var_375_13 then
					arg_372_1.talkMaxDuration = var_375_13

					if var_375_13 + var_375_6 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_13 + var_375_6
					end
				end

				arg_372_1.text_.text = var_375_10
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_14 = math.max(var_375_7, arg_372_1.talkMaxDuration)

			if var_375_6 <= arg_372_1.time_ and arg_372_1.time_ < var_375_6 + var_375_14 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_6) / var_375_14

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_6 + var_375_14 and arg_372_1.time_ < var_375_6 + var_375_14 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1109503088 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1109503088
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1109503089(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["10058ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10058ui_story == nil then
				arg_376_1.var_.characterEffect10058ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect10058ui_story and not isNil(var_379_0) then
					local var_379_4 = Mathf.Lerp(0, 0.5, var_379_3)

					arg_376_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_376_1.var_.characterEffect10058ui_story.fillRatio = var_379_4
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10058ui_story then
				local var_379_5 = 0.5

				arg_376_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_376_1.var_.characterEffect10058ui_story.fillRatio = var_379_5
			end

			local var_379_6 = 0
			local var_379_7 = 0.7

			if var_379_6 < arg_376_1.time_ and arg_376_1.time_ <= var_379_6 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_8 = arg_376_1:FormatText(StoryNameCfg[7].name)

				arg_376_1.leftNameTxt_.text = var_379_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_9 = arg_376_1:GetWordFromCfg(1109503088)
				local var_379_10 = arg_376_1:FormatText(var_379_9.content)

				arg_376_1.text_.text = var_379_10

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_11 = 28
				local var_379_12 = utf8.len(var_379_10)
				local var_379_13 = var_379_11 <= 0 and var_379_7 or var_379_7 * (var_379_12 / var_379_11)

				if var_379_13 > 0 and var_379_7 < var_379_13 then
					arg_376_1.talkMaxDuration = var_379_13

					if var_379_13 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_13 + var_379_6
					end
				end

				arg_376_1.text_.text = var_379_10
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_14 = math.max(var_379_7, arg_376_1.talkMaxDuration)

			if var_379_6 <= arg_376_1.time_ and arg_376_1.time_ < var_379_6 + var_379_14 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_6) / var_379_14

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_6 + var_379_14 and arg_376_1.time_ < var_379_6 + var_379_14 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1109503089 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1109503089
		arg_380_1.duration_ = 5.27

		local var_380_0 = {
			zh = 3.4,
			ja = 5.266
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1109503090(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["10058ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect10058ui_story == nil then
				arg_380_1.var_.characterEffect10058ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.200000002980232

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect10058ui_story and not isNil(var_383_0) then
					arg_380_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect10058ui_story then
				arg_380_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_383_4 = 0

			if var_383_4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_383_5 = 0

			if var_383_5 < arg_380_1.time_ and arg_380_1.time_ <= var_383_5 + arg_383_0 then
				arg_380_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_383_6 = 0
			local var_383_7 = 0.25

			if var_383_6 < arg_380_1.time_ and arg_380_1.time_ <= var_383_6 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_8 = arg_380_1:FormatText(StoryNameCfg[471].name)

				arg_380_1.leftNameTxt_.text = var_383_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_9 = arg_380_1:GetWordFromCfg(1109503089)
				local var_383_10 = arg_380_1:FormatText(var_383_9.content)

				arg_380_1.text_.text = var_383_10

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_11 = 10
				local var_383_12 = utf8.len(var_383_10)
				local var_383_13 = var_383_11 <= 0 and var_383_7 or var_383_7 * (var_383_12 / var_383_11)

				if var_383_13 > 0 and var_383_7 < var_383_13 then
					arg_380_1.talkMaxDuration = var_383_13

					if var_383_13 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_13 + var_383_6
					end
				end

				arg_380_1.text_.text = var_383_10
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503089", "story_v_side_new_1109503.awb") ~= 0 then
					local var_383_14 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503089", "story_v_side_new_1109503.awb") / 1000

					if var_383_14 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_14 + var_383_6
					end

					if var_383_9.prefab_name ~= "" and arg_380_1.actors_[var_383_9.prefab_name] ~= nil then
						local var_383_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_9.prefab_name].transform, "story_v_side_new_1109503", "1109503089", "story_v_side_new_1109503.awb")

						arg_380_1:RecordAudio("1109503089", var_383_15)
						arg_380_1:RecordAudio("1109503089", var_383_15)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503089", "story_v_side_new_1109503.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503089", "story_v_side_new_1109503.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_16 = math.max(var_383_7, arg_380_1.talkMaxDuration)

			if var_383_6 <= arg_380_1.time_ and arg_380_1.time_ < var_383_6 + var_383_16 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_6) / var_383_16

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_6 + var_383_16 and arg_380_1.time_ < var_383_6 + var_383_16 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1109503090 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1109503090
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1109503091(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["10058ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10058ui_story == nil then
				arg_384_1.var_.characterEffect10058ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect10058ui_story and not isNil(var_387_0) then
					local var_387_4 = Mathf.Lerp(0, 0.5, var_387_3)

					arg_384_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_384_1.var_.characterEffect10058ui_story.fillRatio = var_387_4
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10058ui_story then
				local var_387_5 = 0.5

				arg_384_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_384_1.var_.characterEffect10058ui_story.fillRatio = var_387_5
			end

			local var_387_6 = 0
			local var_387_7 = 0.175

			if var_387_6 < arg_384_1.time_ and arg_384_1.time_ <= var_387_6 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_8 = arg_384_1:FormatText(StoryNameCfg[7].name)

				arg_384_1.leftNameTxt_.text = var_387_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_9 = arg_384_1:GetWordFromCfg(1109503090)
				local var_387_10 = arg_384_1:FormatText(var_387_9.content)

				arg_384_1.text_.text = var_387_10

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_11 = 7
				local var_387_12 = utf8.len(var_387_10)
				local var_387_13 = var_387_11 <= 0 and var_387_7 or var_387_7 * (var_387_12 / var_387_11)

				if var_387_13 > 0 and var_387_7 < var_387_13 then
					arg_384_1.talkMaxDuration = var_387_13

					if var_387_13 + var_387_6 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_13 + var_387_6
					end
				end

				arg_384_1.text_.text = var_387_10
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_14 = math.max(var_387_7, arg_384_1.talkMaxDuration)

			if var_387_6 <= arg_384_1.time_ and arg_384_1.time_ < var_387_6 + var_387_14 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_6) / var_387_14

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_6 + var_387_14 and arg_384_1.time_ < var_387_6 + var_387_14 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1109503091 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1109503091
		arg_388_1.duration_ = 4.6

		local var_388_0 = {
			zh = 4.233,
			ja = 4.6
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1109503092(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["10058ui_story"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos10058ui_story = var_391_0.localPosition
			end

			local var_391_2 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2
				local var_391_4 = Vector3.New(0, -0.98, -6.1)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10058ui_story, var_391_4, var_391_3)

				local var_391_5 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_5.x, var_391_5.y, var_391_5.z)

				local var_391_6 = var_391_0.localEulerAngles

				var_391_6.z = 0
				var_391_6.x = 0
				var_391_0.localEulerAngles = var_391_6
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_391_7 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_7.x, var_391_7.y, var_391_7.z)

				local var_391_8 = var_391_0.localEulerAngles

				var_391_8.z = 0
				var_391_8.x = 0
				var_391_0.localEulerAngles = var_391_8
			end

			local var_391_9 = arg_388_1.actors_["10058ui_story"]
			local var_391_10 = 0

			if var_391_10 < arg_388_1.time_ and arg_388_1.time_ <= var_391_10 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect10058ui_story == nil then
				arg_388_1.var_.characterEffect10058ui_story = var_391_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_11 = 0.200000002980232

			if var_391_10 <= arg_388_1.time_ and arg_388_1.time_ < var_391_10 + var_391_11 and not isNil(var_391_9) then
				local var_391_12 = (arg_388_1.time_ - var_391_10) / var_391_11

				if arg_388_1.var_.characterEffect10058ui_story and not isNil(var_391_9) then
					arg_388_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_10 + var_391_11 and arg_388_1.time_ < var_391_10 + var_391_11 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect10058ui_story then
				arg_388_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_391_13 = 0
			local var_391_14 = 0.475

			if var_391_13 < arg_388_1.time_ and arg_388_1.time_ <= var_391_13 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_15 = arg_388_1:FormatText(StoryNameCfg[471].name)

				arg_388_1.leftNameTxt_.text = var_391_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_16 = arg_388_1:GetWordFromCfg(1109503091)
				local var_391_17 = arg_388_1:FormatText(var_391_16.content)

				arg_388_1.text_.text = var_391_17

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_18 = 19
				local var_391_19 = utf8.len(var_391_17)
				local var_391_20 = var_391_18 <= 0 and var_391_14 or var_391_14 * (var_391_19 / var_391_18)

				if var_391_20 > 0 and var_391_14 < var_391_20 then
					arg_388_1.talkMaxDuration = var_391_20

					if var_391_20 + var_391_13 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_20 + var_391_13
					end
				end

				arg_388_1.text_.text = var_391_17
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503091", "story_v_side_new_1109503.awb") ~= 0 then
					local var_391_21 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503091", "story_v_side_new_1109503.awb") / 1000

					if var_391_21 + var_391_13 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_21 + var_391_13
					end

					if var_391_16.prefab_name ~= "" and arg_388_1.actors_[var_391_16.prefab_name] ~= nil then
						local var_391_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_16.prefab_name].transform, "story_v_side_new_1109503", "1109503091", "story_v_side_new_1109503.awb")

						arg_388_1:RecordAudio("1109503091", var_391_22)
						arg_388_1:RecordAudio("1109503091", var_391_22)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503091", "story_v_side_new_1109503.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503091", "story_v_side_new_1109503.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_23 = math.max(var_391_14, arg_388_1.talkMaxDuration)

			if var_391_13 <= arg_388_1.time_ and arg_388_1.time_ < var_391_13 + var_391_23 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_13) / var_391_23

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_13 + var_391_23 and arg_388_1.time_ < var_391_13 + var_391_23 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play1109503092 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1109503092
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1109503093(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["10058ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect10058ui_story == nil then
				arg_392_1.var_.characterEffect10058ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect10058ui_story and not isNil(var_395_0) then
					local var_395_4 = Mathf.Lerp(0, 0.5, var_395_3)

					arg_392_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_392_1.var_.characterEffect10058ui_story.fillRatio = var_395_4
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect10058ui_story then
				local var_395_5 = 0.5

				arg_392_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_392_1.var_.characterEffect10058ui_story.fillRatio = var_395_5
			end

			local var_395_6 = 0
			local var_395_7 = 0.05

			if var_395_6 < arg_392_1.time_ and arg_392_1.time_ <= var_395_6 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_8 = arg_392_1:FormatText(StoryNameCfg[7].name)

				arg_392_1.leftNameTxt_.text = var_395_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_9 = arg_392_1:GetWordFromCfg(1109503092)
				local var_395_10 = arg_392_1:FormatText(var_395_9.content)

				arg_392_1.text_.text = var_395_10

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_11 = 2
				local var_395_12 = utf8.len(var_395_10)
				local var_395_13 = var_395_11 <= 0 and var_395_7 or var_395_7 * (var_395_12 / var_395_11)

				if var_395_13 > 0 and var_395_7 < var_395_13 then
					arg_392_1.talkMaxDuration = var_395_13

					if var_395_13 + var_395_6 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_13 + var_395_6
					end
				end

				arg_392_1.text_.text = var_395_10
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_14 = math.max(var_395_7, arg_392_1.talkMaxDuration)

			if var_395_6 <= arg_392_1.time_ and arg_392_1.time_ < var_395_6 + var_395_14 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_6) / var_395_14

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_6 + var_395_14 and arg_392_1.time_ < var_395_6 + var_395_14 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play1109503093 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1109503093
		arg_396_1.duration_ = 6.07

		local var_396_0 = {
			zh = 3.3,
			ja = 6.066
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1109503094(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["10058ui_story"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect10058ui_story == nil then
				arg_396_1.var_.characterEffect10058ui_story = var_399_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.characterEffect10058ui_story and not isNil(var_399_0) then
					arg_396_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect10058ui_story then
				arg_396_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_399_4 = 0

			if var_399_4 < arg_396_1.time_ and arg_396_1.time_ <= var_399_4 + arg_399_0 then
				arg_396_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_399_5 = 0

			if var_399_5 < arg_396_1.time_ and arg_396_1.time_ <= var_399_5 + arg_399_0 then
				arg_396_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_399_6 = 0
			local var_399_7 = 0.275

			if var_399_6 < arg_396_1.time_ and arg_396_1.time_ <= var_399_6 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_8 = arg_396_1:FormatText(StoryNameCfg[471].name)

				arg_396_1.leftNameTxt_.text = var_399_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_9 = arg_396_1:GetWordFromCfg(1109503093)
				local var_399_10 = arg_396_1:FormatText(var_399_9.content)

				arg_396_1.text_.text = var_399_10

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_11 = 11
				local var_399_12 = utf8.len(var_399_10)
				local var_399_13 = var_399_11 <= 0 and var_399_7 or var_399_7 * (var_399_12 / var_399_11)

				if var_399_13 > 0 and var_399_7 < var_399_13 then
					arg_396_1.talkMaxDuration = var_399_13

					if var_399_13 + var_399_6 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_13 + var_399_6
					end
				end

				arg_396_1.text_.text = var_399_10
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503093", "story_v_side_new_1109503.awb") ~= 0 then
					local var_399_14 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503093", "story_v_side_new_1109503.awb") / 1000

					if var_399_14 + var_399_6 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_14 + var_399_6
					end

					if var_399_9.prefab_name ~= "" and arg_396_1.actors_[var_399_9.prefab_name] ~= nil then
						local var_399_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_9.prefab_name].transform, "story_v_side_new_1109503", "1109503093", "story_v_side_new_1109503.awb")

						arg_396_1:RecordAudio("1109503093", var_399_15)
						arg_396_1:RecordAudio("1109503093", var_399_15)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503093", "story_v_side_new_1109503.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503093", "story_v_side_new_1109503.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_16 = math.max(var_399_7, arg_396_1.talkMaxDuration)

			if var_399_6 <= arg_396_1.time_ and arg_396_1.time_ < var_399_6 + var_399_16 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_6) / var_399_16

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_6 + var_399_16 and arg_396_1.time_ < var_399_6 + var_399_16 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play1109503094 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1109503094
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1109503095(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["10058ui_story"].transform
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.var_.moveOldPos10058ui_story = var_403_0.localPosition
			end

			local var_403_2 = 0.001

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2
				local var_403_4 = Vector3.New(0, 100, 0)

				var_403_0.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10058ui_story, var_403_4, var_403_3)

				local var_403_5 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_5.x, var_403_5.y, var_403_5.z)

				local var_403_6 = var_403_0.localEulerAngles

				var_403_6.z = 0
				var_403_6.x = 0
				var_403_0.localEulerAngles = var_403_6
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 then
				var_403_0.localPosition = Vector3.New(0, 100, 0)

				local var_403_7 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_7.x, var_403_7.y, var_403_7.z)

				local var_403_8 = var_403_0.localEulerAngles

				var_403_8.z = 0
				var_403_8.x = 0
				var_403_0.localEulerAngles = var_403_8
			end

			local var_403_9 = 0
			local var_403_10 = 0.6

			if var_403_9 < arg_400_1.time_ and arg_400_1.time_ <= var_403_9 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_11 = arg_400_1:GetWordFromCfg(1109503094)
				local var_403_12 = arg_400_1:FormatText(var_403_11.content)

				arg_400_1.text_.text = var_403_12

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_13 = 24
				local var_403_14 = utf8.len(var_403_12)
				local var_403_15 = var_403_13 <= 0 and var_403_10 or var_403_10 * (var_403_14 / var_403_13)

				if var_403_15 > 0 and var_403_10 < var_403_15 then
					arg_400_1.talkMaxDuration = var_403_15

					if var_403_15 + var_403_9 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_15 + var_403_9
					end
				end

				arg_400_1.text_.text = var_403_12
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_16 = math.max(var_403_10, arg_400_1.talkMaxDuration)

			if var_403_9 <= arg_400_1.time_ and arg_400_1.time_ < var_403_9 + var_403_16 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_9) / var_403_16

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_9 + var_403_16 and arg_400_1.time_ < var_403_9 + var_403_16 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play1109503095 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1109503095
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1109503096(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 1.125

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_2 = arg_404_1:GetWordFromCfg(1109503095)
				local var_407_3 = arg_404_1:FormatText(var_407_2.content)

				arg_404_1.text_.text = var_407_3

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 45
				local var_407_5 = utf8.len(var_407_3)
				local var_407_6 = var_407_4 <= 0 and var_407_1 or var_407_1 * (var_407_5 / var_407_4)

				if var_407_6 > 0 and var_407_1 < var_407_6 then
					arg_404_1.talkMaxDuration = var_407_6

					if var_407_6 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_6 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_3
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_7 and arg_404_1.time_ < var_407_0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play1109503096 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1109503096
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1109503097(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.225

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_2 = arg_408_1:FormatText(StoryNameCfg[7].name)

				arg_408_1.leftNameTxt_.text = var_411_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_3 = arg_408_1:GetWordFromCfg(1109503096)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 9
				local var_411_6 = utf8.len(var_411_4)
				local var_411_7 = var_411_5 <= 0 and var_411_1 or var_411_1 * (var_411_6 / var_411_5)

				if var_411_7 > 0 and var_411_1 < var_411_7 then
					arg_408_1.talkMaxDuration = var_411_7

					if var_411_7 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_8 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_8 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_8

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_8 and arg_408_1.time_ < var_411_0 + var_411_8 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1109503097 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1109503097
		arg_412_1.duration_ = 7.5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1109503098(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.mask_.enabled = true
				arg_412_1.mask_.raycastTarget = true

				arg_412_1:SetGaussion(false)
			end

			local var_415_1 = 1.25

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_1 then
				local var_415_2 = (arg_412_1.time_ - var_415_0) / var_415_1
				local var_415_3 = Color.New(0, 0, 0)

				var_415_3.a = Mathf.Lerp(0, 1, var_415_2)
				arg_412_1.mask_.color = var_415_3
			end

			if arg_412_1.time_ >= var_415_0 + var_415_1 and arg_412_1.time_ < var_415_0 + var_415_1 + arg_415_0 then
				local var_415_4 = Color.New(0, 0, 0)

				var_415_4.a = 1
				arg_412_1.mask_.color = var_415_4
			end

			local var_415_5 = 1.25

			if var_415_5 < arg_412_1.time_ and arg_412_1.time_ <= var_415_5 + arg_415_0 then
				arg_412_1.mask_.enabled = true
				arg_412_1.mask_.raycastTarget = true

				arg_412_1:SetGaussion(false)
			end

			local var_415_6 = 1.25

			if var_415_5 <= arg_412_1.time_ and arg_412_1.time_ < var_415_5 + var_415_6 then
				local var_415_7 = (arg_412_1.time_ - var_415_5) / var_415_6
				local var_415_8 = Color.New(0, 0, 0)

				var_415_8.a = Mathf.Lerp(1, 0, var_415_7)
				arg_412_1.mask_.color = var_415_8
			end

			if arg_412_1.time_ >= var_415_5 + var_415_6 and arg_412_1.time_ < var_415_5 + var_415_6 + arg_415_0 then
				local var_415_9 = Color.New(0, 0, 0)
				local var_415_10 = 0

				arg_412_1.mask_.enabled = false
				var_415_9.a = var_415_10
				arg_412_1.mask_.color = var_415_9
			end

			local var_415_11 = 2.33333333333333
			local var_415_12 = 1

			if var_415_11 < arg_412_1.time_ and arg_412_1.time_ <= var_415_11 + arg_415_0 then
				local var_415_13 = "play"
				local var_415_14 = "effect"

				arg_412_1:AudioAction(var_415_13, var_415_14, "se_story_side_1038", "se_story_1038_cheer02", "")
			end

			if arg_412_1.frameCnt_ <= 1 then
				arg_412_1.dialog_:SetActive(false)
			end

			local var_415_15 = 2.499999999999
			local var_415_16 = 0.95

			if var_415_15 < arg_412_1.time_ and arg_412_1.time_ <= var_415_15 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0

				arg_412_1.dialog_:SetActive(true)

				arg_412_1.dialogCg_.alpha = 0

				local var_415_17 = LeanTween.value(arg_412_1.dialog_, 0, 1, 0.3)

				var_415_17:setOnUpdate(LuaHelper.FloatAction(function(arg_416_0)
					arg_412_1.dialogCg_.alpha = arg_416_0
				end))
				var_415_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_412_1.dialog_)
					var_415_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_412_1.duration_ = arg_412_1.duration_ + 0.3

				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_18 = arg_412_1:GetWordFromCfg(1109503097)
				local var_415_19 = arg_412_1:FormatText(var_415_18.content)

				arg_412_1.text_.text = var_415_19

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_20 = 38
				local var_415_21 = utf8.len(var_415_19)
				local var_415_22 = var_415_20 <= 0 and var_415_16 or var_415_16 * (var_415_21 / var_415_20)

				if var_415_22 > 0 and var_415_16 < var_415_22 then
					arg_412_1.talkMaxDuration = var_415_22
					var_415_15 = var_415_15 + 0.3

					if var_415_22 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_22 + var_415_15
					end
				end

				arg_412_1.text_.text = var_415_19
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_23 = var_415_15 + 0.3
			local var_415_24 = math.max(var_415_16, arg_412_1.talkMaxDuration)

			if var_415_23 <= arg_412_1.time_ and arg_412_1.time_ < var_415_23 + var_415_24 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_23) / var_415_24

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_23 + var_415_24 and arg_412_1.time_ < var_415_23 + var_415_24 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1109503098 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1109503098
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1109503099(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 0.225

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_2 = arg_418_1:FormatText(StoryNameCfg[7].name)

				arg_418_1.leftNameTxt_.text = var_421_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_3 = arg_418_1:GetWordFromCfg(1109503098)
				local var_421_4 = arg_418_1:FormatText(var_421_3.content)

				arg_418_1.text_.text = var_421_4

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 9
				local var_421_6 = utf8.len(var_421_4)
				local var_421_7 = var_421_5 <= 0 and var_421_1 or var_421_1 * (var_421_6 / var_421_5)

				if var_421_7 > 0 and var_421_1 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_4
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_8 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_8 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_8

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_8 and arg_418_1.time_ < var_421_0 + var_421_8 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1109503099 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1109503099
		arg_422_1.duration_ = 2.7

		local var_422_0 = {
			zh = 1.999999999999,
			ja = 2.7
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1109503100(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["10058ui_story"].transform
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.var_.moveOldPos10058ui_story = var_425_0.localPosition
			end

			local var_425_2 = 0.001

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2
				local var_425_4 = Vector3.New(0, -0.98, -6.1)

				var_425_0.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos10058ui_story, var_425_4, var_425_3)

				local var_425_5 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_5.x, var_425_5.y, var_425_5.z)

				local var_425_6 = var_425_0.localEulerAngles

				var_425_6.z = 0
				var_425_6.x = 0
				var_425_0.localEulerAngles = var_425_6
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 then
				var_425_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_425_7 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_7.x, var_425_7.y, var_425_7.z)

				local var_425_8 = var_425_0.localEulerAngles

				var_425_8.z = 0
				var_425_8.x = 0
				var_425_0.localEulerAngles = var_425_8
			end

			local var_425_9 = arg_422_1.actors_["10058ui_story"]
			local var_425_10 = 0

			if var_425_10 < arg_422_1.time_ and arg_422_1.time_ <= var_425_10 + arg_425_0 and not isNil(var_425_9) and arg_422_1.var_.characterEffect10058ui_story == nil then
				arg_422_1.var_.characterEffect10058ui_story = var_425_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_11 = 0.200000002980232

			if var_425_10 <= arg_422_1.time_ and arg_422_1.time_ < var_425_10 + var_425_11 and not isNil(var_425_9) then
				local var_425_12 = (arg_422_1.time_ - var_425_10) / var_425_11

				if arg_422_1.var_.characterEffect10058ui_story and not isNil(var_425_9) then
					arg_422_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= var_425_10 + var_425_11 and arg_422_1.time_ < var_425_10 + var_425_11 + arg_425_0 and not isNil(var_425_9) and arg_422_1.var_.characterEffect10058ui_story then
				arg_422_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_425_13 = 0

			if var_425_13 < arg_422_1.time_ and arg_422_1.time_ <= var_425_13 + arg_425_0 then
				arg_422_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_425_14 = 0

			if var_425_14 < arg_422_1.time_ and arg_422_1.time_ <= var_425_14 + arg_425_0 then
				arg_422_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_425_15 = 0
			local var_425_16 = 0.25

			if var_425_15 < arg_422_1.time_ and arg_422_1.time_ <= var_425_15 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_17 = arg_422_1:FormatText(StoryNameCfg[471].name)

				arg_422_1.leftNameTxt_.text = var_425_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_18 = arg_422_1:GetWordFromCfg(1109503099)
				local var_425_19 = arg_422_1:FormatText(var_425_18.content)

				arg_422_1.text_.text = var_425_19

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_20 = 10
				local var_425_21 = utf8.len(var_425_19)
				local var_425_22 = var_425_20 <= 0 and var_425_16 or var_425_16 * (var_425_21 / var_425_20)

				if var_425_22 > 0 and var_425_16 < var_425_22 then
					arg_422_1.talkMaxDuration = var_425_22

					if var_425_22 + var_425_15 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_22 + var_425_15
					end
				end

				arg_422_1.text_.text = var_425_19
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503099", "story_v_side_new_1109503.awb") ~= 0 then
					local var_425_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503099", "story_v_side_new_1109503.awb") / 1000

					if var_425_23 + var_425_15 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_23 + var_425_15
					end

					if var_425_18.prefab_name ~= "" and arg_422_1.actors_[var_425_18.prefab_name] ~= nil then
						local var_425_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_18.prefab_name].transform, "story_v_side_new_1109503", "1109503099", "story_v_side_new_1109503.awb")

						arg_422_1:RecordAudio("1109503099", var_425_24)
						arg_422_1:RecordAudio("1109503099", var_425_24)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503099", "story_v_side_new_1109503.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503099", "story_v_side_new_1109503.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_25 = math.max(var_425_16, arg_422_1.talkMaxDuration)

			if var_425_15 <= arg_422_1.time_ and arg_422_1.time_ < var_425_15 + var_425_25 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_15) / var_425_25

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_15 + var_425_25 and arg_422_1.time_ < var_425_15 + var_425_25 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play1109503100 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1109503100
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1109503101(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["10058ui_story"]
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect10058ui_story == nil then
				arg_426_1.var_.characterEffect10058ui_story = var_429_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.200000002980232

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 and not isNil(var_429_0) then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2

				if arg_426_1.var_.characterEffect10058ui_story and not isNil(var_429_0) then
					local var_429_4 = Mathf.Lerp(0, 0.5, var_429_3)

					arg_426_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_426_1.var_.characterEffect10058ui_story.fillRatio = var_429_4
				end
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect10058ui_story then
				local var_429_5 = 0.5

				arg_426_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_426_1.var_.characterEffect10058ui_story.fillRatio = var_429_5
			end

			local var_429_6 = 0
			local var_429_7 = 0.275

			if var_429_6 < arg_426_1.time_ and arg_426_1.time_ <= var_429_6 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_8 = arg_426_1:FormatText(StoryNameCfg[7].name)

				arg_426_1.leftNameTxt_.text = var_429_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_9 = arg_426_1:GetWordFromCfg(1109503100)
				local var_429_10 = arg_426_1:FormatText(var_429_9.content)

				arg_426_1.text_.text = var_429_10

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_11 = 11
				local var_429_12 = utf8.len(var_429_10)
				local var_429_13 = var_429_11 <= 0 and var_429_7 or var_429_7 * (var_429_12 / var_429_11)

				if var_429_13 > 0 and var_429_7 < var_429_13 then
					arg_426_1.talkMaxDuration = var_429_13

					if var_429_13 + var_429_6 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_13 + var_429_6
					end
				end

				arg_426_1.text_.text = var_429_10
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_14 = math.max(var_429_7, arg_426_1.talkMaxDuration)

			if var_429_6 <= arg_426_1.time_ and arg_426_1.time_ < var_429_6 + var_429_14 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_6) / var_429_14

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_6 + var_429_14 and arg_426_1.time_ < var_429_6 + var_429_14 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play1109503101 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1109503101
		arg_430_1.duration_ = 6.2

		local var_430_0 = {
			zh = 5.733,
			ja = 6.2
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1109503102(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["10058ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect10058ui_story == nil then
				arg_430_1.var_.characterEffect10058ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect10058ui_story and not isNil(var_433_0) then
					arg_430_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect10058ui_story then
				arg_430_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_433_4 = 0
			local var_433_5 = 0.65

			if var_433_4 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_6 = arg_430_1:FormatText(StoryNameCfg[471].name)

				arg_430_1.leftNameTxt_.text = var_433_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_7 = arg_430_1:GetWordFromCfg(1109503101)
				local var_433_8 = arg_430_1:FormatText(var_433_7.content)

				arg_430_1.text_.text = var_433_8

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_9 = 26
				local var_433_10 = utf8.len(var_433_8)
				local var_433_11 = var_433_9 <= 0 and var_433_5 or var_433_5 * (var_433_10 / var_433_9)

				if var_433_11 > 0 and var_433_5 < var_433_11 then
					arg_430_1.talkMaxDuration = var_433_11

					if var_433_11 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_11 + var_433_4
					end
				end

				arg_430_1.text_.text = var_433_8
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503101", "story_v_side_new_1109503.awb") ~= 0 then
					local var_433_12 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503101", "story_v_side_new_1109503.awb") / 1000

					if var_433_12 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_12 + var_433_4
					end

					if var_433_7.prefab_name ~= "" and arg_430_1.actors_[var_433_7.prefab_name] ~= nil then
						local var_433_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_7.prefab_name].transform, "story_v_side_new_1109503", "1109503101", "story_v_side_new_1109503.awb")

						arg_430_1:RecordAudio("1109503101", var_433_13)
						arg_430_1:RecordAudio("1109503101", var_433_13)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503101", "story_v_side_new_1109503.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503101", "story_v_side_new_1109503.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_14 = math.max(var_433_5, arg_430_1.talkMaxDuration)

			if var_433_4 <= arg_430_1.time_ and arg_430_1.time_ < var_433_4 + var_433_14 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_4) / var_433_14

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_4 + var_433_14 and arg_430_1.time_ < var_433_4 + var_433_14 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1109503102 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1109503102
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1109503103(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["10058ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect10058ui_story == nil then
				arg_434_1.var_.characterEffect10058ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect10058ui_story and not isNil(var_437_0) then
					local var_437_4 = Mathf.Lerp(0, 0.5, var_437_3)

					arg_434_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_434_1.var_.characterEffect10058ui_story.fillRatio = var_437_4
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect10058ui_story then
				local var_437_5 = 0.5

				arg_434_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_434_1.var_.characterEffect10058ui_story.fillRatio = var_437_5
			end

			local var_437_6 = 0
			local var_437_7 = 0.2

			if var_437_6 < arg_434_1.time_ and arg_434_1.time_ <= var_437_6 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_8 = arg_434_1:FormatText(StoryNameCfg[7].name)

				arg_434_1.leftNameTxt_.text = var_437_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_9 = arg_434_1:GetWordFromCfg(1109503102)
				local var_437_10 = arg_434_1:FormatText(var_437_9.content)

				arg_434_1.text_.text = var_437_10

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_11 = 8
				local var_437_12 = utf8.len(var_437_10)
				local var_437_13 = var_437_11 <= 0 and var_437_7 or var_437_7 * (var_437_12 / var_437_11)

				if var_437_13 > 0 and var_437_7 < var_437_13 then
					arg_434_1.talkMaxDuration = var_437_13

					if var_437_13 + var_437_6 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_13 + var_437_6
					end
				end

				arg_434_1.text_.text = var_437_10
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_14 = math.max(var_437_7, arg_434_1.talkMaxDuration)

			if var_437_6 <= arg_434_1.time_ and arg_434_1.time_ < var_437_6 + var_437_14 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_6) / var_437_14

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_6 + var_437_14 and arg_434_1.time_ < var_437_6 + var_437_14 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1109503103 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1109503103
		arg_438_1.duration_ = 5.33

		local var_438_0 = {
			zh = 2.866,
			ja = 5.333
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1109503104(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["10058ui_story"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect10058ui_story == nil then
				arg_438_1.var_.characterEffect10058ui_story = var_441_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.characterEffect10058ui_story and not isNil(var_441_0) then
					arg_438_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect10058ui_story then
				arg_438_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_441_4 = 0
			local var_441_5 = 0.35

			if var_441_4 < arg_438_1.time_ and arg_438_1.time_ <= var_441_4 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_6 = arg_438_1:FormatText(StoryNameCfg[471].name)

				arg_438_1.leftNameTxt_.text = var_441_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_7 = arg_438_1:GetWordFromCfg(1109503103)
				local var_441_8 = arg_438_1:FormatText(var_441_7.content)

				arg_438_1.text_.text = var_441_8

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_9 = 14
				local var_441_10 = utf8.len(var_441_8)
				local var_441_11 = var_441_9 <= 0 and var_441_5 or var_441_5 * (var_441_10 / var_441_9)

				if var_441_11 > 0 and var_441_5 < var_441_11 then
					arg_438_1.talkMaxDuration = var_441_11

					if var_441_11 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_11 + var_441_4
					end
				end

				arg_438_1.text_.text = var_441_8
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503103", "story_v_side_new_1109503.awb") ~= 0 then
					local var_441_12 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503103", "story_v_side_new_1109503.awb") / 1000

					if var_441_12 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_12 + var_441_4
					end

					if var_441_7.prefab_name ~= "" and arg_438_1.actors_[var_441_7.prefab_name] ~= nil then
						local var_441_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_7.prefab_name].transform, "story_v_side_new_1109503", "1109503103", "story_v_side_new_1109503.awb")

						arg_438_1:RecordAudio("1109503103", var_441_13)
						arg_438_1:RecordAudio("1109503103", var_441_13)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503103", "story_v_side_new_1109503.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503103", "story_v_side_new_1109503.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_14 = math.max(var_441_5, arg_438_1.talkMaxDuration)

			if var_441_4 <= arg_438_1.time_ and arg_438_1.time_ < var_441_4 + var_441_14 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_4) / var_441_14

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_4 + var_441_14 and arg_438_1.time_ < var_441_4 + var_441_14 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1109503104 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1109503104
		arg_442_1.duration_ = 12.13

		local var_442_0 = {
			zh = 9.9,
			ja = 12.133
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1109503105(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["10058ui_story"].transform
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.var_.moveOldPos10058ui_story = var_445_0.localPosition
			end

			local var_445_2 = 0.001

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2
				local var_445_4 = Vector3.New(0, 100, 0)

				var_445_0.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos10058ui_story, var_445_4, var_445_3)

				local var_445_5 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_5.x, var_445_5.y, var_445_5.z)

				local var_445_6 = var_445_0.localEulerAngles

				var_445_6.z = 0
				var_445_6.x = 0
				var_445_0.localEulerAngles = var_445_6
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 then
				var_445_0.localPosition = Vector3.New(0, 100, 0)

				local var_445_7 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_7.x, var_445_7.y, var_445_7.z)

				local var_445_8 = var_445_0.localEulerAngles

				var_445_8.z = 0
				var_445_8.x = 0
				var_445_0.localEulerAngles = var_445_8
			end

			local var_445_9 = manager.ui.mainCamera.transform
			local var_445_10 = 0

			if var_445_10 < arg_442_1.time_ and arg_442_1.time_ <= var_445_10 + arg_445_0 then
				arg_442_1.var_.shakeOldPos = var_445_9.localPosition
			end

			local var_445_11 = 0.6

			if var_445_10 <= arg_442_1.time_ and arg_442_1.time_ < var_445_10 + var_445_11 then
				local var_445_12 = (arg_442_1.time_ - var_445_10) / 0.066
				local var_445_13, var_445_14 = math.modf(var_445_12)

				var_445_9.localPosition = Vector3.New(var_445_14 * 0.13, var_445_14 * 0.13, var_445_14 * 0.13) + arg_442_1.var_.shakeOldPos
			end

			if arg_442_1.time_ >= var_445_10 + var_445_11 and arg_442_1.time_ < var_445_10 + var_445_11 + arg_445_0 then
				var_445_9.localPosition = arg_442_1.var_.shakeOldPos
			end

			local var_445_15 = 0

			if var_445_15 < arg_442_1.time_ and arg_442_1.time_ <= var_445_15 + arg_445_0 then
				arg_442_1.allBtn_.enabled = false
			end

			local var_445_16 = 0.6

			if arg_442_1.time_ >= var_445_15 + var_445_16 and arg_442_1.time_ < var_445_15 + var_445_16 + arg_445_0 then
				arg_442_1.allBtn_.enabled = true
			end

			local var_445_17 = 0
			local var_445_18 = 1

			if var_445_17 < arg_442_1.time_ and arg_442_1.time_ <= var_445_17 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_19 = arg_442_1:FormatText(StoryNameCfg[426].name)

				arg_442_1.leftNameTxt_.text = var_445_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_20 = arg_442_1:GetWordFromCfg(1109503104)
				local var_445_21 = arg_442_1:FormatText(var_445_20.content)

				arg_442_1.text_.text = var_445_21

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_22 = 40
				local var_445_23 = utf8.len(var_445_21)
				local var_445_24 = var_445_22 <= 0 and var_445_18 or var_445_18 * (var_445_23 / var_445_22)

				if var_445_24 > 0 and var_445_18 < var_445_24 then
					arg_442_1.talkMaxDuration = var_445_24

					if var_445_24 + var_445_17 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_24 + var_445_17
					end
				end

				arg_442_1.text_.text = var_445_21
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503104", "story_v_side_new_1109503.awb") ~= 0 then
					local var_445_25 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503104", "story_v_side_new_1109503.awb") / 1000

					if var_445_25 + var_445_17 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_25 + var_445_17
					end

					if var_445_20.prefab_name ~= "" and arg_442_1.actors_[var_445_20.prefab_name] ~= nil then
						local var_445_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_20.prefab_name].transform, "story_v_side_new_1109503", "1109503104", "story_v_side_new_1109503.awb")

						arg_442_1:RecordAudio("1109503104", var_445_26)
						arg_442_1:RecordAudio("1109503104", var_445_26)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503104", "story_v_side_new_1109503.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503104", "story_v_side_new_1109503.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_27 = math.max(var_445_18, arg_442_1.talkMaxDuration)

			if var_445_17 <= arg_442_1.time_ and arg_442_1.time_ < var_445_17 + var_445_27 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_17) / var_445_27

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_17 + var_445_27 and arg_442_1.time_ < var_445_17 + var_445_27 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play1109503105 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1109503105
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1109503106(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 1.1

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_2 = arg_446_1:GetWordFromCfg(1109503105)
				local var_449_3 = arg_446_1:FormatText(var_449_2.content)

				arg_446_1.text_.text = var_449_3

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_4 = 44
				local var_449_5 = utf8.len(var_449_3)
				local var_449_6 = var_449_4 <= 0 and var_449_1 or var_449_1 * (var_449_5 / var_449_4)

				if var_449_6 > 0 and var_449_1 < var_449_6 then
					arg_446_1.talkMaxDuration = var_449_6

					if var_449_6 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_6 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_3
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_7 and arg_446_1.time_ < var_449_0 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1109503106 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1109503106
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1109503107(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 0.175

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_2 = arg_450_1:FormatText(StoryNameCfg[7].name)

				arg_450_1.leftNameTxt_.text = var_453_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:GetWordFromCfg(1109503106)
				local var_453_4 = arg_450_1:FormatText(var_453_3.content)

				arg_450_1.text_.text = var_453_4

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 7
				local var_453_6 = utf8.len(var_453_4)
				local var_453_7 = var_453_5 <= 0 and var_453_1 or var_453_1 * (var_453_6 / var_453_5)

				if var_453_7 > 0 and var_453_1 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_4
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_8 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_8 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_8

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_8 and arg_450_1.time_ < var_453_0 + var_453_8 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1109503107 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1109503107
		arg_454_1.duration_ = 6.1

		local var_454_0 = {
			zh = 2.5,
			ja = 6.1
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1109503108(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["10058ui_story"].transform
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 then
				arg_454_1.var_.moveOldPos10058ui_story = var_457_0.localPosition
			end

			local var_457_2 = 0.001

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2
				local var_457_4 = Vector3.New(0, -0.98, -6.1)

				var_457_0.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos10058ui_story, var_457_4, var_457_3)

				local var_457_5 = manager.ui.mainCamera.transform.position - var_457_0.position

				var_457_0.forward = Vector3.New(var_457_5.x, var_457_5.y, var_457_5.z)

				local var_457_6 = var_457_0.localEulerAngles

				var_457_6.z = 0
				var_457_6.x = 0
				var_457_0.localEulerAngles = var_457_6
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 then
				var_457_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_457_7 = manager.ui.mainCamera.transform.position - var_457_0.position

				var_457_0.forward = Vector3.New(var_457_7.x, var_457_7.y, var_457_7.z)

				local var_457_8 = var_457_0.localEulerAngles

				var_457_8.z = 0
				var_457_8.x = 0
				var_457_0.localEulerAngles = var_457_8
			end

			local var_457_9 = arg_454_1.actors_["10058ui_story"]
			local var_457_10 = 0

			if var_457_10 < arg_454_1.time_ and arg_454_1.time_ <= var_457_10 + arg_457_0 and not isNil(var_457_9) and arg_454_1.var_.characterEffect10058ui_story == nil then
				arg_454_1.var_.characterEffect10058ui_story = var_457_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_11 = 0.200000002980232

			if var_457_10 <= arg_454_1.time_ and arg_454_1.time_ < var_457_10 + var_457_11 and not isNil(var_457_9) then
				local var_457_12 = (arg_454_1.time_ - var_457_10) / var_457_11

				if arg_454_1.var_.characterEffect10058ui_story and not isNil(var_457_9) then
					arg_454_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= var_457_10 + var_457_11 and arg_454_1.time_ < var_457_10 + var_457_11 + arg_457_0 and not isNil(var_457_9) and arg_454_1.var_.characterEffect10058ui_story then
				arg_454_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_457_13 = 0

			if var_457_13 < arg_454_1.time_ and arg_454_1.time_ <= var_457_13 + arg_457_0 then
				arg_454_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_457_14 = 0

			if var_457_14 < arg_454_1.time_ and arg_454_1.time_ <= var_457_14 + arg_457_0 then
				arg_454_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_457_15 = 0
			local var_457_16 = 0.3

			if var_457_15 < arg_454_1.time_ and arg_454_1.time_ <= var_457_15 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_17 = arg_454_1:FormatText(StoryNameCfg[471].name)

				arg_454_1.leftNameTxt_.text = var_457_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_18 = arg_454_1:GetWordFromCfg(1109503107)
				local var_457_19 = arg_454_1:FormatText(var_457_18.content)

				arg_454_1.text_.text = var_457_19

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_20 = 12
				local var_457_21 = utf8.len(var_457_19)
				local var_457_22 = var_457_20 <= 0 and var_457_16 or var_457_16 * (var_457_21 / var_457_20)

				if var_457_22 > 0 and var_457_16 < var_457_22 then
					arg_454_1.talkMaxDuration = var_457_22

					if var_457_22 + var_457_15 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_22 + var_457_15
					end
				end

				arg_454_1.text_.text = var_457_19
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503107", "story_v_side_new_1109503.awb") ~= 0 then
					local var_457_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503107", "story_v_side_new_1109503.awb") / 1000

					if var_457_23 + var_457_15 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_23 + var_457_15
					end

					if var_457_18.prefab_name ~= "" and arg_454_1.actors_[var_457_18.prefab_name] ~= nil then
						local var_457_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_18.prefab_name].transform, "story_v_side_new_1109503", "1109503107", "story_v_side_new_1109503.awb")

						arg_454_1:RecordAudio("1109503107", var_457_24)
						arg_454_1:RecordAudio("1109503107", var_457_24)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503107", "story_v_side_new_1109503.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503107", "story_v_side_new_1109503.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_25 = math.max(var_457_16, arg_454_1.talkMaxDuration)

			if var_457_15 <= arg_454_1.time_ and arg_454_1.time_ < var_457_15 + var_457_25 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_15) / var_457_25

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_15 + var_457_25 and arg_454_1.time_ < var_457_15 + var_457_25 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play1109503108 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1109503108
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1109503109(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["10058ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect10058ui_story == nil then
				arg_458_1.var_.characterEffect10058ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect10058ui_story and not isNil(var_461_0) then
					local var_461_4 = Mathf.Lerp(0, 0.5, var_461_3)

					arg_458_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_458_1.var_.characterEffect10058ui_story.fillRatio = var_461_4
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect10058ui_story then
				local var_461_5 = 0.5

				arg_458_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_458_1.var_.characterEffect10058ui_story.fillRatio = var_461_5
			end

			local var_461_6 = 0
			local var_461_7 = 0.275

			if var_461_6 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_8 = arg_458_1:FormatText(StoryNameCfg[7].name)

				arg_458_1.leftNameTxt_.text = var_461_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_9 = arg_458_1:GetWordFromCfg(1109503108)
				local var_461_10 = arg_458_1:FormatText(var_461_9.content)

				arg_458_1.text_.text = var_461_10

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_11 = 11
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
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_14 = math.max(var_461_7, arg_458_1.talkMaxDuration)

			if var_461_6 <= arg_458_1.time_ and arg_458_1.time_ < var_461_6 + var_461_14 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_6) / var_461_14

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_6 + var_461_14 and arg_458_1.time_ < var_461_6 + var_461_14 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1109503109 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1109503109
		arg_462_1.duration_ = 12.1

		local var_462_0 = {
			zh = 5.133,
			ja = 12.1
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1109503110(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["10058ui_story"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect10058ui_story == nil then
				arg_462_1.var_.characterEffect10058ui_story = var_465_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.200000002980232

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.characterEffect10058ui_story and not isNil(var_465_0) then
					arg_462_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect10058ui_story then
				arg_462_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_465_4 = 0

			if var_465_4 < arg_462_1.time_ and arg_462_1.time_ <= var_465_4 + arg_465_0 then
				arg_462_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_465_5 = 0
			local var_465_6 = 0.625

			if var_465_5 < arg_462_1.time_ and arg_462_1.time_ <= var_465_5 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_7 = arg_462_1:FormatText(StoryNameCfg[471].name)

				arg_462_1.leftNameTxt_.text = var_465_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_8 = arg_462_1:GetWordFromCfg(1109503109)
				local var_465_9 = arg_462_1:FormatText(var_465_8.content)

				arg_462_1.text_.text = var_465_9

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_10 = 25
				local var_465_11 = utf8.len(var_465_9)
				local var_465_12 = var_465_10 <= 0 and var_465_6 or var_465_6 * (var_465_11 / var_465_10)

				if var_465_12 > 0 and var_465_6 < var_465_12 then
					arg_462_1.talkMaxDuration = var_465_12

					if var_465_12 + var_465_5 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_12 + var_465_5
					end
				end

				arg_462_1.text_.text = var_465_9
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503109", "story_v_side_new_1109503.awb") ~= 0 then
					local var_465_13 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503109", "story_v_side_new_1109503.awb") / 1000

					if var_465_13 + var_465_5 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_13 + var_465_5
					end

					if var_465_8.prefab_name ~= "" and arg_462_1.actors_[var_465_8.prefab_name] ~= nil then
						local var_465_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_8.prefab_name].transform, "story_v_side_new_1109503", "1109503109", "story_v_side_new_1109503.awb")

						arg_462_1:RecordAudio("1109503109", var_465_14)
						arg_462_1:RecordAudio("1109503109", var_465_14)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503109", "story_v_side_new_1109503.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503109", "story_v_side_new_1109503.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_15 = math.max(var_465_6, arg_462_1.talkMaxDuration)

			if var_465_5 <= arg_462_1.time_ and arg_462_1.time_ < var_465_5 + var_465_15 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_5) / var_465_15

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_5 + var_465_15 and arg_462_1.time_ < var_465_5 + var_465_15 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play1109503110 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1109503110
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1109503111(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["10058ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect10058ui_story == nil then
				arg_466_1.var_.characterEffect10058ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect10058ui_story and not isNil(var_469_0) then
					local var_469_4 = Mathf.Lerp(0, 0.5, var_469_3)

					arg_466_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_466_1.var_.characterEffect10058ui_story.fillRatio = var_469_4
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect10058ui_story then
				local var_469_5 = 0.5

				arg_466_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_466_1.var_.characterEffect10058ui_story.fillRatio = var_469_5
			end

			local var_469_6 = 0
			local var_469_7 = 0.075

			if var_469_6 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_8 = arg_466_1:FormatText(StoryNameCfg[7].name)

				arg_466_1.leftNameTxt_.text = var_469_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_9 = arg_466_1:GetWordFromCfg(1109503110)
				local var_469_10 = arg_466_1:FormatText(var_469_9.content)

				arg_466_1.text_.text = var_469_10

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_11 = 3
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
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_14 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_14 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_14

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_14 and arg_466_1.time_ < var_469_6 + var_469_14 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1109503111 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1109503111
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1109503112(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["10058ui_story"].transform
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.var_.moveOldPos10058ui_story = var_473_0.localPosition
			end

			local var_473_2 = 0.001

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2
				local var_473_4 = Vector3.New(0, 100, 0)

				var_473_0.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos10058ui_story, var_473_4, var_473_3)

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

			local var_473_9 = 0
			local var_473_10 = 1.225

			if var_473_9 < arg_470_1.time_ and arg_470_1.time_ <= var_473_9 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_11 = arg_470_1:GetWordFromCfg(1109503111)
				local var_473_12 = arg_470_1:FormatText(var_473_11.content)

				arg_470_1.text_.text = var_473_12

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_13 = 49
				local var_473_14 = utf8.len(var_473_12)
				local var_473_15 = var_473_13 <= 0 and var_473_10 or var_473_10 * (var_473_14 / var_473_13)

				if var_473_15 > 0 and var_473_10 < var_473_15 then
					arg_470_1.talkMaxDuration = var_473_15

					if var_473_15 + var_473_9 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_15 + var_473_9
					end
				end

				arg_470_1.text_.text = var_473_12
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_16 = math.max(var_473_10, arg_470_1.talkMaxDuration)

			if var_473_9 <= arg_470_1.time_ and arg_470_1.time_ < var_473_9 + var_473_16 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_9) / var_473_16

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_9 + var_473_16 and arg_470_1.time_ < var_473_9 + var_473_16 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play1109503112 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1109503112
		arg_474_1.duration_ = 2

		local var_474_0 = {
			zh = 2,
			ja = 1.999999999999
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1109503113(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["10058ui_story"].transform
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.var_.moveOldPos10058ui_story = var_477_0.localPosition
			end

			local var_477_2 = 0.001

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2
				local var_477_4 = Vector3.New(0, -0.98, -6.1)

				var_477_0.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos10058ui_story, var_477_4, var_477_3)

				local var_477_5 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_5.x, var_477_5.y, var_477_5.z)

				local var_477_6 = var_477_0.localEulerAngles

				var_477_6.z = 0
				var_477_6.x = 0
				var_477_0.localEulerAngles = var_477_6
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 then
				var_477_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_477_7 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_7.x, var_477_7.y, var_477_7.z)

				local var_477_8 = var_477_0.localEulerAngles

				var_477_8.z = 0
				var_477_8.x = 0
				var_477_0.localEulerAngles = var_477_8
			end

			local var_477_9 = arg_474_1.actors_["10058ui_story"]
			local var_477_10 = 0

			if var_477_10 < arg_474_1.time_ and arg_474_1.time_ <= var_477_10 + arg_477_0 and not isNil(var_477_9) and arg_474_1.var_.characterEffect10058ui_story == nil then
				arg_474_1.var_.characterEffect10058ui_story = var_477_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_11 = 0.200000002980232

			if var_477_10 <= arg_474_1.time_ and arg_474_1.time_ < var_477_10 + var_477_11 and not isNil(var_477_9) then
				local var_477_12 = (arg_474_1.time_ - var_477_10) / var_477_11

				if arg_474_1.var_.characterEffect10058ui_story and not isNil(var_477_9) then
					arg_474_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= var_477_10 + var_477_11 and arg_474_1.time_ < var_477_10 + var_477_11 + arg_477_0 and not isNil(var_477_9) and arg_474_1.var_.characterEffect10058ui_story then
				arg_474_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_477_13 = 0

			if var_477_13 < arg_474_1.time_ and arg_474_1.time_ <= var_477_13 + arg_477_0 then
				arg_474_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_477_14 = 0

			if var_477_14 < arg_474_1.time_ and arg_474_1.time_ <= var_477_14 + arg_477_0 then
				arg_474_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_477_15 = 0
			local var_477_16 = 0.15

			if var_477_15 < arg_474_1.time_ and arg_474_1.time_ <= var_477_15 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_17 = arg_474_1:FormatText(StoryNameCfg[471].name)

				arg_474_1.leftNameTxt_.text = var_477_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_18 = arg_474_1:GetWordFromCfg(1109503112)
				local var_477_19 = arg_474_1:FormatText(var_477_18.content)

				arg_474_1.text_.text = var_477_19

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_20 = 6
				local var_477_21 = utf8.len(var_477_19)
				local var_477_22 = var_477_20 <= 0 and var_477_16 or var_477_16 * (var_477_21 / var_477_20)

				if var_477_22 > 0 and var_477_16 < var_477_22 then
					arg_474_1.talkMaxDuration = var_477_22

					if var_477_22 + var_477_15 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_22 + var_477_15
					end
				end

				arg_474_1.text_.text = var_477_19
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503112", "story_v_side_new_1109503.awb") ~= 0 then
					local var_477_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503112", "story_v_side_new_1109503.awb") / 1000

					if var_477_23 + var_477_15 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_23 + var_477_15
					end

					if var_477_18.prefab_name ~= "" and arg_474_1.actors_[var_477_18.prefab_name] ~= nil then
						local var_477_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_18.prefab_name].transform, "story_v_side_new_1109503", "1109503112", "story_v_side_new_1109503.awb")

						arg_474_1:RecordAudio("1109503112", var_477_24)
						arg_474_1:RecordAudio("1109503112", var_477_24)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503112", "story_v_side_new_1109503.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503112", "story_v_side_new_1109503.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_25 = math.max(var_477_16, arg_474_1.talkMaxDuration)

			if var_477_15 <= arg_474_1.time_ and arg_474_1.time_ < var_477_15 + var_477_25 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_15) / var_477_25

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_15 + var_477_25 and arg_474_1.time_ < var_477_15 + var_477_25 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109503113 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1109503113
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1109503114(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = arg_478_1.actors_["10058ui_story"]
			local var_481_1 = 0

			if var_481_1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect10058ui_story == nil then
				arg_478_1.var_.characterEffect10058ui_story = var_481_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_2 = 0.200000002980232

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_2 and not isNil(var_481_0) then
				local var_481_3 = (arg_478_1.time_ - var_481_1) / var_481_2

				if arg_478_1.var_.characterEffect10058ui_story and not isNil(var_481_0) then
					local var_481_4 = Mathf.Lerp(0, 0.5, var_481_3)

					arg_478_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_478_1.var_.characterEffect10058ui_story.fillRatio = var_481_4
				end
			end

			if arg_478_1.time_ >= var_481_1 + var_481_2 and arg_478_1.time_ < var_481_1 + var_481_2 + arg_481_0 and not isNil(var_481_0) and arg_478_1.var_.characterEffect10058ui_story then
				local var_481_5 = 0.5

				arg_478_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_478_1.var_.characterEffect10058ui_story.fillRatio = var_481_5
			end

			local var_481_6 = 0
			local var_481_7 = 0.6

			if var_481_6 < arg_478_1.time_ and arg_478_1.time_ <= var_481_6 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_8 = arg_478_1:GetWordFromCfg(1109503113)
				local var_481_9 = arg_478_1:FormatText(var_481_8.content)

				arg_478_1.text_.text = var_481_9

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_10 = 24
				local var_481_11 = utf8.len(var_481_9)
				local var_481_12 = var_481_10 <= 0 and var_481_7 or var_481_7 * (var_481_11 / var_481_10)

				if var_481_12 > 0 and var_481_7 < var_481_12 then
					arg_478_1.talkMaxDuration = var_481_12

					if var_481_12 + var_481_6 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_12 + var_481_6
					end
				end

				arg_478_1.text_.text = var_481_9
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_13 = math.max(var_481_7, arg_478_1.talkMaxDuration)

			if var_481_6 <= arg_478_1.time_ and arg_478_1.time_ < var_481_6 + var_481_13 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_6) / var_481_13

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_6 + var_481_13 and arg_478_1.time_ < var_481_6 + var_481_13 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play1109503114 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1109503114
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1109503115(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.175

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[7].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_3 = arg_482_1:GetWordFromCfg(1109503114)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 7
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_8 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_8 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_8

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_8 and arg_482_1.time_ < var_485_0 + var_485_8 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1109503115 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1109503115
		arg_486_1.duration_ = 2.27

		local var_486_0 = {
			zh = 2.266,
			ja = 1.333
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1109503116(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["10058ui_story"]
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect10058ui_story == nil then
				arg_486_1.var_.characterEffect10058ui_story = var_489_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_2 = 0.200000002980232

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 and not isNil(var_489_0) then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2

				if arg_486_1.var_.characterEffect10058ui_story and not isNil(var_489_0) then
					arg_486_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect10058ui_story then
				arg_486_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_489_4 = 0
			local var_489_5 = 0.225

			if var_489_4 < arg_486_1.time_ and arg_486_1.time_ <= var_489_4 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_6 = arg_486_1:FormatText(StoryNameCfg[471].name)

				arg_486_1.leftNameTxt_.text = var_489_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_7 = arg_486_1:GetWordFromCfg(1109503115)
				local var_489_8 = arg_486_1:FormatText(var_489_7.content)

				arg_486_1.text_.text = var_489_8

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_9 = 9
				local var_489_10 = utf8.len(var_489_8)
				local var_489_11 = var_489_9 <= 0 and var_489_5 or var_489_5 * (var_489_10 / var_489_9)

				if var_489_11 > 0 and var_489_5 < var_489_11 then
					arg_486_1.talkMaxDuration = var_489_11

					if var_489_11 + var_489_4 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_11 + var_489_4
					end
				end

				arg_486_1.text_.text = var_489_8
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503115", "story_v_side_new_1109503.awb") ~= 0 then
					local var_489_12 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503115", "story_v_side_new_1109503.awb") / 1000

					if var_489_12 + var_489_4 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_12 + var_489_4
					end

					if var_489_7.prefab_name ~= "" and arg_486_1.actors_[var_489_7.prefab_name] ~= nil then
						local var_489_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_7.prefab_name].transform, "story_v_side_new_1109503", "1109503115", "story_v_side_new_1109503.awb")

						arg_486_1:RecordAudio("1109503115", var_489_13)
						arg_486_1:RecordAudio("1109503115", var_489_13)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503115", "story_v_side_new_1109503.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503115", "story_v_side_new_1109503.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_14 = math.max(var_489_5, arg_486_1.talkMaxDuration)

			if var_489_4 <= arg_486_1.time_ and arg_486_1.time_ < var_489_4 + var_489_14 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_4) / var_489_14

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_4 + var_489_14 and arg_486_1.time_ < var_489_4 + var_489_14 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1109503116 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1109503116
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1109503117(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["10058ui_story"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect10058ui_story == nil then
				arg_490_1.var_.characterEffect10058ui_story = var_493_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_2 = 0.200000002980232

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.characterEffect10058ui_story and not isNil(var_493_0) then
					local var_493_4 = Mathf.Lerp(0, 0.5, var_493_3)

					arg_490_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_490_1.var_.characterEffect10058ui_story.fillRatio = var_493_4
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect10058ui_story then
				local var_493_5 = 0.5

				arg_490_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_490_1.var_.characterEffect10058ui_story.fillRatio = var_493_5
			end

			local var_493_6 = 0
			local var_493_7 = 0.325

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

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_9 = arg_490_1:GetWordFromCfg(1109503116)
				local var_493_10 = arg_490_1:FormatText(var_493_9.content)

				arg_490_1.text_.text = var_493_10

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_11 = 13
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
	Play1109503117 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1109503117
		arg_494_1.duration_ = 4.9

		local var_494_0 = {
			zh = 1.999999999999,
			ja = 4.9
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1109503118(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["10058ui_story"].transform
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.var_.moveOldPos10058ui_story = var_497_0.localPosition
			end

			local var_497_2 = 0.001

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2
				local var_497_4 = Vector3.New(0, -0.98, -6.1)

				var_497_0.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos10058ui_story, var_497_4, var_497_3)

				local var_497_5 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_5.x, var_497_5.y, var_497_5.z)

				local var_497_6 = var_497_0.localEulerAngles

				var_497_6.z = 0
				var_497_6.x = 0
				var_497_0.localEulerAngles = var_497_6
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 then
				var_497_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_497_7 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_7.x, var_497_7.y, var_497_7.z)

				local var_497_8 = var_497_0.localEulerAngles

				var_497_8.z = 0
				var_497_8.x = 0
				var_497_0.localEulerAngles = var_497_8
			end

			local var_497_9 = arg_494_1.actors_["10058ui_story"]
			local var_497_10 = 0

			if var_497_10 < arg_494_1.time_ and arg_494_1.time_ <= var_497_10 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect10058ui_story == nil then
				arg_494_1.var_.characterEffect10058ui_story = var_497_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_11 = 0.200000002980232

			if var_497_10 <= arg_494_1.time_ and arg_494_1.time_ < var_497_10 + var_497_11 and not isNil(var_497_9) then
				local var_497_12 = (arg_494_1.time_ - var_497_10) / var_497_11

				if arg_494_1.var_.characterEffect10058ui_story and not isNil(var_497_9) then
					arg_494_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= var_497_10 + var_497_11 and arg_494_1.time_ < var_497_10 + var_497_11 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect10058ui_story then
				arg_494_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_497_13 = 0

			if var_497_13 < arg_494_1.time_ and arg_494_1.time_ <= var_497_13 + arg_497_0 then
				arg_494_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_497_14 = 0
			local var_497_15 = 0.2

			if var_497_14 < arg_494_1.time_ and arg_494_1.time_ <= var_497_14 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_16 = arg_494_1:FormatText(StoryNameCfg[471].name)

				arg_494_1.leftNameTxt_.text = var_497_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_17 = arg_494_1:GetWordFromCfg(1109503117)
				local var_497_18 = arg_494_1:FormatText(var_497_17.content)

				arg_494_1.text_.text = var_497_18

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_19 = 8
				local var_497_20 = utf8.len(var_497_18)
				local var_497_21 = var_497_19 <= 0 and var_497_15 or var_497_15 * (var_497_20 / var_497_19)

				if var_497_21 > 0 and var_497_15 < var_497_21 then
					arg_494_1.talkMaxDuration = var_497_21

					if var_497_21 + var_497_14 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_21 + var_497_14
					end
				end

				arg_494_1.text_.text = var_497_18
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503117", "story_v_side_new_1109503.awb") ~= 0 then
					local var_497_22 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503117", "story_v_side_new_1109503.awb") / 1000

					if var_497_22 + var_497_14 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_22 + var_497_14
					end

					if var_497_17.prefab_name ~= "" and arg_494_1.actors_[var_497_17.prefab_name] ~= nil then
						local var_497_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_17.prefab_name].transform, "story_v_side_new_1109503", "1109503117", "story_v_side_new_1109503.awb")

						arg_494_1:RecordAudio("1109503117", var_497_23)
						arg_494_1:RecordAudio("1109503117", var_497_23)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503117", "story_v_side_new_1109503.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503117", "story_v_side_new_1109503.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_24 = math.max(var_497_15, arg_494_1.talkMaxDuration)

			if var_497_14 <= arg_494_1.time_ and arg_494_1.time_ < var_497_14 + var_497_24 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_14) / var_497_24

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_14 + var_497_24 and arg_494_1.time_ < var_497_14 + var_497_24 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play1109503118 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1109503118
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1109503119(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["10058ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect10058ui_story == nil then
				arg_498_1.var_.characterEffect10058ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect10058ui_story and not isNil(var_501_0) then
					local var_501_4 = Mathf.Lerp(0, 0.5, var_501_3)

					arg_498_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_498_1.var_.characterEffect10058ui_story.fillRatio = var_501_4
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect10058ui_story then
				local var_501_5 = 0.5

				arg_498_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_498_1.var_.characterEffect10058ui_story.fillRatio = var_501_5
			end

			local var_501_6 = 0
			local var_501_7 = 0.75

			if var_501_6 < arg_498_1.time_ and arg_498_1.time_ <= var_501_6 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, false)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_8 = arg_498_1:GetWordFromCfg(1109503118)
				local var_501_9 = arg_498_1:FormatText(var_501_8.content)

				arg_498_1.text_.text = var_501_9

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_10 = 30
				local var_501_11 = utf8.len(var_501_9)
				local var_501_12 = var_501_10 <= 0 and var_501_7 or var_501_7 * (var_501_11 / var_501_10)

				if var_501_12 > 0 and var_501_7 < var_501_12 then
					arg_498_1.talkMaxDuration = var_501_12

					if var_501_12 + var_501_6 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_12 + var_501_6
					end
				end

				arg_498_1.text_.text = var_501_9
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_13 = math.max(var_501_7, arg_498_1.talkMaxDuration)

			if var_501_6 <= arg_498_1.time_ and arg_498_1.time_ < var_501_6 + var_501_13 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_6) / var_501_13

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_6 + var_501_13 and arg_498_1.time_ < var_501_6 + var_501_13 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1109503119 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1109503119
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1109503120(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0
			local var_505_1 = 0.1

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_2 = arg_502_1:FormatText(StoryNameCfg[7].name)

				arg_502_1.leftNameTxt_.text = var_505_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_3 = arg_502_1:GetWordFromCfg(1109503119)
				local var_505_4 = arg_502_1:FormatText(var_505_3.content)

				arg_502_1.text_.text = var_505_4

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 4
				local var_505_6 = utf8.len(var_505_4)
				local var_505_7 = var_505_5 <= 0 and var_505_1 or var_505_1 * (var_505_6 / var_505_5)

				if var_505_7 > 0 and var_505_1 < var_505_7 then
					arg_502_1.talkMaxDuration = var_505_7

					if var_505_7 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_7 + var_505_0
					end
				end

				arg_502_1.text_.text = var_505_4
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_8 = math.max(var_505_1, arg_502_1.talkMaxDuration)

			if var_505_0 <= arg_502_1.time_ and arg_502_1.time_ < var_505_0 + var_505_8 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_0) / var_505_8

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_0 + var_505_8 and arg_502_1.time_ < var_505_0 + var_505_8 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play1109503120 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1109503120
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1109503121(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0
			local var_509_1 = 0.65

			if var_509_0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_2 = arg_506_1:FormatText(StoryNameCfg[7].name)

				arg_506_1.leftNameTxt_.text = var_509_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_3 = arg_506_1:GetWordFromCfg(1109503120)
				local var_509_4 = arg_506_1:FormatText(var_509_3.content)

				arg_506_1.text_.text = var_509_4

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 26
				local var_509_6 = utf8.len(var_509_4)
				local var_509_7 = var_509_5 <= 0 and var_509_1 or var_509_1 * (var_509_6 / var_509_5)

				if var_509_7 > 0 and var_509_1 < var_509_7 then
					arg_506_1.talkMaxDuration = var_509_7

					if var_509_7 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_7 + var_509_0
					end
				end

				arg_506_1.text_.text = var_509_4
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_8 = math.max(var_509_1, arg_506_1.talkMaxDuration)

			if var_509_0 <= arg_506_1.time_ and arg_506_1.time_ < var_509_0 + var_509_8 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_0) / var_509_8

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_0 + var_509_8 and arg_506_1.time_ < var_509_0 + var_509_8 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1109503121 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1109503121
		arg_510_1.duration_ = 7.83

		local var_510_0 = {
			zh = 2.866,
			ja = 7.833
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1109503122(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["10058ui_story"].transform
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.var_.moveOldPos10058ui_story = var_513_0.localPosition
			end

			local var_513_2 = 0.001

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2
				local var_513_4 = Vector3.New(0, -0.98, -6.1)

				var_513_0.localPosition = Vector3.Lerp(arg_510_1.var_.moveOldPos10058ui_story, var_513_4, var_513_3)

				local var_513_5 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_5.x, var_513_5.y, var_513_5.z)

				local var_513_6 = var_513_0.localEulerAngles

				var_513_6.z = 0
				var_513_6.x = 0
				var_513_0.localEulerAngles = var_513_6
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 then
				var_513_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_513_7 = manager.ui.mainCamera.transform.position - var_513_0.position

				var_513_0.forward = Vector3.New(var_513_7.x, var_513_7.y, var_513_7.z)

				local var_513_8 = var_513_0.localEulerAngles

				var_513_8.z = 0
				var_513_8.x = 0
				var_513_0.localEulerAngles = var_513_8
			end

			local var_513_9 = arg_510_1.actors_["10058ui_story"]
			local var_513_10 = 0

			if var_513_10 < arg_510_1.time_ and arg_510_1.time_ <= var_513_10 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect10058ui_story == nil then
				arg_510_1.var_.characterEffect10058ui_story = var_513_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_11 = 0.200000002980232

			if var_513_10 <= arg_510_1.time_ and arg_510_1.time_ < var_513_10 + var_513_11 and not isNil(var_513_9) then
				local var_513_12 = (arg_510_1.time_ - var_513_10) / var_513_11

				if arg_510_1.var_.characterEffect10058ui_story and not isNil(var_513_9) then
					arg_510_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= var_513_10 + var_513_11 and arg_510_1.time_ < var_513_10 + var_513_11 + arg_513_0 and not isNil(var_513_9) and arg_510_1.var_.characterEffect10058ui_story then
				arg_510_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_513_13 = 0

			if var_513_13 < arg_510_1.time_ and arg_510_1.time_ <= var_513_13 + arg_513_0 then
				arg_510_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_513_14 = 0
			local var_513_15 = 0.35

			if var_513_14 < arg_510_1.time_ and arg_510_1.time_ <= var_513_14 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_16 = arg_510_1:FormatText(StoryNameCfg[471].name)

				arg_510_1.leftNameTxt_.text = var_513_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_17 = arg_510_1:GetWordFromCfg(1109503121)
				local var_513_18 = arg_510_1:FormatText(var_513_17.content)

				arg_510_1.text_.text = var_513_18

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_19 = 14
				local var_513_20 = utf8.len(var_513_18)
				local var_513_21 = var_513_19 <= 0 and var_513_15 or var_513_15 * (var_513_20 / var_513_19)

				if var_513_21 > 0 and var_513_15 < var_513_21 then
					arg_510_1.talkMaxDuration = var_513_21

					if var_513_21 + var_513_14 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_21 + var_513_14
					end
				end

				arg_510_1.text_.text = var_513_18
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503121", "story_v_side_new_1109503.awb") ~= 0 then
					local var_513_22 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503121", "story_v_side_new_1109503.awb") / 1000

					if var_513_22 + var_513_14 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_22 + var_513_14
					end

					if var_513_17.prefab_name ~= "" and arg_510_1.actors_[var_513_17.prefab_name] ~= nil then
						local var_513_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_17.prefab_name].transform, "story_v_side_new_1109503", "1109503121", "story_v_side_new_1109503.awb")

						arg_510_1:RecordAudio("1109503121", var_513_23)
						arg_510_1:RecordAudio("1109503121", var_513_23)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503121", "story_v_side_new_1109503.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503121", "story_v_side_new_1109503.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_24 = math.max(var_513_15, arg_510_1.talkMaxDuration)

			if var_513_14 <= arg_510_1.time_ and arg_510_1.time_ < var_513_14 + var_513_24 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_14) / var_513_24

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_14 + var_513_24 and arg_510_1.time_ < var_513_14 + var_513_24 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_510_1:InitPlayNodeList()
	end,
	Play1109503122 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1109503122
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1109503123(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["10058ui_story"]
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect10058ui_story == nil then
				arg_514_1.var_.characterEffect10058ui_story = var_517_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 and not isNil(var_517_0) then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2

				if arg_514_1.var_.characterEffect10058ui_story and not isNil(var_517_0) then
					local var_517_4 = Mathf.Lerp(0, 0.5, var_517_3)

					arg_514_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_514_1.var_.characterEffect10058ui_story.fillRatio = var_517_4
				end
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect10058ui_story then
				local var_517_5 = 0.5

				arg_514_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_514_1.var_.characterEffect10058ui_story.fillRatio = var_517_5
			end

			local var_517_6 = 0
			local var_517_7 = 0.2

			if var_517_6 < arg_514_1.time_ and arg_514_1.time_ <= var_517_6 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_8 = arg_514_1:FormatText(StoryNameCfg[7].name)

				arg_514_1.leftNameTxt_.text = var_517_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_9 = arg_514_1:GetWordFromCfg(1109503122)
				local var_517_10 = arg_514_1:FormatText(var_517_9.content)

				arg_514_1.text_.text = var_517_10

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_11 = 8
				local var_517_12 = utf8.len(var_517_10)
				local var_517_13 = var_517_11 <= 0 and var_517_7 or var_517_7 * (var_517_12 / var_517_11)

				if var_517_13 > 0 and var_517_7 < var_517_13 then
					arg_514_1.talkMaxDuration = var_517_13

					if var_517_13 + var_517_6 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_13 + var_517_6
					end
				end

				arg_514_1.text_.text = var_517_10
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_14 = math.max(var_517_7, arg_514_1.talkMaxDuration)

			if var_517_6 <= arg_514_1.time_ and arg_514_1.time_ < var_517_6 + var_517_14 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_6) / var_517_14

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_6 + var_517_14 and arg_514_1.time_ < var_517_6 + var_517_14 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play1109503123 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 1109503123
		arg_518_1.duration_ = 15.77

		local var_518_0 = {
			zh = 7.6,
			ja = 15.766
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play1109503124(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["10058ui_story"].transform
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.var_.moveOldPos10058ui_story = var_521_0.localPosition
			end

			local var_521_2 = 0.001

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2
				local var_521_4 = Vector3.New(0, -0.98, -6.1)

				var_521_0.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos10058ui_story, var_521_4, var_521_3)

				local var_521_5 = manager.ui.mainCamera.transform.position - var_521_0.position

				var_521_0.forward = Vector3.New(var_521_5.x, var_521_5.y, var_521_5.z)

				local var_521_6 = var_521_0.localEulerAngles

				var_521_6.z = 0
				var_521_6.x = 0
				var_521_0.localEulerAngles = var_521_6
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 then
				var_521_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_521_7 = manager.ui.mainCamera.transform.position - var_521_0.position

				var_521_0.forward = Vector3.New(var_521_7.x, var_521_7.y, var_521_7.z)

				local var_521_8 = var_521_0.localEulerAngles

				var_521_8.z = 0
				var_521_8.x = 0
				var_521_0.localEulerAngles = var_521_8
			end

			local var_521_9 = arg_518_1.actors_["10058ui_story"]
			local var_521_10 = 0

			if var_521_10 < arg_518_1.time_ and arg_518_1.time_ <= var_521_10 + arg_521_0 and not isNil(var_521_9) and arg_518_1.var_.characterEffect10058ui_story == nil then
				arg_518_1.var_.characterEffect10058ui_story = var_521_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_11 = 0.200000002980232

			if var_521_10 <= arg_518_1.time_ and arg_518_1.time_ < var_521_10 + var_521_11 and not isNil(var_521_9) then
				local var_521_12 = (arg_518_1.time_ - var_521_10) / var_521_11

				if arg_518_1.var_.characterEffect10058ui_story and not isNil(var_521_9) then
					arg_518_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= var_521_10 + var_521_11 and arg_518_1.time_ < var_521_10 + var_521_11 + arg_521_0 and not isNil(var_521_9) and arg_518_1.var_.characterEffect10058ui_story then
				arg_518_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_521_13 = 0

			if var_521_13 < arg_518_1.time_ and arg_518_1.time_ <= var_521_13 + arg_521_0 then
				arg_518_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action442")
			end

			local var_521_14 = 0

			if var_521_14 < arg_518_1.time_ and arg_518_1.time_ <= var_521_14 + arg_521_0 then
				arg_518_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_521_15 = 0
			local var_521_16 = 0.925

			if var_521_15 < arg_518_1.time_ and arg_518_1.time_ <= var_521_15 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_17 = arg_518_1:FormatText(StoryNameCfg[471].name)

				arg_518_1.leftNameTxt_.text = var_521_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_18 = arg_518_1:GetWordFromCfg(1109503123)
				local var_521_19 = arg_518_1:FormatText(var_521_18.content)

				arg_518_1.text_.text = var_521_19

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_20 = 37
				local var_521_21 = utf8.len(var_521_19)
				local var_521_22 = var_521_20 <= 0 and var_521_16 or var_521_16 * (var_521_21 / var_521_20)

				if var_521_22 > 0 and var_521_16 < var_521_22 then
					arg_518_1.talkMaxDuration = var_521_22

					if var_521_22 + var_521_15 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_22 + var_521_15
					end
				end

				arg_518_1.text_.text = var_521_19
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503123", "story_v_side_new_1109503.awb") ~= 0 then
					local var_521_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503123", "story_v_side_new_1109503.awb") / 1000

					if var_521_23 + var_521_15 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_23 + var_521_15
					end

					if var_521_18.prefab_name ~= "" and arg_518_1.actors_[var_521_18.prefab_name] ~= nil then
						local var_521_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_18.prefab_name].transform, "story_v_side_new_1109503", "1109503123", "story_v_side_new_1109503.awb")

						arg_518_1:RecordAudio("1109503123", var_521_24)
						arg_518_1:RecordAudio("1109503123", var_521_24)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503123", "story_v_side_new_1109503.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503123", "story_v_side_new_1109503.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_25 = math.max(var_521_16, arg_518_1.talkMaxDuration)

			if var_521_15 <= arg_518_1.time_ and arg_518_1.time_ < var_521_15 + var_521_25 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_15) / var_521_25

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_15 + var_521_25 and arg_518_1.time_ < var_521_15 + var_521_25 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play1109503124 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 1109503124
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play1109503125(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["10058ui_story"]
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect10058ui_story == nil then
				arg_522_1.var_.characterEffect10058ui_story = var_525_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_2 = 0.200000002980232

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 and not isNil(var_525_0) then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2

				if arg_522_1.var_.characterEffect10058ui_story and not isNil(var_525_0) then
					local var_525_4 = Mathf.Lerp(0, 0.5, var_525_3)

					arg_522_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_522_1.var_.characterEffect10058ui_story.fillRatio = var_525_4
				end
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect10058ui_story then
				local var_525_5 = 0.5

				arg_522_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_522_1.var_.characterEffect10058ui_story.fillRatio = var_525_5
			end

			local var_525_6 = 0
			local var_525_7 = 0.825

			if var_525_6 < arg_522_1.time_ and arg_522_1.time_ <= var_525_6 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_8 = arg_522_1:FormatText(StoryNameCfg[7].name)

				arg_522_1.leftNameTxt_.text = var_525_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_9 = arg_522_1:GetWordFromCfg(1109503124)
				local var_525_10 = arg_522_1:FormatText(var_525_9.content)

				arg_522_1.text_.text = var_525_10

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_11 = 33
				local var_525_12 = utf8.len(var_525_10)
				local var_525_13 = var_525_11 <= 0 and var_525_7 or var_525_7 * (var_525_12 / var_525_11)

				if var_525_13 > 0 and var_525_7 < var_525_13 then
					arg_522_1.talkMaxDuration = var_525_13

					if var_525_13 + var_525_6 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_13 + var_525_6
					end
				end

				arg_522_1.text_.text = var_525_10
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_14 = math.max(var_525_7, arg_522_1.talkMaxDuration)

			if var_525_6 <= arg_522_1.time_ and arg_522_1.time_ < var_525_6 + var_525_14 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_6) / var_525_14

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_6 + var_525_14 and arg_522_1.time_ < var_525_6 + var_525_14 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play1109503125 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 1109503125
		arg_526_1.duration_ = 5.6

		local var_526_0 = {
			zh = 4.633,
			ja = 5.6
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play1109503126(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["10058ui_story"]
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect10058ui_story == nil then
				arg_526_1.var_.characterEffect10058ui_story = var_529_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_2 = 0.200000002980232

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 and not isNil(var_529_0) then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2

				if arg_526_1.var_.characterEffect10058ui_story and not isNil(var_529_0) then
					arg_526_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect10058ui_story then
				arg_526_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_529_4 = 0

			if var_529_4 < arg_526_1.time_ and arg_526_1.time_ <= var_529_4 + arg_529_0 then
				arg_526_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_529_5 = 0

			if var_529_5 < arg_526_1.time_ and arg_526_1.time_ <= var_529_5 + arg_529_0 then
				arg_526_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_529_6 = 0
			local var_529_7 = 0.45

			if var_529_6 < arg_526_1.time_ and arg_526_1.time_ <= var_529_6 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_8 = arg_526_1:FormatText(StoryNameCfg[471].name)

				arg_526_1.leftNameTxt_.text = var_529_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_9 = arg_526_1:GetWordFromCfg(1109503125)
				local var_529_10 = arg_526_1:FormatText(var_529_9.content)

				arg_526_1.text_.text = var_529_10

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_11 = 18
				local var_529_12 = utf8.len(var_529_10)
				local var_529_13 = var_529_11 <= 0 and var_529_7 or var_529_7 * (var_529_12 / var_529_11)

				if var_529_13 > 0 and var_529_7 < var_529_13 then
					arg_526_1.talkMaxDuration = var_529_13

					if var_529_13 + var_529_6 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_13 + var_529_6
					end
				end

				arg_526_1.text_.text = var_529_10
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503125", "story_v_side_new_1109503.awb") ~= 0 then
					local var_529_14 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503125", "story_v_side_new_1109503.awb") / 1000

					if var_529_14 + var_529_6 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_14 + var_529_6
					end

					if var_529_9.prefab_name ~= "" and arg_526_1.actors_[var_529_9.prefab_name] ~= nil then
						local var_529_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_9.prefab_name].transform, "story_v_side_new_1109503", "1109503125", "story_v_side_new_1109503.awb")

						arg_526_1:RecordAudio("1109503125", var_529_15)
						arg_526_1:RecordAudio("1109503125", var_529_15)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503125", "story_v_side_new_1109503.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503125", "story_v_side_new_1109503.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_16 = math.max(var_529_7, arg_526_1.talkMaxDuration)

			if var_529_6 <= arg_526_1.time_ and arg_526_1.time_ < var_529_6 + var_529_16 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_6) / var_529_16

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_6 + var_529_16 and arg_526_1.time_ < var_529_6 + var_529_16 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play1109503126 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 1109503126
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play1109503127(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["10058ui_story"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect10058ui_story == nil then
				arg_530_1.var_.characterEffect10058ui_story = var_533_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_2 = 0.200000002980232

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 and not isNil(var_533_0) then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2

				if arg_530_1.var_.characterEffect10058ui_story and not isNil(var_533_0) then
					local var_533_4 = Mathf.Lerp(0, 0.5, var_533_3)

					arg_530_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_530_1.var_.characterEffect10058ui_story.fillRatio = var_533_4
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect10058ui_story then
				local var_533_5 = 0.5

				arg_530_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_530_1.var_.characterEffect10058ui_story.fillRatio = var_533_5
			end

			local var_533_6 = 0
			local var_533_7 = 0.525

			if var_533_6 < arg_530_1.time_ and arg_530_1.time_ <= var_533_6 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, false)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_8 = arg_530_1:GetWordFromCfg(1109503126)
				local var_533_9 = arg_530_1:FormatText(var_533_8.content)

				arg_530_1.text_.text = var_533_9

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_10 = 21
				local var_533_11 = utf8.len(var_533_9)
				local var_533_12 = var_533_10 <= 0 and var_533_7 or var_533_7 * (var_533_11 / var_533_10)

				if var_533_12 > 0 and var_533_7 < var_533_12 then
					arg_530_1.talkMaxDuration = var_533_12

					if var_533_12 + var_533_6 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_12 + var_533_6
					end
				end

				arg_530_1.text_.text = var_533_9
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_13 = math.max(var_533_7, arg_530_1.talkMaxDuration)

			if var_533_6 <= arg_530_1.time_ and arg_530_1.time_ < var_533_6 + var_533_13 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_6) / var_533_13

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_6 + var_533_13 and arg_530_1.time_ < var_533_6 + var_533_13 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play1109503127 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 1109503127
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play1109503128(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 0
			local var_537_1 = 0.525

			if var_537_0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_0 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, false)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_2 = arg_534_1:GetWordFromCfg(1109503127)
				local var_537_3 = arg_534_1:FormatText(var_537_2.content)

				arg_534_1.text_.text = var_537_3

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_4 = 21
				local var_537_5 = utf8.len(var_537_3)
				local var_537_6 = var_537_4 <= 0 and var_537_1 or var_537_1 * (var_537_5 / var_537_4)

				if var_537_6 > 0 and var_537_1 < var_537_6 then
					arg_534_1.talkMaxDuration = var_537_6

					if var_537_6 + var_537_0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_6 + var_537_0
					end
				end

				arg_534_1.text_.text = var_537_3
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_7 = math.max(var_537_1, arg_534_1.talkMaxDuration)

			if var_537_0 <= arg_534_1.time_ and arg_534_1.time_ < var_537_0 + var_537_7 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_0) / var_537_7

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_0 + var_537_7 and arg_534_1.time_ < var_537_0 + var_537_7 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play1109503128 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 1109503128
		arg_538_1.duration_ = 5

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play1109503129(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["10058ui_story"].transform
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 then
				arg_538_1.var_.moveOldPos10058ui_story = var_541_0.localPosition
			end

			local var_541_2 = 0.001

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2
				local var_541_4 = Vector3.New(0, 100, 0)

				var_541_0.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos10058ui_story, var_541_4, var_541_3)

				local var_541_5 = manager.ui.mainCamera.transform.position - var_541_0.position

				var_541_0.forward = Vector3.New(var_541_5.x, var_541_5.y, var_541_5.z)

				local var_541_6 = var_541_0.localEulerAngles

				var_541_6.z = 0
				var_541_6.x = 0
				var_541_0.localEulerAngles = var_541_6
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 then
				var_541_0.localPosition = Vector3.New(0, 100, 0)

				local var_541_7 = manager.ui.mainCamera.transform.position - var_541_0.position

				var_541_0.forward = Vector3.New(var_541_7.x, var_541_7.y, var_541_7.z)

				local var_541_8 = var_541_0.localEulerAngles

				var_541_8.z = 0
				var_541_8.x = 0
				var_541_0.localEulerAngles = var_541_8
			end

			local var_541_9 = 0
			local var_541_10 = 0.575

			if var_541_9 < arg_538_1.time_ and arg_538_1.time_ <= var_541_9 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, false)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_11 = arg_538_1:GetWordFromCfg(1109503128)
				local var_541_12 = arg_538_1:FormatText(var_541_11.content)

				arg_538_1.text_.text = var_541_12

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_13 = 23
				local var_541_14 = utf8.len(var_541_12)
				local var_541_15 = var_541_13 <= 0 and var_541_10 or var_541_10 * (var_541_14 / var_541_13)

				if var_541_15 > 0 and var_541_10 < var_541_15 then
					arg_538_1.talkMaxDuration = var_541_15

					if var_541_15 + var_541_9 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_15 + var_541_9
					end
				end

				arg_538_1.text_.text = var_541_12
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_16 = math.max(var_541_10, arg_538_1.talkMaxDuration)

			if var_541_9 <= arg_538_1.time_ and arg_538_1.time_ < var_541_9 + var_541_16 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_9) / var_541_16

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_9 + var_541_16 and arg_538_1.time_ < var_541_9 + var_541_16 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play1109503129 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1109503129
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1109503130(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0
			local var_545_1 = 0.675

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_2 = arg_542_1:FormatText(StoryNameCfg[7].name)

				arg_542_1.leftNameTxt_.text = var_545_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, true)
				arg_542_1.iconController_:SetSelectedState("hero")

				arg_542_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_542_1.callingController_:SetSelectedState("normal")

				arg_542_1.keyicon_.color = Color.New(1, 1, 1)
				arg_542_1.icon_.color = Color.New(1, 1, 1)

				local var_545_3 = arg_542_1:GetWordFromCfg(1109503129)
				local var_545_4 = arg_542_1:FormatText(var_545_3.content)

				arg_542_1.text_.text = var_545_4

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_5 = 27
				local var_545_6 = utf8.len(var_545_4)
				local var_545_7 = var_545_5 <= 0 and var_545_1 or var_545_1 * (var_545_6 / var_545_5)

				if var_545_7 > 0 and var_545_1 < var_545_7 then
					arg_542_1.talkMaxDuration = var_545_7

					if var_545_7 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_7 + var_545_0
					end
				end

				arg_542_1.text_.text = var_545_4
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_8 = math.max(var_545_1, arg_542_1.talkMaxDuration)

			if var_545_0 <= arg_542_1.time_ and arg_542_1.time_ < var_545_0 + var_545_8 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_0) / var_545_8

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_0 + var_545_8 and arg_542_1.time_ < var_545_0 + var_545_8 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play1109503130 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 1109503130
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play1109503131(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 0.8

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_2 = arg_546_1:FormatText(StoryNameCfg[7].name)

				arg_546_1.leftNameTxt_.text = var_549_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_3 = arg_546_1:GetWordFromCfg(1109503130)
				local var_549_4 = arg_546_1:FormatText(var_549_3.content)

				arg_546_1.text_.text = var_549_4

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_5 = 32
				local var_549_6 = utf8.len(var_549_4)
				local var_549_7 = var_549_5 <= 0 and var_549_1 or var_549_1 * (var_549_6 / var_549_5)

				if var_549_7 > 0 and var_549_1 < var_549_7 then
					arg_546_1.talkMaxDuration = var_549_7

					if var_549_7 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_7 + var_549_0
					end
				end

				arg_546_1.text_.text = var_549_4
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_8 = math.max(var_549_1, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_8 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_0) / var_549_8

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_8 and arg_546_1.time_ < var_549_0 + var_549_8 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play1109503131 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 1109503131
		arg_550_1.duration_ = 7.5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play1109503132(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.mask_.enabled = true
				arg_550_1.mask_.raycastTarget = true

				arg_550_1:SetGaussion(false)
			end

			local var_553_1 = 1.25

			if var_553_0 <= arg_550_1.time_ and arg_550_1.time_ < var_553_0 + var_553_1 then
				local var_553_2 = (arg_550_1.time_ - var_553_0) / var_553_1
				local var_553_3 = Color.New(0, 0, 0)

				var_553_3.a = Mathf.Lerp(0, 1, var_553_2)
				arg_550_1.mask_.color = var_553_3
			end

			if arg_550_1.time_ >= var_553_0 + var_553_1 and arg_550_1.time_ < var_553_0 + var_553_1 + arg_553_0 then
				local var_553_4 = Color.New(0, 0, 0)

				var_553_4.a = 1
				arg_550_1.mask_.color = var_553_4
			end

			local var_553_5 = 1.25

			if var_553_5 < arg_550_1.time_ and arg_550_1.time_ <= var_553_5 + arg_553_0 then
				arg_550_1.mask_.enabled = true
				arg_550_1.mask_.raycastTarget = true

				arg_550_1:SetGaussion(false)
			end

			local var_553_6 = 1.25

			if var_553_5 <= arg_550_1.time_ and arg_550_1.time_ < var_553_5 + var_553_6 then
				local var_553_7 = (arg_550_1.time_ - var_553_5) / var_553_6
				local var_553_8 = Color.New(0, 0, 0)

				var_553_8.a = Mathf.Lerp(1, 0, var_553_7)
				arg_550_1.mask_.color = var_553_8
			end

			if arg_550_1.time_ >= var_553_5 + var_553_6 and arg_550_1.time_ < var_553_5 + var_553_6 + arg_553_0 then
				local var_553_9 = Color.New(0, 0, 0)
				local var_553_10 = 0

				arg_550_1.mask_.enabled = false
				var_553_9.a = var_553_10
				arg_550_1.mask_.color = var_553_9
			end

			local var_553_11 = 0
			local var_553_12 = 0.7

			if var_553_11 < arg_550_1.time_ and arg_550_1.time_ <= var_553_11 + arg_553_0 then
				local var_553_13 = "play"
				local var_553_14 = "music"

				arg_550_1:AudioAction(var_553_13, var_553_14, "ui_battle", "ui_battle_stopbgm", "")

				local var_553_15 = ""
				local var_553_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_553_16 ~= "" then
					if arg_550_1.bgmTxt_.text ~= var_553_16 and arg_550_1.bgmTxt_.text ~= "" then
						if arg_550_1.bgmTxt2_.text ~= "" then
							arg_550_1.bgmTxt_.text = arg_550_1.bgmTxt2_.text
						end

						arg_550_1.bgmTxt2_.text = var_553_16

						arg_550_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_550_1.bgmTxt_.text = var_553_16
						arg_550_1.bgmTxt2_.text = var_553_16
					end

					if arg_550_1.bgmTimer then
						arg_550_1.bgmTimer:Stop()

						arg_550_1.bgmTimer = nil
					end

					if arg_550_1.settingData.show_music_name == 1 then
						arg_550_1.musicController:SetSelectedState("show")
						arg_550_1.musicAnimator_:Play("open", 0, 0)

						if arg_550_1.settingData.music_time ~= 0 then
							arg_550_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_550_1.settingData.music_time), function()
								if arg_550_1 == nil or isNil(arg_550_1.bgmTxt_) then
									return
								end

								arg_550_1.musicController:SetSelectedState("hide")
								arg_550_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_553_17 = 0.833333333333333
			local var_553_18 = 1

			if var_553_17 < arg_550_1.time_ and arg_550_1.time_ <= var_553_17 + arg_553_0 then
				local var_553_19 = "play"
				local var_553_20 = "music"

				arg_550_1:AudioAction(var_553_19, var_553_20, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_553_21 = ""
				local var_553_22 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if var_553_22 ~= "" then
					if arg_550_1.bgmTxt_.text ~= var_553_22 and arg_550_1.bgmTxt_.text ~= "" then
						if arg_550_1.bgmTxt2_.text ~= "" then
							arg_550_1.bgmTxt_.text = arg_550_1.bgmTxt2_.text
						end

						arg_550_1.bgmTxt2_.text = var_553_22

						arg_550_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_550_1.bgmTxt_.text = var_553_22
						arg_550_1.bgmTxt2_.text = var_553_22
					end

					if arg_550_1.bgmTimer then
						arg_550_1.bgmTimer:Stop()

						arg_550_1.bgmTimer = nil
					end

					if arg_550_1.settingData.show_music_name == 1 then
						arg_550_1.musicController:SetSelectedState("show")
						arg_550_1.musicAnimator_:Play("open", 0, 0)

						if arg_550_1.settingData.music_time ~= 0 then
							arg_550_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_550_1.settingData.music_time), function()
								if arg_550_1 == nil or isNil(arg_550_1.bgmTxt_) then
									return
								end

								arg_550_1.musicController:SetSelectedState("hide")
								arg_550_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_550_1.frameCnt_ <= 1 then
				arg_550_1.dialog_:SetActive(false)
			end

			local var_553_23 = 2.499999999999
			local var_553_24 = 0.95

			if var_553_23 < arg_550_1.time_ and arg_550_1.time_ <= var_553_23 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0

				arg_550_1.dialog_:SetActive(true)

				arg_550_1.dialogCg_.alpha = 0

				local var_553_25 = LeanTween.value(arg_550_1.dialog_, 0, 1, 0.3)

				var_553_25:setOnUpdate(LuaHelper.FloatAction(function(arg_556_0)
					arg_550_1.dialogCg_.alpha = arg_556_0
				end))
				var_553_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_550_1.dialog_)
					var_553_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_550_1.duration_ = arg_550_1.duration_ + 0.3

				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_26 = arg_550_1:GetWordFromCfg(1109503131)
				local var_553_27 = arg_550_1:FormatText(var_553_26.content)

				arg_550_1.text_.text = var_553_27

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_28 = 38
				local var_553_29 = utf8.len(var_553_27)
				local var_553_30 = var_553_28 <= 0 and var_553_24 or var_553_24 * (var_553_29 / var_553_28)

				if var_553_30 > 0 and var_553_24 < var_553_30 then
					arg_550_1.talkMaxDuration = var_553_30
					var_553_23 = var_553_23 + 0.3

					if var_553_30 + var_553_23 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_30 + var_553_23
					end
				end

				arg_550_1.text_.text = var_553_27
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_31 = var_553_23 + 0.3
			local var_553_32 = math.max(var_553_24, arg_550_1.talkMaxDuration)

			if var_553_31 <= arg_550_1.time_ and arg_550_1.time_ < var_553_31 + var_553_32 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_31) / var_553_32

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_31 + var_553_32 and arg_550_1.time_ < var_553_31 + var_553_32 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play1109503132 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 1109503132
		arg_558_1.duration_ = 7.47

		local var_558_0 = {
			zh = 6.7,
			ja = 7.466
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play1109503133(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = arg_558_1.actors_["10058ui_story"].transform
			local var_561_1 = 0

			if var_561_1 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 then
				arg_558_1.var_.moveOldPos10058ui_story = var_561_0.localPosition
			end

			local var_561_2 = 0.001

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_2 then
				local var_561_3 = (arg_558_1.time_ - var_561_1) / var_561_2
				local var_561_4 = Vector3.New(0, -0.98, -6.1)

				var_561_0.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos10058ui_story, var_561_4, var_561_3)

				local var_561_5 = manager.ui.mainCamera.transform.position - var_561_0.position

				var_561_0.forward = Vector3.New(var_561_5.x, var_561_5.y, var_561_5.z)

				local var_561_6 = var_561_0.localEulerAngles

				var_561_6.z = 0
				var_561_6.x = 0
				var_561_0.localEulerAngles = var_561_6
			end

			if arg_558_1.time_ >= var_561_1 + var_561_2 and arg_558_1.time_ < var_561_1 + var_561_2 + arg_561_0 then
				var_561_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_561_7 = manager.ui.mainCamera.transform.position - var_561_0.position

				var_561_0.forward = Vector3.New(var_561_7.x, var_561_7.y, var_561_7.z)

				local var_561_8 = var_561_0.localEulerAngles

				var_561_8.z = 0
				var_561_8.x = 0
				var_561_0.localEulerAngles = var_561_8
			end

			local var_561_9 = arg_558_1.actors_["10058ui_story"]
			local var_561_10 = 0

			if var_561_10 < arg_558_1.time_ and arg_558_1.time_ <= var_561_10 + arg_561_0 and not isNil(var_561_9) and arg_558_1.var_.characterEffect10058ui_story == nil then
				arg_558_1.var_.characterEffect10058ui_story = var_561_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_11 = 0.200000002980232

			if var_561_10 <= arg_558_1.time_ and arg_558_1.time_ < var_561_10 + var_561_11 and not isNil(var_561_9) then
				local var_561_12 = (arg_558_1.time_ - var_561_10) / var_561_11

				if arg_558_1.var_.characterEffect10058ui_story and not isNil(var_561_9) then
					arg_558_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_558_1.time_ >= var_561_10 + var_561_11 and arg_558_1.time_ < var_561_10 + var_561_11 + arg_561_0 and not isNil(var_561_9) and arg_558_1.var_.characterEffect10058ui_story then
				arg_558_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_561_13 = 0

			if var_561_13 < arg_558_1.time_ and arg_558_1.time_ <= var_561_13 + arg_561_0 then
				arg_558_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_561_14 = 0

			if var_561_14 < arg_558_1.time_ and arg_558_1.time_ <= var_561_14 + arg_561_0 then
				arg_558_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_561_15 = 0
			local var_561_16 = 0.65

			if var_561_15 < arg_558_1.time_ and arg_558_1.time_ <= var_561_15 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_17 = arg_558_1:FormatText(StoryNameCfg[471].name)

				arg_558_1.leftNameTxt_.text = var_561_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_18 = arg_558_1:GetWordFromCfg(1109503132)
				local var_561_19 = arg_558_1:FormatText(var_561_18.content)

				arg_558_1.text_.text = var_561_19

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_20 = 26
				local var_561_21 = utf8.len(var_561_19)
				local var_561_22 = var_561_20 <= 0 and var_561_16 or var_561_16 * (var_561_21 / var_561_20)

				if var_561_22 > 0 and var_561_16 < var_561_22 then
					arg_558_1.talkMaxDuration = var_561_22

					if var_561_22 + var_561_15 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_22 + var_561_15
					end
				end

				arg_558_1.text_.text = var_561_19
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503132", "story_v_side_new_1109503.awb") ~= 0 then
					local var_561_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503132", "story_v_side_new_1109503.awb") / 1000

					if var_561_23 + var_561_15 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_23 + var_561_15
					end

					if var_561_18.prefab_name ~= "" and arg_558_1.actors_[var_561_18.prefab_name] ~= nil then
						local var_561_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_18.prefab_name].transform, "story_v_side_new_1109503", "1109503132", "story_v_side_new_1109503.awb")

						arg_558_1:RecordAudio("1109503132", var_561_24)
						arg_558_1:RecordAudio("1109503132", var_561_24)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503132", "story_v_side_new_1109503.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503132", "story_v_side_new_1109503.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_25 = math.max(var_561_16, arg_558_1.talkMaxDuration)

			if var_561_15 <= arg_558_1.time_ and arg_558_1.time_ < var_561_15 + var_561_25 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_15) / var_561_25

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_15 + var_561_25 and arg_558_1.time_ < var_561_15 + var_561_25 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_558_1:InitPlayNodeList()
	end,
	Play1109503133 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1109503133
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1109503134(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = arg_562_1.actors_["10058ui_story"]
			local var_565_1 = 0

			if var_565_1 < arg_562_1.time_ and arg_562_1.time_ <= var_565_1 + arg_565_0 and not isNil(var_565_0) and arg_562_1.var_.characterEffect10058ui_story == nil then
				arg_562_1.var_.characterEffect10058ui_story = var_565_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_2 = 0.200000002980232

			if var_565_1 <= arg_562_1.time_ and arg_562_1.time_ < var_565_1 + var_565_2 and not isNil(var_565_0) then
				local var_565_3 = (arg_562_1.time_ - var_565_1) / var_565_2

				if arg_562_1.var_.characterEffect10058ui_story and not isNil(var_565_0) then
					local var_565_4 = Mathf.Lerp(0, 0.5, var_565_3)

					arg_562_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_562_1.var_.characterEffect10058ui_story.fillRatio = var_565_4
				end
			end

			if arg_562_1.time_ >= var_565_1 + var_565_2 and arg_562_1.time_ < var_565_1 + var_565_2 + arg_565_0 and not isNil(var_565_0) and arg_562_1.var_.characterEffect10058ui_story then
				local var_565_5 = 0.5

				arg_562_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_562_1.var_.characterEffect10058ui_story.fillRatio = var_565_5
			end

			local var_565_6 = arg_562_1.actors_["10058ui_story"].transform
			local var_565_7 = 0

			if var_565_7 < arg_562_1.time_ and arg_562_1.time_ <= var_565_7 + arg_565_0 then
				arg_562_1.var_.moveOldPos10058ui_story = var_565_6.localPosition
			end

			local var_565_8 = 0.001

			if var_565_7 <= arg_562_1.time_ and arg_562_1.time_ < var_565_7 + var_565_8 then
				local var_565_9 = (arg_562_1.time_ - var_565_7) / var_565_8
				local var_565_10 = Vector3.New(0, 100, 0)

				var_565_6.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos10058ui_story, var_565_10, var_565_9)

				local var_565_11 = manager.ui.mainCamera.transform.position - var_565_6.position

				var_565_6.forward = Vector3.New(var_565_11.x, var_565_11.y, var_565_11.z)

				local var_565_12 = var_565_6.localEulerAngles

				var_565_12.z = 0
				var_565_12.x = 0
				var_565_6.localEulerAngles = var_565_12
			end

			if arg_562_1.time_ >= var_565_7 + var_565_8 and arg_562_1.time_ < var_565_7 + var_565_8 + arg_565_0 then
				var_565_6.localPosition = Vector3.New(0, 100, 0)

				local var_565_13 = manager.ui.mainCamera.transform.position - var_565_6.position

				var_565_6.forward = Vector3.New(var_565_13.x, var_565_13.y, var_565_13.z)

				local var_565_14 = var_565_6.localEulerAngles

				var_565_14.z = 0
				var_565_14.x = 0
				var_565_6.localEulerAngles = var_565_14
			end

			local var_565_15 = 0
			local var_565_16 = 0.625

			if var_565_15 < arg_562_1.time_ and arg_562_1.time_ <= var_565_15 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, false)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_17 = arg_562_1:GetWordFromCfg(1109503133)
				local var_565_18 = arg_562_1:FormatText(var_565_17.content)

				arg_562_1.text_.text = var_565_18

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_19 = 25
				local var_565_20 = utf8.len(var_565_18)
				local var_565_21 = var_565_19 <= 0 and var_565_16 or var_565_16 * (var_565_20 / var_565_19)

				if var_565_21 > 0 and var_565_16 < var_565_21 then
					arg_562_1.talkMaxDuration = var_565_21

					if var_565_21 + var_565_15 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_21 + var_565_15
					end
				end

				arg_562_1.text_.text = var_565_18
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_22 = math.max(var_565_16, arg_562_1.talkMaxDuration)

			if var_565_15 <= arg_562_1.time_ and arg_562_1.time_ < var_565_15 + var_565_22 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_15) / var_565_22

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_15 + var_565_22 and arg_562_1.time_ < var_565_15 + var_565_22 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_562_1:InitPlayNodeList()
	end,
	Play1109503134 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1109503134
		arg_566_1.duration_ = 5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play1109503135(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0
			local var_569_1 = 0.15

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_2 = arg_566_1:FormatText(StoryNameCfg[7].name)

				arg_566_1.leftNameTxt_.text = var_569_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, true)
				arg_566_1.iconController_:SetSelectedState("hero")

				arg_566_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_566_1.callingController_:SetSelectedState("normal")

				arg_566_1.keyicon_.color = Color.New(1, 1, 1)
				arg_566_1.icon_.color = Color.New(1, 1, 1)

				local var_569_3 = arg_566_1:GetWordFromCfg(1109503134)
				local var_569_4 = arg_566_1:FormatText(var_569_3.content)

				arg_566_1.text_.text = var_569_4

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_5 = 6
				local var_569_6 = utf8.len(var_569_4)
				local var_569_7 = var_569_5 <= 0 and var_569_1 or var_569_1 * (var_569_6 / var_569_5)

				if var_569_7 > 0 and var_569_1 < var_569_7 then
					arg_566_1.talkMaxDuration = var_569_7

					if var_569_7 + var_569_0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_7 + var_569_0
					end
				end

				arg_566_1.text_.text = var_569_4
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_8 = math.max(var_569_1, arg_566_1.talkMaxDuration)

			if var_569_0 <= arg_566_1.time_ and arg_566_1.time_ < var_569_0 + var_569_8 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_0) / var_569_8

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_0 + var_569_8 and arg_566_1.time_ < var_569_0 + var_569_8 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play1109503135 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1109503135
		arg_570_1.duration_ = 5.73

		local var_570_0 = {
			zh = 4.19966666666667,
			ja = 5.73266666666667
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1109503136(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = 0

			if var_573_0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_0 + arg_573_0 then
				arg_570_1.mask_.enabled = true
				arg_570_1.mask_.raycastTarget = true

				arg_570_1:SetGaussion(false)
			end

			local var_573_1 = 1.66666666666667

			if var_573_0 <= arg_570_1.time_ and arg_570_1.time_ < var_573_0 + var_573_1 then
				local var_573_2 = (arg_570_1.time_ - var_573_0) / var_573_1
				local var_573_3 = Color.New(0, 0, 0)

				var_573_3.a = Mathf.Lerp(1, 0, var_573_2)
				arg_570_1.mask_.color = var_573_3
			end

			if arg_570_1.time_ >= var_573_0 + var_573_1 and arg_570_1.time_ < var_573_0 + var_573_1 + arg_573_0 then
				local var_573_4 = Color.New(0, 0, 0)
				local var_573_5 = 0

				arg_570_1.mask_.enabled = false
				var_573_4.a = var_573_5
				arg_570_1.mask_.color = var_573_4
			end

			local var_573_6 = arg_570_1.actors_["10058ui_story"].transform
			local var_573_7 = 1.66666666666667

			if var_573_7 < arg_570_1.time_ and arg_570_1.time_ <= var_573_7 + arg_573_0 then
				arg_570_1.var_.moveOldPos10058ui_story = var_573_6.localPosition
			end

			local var_573_8 = 0.001

			if var_573_7 <= arg_570_1.time_ and arg_570_1.time_ < var_573_7 + var_573_8 then
				local var_573_9 = (arg_570_1.time_ - var_573_7) / var_573_8
				local var_573_10 = Vector3.New(0, -0.98, -6.1)

				var_573_6.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPos10058ui_story, var_573_10, var_573_9)

				local var_573_11 = manager.ui.mainCamera.transform.position - var_573_6.position

				var_573_6.forward = Vector3.New(var_573_11.x, var_573_11.y, var_573_11.z)

				local var_573_12 = var_573_6.localEulerAngles

				var_573_12.z = 0
				var_573_12.x = 0
				var_573_6.localEulerAngles = var_573_12
			end

			if arg_570_1.time_ >= var_573_7 + var_573_8 and arg_570_1.time_ < var_573_7 + var_573_8 + arg_573_0 then
				var_573_6.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_573_13 = manager.ui.mainCamera.transform.position - var_573_6.position

				var_573_6.forward = Vector3.New(var_573_13.x, var_573_13.y, var_573_13.z)

				local var_573_14 = var_573_6.localEulerAngles

				var_573_14.z = 0
				var_573_14.x = 0
				var_573_6.localEulerAngles = var_573_14
			end

			local var_573_15 = 1.66666666666667

			if var_573_15 < arg_570_1.time_ and arg_570_1.time_ <= var_573_15 + arg_573_0 then
				arg_570_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_573_16 = arg_570_1.actors_["10058ui_story"]
			local var_573_17 = 1.66666666666667

			if var_573_17 < arg_570_1.time_ and arg_570_1.time_ <= var_573_17 + arg_573_0 and not isNil(var_573_16) and arg_570_1.var_.characterEffect10058ui_story == nil then
				arg_570_1.var_.characterEffect10058ui_story = var_573_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_18 = 0.200000002980232

			if var_573_17 <= arg_570_1.time_ and arg_570_1.time_ < var_573_17 + var_573_18 and not isNil(var_573_16) then
				local var_573_19 = (arg_570_1.time_ - var_573_17) / var_573_18

				if arg_570_1.var_.characterEffect10058ui_story and not isNil(var_573_16) then
					arg_570_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_570_1.time_ >= var_573_17 + var_573_18 and arg_570_1.time_ < var_573_17 + var_573_18 + arg_573_0 and not isNil(var_573_16) and arg_570_1.var_.characterEffect10058ui_story then
				arg_570_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_573_20 = 1.66666666666667

			if var_573_20 < arg_570_1.time_ and arg_570_1.time_ <= var_573_20 + arg_573_0 then
				arg_570_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_570_1.frameCnt_ <= 1 then
				arg_570_1.dialog_:SetActive(false)
			end

			local var_573_21 = 1.66666666666667
			local var_573_22 = 0.175

			if var_573_21 < arg_570_1.time_ and arg_570_1.time_ <= var_573_21 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0

				arg_570_1.dialog_:SetActive(true)

				arg_570_1.dialogCg_.alpha = 0

				local var_573_23 = LeanTween.value(arg_570_1.dialog_, 0, 1, 0.3)

				var_573_23:setOnUpdate(LuaHelper.FloatAction(function(arg_574_0)
					arg_570_1.dialogCg_.alpha = arg_574_0
				end))
				var_573_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_570_1.dialog_)
					var_573_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_570_1.duration_ = arg_570_1.duration_ + 0.3

				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_24 = arg_570_1:FormatText(StoryNameCfg[665].name)

				arg_570_1.leftNameTxt_.text = var_573_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_25 = arg_570_1:GetWordFromCfg(1109503135)
				local var_573_26 = arg_570_1:FormatText(var_573_25.content)

				arg_570_1.text_.text = var_573_26

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_27 = 7
				local var_573_28 = utf8.len(var_573_26)
				local var_573_29 = var_573_27 <= 0 and var_573_22 or var_573_22 * (var_573_28 / var_573_27)

				if var_573_29 > 0 and var_573_22 < var_573_29 then
					arg_570_1.talkMaxDuration = var_573_29
					var_573_21 = var_573_21 + 0.3

					if var_573_29 + var_573_21 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_29 + var_573_21
					end
				end

				arg_570_1.text_.text = var_573_26
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503135", "story_v_side_new_1109503.awb") ~= 0 then
					local var_573_30 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503135", "story_v_side_new_1109503.awb") / 1000

					if var_573_30 + var_573_21 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_30 + var_573_21
					end

					if var_573_25.prefab_name ~= "" and arg_570_1.actors_[var_573_25.prefab_name] ~= nil then
						local var_573_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_25.prefab_name].transform, "story_v_side_new_1109503", "1109503135", "story_v_side_new_1109503.awb")

						arg_570_1:RecordAudio("1109503135", var_573_31)
						arg_570_1:RecordAudio("1109503135", var_573_31)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503135", "story_v_side_new_1109503.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503135", "story_v_side_new_1109503.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_32 = var_573_21 + 0.3
			local var_573_33 = math.max(var_573_22, arg_570_1.talkMaxDuration)

			if var_573_32 <= arg_570_1.time_ and arg_570_1.time_ < var_573_32 + var_573_33 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_32) / var_573_33

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_32 + var_573_33 and arg_570_1.time_ < var_573_32 + var_573_33 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_570_1:InitPlayNodeList()
	end,
	Play1109503136 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 1109503136
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play1109503137(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = arg_576_1.actors_["10058ui_story"]
			local var_579_1 = 0

			if var_579_1 < arg_576_1.time_ and arg_576_1.time_ <= var_579_1 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.characterEffect10058ui_story == nil then
				arg_576_1.var_.characterEffect10058ui_story = var_579_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_579_2 = 0.200000002980232

			if var_579_1 <= arg_576_1.time_ and arg_576_1.time_ < var_579_1 + var_579_2 and not isNil(var_579_0) then
				local var_579_3 = (arg_576_1.time_ - var_579_1) / var_579_2

				if arg_576_1.var_.characterEffect10058ui_story and not isNil(var_579_0) then
					local var_579_4 = Mathf.Lerp(0, 0.5, var_579_3)

					arg_576_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_576_1.var_.characterEffect10058ui_story.fillRatio = var_579_4
				end
			end

			if arg_576_1.time_ >= var_579_1 + var_579_2 and arg_576_1.time_ < var_579_1 + var_579_2 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.characterEffect10058ui_story then
				local var_579_5 = 0.5

				arg_576_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_576_1.var_.characterEffect10058ui_story.fillRatio = var_579_5
			end

			local var_579_6 = 0
			local var_579_7 = 0.525

			if var_579_6 < arg_576_1.time_ and arg_576_1.time_ <= var_579_6 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_8 = arg_576_1:GetWordFromCfg(1109503136)
				local var_579_9 = arg_576_1:FormatText(var_579_8.content)

				arg_576_1.text_.text = var_579_9

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_10 = 21
				local var_579_11 = utf8.len(var_579_9)
				local var_579_12 = var_579_10 <= 0 and var_579_7 or var_579_7 * (var_579_11 / var_579_10)

				if var_579_12 > 0 and var_579_7 < var_579_12 then
					arg_576_1.talkMaxDuration = var_579_12

					if var_579_12 + var_579_6 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_12 + var_579_6
					end
				end

				arg_576_1.text_.text = var_579_9
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_13 = math.max(var_579_7, arg_576_1.talkMaxDuration)

			if var_579_6 <= arg_576_1.time_ and arg_576_1.time_ < var_579_6 + var_579_13 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_6) / var_579_13

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_6 + var_579_13 and arg_576_1.time_ < var_579_6 + var_579_13 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play1109503137 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 1109503137
		arg_580_1.duration_ = 3.83

		local var_580_0 = {
			zh = 1.999999999999,
			ja = 3.833
		}
		local var_580_1 = manager.audio:GetLocalizationFlag()

		if var_580_0[var_580_1] ~= nil then
			arg_580_1.duration_ = var_580_0[var_580_1]
		end

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play1109503138(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = arg_580_1.actors_["10058ui_story"]
			local var_583_1 = 0

			if var_583_1 < arg_580_1.time_ and arg_580_1.time_ <= var_583_1 + arg_583_0 and not isNil(var_583_0) and arg_580_1.var_.characterEffect10058ui_story == nil then
				arg_580_1.var_.characterEffect10058ui_story = var_583_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_2 = 0.200000002980232

			if var_583_1 <= arg_580_1.time_ and arg_580_1.time_ < var_583_1 + var_583_2 and not isNil(var_583_0) then
				local var_583_3 = (arg_580_1.time_ - var_583_1) / var_583_2

				if arg_580_1.var_.characterEffect10058ui_story and not isNil(var_583_0) then
					arg_580_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_580_1.time_ >= var_583_1 + var_583_2 and arg_580_1.time_ < var_583_1 + var_583_2 + arg_583_0 and not isNil(var_583_0) and arg_580_1.var_.characterEffect10058ui_story then
				arg_580_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_583_4 = 0

			if var_583_4 < arg_580_1.time_ and arg_580_1.time_ <= var_583_4 + arg_583_0 then
				arg_580_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_583_5 = 0
			local var_583_6 = 0.2

			if var_583_5 < arg_580_1.time_ and arg_580_1.time_ <= var_583_5 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				local var_583_7 = arg_580_1:FormatText(StoryNameCfg[665].name)

				arg_580_1.leftNameTxt_.text = var_583_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_8 = arg_580_1:GetWordFromCfg(1109503137)
				local var_583_9 = arg_580_1:FormatText(var_583_8.content)

				arg_580_1.text_.text = var_583_9

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_10 = 8
				local var_583_11 = utf8.len(var_583_9)
				local var_583_12 = var_583_10 <= 0 and var_583_6 or var_583_6 * (var_583_11 / var_583_10)

				if var_583_12 > 0 and var_583_6 < var_583_12 then
					arg_580_1.talkMaxDuration = var_583_12

					if var_583_12 + var_583_5 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_12 + var_583_5
					end
				end

				arg_580_1.text_.text = var_583_9
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503137", "story_v_side_new_1109503.awb") ~= 0 then
					local var_583_13 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503137", "story_v_side_new_1109503.awb") / 1000

					if var_583_13 + var_583_5 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_13 + var_583_5
					end

					if var_583_8.prefab_name ~= "" and arg_580_1.actors_[var_583_8.prefab_name] ~= nil then
						local var_583_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_8.prefab_name].transform, "story_v_side_new_1109503", "1109503137", "story_v_side_new_1109503.awb")

						arg_580_1:RecordAudio("1109503137", var_583_14)
						arg_580_1:RecordAudio("1109503137", var_583_14)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503137", "story_v_side_new_1109503.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503137", "story_v_side_new_1109503.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_15 = math.max(var_583_6, arg_580_1.talkMaxDuration)

			if var_583_5 <= arg_580_1.time_ and arg_580_1.time_ < var_583_5 + var_583_15 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_5) / var_583_15

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_5 + var_583_15 and arg_580_1.time_ < var_583_5 + var_583_15 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play1109503138 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 1109503138
		arg_584_1.duration_ = 5

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play1109503139(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = arg_584_1.actors_["10058ui_story"].transform
			local var_587_1 = 0

			if var_587_1 < arg_584_1.time_ and arg_584_1.time_ <= var_587_1 + arg_587_0 then
				arg_584_1.var_.moveOldPos10058ui_story = var_587_0.localPosition
			end

			local var_587_2 = 0.001

			if var_587_1 <= arg_584_1.time_ and arg_584_1.time_ < var_587_1 + var_587_2 then
				local var_587_3 = (arg_584_1.time_ - var_587_1) / var_587_2
				local var_587_4 = Vector3.New(0, 100, 0)

				var_587_0.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos10058ui_story, var_587_4, var_587_3)

				local var_587_5 = manager.ui.mainCamera.transform.position - var_587_0.position

				var_587_0.forward = Vector3.New(var_587_5.x, var_587_5.y, var_587_5.z)

				local var_587_6 = var_587_0.localEulerAngles

				var_587_6.z = 0
				var_587_6.x = 0
				var_587_0.localEulerAngles = var_587_6
			end

			if arg_584_1.time_ >= var_587_1 + var_587_2 and arg_584_1.time_ < var_587_1 + var_587_2 + arg_587_0 then
				var_587_0.localPosition = Vector3.New(0, 100, 0)

				local var_587_7 = manager.ui.mainCamera.transform.position - var_587_0.position

				var_587_0.forward = Vector3.New(var_587_7.x, var_587_7.y, var_587_7.z)

				local var_587_8 = var_587_0.localEulerAngles

				var_587_8.z = 0
				var_587_8.x = 0
				var_587_0.localEulerAngles = var_587_8
			end

			local var_587_9 = 0
			local var_587_10 = 0.525

			if var_587_9 < arg_584_1.time_ and arg_584_1.time_ <= var_587_9 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0

				arg_584_1.dialog_:SetActive(true)

				arg_584_1.dialogCg_.alpha = 0

				local var_587_11 = LeanTween.value(arg_584_1.dialog_, 0, 1, 0.3)

				var_587_11:setOnUpdate(LuaHelper.FloatAction(function(arg_588_0)
					arg_584_1.dialogCg_.alpha = arg_588_0
				end))
				var_587_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_584_1.dialog_)
					var_587_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_584_1.duration_ = arg_584_1.duration_ + 0.3

				SetActive(arg_584_1.leftNameGo_, false)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_12 = arg_584_1:GetWordFromCfg(1109503138)
				local var_587_13 = arg_584_1:FormatText(var_587_12.content)

				arg_584_1.text_.text = var_587_13

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_14 = 21
				local var_587_15 = utf8.len(var_587_13)
				local var_587_16 = var_587_14 <= 0 and var_587_10 or var_587_10 * (var_587_15 / var_587_14)

				if var_587_16 > 0 and var_587_10 < var_587_16 then
					arg_584_1.talkMaxDuration = var_587_16
					var_587_9 = var_587_9 + 0.3

					if var_587_16 + var_587_9 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_16 + var_587_9
					end
				end

				arg_584_1.text_.text = var_587_13
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)
				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_17 = var_587_9 + 0.3
			local var_587_18 = math.max(var_587_10, arg_584_1.talkMaxDuration)

			if var_587_17 <= arg_584_1.time_ and arg_584_1.time_ < var_587_17 + var_587_18 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_17) / var_587_18

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_17 + var_587_18 and arg_584_1.time_ < var_587_17 + var_587_18 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_584_1:InitPlayNodeList()
	end,
	Play1109503139 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1109503139
		arg_590_1.duration_ = 5

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1109503140(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = 0
			local var_593_1 = 0.175

			if var_593_0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_0 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				local var_593_2 = arg_590_1:FormatText(StoryNameCfg[7].name)

				arg_590_1.leftNameTxt_.text = var_593_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, true)
				arg_590_1.iconController_:SetSelectedState("hero")

				arg_590_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_590_1.callingController_:SetSelectedState("normal")

				arg_590_1.keyicon_.color = Color.New(1, 1, 1)
				arg_590_1.icon_.color = Color.New(1, 1, 1)

				local var_593_3 = arg_590_1:GetWordFromCfg(1109503139)
				local var_593_4 = arg_590_1:FormatText(var_593_3.content)

				arg_590_1.text_.text = var_593_4

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_5 = 7
				local var_593_6 = utf8.len(var_593_4)
				local var_593_7 = var_593_5 <= 0 and var_593_1 or var_593_1 * (var_593_6 / var_593_5)

				if var_593_7 > 0 and var_593_1 < var_593_7 then
					arg_590_1.talkMaxDuration = var_593_7

					if var_593_7 + var_593_0 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_7 + var_593_0
					end
				end

				arg_590_1.text_.text = var_593_4
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_8 = math.max(var_593_1, arg_590_1.talkMaxDuration)

			if var_593_0 <= arg_590_1.time_ and arg_590_1.time_ < var_593_0 + var_593_8 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_0) / var_593_8

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_0 + var_593_8 and arg_590_1.time_ < var_593_0 + var_593_8 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play1109503140 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 1109503140
		arg_594_1.duration_ = 4.43

		local var_594_0 = {
			zh = 4.433,
			ja = 4.166
		}
		local var_594_1 = manager.audio:GetLocalizationFlag()

		if var_594_0[var_594_1] ~= nil then
			arg_594_1.duration_ = var_594_0[var_594_1]
		end

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play1109503141(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = arg_594_1.actors_["10058ui_story"].transform
			local var_597_1 = 0

			if var_597_1 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 then
				arg_594_1.var_.moveOldPos10058ui_story = var_597_0.localPosition
			end

			local var_597_2 = 0.001

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_2 then
				local var_597_3 = (arg_594_1.time_ - var_597_1) / var_597_2
				local var_597_4 = Vector3.New(0, -0.98, -6.1)

				var_597_0.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPos10058ui_story, var_597_4, var_597_3)

				local var_597_5 = manager.ui.mainCamera.transform.position - var_597_0.position

				var_597_0.forward = Vector3.New(var_597_5.x, var_597_5.y, var_597_5.z)

				local var_597_6 = var_597_0.localEulerAngles

				var_597_6.z = 0
				var_597_6.x = 0
				var_597_0.localEulerAngles = var_597_6
			end

			if arg_594_1.time_ >= var_597_1 + var_597_2 and arg_594_1.time_ < var_597_1 + var_597_2 + arg_597_0 then
				var_597_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_597_7 = manager.ui.mainCamera.transform.position - var_597_0.position

				var_597_0.forward = Vector3.New(var_597_7.x, var_597_7.y, var_597_7.z)

				local var_597_8 = var_597_0.localEulerAngles

				var_597_8.z = 0
				var_597_8.x = 0
				var_597_0.localEulerAngles = var_597_8
			end

			local var_597_9 = arg_594_1.actors_["10058ui_story"]
			local var_597_10 = 0

			if var_597_10 < arg_594_1.time_ and arg_594_1.time_ <= var_597_10 + arg_597_0 and not isNil(var_597_9) and arg_594_1.var_.characterEffect10058ui_story == nil then
				arg_594_1.var_.characterEffect10058ui_story = var_597_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_11 = 0.200000002980232

			if var_597_10 <= arg_594_1.time_ and arg_594_1.time_ < var_597_10 + var_597_11 and not isNil(var_597_9) then
				local var_597_12 = (arg_594_1.time_ - var_597_10) / var_597_11

				if arg_594_1.var_.characterEffect10058ui_story and not isNil(var_597_9) then
					arg_594_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_594_1.time_ >= var_597_10 + var_597_11 and arg_594_1.time_ < var_597_10 + var_597_11 + arg_597_0 and not isNil(var_597_9) and arg_594_1.var_.characterEffect10058ui_story then
				arg_594_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_597_13 = 0

			if var_597_13 < arg_594_1.time_ and arg_594_1.time_ <= var_597_13 + arg_597_0 then
				arg_594_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_597_14 = 0
			local var_597_15 = 0.55

			if var_597_14 < arg_594_1.time_ and arg_594_1.time_ <= var_597_14 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				local var_597_16 = arg_594_1:FormatText(StoryNameCfg[471].name)

				arg_594_1.leftNameTxt_.text = var_597_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_17 = arg_594_1:GetWordFromCfg(1109503140)
				local var_597_18 = arg_594_1:FormatText(var_597_17.content)

				arg_594_1.text_.text = var_597_18

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_19 = 22
				local var_597_20 = utf8.len(var_597_18)
				local var_597_21 = var_597_19 <= 0 and var_597_15 or var_597_15 * (var_597_20 / var_597_19)

				if var_597_21 > 0 and var_597_15 < var_597_21 then
					arg_594_1.talkMaxDuration = var_597_21

					if var_597_21 + var_597_14 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_21 + var_597_14
					end
				end

				arg_594_1.text_.text = var_597_18
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503140", "story_v_side_new_1109503.awb") ~= 0 then
					local var_597_22 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503140", "story_v_side_new_1109503.awb") / 1000

					if var_597_22 + var_597_14 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_22 + var_597_14
					end

					if var_597_17.prefab_name ~= "" and arg_594_1.actors_[var_597_17.prefab_name] ~= nil then
						local var_597_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_17.prefab_name].transform, "story_v_side_new_1109503", "1109503140", "story_v_side_new_1109503.awb")

						arg_594_1:RecordAudio("1109503140", var_597_23)
						arg_594_1:RecordAudio("1109503140", var_597_23)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503140", "story_v_side_new_1109503.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503140", "story_v_side_new_1109503.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_24 = math.max(var_597_15, arg_594_1.talkMaxDuration)

			if var_597_14 <= arg_594_1.time_ and arg_594_1.time_ < var_597_14 + var_597_24 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_14) / var_597_24

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_14 + var_597_24 and arg_594_1.time_ < var_597_14 + var_597_24 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_594_1:InitPlayNodeList()
	end,
	Play1109503141 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 1109503141
		arg_598_1.duration_ = 5

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play1109503142(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = arg_598_1.actors_["10058ui_story"]
			local var_601_1 = 0

			if var_601_1 < arg_598_1.time_ and arg_598_1.time_ <= var_601_1 + arg_601_0 and not isNil(var_601_0) and arg_598_1.var_.characterEffect10058ui_story == nil then
				arg_598_1.var_.characterEffect10058ui_story = var_601_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_2 = 0.200000002980232

			if var_601_1 <= arg_598_1.time_ and arg_598_1.time_ < var_601_1 + var_601_2 and not isNil(var_601_0) then
				local var_601_3 = (arg_598_1.time_ - var_601_1) / var_601_2

				if arg_598_1.var_.characterEffect10058ui_story and not isNil(var_601_0) then
					local var_601_4 = Mathf.Lerp(0, 0.5, var_601_3)

					arg_598_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_598_1.var_.characterEffect10058ui_story.fillRatio = var_601_4
				end
			end

			if arg_598_1.time_ >= var_601_1 + var_601_2 and arg_598_1.time_ < var_601_1 + var_601_2 + arg_601_0 and not isNil(var_601_0) and arg_598_1.var_.characterEffect10058ui_story then
				local var_601_5 = 0.5

				arg_598_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_598_1.var_.characterEffect10058ui_story.fillRatio = var_601_5
			end

			local var_601_6 = 0
			local var_601_7 = 0.35

			if var_601_6 < arg_598_1.time_ and arg_598_1.time_ <= var_601_6 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				local var_601_8 = arg_598_1:FormatText(StoryNameCfg[7].name)

				arg_598_1.leftNameTxt_.text = var_601_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, true)
				arg_598_1.iconController_:SetSelectedState("hero")

				arg_598_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_598_1.callingController_:SetSelectedState("normal")

				arg_598_1.keyicon_.color = Color.New(1, 1, 1)
				arg_598_1.icon_.color = Color.New(1, 1, 1)

				local var_601_9 = arg_598_1:GetWordFromCfg(1109503141)
				local var_601_10 = arg_598_1:FormatText(var_601_9.content)

				arg_598_1.text_.text = var_601_10

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_11 = 14
				local var_601_12 = utf8.len(var_601_10)
				local var_601_13 = var_601_11 <= 0 and var_601_7 or var_601_7 * (var_601_12 / var_601_11)

				if var_601_13 > 0 and var_601_7 < var_601_13 then
					arg_598_1.talkMaxDuration = var_601_13

					if var_601_13 + var_601_6 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_13 + var_601_6
					end
				end

				arg_598_1.text_.text = var_601_10
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)
				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_14 = math.max(var_601_7, arg_598_1.talkMaxDuration)

			if var_601_6 <= arg_598_1.time_ and arg_598_1.time_ < var_601_6 + var_601_14 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_6) / var_601_14

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_6 + var_601_14 and arg_598_1.time_ < var_601_6 + var_601_14 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {}

		arg_598_1:InitPlayNodeList()
	end,
	Play1109503142 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1109503142
		arg_602_1.duration_ = 6.47

		local var_602_0 = {
			zh = 2.1,
			ja = 6.466
		}
		local var_602_1 = manager.audio:GetLocalizationFlag()

		if var_602_0[var_602_1] ~= nil then
			arg_602_1.duration_ = var_602_0[var_602_1]
		end

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1109503143(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			local var_605_0 = arg_602_1.actors_["10058ui_story"]
			local var_605_1 = 0

			if var_605_1 < arg_602_1.time_ and arg_602_1.time_ <= var_605_1 + arg_605_0 and not isNil(var_605_0) and arg_602_1.var_.characterEffect10058ui_story == nil then
				arg_602_1.var_.characterEffect10058ui_story = var_605_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_2 = 0.200000002980232

			if var_605_1 <= arg_602_1.time_ and arg_602_1.time_ < var_605_1 + var_605_2 and not isNil(var_605_0) then
				local var_605_3 = (arg_602_1.time_ - var_605_1) / var_605_2

				if arg_602_1.var_.characterEffect10058ui_story and not isNil(var_605_0) then
					arg_602_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_602_1.time_ >= var_605_1 + var_605_2 and arg_602_1.time_ < var_605_1 + var_605_2 + arg_605_0 and not isNil(var_605_0) and arg_602_1.var_.characterEffect10058ui_story then
				arg_602_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_605_4 = 0
			local var_605_5 = 0.25

			if var_605_4 < arg_602_1.time_ and arg_602_1.time_ <= var_605_4 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				local var_605_6 = arg_602_1:FormatText(StoryNameCfg[471].name)

				arg_602_1.leftNameTxt_.text = var_605_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_7 = arg_602_1:GetWordFromCfg(1109503142)
				local var_605_8 = arg_602_1:FormatText(var_605_7.content)

				arg_602_1.text_.text = var_605_8

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_9 = 10
				local var_605_10 = utf8.len(var_605_8)
				local var_605_11 = var_605_9 <= 0 and var_605_5 or var_605_5 * (var_605_10 / var_605_9)

				if var_605_11 > 0 and var_605_5 < var_605_11 then
					arg_602_1.talkMaxDuration = var_605_11

					if var_605_11 + var_605_4 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_11 + var_605_4
					end
				end

				arg_602_1.text_.text = var_605_8
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503142", "story_v_side_new_1109503.awb") ~= 0 then
					local var_605_12 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503142", "story_v_side_new_1109503.awb") / 1000

					if var_605_12 + var_605_4 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_12 + var_605_4
					end

					if var_605_7.prefab_name ~= "" and arg_602_1.actors_[var_605_7.prefab_name] ~= nil then
						local var_605_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_602_1.actors_[var_605_7.prefab_name].transform, "story_v_side_new_1109503", "1109503142", "story_v_side_new_1109503.awb")

						arg_602_1:RecordAudio("1109503142", var_605_13)
						arg_602_1:RecordAudio("1109503142", var_605_13)
					else
						arg_602_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503142", "story_v_side_new_1109503.awb")
					end

					arg_602_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503142", "story_v_side_new_1109503.awb")
				end

				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_14 = math.max(var_605_5, arg_602_1.talkMaxDuration)

			if var_605_4 <= arg_602_1.time_ and arg_602_1.time_ < var_605_4 + var_605_14 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_4) / var_605_14

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_4 + var_605_14 and arg_602_1.time_ < var_605_4 + var_605_14 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {}

		arg_602_1:InitPlayNodeList()
	end,
	Play1109503143 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1109503143
		arg_606_1.duration_ = 9.13

		local var_606_0 = {
			zh = 5.9,
			ja = 9.133
		}
		local var_606_1 = manager.audio:GetLocalizationFlag()

		if var_606_0[var_606_1] ~= nil then
			arg_606_1.duration_ = var_606_0[var_606_1]
		end

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1109503144(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = arg_606_1.actors_["10058ui_story"]
			local var_609_1 = 0

			if var_609_1 < arg_606_1.time_ and arg_606_1.time_ <= var_609_1 + arg_609_0 and not isNil(var_609_0) and arg_606_1.var_.characterEffect10058ui_story == nil then
				arg_606_1.var_.characterEffect10058ui_story = var_609_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_2 = 0.200000002980232

			if var_609_1 <= arg_606_1.time_ and arg_606_1.time_ < var_609_1 + var_609_2 and not isNil(var_609_0) then
				local var_609_3 = (arg_606_1.time_ - var_609_1) / var_609_2

				if arg_606_1.var_.characterEffect10058ui_story and not isNil(var_609_0) then
					arg_606_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_606_1.time_ >= var_609_1 + var_609_2 and arg_606_1.time_ < var_609_1 + var_609_2 + arg_609_0 and not isNil(var_609_0) and arg_606_1.var_.characterEffect10058ui_story then
				arg_606_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_609_4 = 0

			if var_609_4 < arg_606_1.time_ and arg_606_1.time_ <= var_609_4 + arg_609_0 then
				arg_606_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_609_5 = 0
			local var_609_6 = 0.7

			if var_609_5 < arg_606_1.time_ and arg_606_1.time_ <= var_609_5 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				local var_609_7 = arg_606_1:FormatText(StoryNameCfg[471].name)

				arg_606_1.leftNameTxt_.text = var_609_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_8 = arg_606_1:GetWordFromCfg(1109503143)
				local var_609_9 = arg_606_1:FormatText(var_609_8.content)

				arg_606_1.text_.text = var_609_9

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_10 = 28
				local var_609_11 = utf8.len(var_609_9)
				local var_609_12 = var_609_10 <= 0 and var_609_6 or var_609_6 * (var_609_11 / var_609_10)

				if var_609_12 > 0 and var_609_6 < var_609_12 then
					arg_606_1.talkMaxDuration = var_609_12

					if var_609_12 + var_609_5 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_12 + var_609_5
					end
				end

				arg_606_1.text_.text = var_609_9
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503143", "story_v_side_new_1109503.awb") ~= 0 then
					local var_609_13 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503143", "story_v_side_new_1109503.awb") / 1000

					if var_609_13 + var_609_5 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_13 + var_609_5
					end

					if var_609_8.prefab_name ~= "" and arg_606_1.actors_[var_609_8.prefab_name] ~= nil then
						local var_609_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_8.prefab_name].transform, "story_v_side_new_1109503", "1109503143", "story_v_side_new_1109503.awb")

						arg_606_1:RecordAudio("1109503143", var_609_14)
						arg_606_1:RecordAudio("1109503143", var_609_14)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503143", "story_v_side_new_1109503.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503143", "story_v_side_new_1109503.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_15 = math.max(var_609_6, arg_606_1.talkMaxDuration)

			if var_609_5 <= arg_606_1.time_ and arg_606_1.time_ < var_609_5 + var_609_15 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_5) / var_609_15

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_5 + var_609_15 and arg_606_1.time_ < var_609_5 + var_609_15 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {}

		arg_606_1:InitPlayNodeList()
	end,
	Play1109503144 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 1109503144
		arg_610_1.duration_ = 5

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play1109503145(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = arg_610_1.actors_["10058ui_story"]
			local var_613_1 = 0

			if var_613_1 < arg_610_1.time_ and arg_610_1.time_ <= var_613_1 + arg_613_0 and not isNil(var_613_0) and arg_610_1.var_.characterEffect10058ui_story == nil then
				arg_610_1.var_.characterEffect10058ui_story = var_613_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_2 = 0.200000002980232

			if var_613_1 <= arg_610_1.time_ and arg_610_1.time_ < var_613_1 + var_613_2 and not isNil(var_613_0) then
				local var_613_3 = (arg_610_1.time_ - var_613_1) / var_613_2

				if arg_610_1.var_.characterEffect10058ui_story and not isNil(var_613_0) then
					local var_613_4 = Mathf.Lerp(0, 0.5, var_613_3)

					arg_610_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_610_1.var_.characterEffect10058ui_story.fillRatio = var_613_4
				end
			end

			if arg_610_1.time_ >= var_613_1 + var_613_2 and arg_610_1.time_ < var_613_1 + var_613_2 + arg_613_0 and not isNil(var_613_0) and arg_610_1.var_.characterEffect10058ui_story then
				local var_613_5 = 0.5

				arg_610_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_610_1.var_.characterEffect10058ui_story.fillRatio = var_613_5
			end

			local var_613_6 = 0
			local var_613_7 = 0.35

			if var_613_6 < arg_610_1.time_ and arg_610_1.time_ <= var_613_6 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, true)

				local var_613_8 = arg_610_1:FormatText(StoryNameCfg[7].name)

				arg_610_1.leftNameTxt_.text = var_613_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_610_1.leftNameTxt_.transform)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1.leftNameTxt_.text)
				SetActive(arg_610_1.iconTrs_.gameObject, true)
				arg_610_1.iconController_:SetSelectedState("hero")

				arg_610_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_610_1.callingController_:SetSelectedState("normal")

				arg_610_1.keyicon_.color = Color.New(1, 1, 1)
				arg_610_1.icon_.color = Color.New(1, 1, 1)

				local var_613_9 = arg_610_1:GetWordFromCfg(1109503144)
				local var_613_10 = arg_610_1:FormatText(var_613_9.content)

				arg_610_1.text_.text = var_613_10

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_11 = 14
				local var_613_12 = utf8.len(var_613_10)
				local var_613_13 = var_613_11 <= 0 and var_613_7 or var_613_7 * (var_613_12 / var_613_11)

				if var_613_13 > 0 and var_613_7 < var_613_13 then
					arg_610_1.talkMaxDuration = var_613_13

					if var_613_13 + var_613_6 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_13 + var_613_6
					end
				end

				arg_610_1.text_.text = var_613_10
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)
				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_14 = math.max(var_613_7, arg_610_1.talkMaxDuration)

			if var_613_6 <= arg_610_1.time_ and arg_610_1.time_ < var_613_6 + var_613_14 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_6) / var_613_14

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_6 + var_613_14 and arg_610_1.time_ < var_613_6 + var_613_14 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play1109503145 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1109503145
		arg_614_1.duration_ = 5.2

		local var_614_0 = {
			zh = 2.6,
			ja = 5.2
		}
		local var_614_1 = manager.audio:GetLocalizationFlag()

		if var_614_0[var_614_1] ~= nil then
			arg_614_1.duration_ = var_614_0[var_614_1]
		end

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1109503146(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = arg_614_1.actors_["10058ui_story"].transform
			local var_617_1 = 0

			if var_617_1 < arg_614_1.time_ and arg_614_1.time_ <= var_617_1 + arg_617_0 then
				arg_614_1.var_.moveOldPos10058ui_story = var_617_0.localPosition
			end

			local var_617_2 = 0.001

			if var_617_1 <= arg_614_1.time_ and arg_614_1.time_ < var_617_1 + var_617_2 then
				local var_617_3 = (arg_614_1.time_ - var_617_1) / var_617_2
				local var_617_4 = Vector3.New(0, -0.98, -6.1)

				var_617_0.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPos10058ui_story, var_617_4, var_617_3)

				local var_617_5 = manager.ui.mainCamera.transform.position - var_617_0.position

				var_617_0.forward = Vector3.New(var_617_5.x, var_617_5.y, var_617_5.z)

				local var_617_6 = var_617_0.localEulerAngles

				var_617_6.z = 0
				var_617_6.x = 0
				var_617_0.localEulerAngles = var_617_6
			end

			if arg_614_1.time_ >= var_617_1 + var_617_2 and arg_614_1.time_ < var_617_1 + var_617_2 + arg_617_0 then
				var_617_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_617_7 = manager.ui.mainCamera.transform.position - var_617_0.position

				var_617_0.forward = Vector3.New(var_617_7.x, var_617_7.y, var_617_7.z)

				local var_617_8 = var_617_0.localEulerAngles

				var_617_8.z = 0
				var_617_8.x = 0
				var_617_0.localEulerAngles = var_617_8
			end

			local var_617_9 = arg_614_1.actors_["10058ui_story"]
			local var_617_10 = 0

			if var_617_10 < arg_614_1.time_ and arg_614_1.time_ <= var_617_10 + arg_617_0 and not isNil(var_617_9) and arg_614_1.var_.characterEffect10058ui_story == nil then
				arg_614_1.var_.characterEffect10058ui_story = var_617_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_617_11 = 0.200000002980232

			if var_617_10 <= arg_614_1.time_ and arg_614_1.time_ < var_617_10 + var_617_11 and not isNil(var_617_9) then
				local var_617_12 = (arg_614_1.time_ - var_617_10) / var_617_11

				if arg_614_1.var_.characterEffect10058ui_story and not isNil(var_617_9) then
					arg_614_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_614_1.time_ >= var_617_10 + var_617_11 and arg_614_1.time_ < var_617_10 + var_617_11 + arg_617_0 and not isNil(var_617_9) and arg_614_1.var_.characterEffect10058ui_story then
				arg_614_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_617_13 = 0

			if var_617_13 < arg_614_1.time_ and arg_614_1.time_ <= var_617_13 + arg_617_0 then
				arg_614_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_617_14 = 0

			if var_617_14 < arg_614_1.time_ and arg_614_1.time_ <= var_617_14 + arg_617_0 then
				arg_614_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_617_15 = 0
			local var_617_16 = 0.275

			if var_617_15 < arg_614_1.time_ and arg_614_1.time_ <= var_617_15 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				local var_617_17 = arg_614_1:FormatText(StoryNameCfg[471].name)

				arg_614_1.leftNameTxt_.text = var_617_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_18 = arg_614_1:GetWordFromCfg(1109503145)
				local var_617_19 = arg_614_1:FormatText(var_617_18.content)

				arg_614_1.text_.text = var_617_19

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_20 = 11
				local var_617_21 = utf8.len(var_617_19)
				local var_617_22 = var_617_20 <= 0 and var_617_16 or var_617_16 * (var_617_21 / var_617_20)

				if var_617_22 > 0 and var_617_16 < var_617_22 then
					arg_614_1.talkMaxDuration = var_617_22

					if var_617_22 + var_617_15 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_22 + var_617_15
					end
				end

				arg_614_1.text_.text = var_617_19
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503145", "story_v_side_new_1109503.awb") ~= 0 then
					local var_617_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503145", "story_v_side_new_1109503.awb") / 1000

					if var_617_23 + var_617_15 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_23 + var_617_15
					end

					if var_617_18.prefab_name ~= "" and arg_614_1.actors_[var_617_18.prefab_name] ~= nil then
						local var_617_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_18.prefab_name].transform, "story_v_side_new_1109503", "1109503145", "story_v_side_new_1109503.awb")

						arg_614_1:RecordAudio("1109503145", var_617_24)
						arg_614_1:RecordAudio("1109503145", var_617_24)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503145", "story_v_side_new_1109503.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503145", "story_v_side_new_1109503.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_25 = math.max(var_617_16, arg_614_1.talkMaxDuration)

			if var_617_15 <= arg_614_1.time_ and arg_614_1.time_ < var_617_15 + var_617_25 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_15) / var_617_25

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_15 + var_617_25 and arg_614_1.time_ < var_617_15 + var_617_25 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_614_1:InitPlayNodeList()
	end,
	Play1109503146 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1109503146
		arg_618_1.duration_ = 5

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play1109503147(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = arg_618_1.actors_["10058ui_story"].transform
			local var_621_1 = 0

			if var_621_1 < arg_618_1.time_ and arg_618_1.time_ <= var_621_1 + arg_621_0 then
				arg_618_1.var_.moveOldPos10058ui_story = var_621_0.localPosition
			end

			local var_621_2 = 0.001

			if var_621_1 <= arg_618_1.time_ and arg_618_1.time_ < var_621_1 + var_621_2 then
				local var_621_3 = (arg_618_1.time_ - var_621_1) / var_621_2
				local var_621_4 = Vector3.New(0, 100, 0)

				var_621_0.localPosition = Vector3.Lerp(arg_618_1.var_.moveOldPos10058ui_story, var_621_4, var_621_3)

				local var_621_5 = manager.ui.mainCamera.transform.position - var_621_0.position

				var_621_0.forward = Vector3.New(var_621_5.x, var_621_5.y, var_621_5.z)

				local var_621_6 = var_621_0.localEulerAngles

				var_621_6.z = 0
				var_621_6.x = 0
				var_621_0.localEulerAngles = var_621_6
			end

			if arg_618_1.time_ >= var_621_1 + var_621_2 and arg_618_1.time_ < var_621_1 + var_621_2 + arg_621_0 then
				var_621_0.localPosition = Vector3.New(0, 100, 0)

				local var_621_7 = manager.ui.mainCamera.transform.position - var_621_0.position

				var_621_0.forward = Vector3.New(var_621_7.x, var_621_7.y, var_621_7.z)

				local var_621_8 = var_621_0.localEulerAngles

				var_621_8.z = 0
				var_621_8.x = 0
				var_621_0.localEulerAngles = var_621_8
			end

			local var_621_9 = 0
			local var_621_10 = 0.325

			if var_621_9 < arg_618_1.time_ and arg_618_1.time_ <= var_621_9 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, false)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_11 = arg_618_1:GetWordFromCfg(1109503146)
				local var_621_12 = arg_618_1:FormatText(var_621_11.content)

				arg_618_1.text_.text = var_621_12

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_13 = 13
				local var_621_14 = utf8.len(var_621_12)
				local var_621_15 = var_621_13 <= 0 and var_621_10 or var_621_10 * (var_621_14 / var_621_13)

				if var_621_15 > 0 and var_621_10 < var_621_15 then
					arg_618_1.talkMaxDuration = var_621_15

					if var_621_15 + var_621_9 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_15 + var_621_9
					end
				end

				arg_618_1.text_.text = var_621_12
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)
				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_16 = math.max(var_621_10, arg_618_1.talkMaxDuration)

			if var_621_9 <= arg_618_1.time_ and arg_618_1.time_ < var_621_9 + var_621_16 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_9) / var_621_16

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_9 + var_621_16 and arg_618_1.time_ < var_621_9 + var_621_16 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_618_1:InitPlayNodeList()
	end,
	Play1109503147 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1109503147
		arg_622_1.duration_ = 9

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1109503148(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = "ST15"

			if arg_622_1.bgs_[var_625_0] == nil then
				local var_625_1 = Object.Instantiate(arg_622_1.paintGo_)

				var_625_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_625_0)
				var_625_1.name = var_625_0
				var_625_1.transform.parent = arg_622_1.stage_.transform
				var_625_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_622_1.bgs_[var_625_0] = var_625_1
			end

			local var_625_2 = 2

			if var_625_2 < arg_622_1.time_ and arg_622_1.time_ <= var_625_2 + arg_625_0 then
				local var_625_3 = manager.ui.mainCamera.transform.localPosition
				local var_625_4 = Vector3.New(0, 0, 10) + Vector3.New(var_625_3.x, var_625_3.y, 0)
				local var_625_5 = arg_622_1.bgs_.ST15

				var_625_5.transform.localPosition = var_625_4
				var_625_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_625_6 = var_625_5:GetComponent("SpriteRenderer")

				if var_625_6 and var_625_6.sprite then
					local var_625_7 = (var_625_5.transform.localPosition - var_625_3).z
					local var_625_8 = manager.ui.mainCameraCom_
					local var_625_9 = 2 * var_625_7 * Mathf.Tan(var_625_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_625_10 = var_625_9 * var_625_8.aspect
					local var_625_11 = var_625_6.sprite.bounds.size.x
					local var_625_12 = var_625_6.sprite.bounds.size.y
					local var_625_13 = var_625_10 / var_625_11
					local var_625_14 = var_625_9 / var_625_12
					local var_625_15 = var_625_14 < var_625_13 and var_625_13 or var_625_14

					var_625_5.transform.localScale = Vector3.New(var_625_15, var_625_15, 0)
				end

				for iter_625_0, iter_625_1 in pairs(arg_622_1.bgs_) do
					if iter_625_0 ~= "ST15" then
						iter_625_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_625_16 = 0

			if var_625_16 < arg_622_1.time_ and arg_622_1.time_ <= var_625_16 + arg_625_0 then
				arg_622_1.mask_.enabled = true
				arg_622_1.mask_.raycastTarget = true

				arg_622_1:SetGaussion(false)
			end

			local var_625_17 = 2

			if var_625_16 <= arg_622_1.time_ and arg_622_1.time_ < var_625_16 + var_625_17 then
				local var_625_18 = (arg_622_1.time_ - var_625_16) / var_625_17
				local var_625_19 = Color.New(0, 0, 0)

				var_625_19.a = Mathf.Lerp(0, 1, var_625_18)
				arg_622_1.mask_.color = var_625_19
			end

			if arg_622_1.time_ >= var_625_16 + var_625_17 and arg_622_1.time_ < var_625_16 + var_625_17 + arg_625_0 then
				local var_625_20 = Color.New(0, 0, 0)

				var_625_20.a = 1
				arg_622_1.mask_.color = var_625_20
			end

			local var_625_21 = 2

			if var_625_21 < arg_622_1.time_ and arg_622_1.time_ <= var_625_21 + arg_625_0 then
				arg_622_1.mask_.enabled = true
				arg_622_1.mask_.raycastTarget = true

				arg_622_1:SetGaussion(false)
			end

			local var_625_22 = 2

			if var_625_21 <= arg_622_1.time_ and arg_622_1.time_ < var_625_21 + var_625_22 then
				local var_625_23 = (arg_622_1.time_ - var_625_21) / var_625_22
				local var_625_24 = Color.New(0, 0, 0)

				var_625_24.a = Mathf.Lerp(1, 0, var_625_23)
				arg_622_1.mask_.color = var_625_24
			end

			if arg_622_1.time_ >= var_625_21 + var_625_22 and arg_622_1.time_ < var_625_21 + var_625_22 + arg_625_0 then
				local var_625_25 = Color.New(0, 0, 0)
				local var_625_26 = 0

				arg_622_1.mask_.enabled = false
				var_625_25.a = var_625_26
				arg_622_1.mask_.color = var_625_25
			end

			local var_625_27 = 2
			local var_625_28 = 0.7

			if var_625_27 < arg_622_1.time_ and arg_622_1.time_ <= var_625_27 + arg_625_0 then
				local var_625_29 = "play"
				local var_625_30 = "effect"

				arg_622_1:AudioAction(var_625_29, var_625_30, "se_story_130", "se_story_130_sea", "")
			end

			local var_625_31 = 0
			local var_625_32 = 0.7

			if var_625_31 < arg_622_1.time_ and arg_622_1.time_ <= var_625_31 + arg_625_0 then
				local var_625_33 = "play"
				local var_625_34 = "music"

				arg_622_1:AudioAction(var_625_33, var_625_34, "ui_battle", "ui_battle_stopbgm", "")

				local var_625_35 = ""
				local var_625_36 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_625_36 ~= "" then
					if arg_622_1.bgmTxt_.text ~= var_625_36 and arg_622_1.bgmTxt_.text ~= "" then
						if arg_622_1.bgmTxt2_.text ~= "" then
							arg_622_1.bgmTxt_.text = arg_622_1.bgmTxt2_.text
						end

						arg_622_1.bgmTxt2_.text = var_625_36

						arg_622_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_622_1.bgmTxt_.text = var_625_36
						arg_622_1.bgmTxt2_.text = var_625_36
					end

					if arg_622_1.bgmTimer then
						arg_622_1.bgmTimer:Stop()

						arg_622_1.bgmTimer = nil
					end

					if arg_622_1.settingData.show_music_name == 1 then
						arg_622_1.musicController:SetSelectedState("show")
						arg_622_1.musicAnimator_:Play("open", 0, 0)

						if arg_622_1.settingData.music_time ~= 0 then
							arg_622_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_622_1.settingData.music_time), function()
								if arg_622_1 == nil or isNil(arg_622_1.bgmTxt_) then
									return
								end

								arg_622_1.musicController:SetSelectedState("hide")
								arg_622_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_625_37 = 0.833333333333333
			local var_625_38 = 1

			if var_625_37 < arg_622_1.time_ and arg_622_1.time_ <= var_625_37 + arg_625_0 then
				local var_625_39 = "play"
				local var_625_40 = "music"

				arg_622_1:AudioAction(var_625_39, var_625_40, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_625_41 = ""
				local var_625_42 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_625_42 ~= "" then
					if arg_622_1.bgmTxt_.text ~= var_625_42 and arg_622_1.bgmTxt_.text ~= "" then
						if arg_622_1.bgmTxt2_.text ~= "" then
							arg_622_1.bgmTxt_.text = arg_622_1.bgmTxt2_.text
						end

						arg_622_1.bgmTxt2_.text = var_625_42

						arg_622_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_622_1.bgmTxt_.text = var_625_42
						arg_622_1.bgmTxt2_.text = var_625_42
					end

					if arg_622_1.bgmTimer then
						arg_622_1.bgmTimer:Stop()

						arg_622_1.bgmTimer = nil
					end

					if arg_622_1.settingData.show_music_name == 1 then
						arg_622_1.musicController:SetSelectedState("show")
						arg_622_1.musicAnimator_:Play("open", 0, 0)

						if arg_622_1.settingData.music_time ~= 0 then
							arg_622_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_622_1.settingData.music_time), function()
								if arg_622_1 == nil or isNil(arg_622_1.bgmTxt_) then
									return
								end

								arg_622_1.musicController:SetSelectedState("hide")
								arg_622_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_622_1.frameCnt_ <= 1 then
				arg_622_1.dialog_:SetActive(false)
			end

			local var_625_43 = 3.999999999999
			local var_625_44 = 0.675

			if var_625_43 < arg_622_1.time_ and arg_622_1.time_ <= var_625_43 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0

				arg_622_1.dialog_:SetActive(true)

				arg_622_1.dialogCg_.alpha = 0

				local var_625_45 = LeanTween.value(arg_622_1.dialog_, 0, 1, 0.3)

				var_625_45:setOnUpdate(LuaHelper.FloatAction(function(arg_628_0)
					arg_622_1.dialogCg_.alpha = arg_628_0
				end))
				var_625_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_622_1.dialog_)
					var_625_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_622_1.duration_ = arg_622_1.duration_ + 0.3

				SetActive(arg_622_1.leftNameGo_, false)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_622_1.iconTrs_.gameObject, false)
				arg_622_1.callingController_:SetSelectedState("normal")

				local var_625_46 = arg_622_1:GetWordFromCfg(1109503147)
				local var_625_47 = arg_622_1:FormatText(var_625_46.content)

				arg_622_1.text_.text = var_625_47

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_48 = 27
				local var_625_49 = utf8.len(var_625_47)
				local var_625_50 = var_625_48 <= 0 and var_625_44 or var_625_44 * (var_625_49 / var_625_48)

				if var_625_50 > 0 and var_625_44 < var_625_50 then
					arg_622_1.talkMaxDuration = var_625_50
					var_625_43 = var_625_43 + 0.3

					if var_625_50 + var_625_43 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_50 + var_625_43
					end
				end

				arg_622_1.text_.text = var_625_47
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)
				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_51 = var_625_43 + 0.3
			local var_625_52 = math.max(var_625_44, arg_622_1.talkMaxDuration)

			if var_625_51 <= arg_622_1.time_ and arg_622_1.time_ < var_625_51 + var_625_52 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_51) / var_625_52

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_51 + var_625_52 and arg_622_1.time_ < var_625_51 + var_625_52 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play1109503148 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 1109503148
		arg_630_1.duration_ = 11.77

		local var_630_0 = {
			zh = 6.966,
			ja = 11.766
		}
		local var_630_1 = manager.audio:GetLocalizationFlag()

		if var_630_0[var_630_1] ~= nil then
			arg_630_1.duration_ = var_630_0[var_630_1]
		end

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play1109503149(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = 0
			local var_633_1 = 0.95

			if var_633_0 < arg_630_1.time_ and arg_630_1.time_ <= var_633_0 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				local var_633_2 = arg_630_1:FormatText(StoryNameCfg[666].name)

				arg_630_1.leftNameTxt_.text = var_633_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, true)
				arg_630_1.iconController_:SetSelectedState("hero")

				arg_630_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_630_1.callingController_:SetSelectedState("normal")

				arg_630_1.keyicon_.color = Color.New(1, 1, 1)
				arg_630_1.icon_.color = Color.New(1, 1, 1)

				local var_633_3 = arg_630_1:GetWordFromCfg(1109503148)
				local var_633_4 = arg_630_1:FormatText(var_633_3.content)

				arg_630_1.text_.text = var_633_4

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_5 = 38
				local var_633_6 = utf8.len(var_633_4)
				local var_633_7 = var_633_5 <= 0 and var_633_1 or var_633_1 * (var_633_6 / var_633_5)

				if var_633_7 > 0 and var_633_1 < var_633_7 then
					arg_630_1.talkMaxDuration = var_633_7

					if var_633_7 + var_633_0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_7 + var_633_0
					end
				end

				arg_630_1.text_.text = var_633_4
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503148", "story_v_side_new_1109503.awb") ~= 0 then
					local var_633_8 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503148", "story_v_side_new_1109503.awb") / 1000

					if var_633_8 + var_633_0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_8 + var_633_0
					end

					if var_633_3.prefab_name ~= "" and arg_630_1.actors_[var_633_3.prefab_name] ~= nil then
						local var_633_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_3.prefab_name].transform, "story_v_side_new_1109503", "1109503148", "story_v_side_new_1109503.awb")

						arg_630_1:RecordAudio("1109503148", var_633_9)
						arg_630_1:RecordAudio("1109503148", var_633_9)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503148", "story_v_side_new_1109503.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503148", "story_v_side_new_1109503.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_10 = math.max(var_633_1, arg_630_1.talkMaxDuration)

			if var_633_0 <= arg_630_1.time_ and arg_630_1.time_ < var_633_0 + var_633_10 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_0) / var_633_10

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_0 + var_633_10 and arg_630_1.time_ < var_633_0 + var_633_10 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play1109503149 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 1109503149
		arg_634_1.duration_ = 5.5

		local var_634_0 = {
			zh = 1.999999999999,
			ja = 5.5
		}
		local var_634_1 = manager.audio:GetLocalizationFlag()

		if var_634_0[var_634_1] ~= nil then
			arg_634_1.duration_ = var_634_0[var_634_1]
		end

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play1109503150(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			local var_637_0 = arg_634_1.actors_["10058ui_story"]
			local var_637_1 = 0

			if var_637_1 < arg_634_1.time_ and arg_634_1.time_ <= var_637_1 + arg_637_0 and not isNil(var_637_0) and arg_634_1.var_.characterEffect10058ui_story == nil then
				arg_634_1.var_.characterEffect10058ui_story = var_637_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_637_2 = 0.200000002980232

			if var_637_1 <= arg_634_1.time_ and arg_634_1.time_ < var_637_1 + var_637_2 and not isNil(var_637_0) then
				local var_637_3 = (arg_634_1.time_ - var_637_1) / var_637_2

				if arg_634_1.var_.characterEffect10058ui_story and not isNil(var_637_0) then
					arg_634_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_634_1.time_ >= var_637_1 + var_637_2 and arg_634_1.time_ < var_637_1 + var_637_2 + arg_637_0 and not isNil(var_637_0) and arg_634_1.var_.characterEffect10058ui_story then
				arg_634_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_637_4 = arg_634_1.actors_["10058ui_story"].transform
			local var_637_5 = 0

			if var_637_5 < arg_634_1.time_ and arg_634_1.time_ <= var_637_5 + arg_637_0 then
				arg_634_1.var_.moveOldPos10058ui_story = var_637_4.localPosition
			end

			local var_637_6 = 0.001

			if var_637_5 <= arg_634_1.time_ and arg_634_1.time_ < var_637_5 + var_637_6 then
				local var_637_7 = (arg_634_1.time_ - var_637_5) / var_637_6
				local var_637_8 = Vector3.New(0, -0.98, -6.1)

				var_637_4.localPosition = Vector3.Lerp(arg_634_1.var_.moveOldPos10058ui_story, var_637_8, var_637_7)

				local var_637_9 = manager.ui.mainCamera.transform.position - var_637_4.position

				var_637_4.forward = Vector3.New(var_637_9.x, var_637_9.y, var_637_9.z)

				local var_637_10 = var_637_4.localEulerAngles

				var_637_10.z = 0
				var_637_10.x = 0
				var_637_4.localEulerAngles = var_637_10
			end

			if arg_634_1.time_ >= var_637_5 + var_637_6 and arg_634_1.time_ < var_637_5 + var_637_6 + arg_637_0 then
				var_637_4.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_637_11 = manager.ui.mainCamera.transform.position - var_637_4.position

				var_637_4.forward = Vector3.New(var_637_11.x, var_637_11.y, var_637_11.z)

				local var_637_12 = var_637_4.localEulerAngles

				var_637_12.z = 0
				var_637_12.x = 0
				var_637_4.localEulerAngles = var_637_12
			end

			local var_637_13 = 0

			if var_637_13 < arg_634_1.time_ and arg_634_1.time_ <= var_637_13 + arg_637_0 then
				arg_634_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_637_14 = 0
			local var_637_15 = 0.15

			if var_637_14 < arg_634_1.time_ and arg_634_1.time_ <= var_637_14 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				local var_637_16 = arg_634_1:FormatText(StoryNameCfg[471].name)

				arg_634_1.leftNameTxt_.text = var_637_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, false)
				arg_634_1.callingController_:SetSelectedState("normal")

				local var_637_17 = arg_634_1:GetWordFromCfg(1109503149)
				local var_637_18 = arg_634_1:FormatText(var_637_17.content)

				arg_634_1.text_.text = var_637_18

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_19 = 6
				local var_637_20 = utf8.len(var_637_18)
				local var_637_21 = var_637_19 <= 0 and var_637_15 or var_637_15 * (var_637_20 / var_637_19)

				if var_637_21 > 0 and var_637_15 < var_637_21 then
					arg_634_1.talkMaxDuration = var_637_21

					if var_637_21 + var_637_14 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_21 + var_637_14
					end
				end

				arg_634_1.text_.text = var_637_18
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503149", "story_v_side_new_1109503.awb") ~= 0 then
					local var_637_22 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503149", "story_v_side_new_1109503.awb") / 1000

					if var_637_22 + var_637_14 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_22 + var_637_14
					end

					if var_637_17.prefab_name ~= "" and arg_634_1.actors_[var_637_17.prefab_name] ~= nil then
						local var_637_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_17.prefab_name].transform, "story_v_side_new_1109503", "1109503149", "story_v_side_new_1109503.awb")

						arg_634_1:RecordAudio("1109503149", var_637_23)
						arg_634_1:RecordAudio("1109503149", var_637_23)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503149", "story_v_side_new_1109503.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503149", "story_v_side_new_1109503.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_24 = math.max(var_637_15, arg_634_1.talkMaxDuration)

			if var_637_14 <= arg_634_1.time_ and arg_634_1.time_ < var_637_14 + var_637_24 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_14) / var_637_24

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_14 + var_637_24 and arg_634_1.time_ < var_637_14 + var_637_24 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_634_1:InitPlayNodeList()
	end,
	Play1109503150 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 1109503150
		arg_638_1.duration_ = 5.37

		local var_638_0 = {
			zh = 5.366,
			ja = 5.166
		}
		local var_638_1 = manager.audio:GetLocalizationFlag()

		if var_638_0[var_638_1] ~= nil then
			arg_638_1.duration_ = var_638_0[var_638_1]
		end

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play1109503151(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			local var_641_0 = arg_638_1.actors_["10058ui_story"]
			local var_641_1 = 0

			if var_641_1 < arg_638_1.time_ and arg_638_1.time_ <= var_641_1 + arg_641_0 and not isNil(var_641_0) and arg_638_1.var_.characterEffect10058ui_story == nil then
				arg_638_1.var_.characterEffect10058ui_story = var_641_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_641_2 = 0.200000002980232

			if var_641_1 <= arg_638_1.time_ and arg_638_1.time_ < var_641_1 + var_641_2 and not isNil(var_641_0) then
				local var_641_3 = (arg_638_1.time_ - var_641_1) / var_641_2

				if arg_638_1.var_.characterEffect10058ui_story and not isNil(var_641_0) then
					local var_641_4 = Mathf.Lerp(0, 0.5, var_641_3)

					arg_638_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_638_1.var_.characterEffect10058ui_story.fillRatio = var_641_4
				end
			end

			if arg_638_1.time_ >= var_641_1 + var_641_2 and arg_638_1.time_ < var_641_1 + var_641_2 + arg_641_0 and not isNil(var_641_0) and arg_638_1.var_.characterEffect10058ui_story then
				local var_641_5 = 0.5

				arg_638_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_638_1.var_.characterEffect10058ui_story.fillRatio = var_641_5
			end

			local var_641_6 = 0
			local var_641_7 = 0.65

			if var_641_6 < arg_638_1.time_ and arg_638_1.time_ <= var_641_6 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, true)

				local var_641_8 = arg_638_1:FormatText(StoryNameCfg[666].name)

				arg_638_1.leftNameTxt_.text = var_641_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_638_1.leftNameTxt_.transform)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1.leftNameTxt_.text)
				SetActive(arg_638_1.iconTrs_.gameObject, true)
				arg_638_1.iconController_:SetSelectedState("hero")

				arg_638_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_638_1.callingController_:SetSelectedState("normal")

				arg_638_1.keyicon_.color = Color.New(1, 1, 1)
				arg_638_1.icon_.color = Color.New(1, 1, 1)

				local var_641_9 = arg_638_1:GetWordFromCfg(1109503150)
				local var_641_10 = arg_638_1:FormatText(var_641_9.content)

				arg_638_1.text_.text = var_641_10

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_11 = 26
				local var_641_12 = utf8.len(var_641_10)
				local var_641_13 = var_641_11 <= 0 and var_641_7 or var_641_7 * (var_641_12 / var_641_11)

				if var_641_13 > 0 and var_641_7 < var_641_13 then
					arg_638_1.talkMaxDuration = var_641_13

					if var_641_13 + var_641_6 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_13 + var_641_6
					end
				end

				arg_638_1.text_.text = var_641_10
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503150", "story_v_side_new_1109503.awb") ~= 0 then
					local var_641_14 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503150", "story_v_side_new_1109503.awb") / 1000

					if var_641_14 + var_641_6 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_14 + var_641_6
					end

					if var_641_9.prefab_name ~= "" and arg_638_1.actors_[var_641_9.prefab_name] ~= nil then
						local var_641_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_638_1.actors_[var_641_9.prefab_name].transform, "story_v_side_new_1109503", "1109503150", "story_v_side_new_1109503.awb")

						arg_638_1:RecordAudio("1109503150", var_641_15)
						arg_638_1:RecordAudio("1109503150", var_641_15)
					else
						arg_638_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503150", "story_v_side_new_1109503.awb")
					end

					arg_638_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503150", "story_v_side_new_1109503.awb")
				end

				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_16 = math.max(var_641_7, arg_638_1.talkMaxDuration)

			if var_641_6 <= arg_638_1.time_ and arg_638_1.time_ < var_641_6 + var_641_16 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_6) / var_641_16

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_6 + var_641_16 and arg_638_1.time_ < var_641_6 + var_641_16 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {}

		arg_638_1:InitPlayNodeList()
	end,
	Play1109503151 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 1109503151
		arg_642_1.duration_ = 5

		local var_642_0 = {
			zh = 3.9,
			ja = 5
		}
		local var_642_1 = manager.audio:GetLocalizationFlag()

		if var_642_0[var_642_1] ~= nil then
			arg_642_1.duration_ = var_642_0[var_642_1]
		end

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play1109503152(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			local var_645_0 = arg_642_1.actors_["10058ui_story"].transform
			local var_645_1 = 0

			if var_645_1 < arg_642_1.time_ and arg_642_1.time_ <= var_645_1 + arg_645_0 then
				arg_642_1.var_.moveOldPos10058ui_story = var_645_0.localPosition
			end

			local var_645_2 = 0.001

			if var_645_1 <= arg_642_1.time_ and arg_642_1.time_ < var_645_1 + var_645_2 then
				local var_645_3 = (arg_642_1.time_ - var_645_1) / var_645_2
				local var_645_4 = Vector3.New(0, -0.98, -6.1)

				var_645_0.localPosition = Vector3.Lerp(arg_642_1.var_.moveOldPos10058ui_story, var_645_4, var_645_3)

				local var_645_5 = manager.ui.mainCamera.transform.position - var_645_0.position

				var_645_0.forward = Vector3.New(var_645_5.x, var_645_5.y, var_645_5.z)

				local var_645_6 = var_645_0.localEulerAngles

				var_645_6.z = 0
				var_645_6.x = 0
				var_645_0.localEulerAngles = var_645_6
			end

			if arg_642_1.time_ >= var_645_1 + var_645_2 and arg_642_1.time_ < var_645_1 + var_645_2 + arg_645_0 then
				var_645_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_645_7 = manager.ui.mainCamera.transform.position - var_645_0.position

				var_645_0.forward = Vector3.New(var_645_7.x, var_645_7.y, var_645_7.z)

				local var_645_8 = var_645_0.localEulerAngles

				var_645_8.z = 0
				var_645_8.x = 0
				var_645_0.localEulerAngles = var_645_8
			end

			local var_645_9 = arg_642_1.actors_["10058ui_story"]
			local var_645_10 = 0

			if var_645_10 < arg_642_1.time_ and arg_642_1.time_ <= var_645_10 + arg_645_0 and not isNil(var_645_9) and arg_642_1.var_.characterEffect10058ui_story == nil then
				arg_642_1.var_.characterEffect10058ui_story = var_645_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_645_11 = 0.200000002980232

			if var_645_10 <= arg_642_1.time_ and arg_642_1.time_ < var_645_10 + var_645_11 and not isNil(var_645_9) then
				local var_645_12 = (arg_642_1.time_ - var_645_10) / var_645_11

				if arg_642_1.var_.characterEffect10058ui_story and not isNil(var_645_9) then
					arg_642_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_642_1.time_ >= var_645_10 + var_645_11 and arg_642_1.time_ < var_645_10 + var_645_11 + arg_645_0 and not isNil(var_645_9) and arg_642_1.var_.characterEffect10058ui_story then
				arg_642_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_645_13 = 0
			local var_645_14 = 0.25

			if var_645_13 < arg_642_1.time_ and arg_642_1.time_ <= var_645_13 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				local var_645_15 = arg_642_1:FormatText(StoryNameCfg[471].name)

				arg_642_1.leftNameTxt_.text = var_645_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_16 = arg_642_1:GetWordFromCfg(1109503151)
				local var_645_17 = arg_642_1:FormatText(var_645_16.content)

				arg_642_1.text_.text = var_645_17

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_18 = 10
				local var_645_19 = utf8.len(var_645_17)
				local var_645_20 = var_645_18 <= 0 and var_645_14 or var_645_14 * (var_645_19 / var_645_18)

				if var_645_20 > 0 and var_645_14 < var_645_20 then
					arg_642_1.talkMaxDuration = var_645_20

					if var_645_20 + var_645_13 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_20 + var_645_13
					end
				end

				arg_642_1.text_.text = var_645_17
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503151", "story_v_side_new_1109503.awb") ~= 0 then
					local var_645_21 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503151", "story_v_side_new_1109503.awb") / 1000

					if var_645_21 + var_645_13 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_21 + var_645_13
					end

					if var_645_16.prefab_name ~= "" and arg_642_1.actors_[var_645_16.prefab_name] ~= nil then
						local var_645_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_642_1.actors_[var_645_16.prefab_name].transform, "story_v_side_new_1109503", "1109503151", "story_v_side_new_1109503.awb")

						arg_642_1:RecordAudio("1109503151", var_645_22)
						arg_642_1:RecordAudio("1109503151", var_645_22)
					else
						arg_642_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503151", "story_v_side_new_1109503.awb")
					end

					arg_642_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503151", "story_v_side_new_1109503.awb")
				end

				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_23 = math.max(var_645_14, arg_642_1.talkMaxDuration)

			if var_645_13 <= arg_642_1.time_ and arg_642_1.time_ < var_645_13 + var_645_23 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_13) / var_645_23

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_13 + var_645_23 and arg_642_1.time_ < var_645_13 + var_645_23 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_642_1:InitPlayNodeList()
	end,
	Play1109503152 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 1109503152
		arg_646_1.duration_ = 5

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play1109503153(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			local var_649_0 = arg_646_1.actors_["10058ui_story"]
			local var_649_1 = 0

			if var_649_1 < arg_646_1.time_ and arg_646_1.time_ <= var_649_1 + arg_649_0 and not isNil(var_649_0) and arg_646_1.var_.characterEffect10058ui_story == nil then
				arg_646_1.var_.characterEffect10058ui_story = var_649_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_649_2 = 0.200000002980232

			if var_649_1 <= arg_646_1.time_ and arg_646_1.time_ < var_649_1 + var_649_2 and not isNil(var_649_0) then
				local var_649_3 = (arg_646_1.time_ - var_649_1) / var_649_2

				if arg_646_1.var_.characterEffect10058ui_story and not isNil(var_649_0) then
					local var_649_4 = Mathf.Lerp(0, 0.5, var_649_3)

					arg_646_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_646_1.var_.characterEffect10058ui_story.fillRatio = var_649_4
				end
			end

			if arg_646_1.time_ >= var_649_1 + var_649_2 and arg_646_1.time_ < var_649_1 + var_649_2 + arg_649_0 and not isNil(var_649_0) and arg_646_1.var_.characterEffect10058ui_story then
				local var_649_5 = 0.5

				arg_646_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_646_1.var_.characterEffect10058ui_story.fillRatio = var_649_5
			end

			local var_649_6 = 0
			local var_649_7 = 0.225

			if var_649_6 < arg_646_1.time_ and arg_646_1.time_ <= var_649_6 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, true)

				local var_649_8 = arg_646_1:FormatText(StoryNameCfg[7].name)

				arg_646_1.leftNameTxt_.text = var_649_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_646_1.leftNameTxt_.transform)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1.leftNameTxt_.text)
				SetActive(arg_646_1.iconTrs_.gameObject, true)
				arg_646_1.iconController_:SetSelectedState("hero")

				arg_646_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_646_1.callingController_:SetSelectedState("normal")

				arg_646_1.keyicon_.color = Color.New(1, 1, 1)
				arg_646_1.icon_.color = Color.New(1, 1, 1)

				local var_649_9 = arg_646_1:GetWordFromCfg(1109503152)
				local var_649_10 = arg_646_1:FormatText(var_649_9.content)

				arg_646_1.text_.text = var_649_10

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_11 = 9
				local var_649_12 = utf8.len(var_649_10)
				local var_649_13 = var_649_11 <= 0 and var_649_7 or var_649_7 * (var_649_12 / var_649_11)

				if var_649_13 > 0 and var_649_7 < var_649_13 then
					arg_646_1.talkMaxDuration = var_649_13

					if var_649_13 + var_649_6 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_13 + var_649_6
					end
				end

				arg_646_1.text_.text = var_649_10
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_14 = math.max(var_649_7, arg_646_1.talkMaxDuration)

			if var_649_6 <= arg_646_1.time_ and arg_646_1.time_ < var_649_6 + var_649_14 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_6) / var_649_14

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_6 + var_649_14 and arg_646_1.time_ < var_649_6 + var_649_14 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {}

		arg_646_1:InitPlayNodeList()
	end,
	Play1109503153 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 1109503153
		arg_650_1.duration_ = 9.43

		local var_650_0 = {
			zh = 8.133,
			ja = 9.433
		}
		local var_650_1 = manager.audio:GetLocalizationFlag()

		if var_650_0[var_650_1] ~= nil then
			arg_650_1.duration_ = var_650_0[var_650_1]
		end

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play1109503154(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			local var_653_0 = 0
			local var_653_1 = 1.05

			if var_653_0 < arg_650_1.time_ and arg_650_1.time_ <= var_653_0 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0
				arg_650_1.dialogCg_.alpha = 1

				arg_650_1.dialog_:SetActive(true)
				SetActive(arg_650_1.leftNameGo_, true)

				local var_653_2 = arg_650_1:FormatText(StoryNameCfg[666].name)

				arg_650_1.leftNameTxt_.text = var_653_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, true)
				arg_650_1.iconController_:SetSelectedState("hero")

				arg_650_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_650_1.callingController_:SetSelectedState("normal")

				arg_650_1.keyicon_.color = Color.New(1, 1, 1)
				arg_650_1.icon_.color = Color.New(1, 1, 1)

				local var_653_3 = arg_650_1:GetWordFromCfg(1109503153)
				local var_653_4 = arg_650_1:FormatText(var_653_3.content)

				arg_650_1.text_.text = var_653_4

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_5 = 42
				local var_653_6 = utf8.len(var_653_4)
				local var_653_7 = var_653_5 <= 0 and var_653_1 or var_653_1 * (var_653_6 / var_653_5)

				if var_653_7 > 0 and var_653_1 < var_653_7 then
					arg_650_1.talkMaxDuration = var_653_7

					if var_653_7 + var_653_0 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_7 + var_653_0
					end
				end

				arg_650_1.text_.text = var_653_4
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503153", "story_v_side_new_1109503.awb") ~= 0 then
					local var_653_8 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503153", "story_v_side_new_1109503.awb") / 1000

					if var_653_8 + var_653_0 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_8 + var_653_0
					end

					if var_653_3.prefab_name ~= "" and arg_650_1.actors_[var_653_3.prefab_name] ~= nil then
						local var_653_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_650_1.actors_[var_653_3.prefab_name].transform, "story_v_side_new_1109503", "1109503153", "story_v_side_new_1109503.awb")

						arg_650_1:RecordAudio("1109503153", var_653_9)
						arg_650_1:RecordAudio("1109503153", var_653_9)
					else
						arg_650_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503153", "story_v_side_new_1109503.awb")
					end

					arg_650_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503153", "story_v_side_new_1109503.awb")
				end

				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_10 = math.max(var_653_1, arg_650_1.talkMaxDuration)

			if var_653_0 <= arg_650_1.time_ and arg_650_1.time_ < var_653_0 + var_653_10 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_0) / var_653_10

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_0 + var_653_10 and arg_650_1.time_ < var_653_0 + var_653_10 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {}

		arg_650_1:InitPlayNodeList()
	end,
	Play1109503154 = function(arg_654_0, arg_654_1)
		arg_654_1.time_ = 0
		arg_654_1.frameCnt_ = 0
		arg_654_1.state_ = "playing"
		arg_654_1.curTalkId_ = 1109503154
		arg_654_1.duration_ = 5

		SetActive(arg_654_1.tipsGo_, false)

		function arg_654_1.onSingleLineFinish_()
			arg_654_1.onSingleLineUpdate_ = nil
			arg_654_1.onSingleLineFinish_ = nil
			arg_654_1.state_ = "waiting"
		end

		function arg_654_1.playNext_(arg_656_0)
			if arg_656_0 == 1 then
				arg_654_0:Play1109503155(arg_654_1)
			end
		end

		function arg_654_1.onSingleLineUpdate_(arg_657_0)
			local var_657_0 = 0
			local var_657_1 = 0.15

			if var_657_0 < arg_654_1.time_ and arg_654_1.time_ <= var_657_0 + arg_657_0 then
				arg_654_1.talkMaxDuration = 0
				arg_654_1.dialogCg_.alpha = 1

				arg_654_1.dialog_:SetActive(true)
				SetActive(arg_654_1.leftNameGo_, true)

				local var_657_2 = arg_654_1:FormatText(StoryNameCfg[7].name)

				arg_654_1.leftNameTxt_.text = var_657_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_654_1.leftNameTxt_.transform)

				arg_654_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_654_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_654_1:RecordName(arg_654_1.leftNameTxt_.text)
				SetActive(arg_654_1.iconTrs_.gameObject, true)
				arg_654_1.iconController_:SetSelectedState("hero")

				arg_654_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_654_1.callingController_:SetSelectedState("normal")

				arg_654_1.keyicon_.color = Color.New(1, 1, 1)
				arg_654_1.icon_.color = Color.New(1, 1, 1)

				local var_657_3 = arg_654_1:GetWordFromCfg(1109503154)
				local var_657_4 = arg_654_1:FormatText(var_657_3.content)

				arg_654_1.text_.text = var_657_4

				LuaForUtil.ClearLinePrefixSymbol(arg_654_1.text_)

				local var_657_5 = 6
				local var_657_6 = utf8.len(var_657_4)
				local var_657_7 = var_657_5 <= 0 and var_657_1 or var_657_1 * (var_657_6 / var_657_5)

				if var_657_7 > 0 and var_657_1 < var_657_7 then
					arg_654_1.talkMaxDuration = var_657_7

					if var_657_7 + var_657_0 > arg_654_1.duration_ then
						arg_654_1.duration_ = var_657_7 + var_657_0
					end
				end

				arg_654_1.text_.text = var_657_4
				arg_654_1.typewritter.percent = 0

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(false)
				arg_654_1:RecordContent(arg_654_1.text_.text)
			end

			local var_657_8 = math.max(var_657_1, arg_654_1.talkMaxDuration)

			if var_657_0 <= arg_654_1.time_ and arg_654_1.time_ < var_657_0 + var_657_8 then
				arg_654_1.typewritter.percent = (arg_654_1.time_ - var_657_0) / var_657_8

				arg_654_1.typewritter:SetDirty()
			end

			if arg_654_1.time_ >= var_657_0 + var_657_8 and arg_654_1.time_ < var_657_0 + var_657_8 + arg_657_0 then
				arg_654_1.typewritter.percent = 1

				arg_654_1.typewritter:SetDirty()
				arg_654_1:ShowNextGo(true)
			end
		end

		arg_654_1.nodeConfigList_ = {}

		arg_654_1:InitPlayNodeList()
	end,
	Play1109503155 = function(arg_658_0, arg_658_1)
		arg_658_1.time_ = 0
		arg_658_1.frameCnt_ = 0
		arg_658_1.state_ = "playing"
		arg_658_1.curTalkId_ = 1109503155
		arg_658_1.duration_ = 5

		SetActive(arg_658_1.tipsGo_, false)

		function arg_658_1.onSingleLineFinish_()
			arg_658_1.onSingleLineUpdate_ = nil
			arg_658_1.onSingleLineFinish_ = nil
			arg_658_1.state_ = "waiting"
		end

		function arg_658_1.playNext_(arg_660_0)
			if arg_660_0 == 1 then
				arg_658_0:Play1109503156(arg_658_1)
			end
		end

		function arg_658_1.onSingleLineUpdate_(arg_661_0)
			local var_661_0 = 0
			local var_661_1 = 0.525

			if var_661_0 < arg_658_1.time_ and arg_658_1.time_ <= var_661_0 + arg_661_0 then
				arg_658_1.talkMaxDuration = 0
				arg_658_1.dialogCg_.alpha = 1

				arg_658_1.dialog_:SetActive(true)
				SetActive(arg_658_1.leftNameGo_, true)

				local var_661_2 = arg_658_1:FormatText(StoryNameCfg[7].name)

				arg_658_1.leftNameTxt_.text = var_661_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_658_1.leftNameTxt_.transform)

				arg_658_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_658_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_658_1:RecordName(arg_658_1.leftNameTxt_.text)
				SetActive(arg_658_1.iconTrs_.gameObject, true)
				arg_658_1.iconController_:SetSelectedState("hero")

				arg_658_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_658_1.callingController_:SetSelectedState("normal")

				arg_658_1.keyicon_.color = Color.New(1, 1, 1)
				arg_658_1.icon_.color = Color.New(1, 1, 1)

				local var_661_3 = arg_658_1:GetWordFromCfg(1109503155)
				local var_661_4 = arg_658_1:FormatText(var_661_3.content)

				arg_658_1.text_.text = var_661_4

				LuaForUtil.ClearLinePrefixSymbol(arg_658_1.text_)

				local var_661_5 = 21
				local var_661_6 = utf8.len(var_661_4)
				local var_661_7 = var_661_5 <= 0 and var_661_1 or var_661_1 * (var_661_6 / var_661_5)

				if var_661_7 > 0 and var_661_1 < var_661_7 then
					arg_658_1.talkMaxDuration = var_661_7

					if var_661_7 + var_661_0 > arg_658_1.duration_ then
						arg_658_1.duration_ = var_661_7 + var_661_0
					end
				end

				arg_658_1.text_.text = var_661_4
				arg_658_1.typewritter.percent = 0

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(false)
				arg_658_1:RecordContent(arg_658_1.text_.text)
			end

			local var_661_8 = math.max(var_661_1, arg_658_1.talkMaxDuration)

			if var_661_0 <= arg_658_1.time_ and arg_658_1.time_ < var_661_0 + var_661_8 then
				arg_658_1.typewritter.percent = (arg_658_1.time_ - var_661_0) / var_661_8

				arg_658_1.typewritter:SetDirty()
			end

			if arg_658_1.time_ >= var_661_0 + var_661_8 and arg_658_1.time_ < var_661_0 + var_661_8 + arg_661_0 then
				arg_658_1.typewritter.percent = 1

				arg_658_1.typewritter:SetDirty()
				arg_658_1:ShowNextGo(true)
			end
		end

		arg_658_1.nodeConfigList_ = {}

		arg_658_1:InitPlayNodeList()
	end,
	Play1109503156 = function(arg_662_0, arg_662_1)
		arg_662_1.time_ = 0
		arg_662_1.frameCnt_ = 0
		arg_662_1.state_ = "playing"
		arg_662_1.curTalkId_ = 1109503156
		arg_662_1.duration_ = 6.87

		local var_662_0 = {
			zh = 5.6,
			ja = 6.866
		}
		local var_662_1 = manager.audio:GetLocalizationFlag()

		if var_662_0[var_662_1] ~= nil then
			arg_662_1.duration_ = var_662_0[var_662_1]
		end

		SetActive(arg_662_1.tipsGo_, false)

		function arg_662_1.onSingleLineFinish_()
			arg_662_1.onSingleLineUpdate_ = nil
			arg_662_1.onSingleLineFinish_ = nil
			arg_662_1.state_ = "waiting"
		end

		function arg_662_1.playNext_(arg_664_0)
			if arg_664_0 == 1 then
				arg_662_0:Play1109503157(arg_662_1)
			end
		end

		function arg_662_1.onSingleLineUpdate_(arg_665_0)
			local var_665_0 = arg_662_1.actors_["10058ui_story"]
			local var_665_1 = 0

			if var_665_1 < arg_662_1.time_ and arg_662_1.time_ <= var_665_1 + arg_665_0 and not isNil(var_665_0) and arg_662_1.var_.characterEffect10058ui_story == nil then
				arg_662_1.var_.characterEffect10058ui_story = var_665_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_665_2 = 0.200000002980232

			if var_665_1 <= arg_662_1.time_ and arg_662_1.time_ < var_665_1 + var_665_2 and not isNil(var_665_0) then
				local var_665_3 = (arg_662_1.time_ - var_665_1) / var_665_2

				if arg_662_1.var_.characterEffect10058ui_story and not isNil(var_665_0) then
					arg_662_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_662_1.time_ >= var_665_1 + var_665_2 and arg_662_1.time_ < var_665_1 + var_665_2 + arg_665_0 and not isNil(var_665_0) and arg_662_1.var_.characterEffect10058ui_story then
				arg_662_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_665_4 = 0
			local var_665_5 = 0.925

			if var_665_4 < arg_662_1.time_ and arg_662_1.time_ <= var_665_4 + arg_665_0 then
				arg_662_1.talkMaxDuration = 0
				arg_662_1.dialogCg_.alpha = 1

				arg_662_1.dialog_:SetActive(true)
				SetActive(arg_662_1.leftNameGo_, true)

				local var_665_6 = arg_662_1:FormatText(StoryNameCfg[471].name)

				arg_662_1.leftNameTxt_.text = var_665_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_662_1.leftNameTxt_.transform)

				arg_662_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_662_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_662_1:RecordName(arg_662_1.leftNameTxt_.text)
				SetActive(arg_662_1.iconTrs_.gameObject, false)
				arg_662_1.callingController_:SetSelectedState("normal")

				local var_665_7 = arg_662_1:GetWordFromCfg(1109503156)
				local var_665_8 = arg_662_1:FormatText(var_665_7.content)

				arg_662_1.text_.text = var_665_8

				LuaForUtil.ClearLinePrefixSymbol(arg_662_1.text_)

				local var_665_9 = 37
				local var_665_10 = utf8.len(var_665_8)
				local var_665_11 = var_665_9 <= 0 and var_665_5 or var_665_5 * (var_665_10 / var_665_9)

				if var_665_11 > 0 and var_665_5 < var_665_11 then
					arg_662_1.talkMaxDuration = var_665_11

					if var_665_11 + var_665_4 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_11 + var_665_4
					end
				end

				arg_662_1.text_.text = var_665_8
				arg_662_1.typewritter.percent = 0

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503156", "story_v_side_new_1109503.awb") ~= 0 then
					local var_665_12 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503156", "story_v_side_new_1109503.awb") / 1000

					if var_665_12 + var_665_4 > arg_662_1.duration_ then
						arg_662_1.duration_ = var_665_12 + var_665_4
					end

					if var_665_7.prefab_name ~= "" and arg_662_1.actors_[var_665_7.prefab_name] ~= nil then
						local var_665_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_662_1.actors_[var_665_7.prefab_name].transform, "story_v_side_new_1109503", "1109503156", "story_v_side_new_1109503.awb")

						arg_662_1:RecordAudio("1109503156", var_665_13)
						arg_662_1:RecordAudio("1109503156", var_665_13)
					else
						arg_662_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503156", "story_v_side_new_1109503.awb")
					end

					arg_662_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503156", "story_v_side_new_1109503.awb")
				end

				arg_662_1:RecordContent(arg_662_1.text_.text)
			end

			local var_665_14 = math.max(var_665_5, arg_662_1.talkMaxDuration)

			if var_665_4 <= arg_662_1.time_ and arg_662_1.time_ < var_665_4 + var_665_14 then
				arg_662_1.typewritter.percent = (arg_662_1.time_ - var_665_4) / var_665_14

				arg_662_1.typewritter:SetDirty()
			end

			if arg_662_1.time_ >= var_665_4 + var_665_14 and arg_662_1.time_ < var_665_4 + var_665_14 + arg_665_0 then
				arg_662_1.typewritter.percent = 1

				arg_662_1.typewritter:SetDirty()
				arg_662_1:ShowNextGo(true)
			end
		end

		arg_662_1.nodeConfigList_ = {}

		arg_662_1:InitPlayNodeList()
	end,
	Play1109503157 = function(arg_666_0, arg_666_1)
		arg_666_1.time_ = 0
		arg_666_1.frameCnt_ = 0
		arg_666_1.state_ = "playing"
		arg_666_1.curTalkId_ = 1109503157
		arg_666_1.duration_ = 5

		SetActive(arg_666_1.tipsGo_, false)

		function arg_666_1.onSingleLineFinish_()
			arg_666_1.onSingleLineUpdate_ = nil
			arg_666_1.onSingleLineFinish_ = nil
			arg_666_1.state_ = "waiting"
		end

		function arg_666_1.playNext_(arg_668_0)
			if arg_668_0 == 1 then
				arg_666_0:Play1109503158(arg_666_1)
			end
		end

		function arg_666_1.onSingleLineUpdate_(arg_669_0)
			local var_669_0 = arg_666_1.actors_["10058ui_story"]
			local var_669_1 = 0

			if var_669_1 < arg_666_1.time_ and arg_666_1.time_ <= var_669_1 + arg_669_0 and not isNil(var_669_0) and arg_666_1.var_.characterEffect10058ui_story == nil then
				arg_666_1.var_.characterEffect10058ui_story = var_669_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_669_2 = 0.200000002980232

			if var_669_1 <= arg_666_1.time_ and arg_666_1.time_ < var_669_1 + var_669_2 and not isNil(var_669_0) then
				local var_669_3 = (arg_666_1.time_ - var_669_1) / var_669_2

				if arg_666_1.var_.characterEffect10058ui_story and not isNil(var_669_0) then
					local var_669_4 = Mathf.Lerp(0, 0.5, var_669_3)

					arg_666_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_666_1.var_.characterEffect10058ui_story.fillRatio = var_669_4
				end
			end

			if arg_666_1.time_ >= var_669_1 + var_669_2 and arg_666_1.time_ < var_669_1 + var_669_2 + arg_669_0 and not isNil(var_669_0) and arg_666_1.var_.characterEffect10058ui_story then
				local var_669_5 = 0.5

				arg_666_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_666_1.var_.characterEffect10058ui_story.fillRatio = var_669_5
			end

			local var_669_6 = 0
			local var_669_7 = 0.05

			if var_669_6 < arg_666_1.time_ and arg_666_1.time_ <= var_669_6 + arg_669_0 then
				arg_666_1.talkMaxDuration = 0
				arg_666_1.dialogCg_.alpha = 1

				arg_666_1.dialog_:SetActive(true)
				SetActive(arg_666_1.leftNameGo_, true)

				local var_669_8 = arg_666_1:FormatText(StoryNameCfg[7].name)

				arg_666_1.leftNameTxt_.text = var_669_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_666_1.leftNameTxt_.transform)

				arg_666_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_666_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_666_1:RecordName(arg_666_1.leftNameTxt_.text)
				SetActive(arg_666_1.iconTrs_.gameObject, true)
				arg_666_1.iconController_:SetSelectedState("hero")

				arg_666_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_666_1.callingController_:SetSelectedState("normal")

				arg_666_1.keyicon_.color = Color.New(1, 1, 1)
				arg_666_1.icon_.color = Color.New(1, 1, 1)

				local var_669_9 = arg_666_1:GetWordFromCfg(1109503157)
				local var_669_10 = arg_666_1:FormatText(var_669_9.content)

				arg_666_1.text_.text = var_669_10

				LuaForUtil.ClearLinePrefixSymbol(arg_666_1.text_)

				local var_669_11 = 2
				local var_669_12 = utf8.len(var_669_10)
				local var_669_13 = var_669_11 <= 0 and var_669_7 or var_669_7 * (var_669_12 / var_669_11)

				if var_669_13 > 0 and var_669_7 < var_669_13 then
					arg_666_1.talkMaxDuration = var_669_13

					if var_669_13 + var_669_6 > arg_666_1.duration_ then
						arg_666_1.duration_ = var_669_13 + var_669_6
					end
				end

				arg_666_1.text_.text = var_669_10
				arg_666_1.typewritter.percent = 0

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(false)
				arg_666_1:RecordContent(arg_666_1.text_.text)
			end

			local var_669_14 = math.max(var_669_7, arg_666_1.talkMaxDuration)

			if var_669_6 <= arg_666_1.time_ and arg_666_1.time_ < var_669_6 + var_669_14 then
				arg_666_1.typewritter.percent = (arg_666_1.time_ - var_669_6) / var_669_14

				arg_666_1.typewritter:SetDirty()
			end

			if arg_666_1.time_ >= var_669_6 + var_669_14 and arg_666_1.time_ < var_669_6 + var_669_14 + arg_669_0 then
				arg_666_1.typewritter.percent = 1

				arg_666_1.typewritter:SetDirty()
				arg_666_1:ShowNextGo(true)
			end
		end

		arg_666_1.nodeConfigList_ = {}

		arg_666_1:InitPlayNodeList()
	end,
	Play1109503158 = function(arg_670_0, arg_670_1)
		arg_670_1.time_ = 0
		arg_670_1.frameCnt_ = 0
		arg_670_1.state_ = "playing"
		arg_670_1.curTalkId_ = 1109503158
		arg_670_1.duration_ = 5

		SetActive(arg_670_1.tipsGo_, false)

		function arg_670_1.onSingleLineFinish_()
			arg_670_1.onSingleLineUpdate_ = nil
			arg_670_1.onSingleLineFinish_ = nil
			arg_670_1.state_ = "waiting"
		end

		function arg_670_1.playNext_(arg_672_0)
			if arg_672_0 == 1 then
				arg_670_0:Play1109503159(arg_670_1)
			end
		end

		function arg_670_1.onSingleLineUpdate_(arg_673_0)
			local var_673_0 = arg_670_1.actors_["10058ui_story"].transform
			local var_673_1 = 0

			if var_673_1 < arg_670_1.time_ and arg_670_1.time_ <= var_673_1 + arg_673_0 then
				arg_670_1.var_.moveOldPos10058ui_story = var_673_0.localPosition
			end

			local var_673_2 = 0.001

			if var_673_1 <= arg_670_1.time_ and arg_670_1.time_ < var_673_1 + var_673_2 then
				local var_673_3 = (arg_670_1.time_ - var_673_1) / var_673_2
				local var_673_4 = Vector3.New(0, 100, 0)

				var_673_0.localPosition = Vector3.Lerp(arg_670_1.var_.moveOldPos10058ui_story, var_673_4, var_673_3)

				local var_673_5 = manager.ui.mainCamera.transform.position - var_673_0.position

				var_673_0.forward = Vector3.New(var_673_5.x, var_673_5.y, var_673_5.z)

				local var_673_6 = var_673_0.localEulerAngles

				var_673_6.z = 0
				var_673_6.x = 0
				var_673_0.localEulerAngles = var_673_6
			end

			if arg_670_1.time_ >= var_673_1 + var_673_2 and arg_670_1.time_ < var_673_1 + var_673_2 + arg_673_0 then
				var_673_0.localPosition = Vector3.New(0, 100, 0)

				local var_673_7 = manager.ui.mainCamera.transform.position - var_673_0.position

				var_673_0.forward = Vector3.New(var_673_7.x, var_673_7.y, var_673_7.z)

				local var_673_8 = var_673_0.localEulerAngles

				var_673_8.z = 0
				var_673_8.x = 0
				var_673_0.localEulerAngles = var_673_8
			end

			local var_673_9 = 0
			local var_673_10 = 1.15

			if var_673_9 < arg_670_1.time_ and arg_670_1.time_ <= var_673_9 + arg_673_0 then
				arg_670_1.talkMaxDuration = 0
				arg_670_1.dialogCg_.alpha = 1

				arg_670_1.dialog_:SetActive(true)
				SetActive(arg_670_1.leftNameGo_, false)

				arg_670_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_670_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_670_1:RecordName(arg_670_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_670_1.iconTrs_.gameObject, false)
				arg_670_1.callingController_:SetSelectedState("normal")

				local var_673_11 = arg_670_1:GetWordFromCfg(1109503158)
				local var_673_12 = arg_670_1:FormatText(var_673_11.content)

				arg_670_1.text_.text = var_673_12

				LuaForUtil.ClearLinePrefixSymbol(arg_670_1.text_)

				local var_673_13 = 46
				local var_673_14 = utf8.len(var_673_12)
				local var_673_15 = var_673_13 <= 0 and var_673_10 or var_673_10 * (var_673_14 / var_673_13)

				if var_673_15 > 0 and var_673_10 < var_673_15 then
					arg_670_1.talkMaxDuration = var_673_15

					if var_673_15 + var_673_9 > arg_670_1.duration_ then
						arg_670_1.duration_ = var_673_15 + var_673_9
					end
				end

				arg_670_1.text_.text = var_673_12
				arg_670_1.typewritter.percent = 0

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(false)
				arg_670_1:RecordContent(arg_670_1.text_.text)
			end

			local var_673_16 = math.max(var_673_10, arg_670_1.talkMaxDuration)

			if var_673_9 <= arg_670_1.time_ and arg_670_1.time_ < var_673_9 + var_673_16 then
				arg_670_1.typewritter.percent = (arg_670_1.time_ - var_673_9) / var_673_16

				arg_670_1.typewritter:SetDirty()
			end

			if arg_670_1.time_ >= var_673_9 + var_673_16 and arg_670_1.time_ < var_673_9 + var_673_16 + arg_673_0 then
				arg_670_1.typewritter.percent = 1

				arg_670_1.typewritter:SetDirty()
				arg_670_1:ShowNextGo(true)
			end
		end

		arg_670_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_670_1:InitPlayNodeList()
	end,
	Play1109503159 = function(arg_674_0, arg_674_1)
		arg_674_1.time_ = 0
		arg_674_1.frameCnt_ = 0
		arg_674_1.state_ = "playing"
		arg_674_1.curTalkId_ = 1109503159
		arg_674_1.duration_ = 3.93

		local var_674_0 = {
			zh = 3.733,
			ja = 3.933
		}
		local var_674_1 = manager.audio:GetLocalizationFlag()

		if var_674_0[var_674_1] ~= nil then
			arg_674_1.duration_ = var_674_0[var_674_1]
		end

		SetActive(arg_674_1.tipsGo_, false)

		function arg_674_1.onSingleLineFinish_()
			arg_674_1.onSingleLineUpdate_ = nil
			arg_674_1.onSingleLineFinish_ = nil
			arg_674_1.state_ = "waiting"
		end

		function arg_674_1.playNext_(arg_676_0)
			if arg_676_0 == 1 then
				arg_674_0:Play1109503160(arg_674_1)
			end
		end

		function arg_674_1.onSingleLineUpdate_(arg_677_0)
			local var_677_0 = arg_674_1.actors_["10058ui_story"].transform
			local var_677_1 = 0

			if var_677_1 < arg_674_1.time_ and arg_674_1.time_ <= var_677_1 + arg_677_0 then
				arg_674_1.var_.moveOldPos10058ui_story = var_677_0.localPosition
			end

			local var_677_2 = 0.001

			if var_677_1 <= arg_674_1.time_ and arg_674_1.time_ < var_677_1 + var_677_2 then
				local var_677_3 = (arg_674_1.time_ - var_677_1) / var_677_2
				local var_677_4 = Vector3.New(0, -0.98, -6.1)

				var_677_0.localPosition = Vector3.Lerp(arg_674_1.var_.moveOldPos10058ui_story, var_677_4, var_677_3)

				local var_677_5 = manager.ui.mainCamera.transform.position - var_677_0.position

				var_677_0.forward = Vector3.New(var_677_5.x, var_677_5.y, var_677_5.z)

				local var_677_6 = var_677_0.localEulerAngles

				var_677_6.z = 0
				var_677_6.x = 0
				var_677_0.localEulerAngles = var_677_6
			end

			if arg_674_1.time_ >= var_677_1 + var_677_2 and arg_674_1.time_ < var_677_1 + var_677_2 + arg_677_0 then
				var_677_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_677_7 = manager.ui.mainCamera.transform.position - var_677_0.position

				var_677_0.forward = Vector3.New(var_677_7.x, var_677_7.y, var_677_7.z)

				local var_677_8 = var_677_0.localEulerAngles

				var_677_8.z = 0
				var_677_8.x = 0
				var_677_0.localEulerAngles = var_677_8
			end

			local var_677_9 = arg_674_1.actors_["10058ui_story"]
			local var_677_10 = 0

			if var_677_10 < arg_674_1.time_ and arg_674_1.time_ <= var_677_10 + arg_677_0 and not isNil(var_677_9) and arg_674_1.var_.characterEffect10058ui_story == nil then
				arg_674_1.var_.characterEffect10058ui_story = var_677_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_677_11 = 0.200000002980232

			if var_677_10 <= arg_674_1.time_ and arg_674_1.time_ < var_677_10 + var_677_11 and not isNil(var_677_9) then
				local var_677_12 = (arg_674_1.time_ - var_677_10) / var_677_11

				if arg_674_1.var_.characterEffect10058ui_story and not isNil(var_677_9) then
					arg_674_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_674_1.time_ >= var_677_10 + var_677_11 and arg_674_1.time_ < var_677_10 + var_677_11 + arg_677_0 and not isNil(var_677_9) and arg_674_1.var_.characterEffect10058ui_story then
				arg_674_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_677_13 = 0

			if var_677_13 < arg_674_1.time_ and arg_674_1.time_ <= var_677_13 + arg_677_0 then
				arg_674_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			local var_677_14 = 0

			if var_677_14 < arg_674_1.time_ and arg_674_1.time_ <= var_677_14 + arg_677_0 then
				arg_674_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_677_15 = 0
			local var_677_16 = 0.35

			if var_677_15 < arg_674_1.time_ and arg_674_1.time_ <= var_677_15 + arg_677_0 then
				arg_674_1.talkMaxDuration = 0
				arg_674_1.dialogCg_.alpha = 1

				arg_674_1.dialog_:SetActive(true)
				SetActive(arg_674_1.leftNameGo_, true)

				local var_677_17 = arg_674_1:FormatText(StoryNameCfg[471].name)

				arg_674_1.leftNameTxt_.text = var_677_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_674_1.leftNameTxt_.transform)

				arg_674_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_674_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_674_1:RecordName(arg_674_1.leftNameTxt_.text)
				SetActive(arg_674_1.iconTrs_.gameObject, false)
				arg_674_1.callingController_:SetSelectedState("normal")

				local var_677_18 = arg_674_1:GetWordFromCfg(1109503159)
				local var_677_19 = arg_674_1:FormatText(var_677_18.content)

				arg_674_1.text_.text = var_677_19

				LuaForUtil.ClearLinePrefixSymbol(arg_674_1.text_)

				local var_677_20 = 14
				local var_677_21 = utf8.len(var_677_19)
				local var_677_22 = var_677_20 <= 0 and var_677_16 or var_677_16 * (var_677_21 / var_677_20)

				if var_677_22 > 0 and var_677_16 < var_677_22 then
					arg_674_1.talkMaxDuration = var_677_22

					if var_677_22 + var_677_15 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_22 + var_677_15
					end
				end

				arg_674_1.text_.text = var_677_19
				arg_674_1.typewritter.percent = 0

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503159", "story_v_side_new_1109503.awb") ~= 0 then
					local var_677_23 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503159", "story_v_side_new_1109503.awb") / 1000

					if var_677_23 + var_677_15 > arg_674_1.duration_ then
						arg_674_1.duration_ = var_677_23 + var_677_15
					end

					if var_677_18.prefab_name ~= "" and arg_674_1.actors_[var_677_18.prefab_name] ~= nil then
						local var_677_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_674_1.actors_[var_677_18.prefab_name].transform, "story_v_side_new_1109503", "1109503159", "story_v_side_new_1109503.awb")

						arg_674_1:RecordAudio("1109503159", var_677_24)
						arg_674_1:RecordAudio("1109503159", var_677_24)
					else
						arg_674_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503159", "story_v_side_new_1109503.awb")
					end

					arg_674_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503159", "story_v_side_new_1109503.awb")
				end

				arg_674_1:RecordContent(arg_674_1.text_.text)
			end

			local var_677_25 = math.max(var_677_16, arg_674_1.talkMaxDuration)

			if var_677_15 <= arg_674_1.time_ and arg_674_1.time_ < var_677_15 + var_677_25 then
				arg_674_1.typewritter.percent = (arg_674_1.time_ - var_677_15) / var_677_25

				arg_674_1.typewritter:SetDirty()
			end

			if arg_674_1.time_ >= var_677_15 + var_677_25 and arg_674_1.time_ < var_677_15 + var_677_25 + arg_677_0 then
				arg_674_1.typewritter.percent = 1

				arg_674_1.typewritter:SetDirty()
				arg_674_1:ShowNextGo(true)
			end
		end

		arg_674_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_674_1:InitPlayNodeList()
	end,
	Play1109503160 = function(arg_678_0, arg_678_1)
		arg_678_1.time_ = 0
		arg_678_1.frameCnt_ = 0
		arg_678_1.state_ = "playing"
		arg_678_1.curTalkId_ = 1109503160
		arg_678_1.duration_ = 5

		SetActive(arg_678_1.tipsGo_, false)

		function arg_678_1.onSingleLineFinish_()
			arg_678_1.onSingleLineUpdate_ = nil
			arg_678_1.onSingleLineFinish_ = nil
			arg_678_1.state_ = "waiting"
		end

		function arg_678_1.playNext_(arg_680_0)
			if arg_680_0 == 1 then
				arg_678_0:Play1109503161(arg_678_1)
			end
		end

		function arg_678_1.onSingleLineUpdate_(arg_681_0)
			local var_681_0 = arg_678_1.actors_["10058ui_story"]
			local var_681_1 = 0

			if var_681_1 < arg_678_1.time_ and arg_678_1.time_ <= var_681_1 + arg_681_0 and not isNil(var_681_0) and arg_678_1.var_.characterEffect10058ui_story == nil then
				arg_678_1.var_.characterEffect10058ui_story = var_681_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_681_2 = 0.200000002980232

			if var_681_1 <= arg_678_1.time_ and arg_678_1.time_ < var_681_1 + var_681_2 and not isNil(var_681_0) then
				local var_681_3 = (arg_678_1.time_ - var_681_1) / var_681_2

				if arg_678_1.var_.characterEffect10058ui_story and not isNil(var_681_0) then
					local var_681_4 = Mathf.Lerp(0, 0.5, var_681_3)

					arg_678_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_678_1.var_.characterEffect10058ui_story.fillRatio = var_681_4
				end
			end

			if arg_678_1.time_ >= var_681_1 + var_681_2 and arg_678_1.time_ < var_681_1 + var_681_2 + arg_681_0 and not isNil(var_681_0) and arg_678_1.var_.characterEffect10058ui_story then
				local var_681_5 = 0.5

				arg_678_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_678_1.var_.characterEffect10058ui_story.fillRatio = var_681_5
			end

			local var_681_6 = 0
			local var_681_7 = 0.55

			if var_681_6 < arg_678_1.time_ and arg_678_1.time_ <= var_681_6 + arg_681_0 then
				arg_678_1.talkMaxDuration = 0
				arg_678_1.dialogCg_.alpha = 1

				arg_678_1.dialog_:SetActive(true)
				SetActive(arg_678_1.leftNameGo_, true)

				local var_681_8 = arg_678_1:FormatText(StoryNameCfg[7].name)

				arg_678_1.leftNameTxt_.text = var_681_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_678_1.leftNameTxt_.transform)

				arg_678_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_678_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_678_1:RecordName(arg_678_1.leftNameTxt_.text)
				SetActive(arg_678_1.iconTrs_.gameObject, true)
				arg_678_1.iconController_:SetSelectedState("hero")

				arg_678_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_678_1.callingController_:SetSelectedState("normal")

				arg_678_1.keyicon_.color = Color.New(1, 1, 1)
				arg_678_1.icon_.color = Color.New(1, 1, 1)

				local var_681_9 = arg_678_1:GetWordFromCfg(1109503160)
				local var_681_10 = arg_678_1:FormatText(var_681_9.content)

				arg_678_1.text_.text = var_681_10

				LuaForUtil.ClearLinePrefixSymbol(arg_678_1.text_)

				local var_681_11 = 22
				local var_681_12 = utf8.len(var_681_10)
				local var_681_13 = var_681_11 <= 0 and var_681_7 or var_681_7 * (var_681_12 / var_681_11)

				if var_681_13 > 0 and var_681_7 < var_681_13 then
					arg_678_1.talkMaxDuration = var_681_13

					if var_681_13 + var_681_6 > arg_678_1.duration_ then
						arg_678_1.duration_ = var_681_13 + var_681_6
					end
				end

				arg_678_1.text_.text = var_681_10
				arg_678_1.typewritter.percent = 0

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(false)
				arg_678_1:RecordContent(arg_678_1.text_.text)
			end

			local var_681_14 = math.max(var_681_7, arg_678_1.talkMaxDuration)

			if var_681_6 <= arg_678_1.time_ and arg_678_1.time_ < var_681_6 + var_681_14 then
				arg_678_1.typewritter.percent = (arg_678_1.time_ - var_681_6) / var_681_14

				arg_678_1.typewritter:SetDirty()
			end

			if arg_678_1.time_ >= var_681_6 + var_681_14 and arg_678_1.time_ < var_681_6 + var_681_14 + arg_681_0 then
				arg_678_1.typewritter.percent = 1

				arg_678_1.typewritter:SetDirty()
				arg_678_1:ShowNextGo(true)
			end
		end

		arg_678_1.nodeConfigList_ = {}

		arg_678_1:InitPlayNodeList()
	end,
	Play1109503161 = function(arg_682_0, arg_682_1)
		arg_682_1.time_ = 0
		arg_682_1.frameCnt_ = 0
		arg_682_1.state_ = "playing"
		arg_682_1.curTalkId_ = 1109503161
		arg_682_1.duration_ = 9.2

		local var_682_0 = {
			zh = 4.366,
			ja = 9.2
		}
		local var_682_1 = manager.audio:GetLocalizationFlag()

		if var_682_0[var_682_1] ~= nil then
			arg_682_1.duration_ = var_682_0[var_682_1]
		end

		SetActive(arg_682_1.tipsGo_, false)

		function arg_682_1.onSingleLineFinish_()
			arg_682_1.onSingleLineUpdate_ = nil
			arg_682_1.onSingleLineFinish_ = nil
			arg_682_1.state_ = "waiting"
		end

		function arg_682_1.playNext_(arg_684_0)
			if arg_684_0 == 1 then
				arg_682_0:Play1109503162(arg_682_1)
			end
		end

		function arg_682_1.onSingleLineUpdate_(arg_685_0)
			local var_685_0 = arg_682_1.actors_["10058ui_story"]
			local var_685_1 = 0

			if var_685_1 < arg_682_1.time_ and arg_682_1.time_ <= var_685_1 + arg_685_0 and not isNil(var_685_0) and arg_682_1.var_.characterEffect10058ui_story == nil then
				arg_682_1.var_.characterEffect10058ui_story = var_685_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_685_2 = 0.200000002980232

			if var_685_1 <= arg_682_1.time_ and arg_682_1.time_ < var_685_1 + var_685_2 and not isNil(var_685_0) then
				local var_685_3 = (arg_682_1.time_ - var_685_1) / var_685_2

				if arg_682_1.var_.characterEffect10058ui_story and not isNil(var_685_0) then
					arg_682_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_682_1.time_ >= var_685_1 + var_685_2 and arg_682_1.time_ < var_685_1 + var_685_2 + arg_685_0 and not isNil(var_685_0) and arg_682_1.var_.characterEffect10058ui_story then
				arg_682_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_685_4 = 0

			if var_685_4 < arg_682_1.time_ and arg_682_1.time_ <= var_685_4 + arg_685_0 then
				arg_682_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_685_5 = 0

			if var_685_5 < arg_682_1.time_ and arg_682_1.time_ <= var_685_5 + arg_685_0 then
				arg_682_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_685_6 = 0
			local var_685_7 = 0.5

			if var_685_6 < arg_682_1.time_ and arg_682_1.time_ <= var_685_6 + arg_685_0 then
				arg_682_1.talkMaxDuration = 0
				arg_682_1.dialogCg_.alpha = 1

				arg_682_1.dialog_:SetActive(true)
				SetActive(arg_682_1.leftNameGo_, true)

				local var_685_8 = arg_682_1:FormatText(StoryNameCfg[471].name)

				arg_682_1.leftNameTxt_.text = var_685_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_682_1.leftNameTxt_.transform)

				arg_682_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_682_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_682_1:RecordName(arg_682_1.leftNameTxt_.text)
				SetActive(arg_682_1.iconTrs_.gameObject, false)
				arg_682_1.callingController_:SetSelectedState("normal")

				local var_685_9 = arg_682_1:GetWordFromCfg(1109503161)
				local var_685_10 = arg_682_1:FormatText(var_685_9.content)

				arg_682_1.text_.text = var_685_10

				LuaForUtil.ClearLinePrefixSymbol(arg_682_1.text_)

				local var_685_11 = 20
				local var_685_12 = utf8.len(var_685_10)
				local var_685_13 = var_685_11 <= 0 and var_685_7 or var_685_7 * (var_685_12 / var_685_11)

				if var_685_13 > 0 and var_685_7 < var_685_13 then
					arg_682_1.talkMaxDuration = var_685_13

					if var_685_13 + var_685_6 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_13 + var_685_6
					end
				end

				arg_682_1.text_.text = var_685_10
				arg_682_1.typewritter.percent = 0

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503161", "story_v_side_new_1109503.awb") ~= 0 then
					local var_685_14 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503161", "story_v_side_new_1109503.awb") / 1000

					if var_685_14 + var_685_6 > arg_682_1.duration_ then
						arg_682_1.duration_ = var_685_14 + var_685_6
					end

					if var_685_9.prefab_name ~= "" and arg_682_1.actors_[var_685_9.prefab_name] ~= nil then
						local var_685_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_682_1.actors_[var_685_9.prefab_name].transform, "story_v_side_new_1109503", "1109503161", "story_v_side_new_1109503.awb")

						arg_682_1:RecordAudio("1109503161", var_685_15)
						arg_682_1:RecordAudio("1109503161", var_685_15)
					else
						arg_682_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503161", "story_v_side_new_1109503.awb")
					end

					arg_682_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503161", "story_v_side_new_1109503.awb")
				end

				arg_682_1:RecordContent(arg_682_1.text_.text)
			end

			local var_685_16 = math.max(var_685_7, arg_682_1.talkMaxDuration)

			if var_685_6 <= arg_682_1.time_ and arg_682_1.time_ < var_685_6 + var_685_16 then
				arg_682_1.typewritter.percent = (arg_682_1.time_ - var_685_6) / var_685_16

				arg_682_1.typewritter:SetDirty()
			end

			if arg_682_1.time_ >= var_685_6 + var_685_16 and arg_682_1.time_ < var_685_6 + var_685_16 + arg_685_0 then
				arg_682_1.typewritter.percent = 1

				arg_682_1.typewritter:SetDirty()
				arg_682_1:ShowNextGo(true)
			end
		end

		arg_682_1.nodeConfigList_ = {}

		arg_682_1:InitPlayNodeList()
	end,
	Play1109503162 = function(arg_686_0, arg_686_1)
		arg_686_1.time_ = 0
		arg_686_1.frameCnt_ = 0
		arg_686_1.state_ = "playing"
		arg_686_1.curTalkId_ = 1109503162
		arg_686_1.duration_ = 8.57

		local var_686_0 = {
			zh = 3.866,
			ja = 8.566
		}
		local var_686_1 = manager.audio:GetLocalizationFlag()

		if var_686_0[var_686_1] ~= nil then
			arg_686_1.duration_ = var_686_0[var_686_1]
		end

		SetActive(arg_686_1.tipsGo_, false)

		function arg_686_1.onSingleLineFinish_()
			arg_686_1.onSingleLineUpdate_ = nil
			arg_686_1.onSingleLineFinish_ = nil
			arg_686_1.state_ = "waiting"
		end

		function arg_686_1.playNext_(arg_688_0)
			if arg_688_0 == 1 then
				arg_686_0:Play1109503163(arg_686_1)
			end
		end

		function arg_686_1.onSingleLineUpdate_(arg_689_0)
			local var_689_0 = arg_686_1.actors_["10058ui_story"]
			local var_689_1 = 0

			if var_689_1 < arg_686_1.time_ and arg_686_1.time_ <= var_689_1 + arg_689_0 and not isNil(var_689_0) and arg_686_1.var_.characterEffect10058ui_story == nil then
				arg_686_1.var_.characterEffect10058ui_story = var_689_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_689_2 = 0.200000002980232

			if var_689_1 <= arg_686_1.time_ and arg_686_1.time_ < var_689_1 + var_689_2 and not isNil(var_689_0) then
				local var_689_3 = (arg_686_1.time_ - var_689_1) / var_689_2

				if arg_686_1.var_.characterEffect10058ui_story and not isNil(var_689_0) then
					arg_686_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_686_1.time_ >= var_689_1 + var_689_2 and arg_686_1.time_ < var_689_1 + var_689_2 + arg_689_0 and not isNil(var_689_0) and arg_686_1.var_.characterEffect10058ui_story then
				arg_686_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_689_4 = 0

			if var_689_4 < arg_686_1.time_ and arg_686_1.time_ <= var_689_4 + arg_689_0 then
				arg_686_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_689_5 = 0

			if var_689_5 < arg_686_1.time_ and arg_686_1.time_ <= var_689_5 + arg_689_0 then
				arg_686_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_689_6 = 0
			local var_689_7 = 0.45

			if var_689_6 < arg_686_1.time_ and arg_686_1.time_ <= var_689_6 + arg_689_0 then
				arg_686_1.talkMaxDuration = 0
				arg_686_1.dialogCg_.alpha = 1

				arg_686_1.dialog_:SetActive(true)
				SetActive(arg_686_1.leftNameGo_, true)

				local var_689_8 = arg_686_1:FormatText(StoryNameCfg[471].name)

				arg_686_1.leftNameTxt_.text = var_689_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_686_1.leftNameTxt_.transform)

				arg_686_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_686_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_686_1:RecordName(arg_686_1.leftNameTxt_.text)
				SetActive(arg_686_1.iconTrs_.gameObject, false)
				arg_686_1.callingController_:SetSelectedState("normal")

				local var_689_9 = arg_686_1:GetWordFromCfg(1109503162)
				local var_689_10 = arg_686_1:FormatText(var_689_9.content)

				arg_686_1.text_.text = var_689_10

				LuaForUtil.ClearLinePrefixSymbol(arg_686_1.text_)

				local var_689_11 = 18
				local var_689_12 = utf8.len(var_689_10)
				local var_689_13 = var_689_11 <= 0 and var_689_7 or var_689_7 * (var_689_12 / var_689_11)

				if var_689_13 > 0 and var_689_7 < var_689_13 then
					arg_686_1.talkMaxDuration = var_689_13

					if var_689_13 + var_689_6 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_13 + var_689_6
					end
				end

				arg_686_1.text_.text = var_689_10
				arg_686_1.typewritter.percent = 0

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503162", "story_v_side_new_1109503.awb") ~= 0 then
					local var_689_14 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503162", "story_v_side_new_1109503.awb") / 1000

					if var_689_14 + var_689_6 > arg_686_1.duration_ then
						arg_686_1.duration_ = var_689_14 + var_689_6
					end

					if var_689_9.prefab_name ~= "" and arg_686_1.actors_[var_689_9.prefab_name] ~= nil then
						local var_689_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_686_1.actors_[var_689_9.prefab_name].transform, "story_v_side_new_1109503", "1109503162", "story_v_side_new_1109503.awb")

						arg_686_1:RecordAudio("1109503162", var_689_15)
						arg_686_1:RecordAudio("1109503162", var_689_15)
					else
						arg_686_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503162", "story_v_side_new_1109503.awb")
					end

					arg_686_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503162", "story_v_side_new_1109503.awb")
				end

				arg_686_1:RecordContent(arg_686_1.text_.text)
			end

			local var_689_16 = math.max(var_689_7, arg_686_1.talkMaxDuration)

			if var_689_6 <= arg_686_1.time_ and arg_686_1.time_ < var_689_6 + var_689_16 then
				arg_686_1.typewritter.percent = (arg_686_1.time_ - var_689_6) / var_689_16

				arg_686_1.typewritter:SetDirty()
			end

			if arg_686_1.time_ >= var_689_6 + var_689_16 and arg_686_1.time_ < var_689_6 + var_689_16 + arg_689_0 then
				arg_686_1.typewritter.percent = 1

				arg_686_1.typewritter:SetDirty()
				arg_686_1:ShowNextGo(true)
			end
		end

		arg_686_1.nodeConfigList_ = {}

		arg_686_1:InitPlayNodeList()
	end,
	Play1109503163 = function(arg_690_0, arg_690_1)
		arg_690_1.time_ = 0
		arg_690_1.frameCnt_ = 0
		arg_690_1.state_ = "playing"
		arg_690_1.curTalkId_ = 1109503163
		arg_690_1.duration_ = 5

		SetActive(arg_690_1.tipsGo_, false)

		function arg_690_1.onSingleLineFinish_()
			arg_690_1.onSingleLineUpdate_ = nil
			arg_690_1.onSingleLineFinish_ = nil
			arg_690_1.state_ = "waiting"
		end

		function arg_690_1.playNext_(arg_692_0)
			if arg_692_0 == 1 then
				arg_690_0:Play1109503164(arg_690_1)
			end
		end

		function arg_690_1.onSingleLineUpdate_(arg_693_0)
			local var_693_0 = arg_690_1.actors_["10058ui_story"]
			local var_693_1 = 0

			if var_693_1 < arg_690_1.time_ and arg_690_1.time_ <= var_693_1 + arg_693_0 and not isNil(var_693_0) and arg_690_1.var_.characterEffect10058ui_story == nil then
				arg_690_1.var_.characterEffect10058ui_story = var_693_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_693_2 = 0.200000002980232

			if var_693_1 <= arg_690_1.time_ and arg_690_1.time_ < var_693_1 + var_693_2 and not isNil(var_693_0) then
				local var_693_3 = (arg_690_1.time_ - var_693_1) / var_693_2

				if arg_690_1.var_.characterEffect10058ui_story and not isNil(var_693_0) then
					local var_693_4 = Mathf.Lerp(0, 0.5, var_693_3)

					arg_690_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_690_1.var_.characterEffect10058ui_story.fillRatio = var_693_4
				end
			end

			if arg_690_1.time_ >= var_693_1 + var_693_2 and arg_690_1.time_ < var_693_1 + var_693_2 + arg_693_0 and not isNil(var_693_0) and arg_690_1.var_.characterEffect10058ui_story then
				local var_693_5 = 0.5

				arg_690_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_690_1.var_.characterEffect10058ui_story.fillRatio = var_693_5
			end

			local var_693_6 = 0
			local var_693_7 = 0.775

			if var_693_6 < arg_690_1.time_ and arg_690_1.time_ <= var_693_6 + arg_693_0 then
				arg_690_1.talkMaxDuration = 0
				arg_690_1.dialogCg_.alpha = 1

				arg_690_1.dialog_:SetActive(true)
				SetActive(arg_690_1.leftNameGo_, false)

				arg_690_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_690_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_690_1:RecordName(arg_690_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_690_1.iconTrs_.gameObject, false)
				arg_690_1.callingController_:SetSelectedState("normal")

				local var_693_8 = arg_690_1:GetWordFromCfg(1109503163)
				local var_693_9 = arg_690_1:FormatText(var_693_8.content)

				arg_690_1.text_.text = var_693_9

				LuaForUtil.ClearLinePrefixSymbol(arg_690_1.text_)

				local var_693_10 = 31
				local var_693_11 = utf8.len(var_693_9)
				local var_693_12 = var_693_10 <= 0 and var_693_7 or var_693_7 * (var_693_11 / var_693_10)

				if var_693_12 > 0 and var_693_7 < var_693_12 then
					arg_690_1.talkMaxDuration = var_693_12

					if var_693_12 + var_693_6 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_12 + var_693_6
					end
				end

				arg_690_1.text_.text = var_693_9
				arg_690_1.typewritter.percent = 0

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(false)
				arg_690_1:RecordContent(arg_690_1.text_.text)
			end

			local var_693_13 = math.max(var_693_7, arg_690_1.talkMaxDuration)

			if var_693_6 <= arg_690_1.time_ and arg_690_1.time_ < var_693_6 + var_693_13 then
				arg_690_1.typewritter.percent = (arg_690_1.time_ - var_693_6) / var_693_13

				arg_690_1.typewritter:SetDirty()
			end

			if arg_690_1.time_ >= var_693_6 + var_693_13 and arg_690_1.time_ < var_693_6 + var_693_13 + arg_693_0 then
				arg_690_1.typewritter.percent = 1

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(true)
			end
		end

		arg_690_1.nodeConfigList_ = {}

		arg_690_1:InitPlayNodeList()
	end,
	Play1109503164 = function(arg_694_0, arg_694_1)
		arg_694_1.time_ = 0
		arg_694_1.frameCnt_ = 0
		arg_694_1.state_ = "playing"
		arg_694_1.curTalkId_ = 1109503164
		arg_694_1.duration_ = 5

		SetActive(arg_694_1.tipsGo_, false)

		function arg_694_1.onSingleLineFinish_()
			arg_694_1.onSingleLineUpdate_ = nil
			arg_694_1.onSingleLineFinish_ = nil
			arg_694_1.state_ = "waiting"
		end

		function arg_694_1.playNext_(arg_696_0)
			if arg_696_0 == 1 then
				arg_694_0:Play1109503165(arg_694_1)
			end
		end

		function arg_694_1.onSingleLineUpdate_(arg_697_0)
			local var_697_0 = arg_694_1.actors_["10058ui_story"].transform
			local var_697_1 = 0

			if var_697_1 < arg_694_1.time_ and arg_694_1.time_ <= var_697_1 + arg_697_0 then
				arg_694_1.var_.moveOldPos10058ui_story = var_697_0.localPosition
			end

			local var_697_2 = 0.001

			if var_697_1 <= arg_694_1.time_ and arg_694_1.time_ < var_697_1 + var_697_2 then
				local var_697_3 = (arg_694_1.time_ - var_697_1) / var_697_2
				local var_697_4 = Vector3.New(0, 100, 0)

				var_697_0.localPosition = Vector3.Lerp(arg_694_1.var_.moveOldPos10058ui_story, var_697_4, var_697_3)

				local var_697_5 = manager.ui.mainCamera.transform.position - var_697_0.position

				var_697_0.forward = Vector3.New(var_697_5.x, var_697_5.y, var_697_5.z)

				local var_697_6 = var_697_0.localEulerAngles

				var_697_6.z = 0
				var_697_6.x = 0
				var_697_0.localEulerAngles = var_697_6
			end

			if arg_694_1.time_ >= var_697_1 + var_697_2 and arg_694_1.time_ < var_697_1 + var_697_2 + arg_697_0 then
				var_697_0.localPosition = Vector3.New(0, 100, 0)

				local var_697_7 = manager.ui.mainCamera.transform.position - var_697_0.position

				var_697_0.forward = Vector3.New(var_697_7.x, var_697_7.y, var_697_7.z)

				local var_697_8 = var_697_0.localEulerAngles

				var_697_8.z = 0
				var_697_8.x = 0
				var_697_0.localEulerAngles = var_697_8
			end

			local var_697_9 = 0
			local var_697_10 = 1.4

			if var_697_9 < arg_694_1.time_ and arg_694_1.time_ <= var_697_9 + arg_697_0 then
				arg_694_1.talkMaxDuration = 0
				arg_694_1.dialogCg_.alpha = 1

				arg_694_1.dialog_:SetActive(true)
				SetActive(arg_694_1.leftNameGo_, false)

				arg_694_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_694_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_694_1:RecordName(arg_694_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_694_1.iconTrs_.gameObject, false)
				arg_694_1.callingController_:SetSelectedState("normal")

				local var_697_11 = arg_694_1:GetWordFromCfg(1109503164)
				local var_697_12 = arg_694_1:FormatText(var_697_11.content)

				arg_694_1.text_.text = var_697_12

				LuaForUtil.ClearLinePrefixSymbol(arg_694_1.text_)

				local var_697_13 = 56
				local var_697_14 = utf8.len(var_697_12)
				local var_697_15 = var_697_13 <= 0 and var_697_10 or var_697_10 * (var_697_14 / var_697_13)

				if var_697_15 > 0 and var_697_10 < var_697_15 then
					arg_694_1.talkMaxDuration = var_697_15

					if var_697_15 + var_697_9 > arg_694_1.duration_ then
						arg_694_1.duration_ = var_697_15 + var_697_9
					end
				end

				arg_694_1.text_.text = var_697_12
				arg_694_1.typewritter.percent = 0

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(false)
				arg_694_1:RecordContent(arg_694_1.text_.text)
			end

			local var_697_16 = math.max(var_697_10, arg_694_1.talkMaxDuration)

			if var_697_9 <= arg_694_1.time_ and arg_694_1.time_ < var_697_9 + var_697_16 then
				arg_694_1.typewritter.percent = (arg_694_1.time_ - var_697_9) / var_697_16

				arg_694_1.typewritter:SetDirty()
			end

			if arg_694_1.time_ >= var_697_9 + var_697_16 and arg_694_1.time_ < var_697_9 + var_697_16 + arg_697_0 then
				arg_694_1.typewritter.percent = 1

				arg_694_1.typewritter:SetDirty()
				arg_694_1:ShowNextGo(true)
			end
		end

		arg_694_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_694_1:InitPlayNodeList()
	end,
	Play1109503165 = function(arg_698_0, arg_698_1)
		arg_698_1.time_ = 0
		arg_698_1.frameCnt_ = 0
		arg_698_1.state_ = "playing"
		arg_698_1.curTalkId_ = 1109503165
		arg_698_1.duration_ = 5

		SetActive(arg_698_1.tipsGo_, false)

		function arg_698_1.onSingleLineFinish_()
			arg_698_1.onSingleLineUpdate_ = nil
			arg_698_1.onSingleLineFinish_ = nil
			arg_698_1.state_ = "waiting"
		end

		function arg_698_1.playNext_(arg_700_0)
			if arg_700_0 == 1 then
				arg_698_0:Play1109503166(arg_698_1)
			end
		end

		function arg_698_1.onSingleLineUpdate_(arg_701_0)
			local var_701_0 = 0
			local var_701_1 = 0.375

			if var_701_0 < arg_698_1.time_ and arg_698_1.time_ <= var_701_0 + arg_701_0 then
				arg_698_1.talkMaxDuration = 0
				arg_698_1.dialogCg_.alpha = 1

				arg_698_1.dialog_:SetActive(true)
				SetActive(arg_698_1.leftNameGo_, true)

				local var_701_2 = arg_698_1:FormatText(StoryNameCfg[7].name)

				arg_698_1.leftNameTxt_.text = var_701_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_698_1.leftNameTxt_.transform)

				arg_698_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_698_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_698_1:RecordName(arg_698_1.leftNameTxt_.text)
				SetActive(arg_698_1.iconTrs_.gameObject, true)
				arg_698_1.iconController_:SetSelectedState("hero")

				arg_698_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_698_1.callingController_:SetSelectedState("normal")

				arg_698_1.keyicon_.color = Color.New(1, 1, 1)
				arg_698_1.icon_.color = Color.New(1, 1, 1)

				local var_701_3 = arg_698_1:GetWordFromCfg(1109503165)
				local var_701_4 = arg_698_1:FormatText(var_701_3.content)

				arg_698_1.text_.text = var_701_4

				LuaForUtil.ClearLinePrefixSymbol(arg_698_1.text_)

				local var_701_5 = 15
				local var_701_6 = utf8.len(var_701_4)
				local var_701_7 = var_701_5 <= 0 and var_701_1 or var_701_1 * (var_701_6 / var_701_5)

				if var_701_7 > 0 and var_701_1 < var_701_7 then
					arg_698_1.talkMaxDuration = var_701_7

					if var_701_7 + var_701_0 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_7 + var_701_0
					end
				end

				arg_698_1.text_.text = var_701_4
				arg_698_1.typewritter.percent = 0

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(false)
				arg_698_1:RecordContent(arg_698_1.text_.text)
			end

			local var_701_8 = math.max(var_701_1, arg_698_1.talkMaxDuration)

			if var_701_0 <= arg_698_1.time_ and arg_698_1.time_ < var_701_0 + var_701_8 then
				arg_698_1.typewritter.percent = (arg_698_1.time_ - var_701_0) / var_701_8

				arg_698_1.typewritter:SetDirty()
			end

			if arg_698_1.time_ >= var_701_0 + var_701_8 and arg_698_1.time_ < var_701_0 + var_701_8 + arg_701_0 then
				arg_698_1.typewritter.percent = 1

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(true)
			end
		end

		arg_698_1.nodeConfigList_ = {}

		arg_698_1:InitPlayNodeList()
	end,
	Play1109503166 = function(arg_702_0, arg_702_1)
		arg_702_1.time_ = 0
		arg_702_1.frameCnt_ = 0
		arg_702_1.state_ = "playing"
		arg_702_1.curTalkId_ = 1109503166
		arg_702_1.duration_ = 5

		SetActive(arg_702_1.tipsGo_, false)

		function arg_702_1.onSingleLineFinish_()
			arg_702_1.onSingleLineUpdate_ = nil
			arg_702_1.onSingleLineFinish_ = nil
			arg_702_1.state_ = "waiting"
		end

		function arg_702_1.playNext_(arg_704_0)
			if arg_704_0 == 1 then
				arg_702_0:Play1109503167(arg_702_1)
			end
		end

		function arg_702_1.onSingleLineUpdate_(arg_705_0)
			local var_705_0 = 0
			local var_705_1 = 0.725

			if var_705_0 < arg_702_1.time_ and arg_702_1.time_ <= var_705_0 + arg_705_0 then
				arg_702_1.talkMaxDuration = 0
				arg_702_1.dialogCg_.alpha = 1

				arg_702_1.dialog_:SetActive(true)
				SetActive(arg_702_1.leftNameGo_, false)

				arg_702_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_702_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_702_1:RecordName(arg_702_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_702_1.iconTrs_.gameObject, false)
				arg_702_1.callingController_:SetSelectedState("normal")

				local var_705_2 = arg_702_1:GetWordFromCfg(1109503166)
				local var_705_3 = arg_702_1:FormatText(var_705_2.content)

				arg_702_1.text_.text = var_705_3

				LuaForUtil.ClearLinePrefixSymbol(arg_702_1.text_)

				local var_705_4 = 29
				local var_705_5 = utf8.len(var_705_3)
				local var_705_6 = var_705_4 <= 0 and var_705_1 or var_705_1 * (var_705_5 / var_705_4)

				if var_705_6 > 0 and var_705_1 < var_705_6 then
					arg_702_1.talkMaxDuration = var_705_6

					if var_705_6 + var_705_0 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_6 + var_705_0
					end
				end

				arg_702_1.text_.text = var_705_3
				arg_702_1.typewritter.percent = 0

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(false)
				arg_702_1:RecordContent(arg_702_1.text_.text)
			end

			local var_705_7 = math.max(var_705_1, arg_702_1.talkMaxDuration)

			if var_705_0 <= arg_702_1.time_ and arg_702_1.time_ < var_705_0 + var_705_7 then
				arg_702_1.typewritter.percent = (arg_702_1.time_ - var_705_0) / var_705_7

				arg_702_1.typewritter:SetDirty()
			end

			if arg_702_1.time_ >= var_705_0 + var_705_7 and arg_702_1.time_ < var_705_0 + var_705_7 + arg_705_0 then
				arg_702_1.typewritter.percent = 1

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(true)
			end
		end

		arg_702_1.nodeConfigList_ = {}

		arg_702_1:InitPlayNodeList()
	end,
	Play1109503167 = function(arg_706_0, arg_706_1)
		arg_706_1.time_ = 0
		arg_706_1.frameCnt_ = 0
		arg_706_1.state_ = "playing"
		arg_706_1.curTalkId_ = 1109503167
		arg_706_1.duration_ = 5.7

		SetActive(arg_706_1.tipsGo_, false)

		function arg_706_1.onSingleLineFinish_()
			arg_706_1.onSingleLineUpdate_ = nil
			arg_706_1.onSingleLineFinish_ = nil
			arg_706_1.state_ = "waiting"
		end

		function arg_706_1.playNext_(arg_708_0)
			if arg_708_0 == 1 then
				arg_706_0:Play1109503168(arg_706_1)
			end
		end

		function arg_706_1.onSingleLineUpdate_(arg_709_0)
			local var_709_0 = 0

			if var_709_0 < arg_706_1.time_ and arg_706_1.time_ <= var_709_0 + arg_709_0 then
				arg_706_1.mask_.enabled = true
				arg_706_1.mask_.raycastTarget = true

				arg_706_1:SetGaussion(false)
			end

			local var_709_1 = 0.7

			if var_709_0 <= arg_706_1.time_ and arg_706_1.time_ < var_709_0 + var_709_1 then
				local var_709_2 = (arg_706_1.time_ - var_709_0) / var_709_1
				local var_709_3 = Color.New(1, 1, 1)

				var_709_3.a = Mathf.Lerp(1, 0, var_709_2)
				arg_706_1.mask_.color = var_709_3
			end

			if arg_706_1.time_ >= var_709_0 + var_709_1 and arg_706_1.time_ < var_709_0 + var_709_1 + arg_709_0 then
				local var_709_4 = Color.New(1, 1, 1)
				local var_709_5 = 0

				arg_706_1.mask_.enabled = false
				var_709_4.a = var_709_5
				arg_706_1.mask_.color = var_709_4
			end

			if arg_706_1.frameCnt_ <= 1 then
				arg_706_1.dialog_:SetActive(false)
			end

			local var_709_6 = 0.7
			local var_709_7 = 0.15

			if var_709_6 < arg_706_1.time_ and arg_706_1.time_ <= var_709_6 + arg_709_0 then
				arg_706_1.talkMaxDuration = 0

				arg_706_1.dialog_:SetActive(true)

				arg_706_1.dialogCg_.alpha = 0

				local var_709_8 = LeanTween.value(arg_706_1.dialog_, 0, 1, 0.3)

				var_709_8:setOnUpdate(LuaHelper.FloatAction(function(arg_710_0)
					arg_706_1.dialogCg_.alpha = arg_710_0
				end))
				var_709_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_706_1.dialog_)
					var_709_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_706_1.duration_ = arg_706_1.duration_ + 0.3

				SetActive(arg_706_1.leftNameGo_, true)

				local var_709_9 = arg_706_1:FormatText(StoryNameCfg[7].name)

				arg_706_1.leftNameTxt_.text = var_709_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_706_1.leftNameTxt_.transform)

				arg_706_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_706_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_706_1:RecordName(arg_706_1.leftNameTxt_.text)
				SetActive(arg_706_1.iconTrs_.gameObject, true)
				arg_706_1.iconController_:SetSelectedState("hero")

				arg_706_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_706_1.callingController_:SetSelectedState("normal")

				arg_706_1.keyicon_.color = Color.New(1, 1, 1)
				arg_706_1.icon_.color = Color.New(1, 1, 1)

				local var_709_10 = arg_706_1:GetWordFromCfg(1109503167)
				local var_709_11 = arg_706_1:FormatText(var_709_10.content)

				arg_706_1.text_.text = var_709_11

				LuaForUtil.ClearLinePrefixSymbol(arg_706_1.text_)

				local var_709_12 = 6
				local var_709_13 = utf8.len(var_709_11)
				local var_709_14 = var_709_12 <= 0 and var_709_7 or var_709_7 * (var_709_13 / var_709_12)

				if var_709_14 > 0 and var_709_7 < var_709_14 then
					arg_706_1.talkMaxDuration = var_709_14
					var_709_6 = var_709_6 + 0.3

					if var_709_14 + var_709_6 > arg_706_1.duration_ then
						arg_706_1.duration_ = var_709_14 + var_709_6
					end
				end

				arg_706_1.text_.text = var_709_11
				arg_706_1.typewritter.percent = 0

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(false)
				arg_706_1:RecordContent(arg_706_1.text_.text)
			end

			local var_709_15 = var_709_6 + 0.3
			local var_709_16 = math.max(var_709_7, arg_706_1.talkMaxDuration)

			if var_709_15 <= arg_706_1.time_ and arg_706_1.time_ < var_709_15 + var_709_16 then
				arg_706_1.typewritter.percent = (arg_706_1.time_ - var_709_15) / var_709_16

				arg_706_1.typewritter:SetDirty()
			end

			if arg_706_1.time_ >= var_709_15 + var_709_16 and arg_706_1.time_ < var_709_15 + var_709_16 + arg_709_0 then
				arg_706_1.typewritter.percent = 1

				arg_706_1.typewritter:SetDirty()
				arg_706_1:ShowNextGo(true)
			end
		end

		arg_706_1.nodeConfigList_ = {}

		arg_706_1:InitPlayNodeList()
	end,
	Play1109503168 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 1109503168
		arg_712_1.duration_ = 5

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play1109503169(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = 0
			local var_715_1 = 0.35

			if var_715_0 < arg_712_1.time_ and arg_712_1.time_ <= var_715_0 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, false)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_712_1.iconTrs_.gameObject, false)
				arg_712_1.callingController_:SetSelectedState("normal")

				local var_715_2 = arg_712_1:GetWordFromCfg(1109503168)
				local var_715_3 = arg_712_1:FormatText(var_715_2.content)

				arg_712_1.text_.text = var_715_3

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_4 = 14
				local var_715_5 = utf8.len(var_715_3)
				local var_715_6 = var_715_4 <= 0 and var_715_1 or var_715_1 * (var_715_5 / var_715_4)

				if var_715_6 > 0 and var_715_1 < var_715_6 then
					arg_712_1.talkMaxDuration = var_715_6

					if var_715_6 + var_715_0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_6 + var_715_0
					end
				end

				arg_712_1.text_.text = var_715_3
				arg_712_1.typewritter.percent = 0

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(false)
				arg_712_1:RecordContent(arg_712_1.text_.text)
			end

			local var_715_7 = math.max(var_715_1, arg_712_1.talkMaxDuration)

			if var_715_0 <= arg_712_1.time_ and arg_712_1.time_ < var_715_0 + var_715_7 then
				arg_712_1.typewritter.percent = (arg_712_1.time_ - var_715_0) / var_715_7

				arg_712_1.typewritter:SetDirty()
			end

			if arg_712_1.time_ >= var_715_0 + var_715_7 and arg_712_1.time_ < var_715_0 + var_715_7 + arg_715_0 then
				arg_712_1.typewritter.percent = 1

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(true)
			end
		end

		arg_712_1.nodeConfigList_ = {}

		arg_712_1:InitPlayNodeList()
	end,
	Play1109503169 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 1109503169
		arg_716_1.duration_ = 2

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play1109503170(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			local var_719_0 = arg_716_1.actors_["10058ui_story"].transform
			local var_719_1 = 0

			if var_719_1 < arg_716_1.time_ and arg_716_1.time_ <= var_719_1 + arg_719_0 then
				arg_716_1.var_.moveOldPos10058ui_story = var_719_0.localPosition
			end

			local var_719_2 = 0.001

			if var_719_1 <= arg_716_1.time_ and arg_716_1.time_ < var_719_1 + var_719_2 then
				local var_719_3 = (arg_716_1.time_ - var_719_1) / var_719_2
				local var_719_4 = Vector3.New(0, -0.98, -6.1)

				var_719_0.localPosition = Vector3.Lerp(arg_716_1.var_.moveOldPos10058ui_story, var_719_4, var_719_3)

				local var_719_5 = manager.ui.mainCamera.transform.position - var_719_0.position

				var_719_0.forward = Vector3.New(var_719_5.x, var_719_5.y, var_719_5.z)

				local var_719_6 = var_719_0.localEulerAngles

				var_719_6.z = 0
				var_719_6.x = 0
				var_719_0.localEulerAngles = var_719_6
			end

			if arg_716_1.time_ >= var_719_1 + var_719_2 and arg_716_1.time_ < var_719_1 + var_719_2 + arg_719_0 then
				var_719_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_719_7 = manager.ui.mainCamera.transform.position - var_719_0.position

				var_719_0.forward = Vector3.New(var_719_7.x, var_719_7.y, var_719_7.z)

				local var_719_8 = var_719_0.localEulerAngles

				var_719_8.z = 0
				var_719_8.x = 0
				var_719_0.localEulerAngles = var_719_8
			end

			local var_719_9 = arg_716_1.actors_["10058ui_story"]
			local var_719_10 = 0

			if var_719_10 < arg_716_1.time_ and arg_716_1.time_ <= var_719_10 + arg_719_0 and not isNil(var_719_9) and arg_716_1.var_.characterEffect10058ui_story == nil then
				arg_716_1.var_.characterEffect10058ui_story = var_719_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_719_11 = 0.200000002980232

			if var_719_10 <= arg_716_1.time_ and arg_716_1.time_ < var_719_10 + var_719_11 and not isNil(var_719_9) then
				local var_719_12 = (arg_716_1.time_ - var_719_10) / var_719_11

				if arg_716_1.var_.characterEffect10058ui_story and not isNil(var_719_9) then
					arg_716_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_716_1.time_ >= var_719_10 + var_719_11 and arg_716_1.time_ < var_719_10 + var_719_11 + arg_719_0 and not isNil(var_719_9) and arg_716_1.var_.characterEffect10058ui_story then
				arg_716_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_719_13 = 0

			if var_719_13 < arg_716_1.time_ and arg_716_1.time_ <= var_719_13 + arg_719_0 then
				arg_716_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_719_14 = 0
			local var_719_15 = 0.075

			if var_719_14 < arg_716_1.time_ and arg_716_1.time_ <= var_719_14 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0
				arg_716_1.dialogCg_.alpha = 1

				arg_716_1.dialog_:SetActive(true)
				SetActive(arg_716_1.leftNameGo_, true)

				local var_719_16 = arg_716_1:FormatText(StoryNameCfg[471].name)

				arg_716_1.leftNameTxt_.text = var_719_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_716_1.leftNameTxt_.transform)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1.leftNameTxt_.text)
				SetActive(arg_716_1.iconTrs_.gameObject, false)
				arg_716_1.callingController_:SetSelectedState("normal")

				local var_719_17 = arg_716_1:GetWordFromCfg(1109503169)
				local var_719_18 = arg_716_1:FormatText(var_719_17.content)

				arg_716_1.text_.text = var_719_18

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_19 = 3
				local var_719_20 = utf8.len(var_719_18)
				local var_719_21 = var_719_19 <= 0 and var_719_15 or var_719_15 * (var_719_20 / var_719_19)

				if var_719_21 > 0 and var_719_15 < var_719_21 then
					arg_716_1.talkMaxDuration = var_719_21

					if var_719_21 + var_719_14 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_21 + var_719_14
					end
				end

				arg_716_1.text_.text = var_719_18
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503169", "story_v_side_new_1109503.awb") ~= 0 then
					local var_719_22 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503169", "story_v_side_new_1109503.awb") / 1000

					if var_719_22 + var_719_14 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_22 + var_719_14
					end

					if var_719_17.prefab_name ~= "" and arg_716_1.actors_[var_719_17.prefab_name] ~= nil then
						local var_719_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_716_1.actors_[var_719_17.prefab_name].transform, "story_v_side_new_1109503", "1109503169", "story_v_side_new_1109503.awb")

						arg_716_1:RecordAudio("1109503169", var_719_23)
						arg_716_1:RecordAudio("1109503169", var_719_23)
					else
						arg_716_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503169", "story_v_side_new_1109503.awb")
					end

					arg_716_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503169", "story_v_side_new_1109503.awb")
				end

				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_24 = math.max(var_719_15, arg_716_1.talkMaxDuration)

			if var_719_14 <= arg_716_1.time_ and arg_716_1.time_ < var_719_14 + var_719_24 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - var_719_14) / var_719_24

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= var_719_14 + var_719_24 and arg_716_1.time_ < var_719_14 + var_719_24 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_716_1:InitPlayNodeList()
	end,
	Play1109503170 = function(arg_720_0, arg_720_1)
		arg_720_1.time_ = 0
		arg_720_1.frameCnt_ = 0
		arg_720_1.state_ = "playing"
		arg_720_1.curTalkId_ = 1109503170
		arg_720_1.duration_ = 5

		SetActive(arg_720_1.tipsGo_, false)

		function arg_720_1.onSingleLineFinish_()
			arg_720_1.onSingleLineUpdate_ = nil
			arg_720_1.onSingleLineFinish_ = nil
			arg_720_1.state_ = "waiting"
		end

		function arg_720_1.playNext_(arg_722_0)
			if arg_722_0 == 1 then
				arg_720_0:Play1109503171(arg_720_1)
			end
		end

		function arg_720_1.onSingleLineUpdate_(arg_723_0)
			local var_723_0 = arg_720_1.actors_["10058ui_story"]
			local var_723_1 = 0

			if var_723_1 < arg_720_1.time_ and arg_720_1.time_ <= var_723_1 + arg_723_0 and not isNil(var_723_0) and arg_720_1.var_.characterEffect10058ui_story == nil then
				arg_720_1.var_.characterEffect10058ui_story = var_723_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_723_2 = 0.200000002980232

			if var_723_1 <= arg_720_1.time_ and arg_720_1.time_ < var_723_1 + var_723_2 and not isNil(var_723_0) then
				local var_723_3 = (arg_720_1.time_ - var_723_1) / var_723_2

				if arg_720_1.var_.characterEffect10058ui_story and not isNil(var_723_0) then
					local var_723_4 = Mathf.Lerp(0, 0.5, var_723_3)

					arg_720_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_720_1.var_.characterEffect10058ui_story.fillRatio = var_723_4
				end
			end

			if arg_720_1.time_ >= var_723_1 + var_723_2 and arg_720_1.time_ < var_723_1 + var_723_2 + arg_723_0 and not isNil(var_723_0) and arg_720_1.var_.characterEffect10058ui_story then
				local var_723_5 = 0.5

				arg_720_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_720_1.var_.characterEffect10058ui_story.fillRatio = var_723_5
			end

			local var_723_6 = 0
			local var_723_7 = 0.35

			if var_723_6 < arg_720_1.time_ and arg_720_1.time_ <= var_723_6 + arg_723_0 then
				arg_720_1.talkMaxDuration = 0
				arg_720_1.dialogCg_.alpha = 1

				arg_720_1.dialog_:SetActive(true)
				SetActive(arg_720_1.leftNameGo_, true)

				local var_723_8 = arg_720_1:FormatText(StoryNameCfg[7].name)

				arg_720_1.leftNameTxt_.text = var_723_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_720_1.leftNameTxt_.transform)

				arg_720_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_720_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_720_1:RecordName(arg_720_1.leftNameTxt_.text)
				SetActive(arg_720_1.iconTrs_.gameObject, true)
				arg_720_1.iconController_:SetSelectedState("hero")

				arg_720_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_720_1.callingController_:SetSelectedState("normal")

				arg_720_1.keyicon_.color = Color.New(1, 1, 1)
				arg_720_1.icon_.color = Color.New(1, 1, 1)

				local var_723_9 = arg_720_1:GetWordFromCfg(1109503170)
				local var_723_10 = arg_720_1:FormatText(var_723_9.content)

				arg_720_1.text_.text = var_723_10

				LuaForUtil.ClearLinePrefixSymbol(arg_720_1.text_)

				local var_723_11 = 14
				local var_723_12 = utf8.len(var_723_10)
				local var_723_13 = var_723_11 <= 0 and var_723_7 or var_723_7 * (var_723_12 / var_723_11)

				if var_723_13 > 0 and var_723_7 < var_723_13 then
					arg_720_1.talkMaxDuration = var_723_13

					if var_723_13 + var_723_6 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_13 + var_723_6
					end
				end

				arg_720_1.text_.text = var_723_10
				arg_720_1.typewritter.percent = 0

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(false)
				arg_720_1:RecordContent(arg_720_1.text_.text)
			end

			local var_723_14 = math.max(var_723_7, arg_720_1.talkMaxDuration)

			if var_723_6 <= arg_720_1.time_ and arg_720_1.time_ < var_723_6 + var_723_14 then
				arg_720_1.typewritter.percent = (arg_720_1.time_ - var_723_6) / var_723_14

				arg_720_1.typewritter:SetDirty()
			end

			if arg_720_1.time_ >= var_723_6 + var_723_14 and arg_720_1.time_ < var_723_6 + var_723_14 + arg_723_0 then
				arg_720_1.typewritter.percent = 1

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(true)
			end
		end

		arg_720_1.nodeConfigList_ = {}

		arg_720_1:InitPlayNodeList()
	end,
	Play1109503171 = function(arg_724_0, arg_724_1)
		arg_724_1.time_ = 0
		arg_724_1.frameCnt_ = 0
		arg_724_1.state_ = "playing"
		arg_724_1.curTalkId_ = 1109503171
		arg_724_1.duration_ = 5

		SetActive(arg_724_1.tipsGo_, false)

		function arg_724_1.onSingleLineFinish_()
			arg_724_1.onSingleLineUpdate_ = nil
			arg_724_1.onSingleLineFinish_ = nil
			arg_724_1.state_ = "waiting"
		end

		function arg_724_1.playNext_(arg_726_0)
			if arg_726_0 == 1 then
				arg_724_0:Play1109503172(arg_724_1)
			end
		end

		function arg_724_1.onSingleLineUpdate_(arg_727_0)
			local var_727_0 = arg_724_1.actors_["10058ui_story"].transform
			local var_727_1 = 0

			if var_727_1 < arg_724_1.time_ and arg_724_1.time_ <= var_727_1 + arg_727_0 then
				arg_724_1.var_.moveOldPos10058ui_story = var_727_0.localPosition
			end

			local var_727_2 = 0.001

			if var_727_1 <= arg_724_1.time_ and arg_724_1.time_ < var_727_1 + var_727_2 then
				local var_727_3 = (arg_724_1.time_ - var_727_1) / var_727_2
				local var_727_4 = Vector3.New(0, 100, 0)

				var_727_0.localPosition = Vector3.Lerp(arg_724_1.var_.moveOldPos10058ui_story, var_727_4, var_727_3)

				local var_727_5 = manager.ui.mainCamera.transform.position - var_727_0.position

				var_727_0.forward = Vector3.New(var_727_5.x, var_727_5.y, var_727_5.z)

				local var_727_6 = var_727_0.localEulerAngles

				var_727_6.z = 0
				var_727_6.x = 0
				var_727_0.localEulerAngles = var_727_6
			end

			if arg_724_1.time_ >= var_727_1 + var_727_2 and arg_724_1.time_ < var_727_1 + var_727_2 + arg_727_0 then
				var_727_0.localPosition = Vector3.New(0, 100, 0)

				local var_727_7 = manager.ui.mainCamera.transform.position - var_727_0.position

				var_727_0.forward = Vector3.New(var_727_7.x, var_727_7.y, var_727_7.z)

				local var_727_8 = var_727_0.localEulerAngles

				var_727_8.z = 0
				var_727_8.x = 0
				var_727_0.localEulerAngles = var_727_8
			end

			local var_727_9 = 0
			local var_727_10 = 0.625

			if var_727_9 < arg_724_1.time_ and arg_724_1.time_ <= var_727_9 + arg_727_0 then
				arg_724_1.talkMaxDuration = 0
				arg_724_1.dialogCg_.alpha = 1

				arg_724_1.dialog_:SetActive(true)
				SetActive(arg_724_1.leftNameGo_, false)

				arg_724_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_724_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_724_1:RecordName(arg_724_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_724_1.iconTrs_.gameObject, false)
				arg_724_1.callingController_:SetSelectedState("normal")

				local var_727_11 = arg_724_1:GetWordFromCfg(1109503171)
				local var_727_12 = arg_724_1:FormatText(var_727_11.content)

				arg_724_1.text_.text = var_727_12

				LuaForUtil.ClearLinePrefixSymbol(arg_724_1.text_)

				local var_727_13 = 25
				local var_727_14 = utf8.len(var_727_12)
				local var_727_15 = var_727_13 <= 0 and var_727_10 or var_727_10 * (var_727_14 / var_727_13)

				if var_727_15 > 0 and var_727_10 < var_727_15 then
					arg_724_1.talkMaxDuration = var_727_15

					if var_727_15 + var_727_9 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_15 + var_727_9
					end
				end

				arg_724_1.text_.text = var_727_12
				arg_724_1.typewritter.percent = 0

				arg_724_1.typewritter:SetDirty()
				arg_724_1:ShowNextGo(false)
				arg_724_1:RecordContent(arg_724_1.text_.text)
			end

			local var_727_16 = math.max(var_727_10, arg_724_1.talkMaxDuration)

			if var_727_9 <= arg_724_1.time_ and arg_724_1.time_ < var_727_9 + var_727_16 then
				arg_724_1.typewritter.percent = (arg_724_1.time_ - var_727_9) / var_727_16

				arg_724_1.typewritter:SetDirty()
			end

			if arg_724_1.time_ >= var_727_9 + var_727_16 and arg_724_1.time_ < var_727_9 + var_727_16 + arg_727_0 then
				arg_724_1.typewritter.percent = 1

				arg_724_1.typewritter:SetDirty()
				arg_724_1:ShowNextGo(true)
			end
		end

		arg_724_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_724_1:InitPlayNodeList()
	end,
	Play1109503172 = function(arg_728_0, arg_728_1)
		arg_728_1.time_ = 0
		arg_728_1.frameCnt_ = 0
		arg_728_1.state_ = "playing"
		arg_728_1.curTalkId_ = 1109503172
		arg_728_1.duration_ = 1

		SetActive(arg_728_1.tipsGo_, false)

		function arg_728_1.onSingleLineFinish_()
			arg_728_1.onSingleLineUpdate_ = nil
			arg_728_1.onSingleLineFinish_ = nil
			arg_728_1.state_ = "waiting"

			SetActive(arg_728_1.choicesGo_, true)

			for iter_729_0, iter_729_1 in ipairs(arg_728_1.choices_) do
				local var_729_0 = iter_729_0 <= 1

				SetActive(iter_729_1.go, var_729_0)
			end

			arg_728_1.choices_[1].txt.text = arg_728_1:FormatText(StoryChoiceCfg[728].name)
		end

		function arg_728_1.playNext_(arg_730_0)
			if arg_730_0 == 1 then
				arg_728_0:Play1109503173(arg_728_1)
			end

			arg_728_1:RecordChoiceLog(1109503172, 728)
		end

		function arg_728_1.onSingleLineUpdate_(arg_731_0)
			local var_731_0 = 0

			if var_731_0 < arg_728_1.time_ and arg_728_1.time_ <= var_731_0 + arg_731_0 then
				arg_728_1.allBtn_.enabled = false
			end

			local var_731_1 = 0.5

			if arg_728_1.time_ >= var_731_0 + var_731_1 and arg_728_1.time_ < var_731_0 + var_731_1 + arg_731_0 then
				arg_728_1.allBtn_.enabled = true
			end
		end

		arg_728_1.nodeConfigList_ = {}

		arg_728_1:InitPlayNodeList()
	end,
	Play1109503173 = function(arg_732_0, arg_732_1)
		arg_732_1.time_ = 0
		arg_732_1.frameCnt_ = 0
		arg_732_1.state_ = "playing"
		arg_732_1.curTalkId_ = 1109503173
		arg_732_1.duration_ = 5

		SetActive(arg_732_1.tipsGo_, false)

		function arg_732_1.onSingleLineFinish_()
			arg_732_1.onSingleLineUpdate_ = nil
			arg_732_1.onSingleLineFinish_ = nil
			arg_732_1.state_ = "waiting"
		end

		function arg_732_1.playNext_(arg_734_0)
			if arg_734_0 == 1 then
				arg_732_0:Play1109503174(arg_732_1)
			end
		end

		function arg_732_1.onSingleLineUpdate_(arg_735_0)
			local var_735_0 = 0
			local var_735_1 = 0.65

			if var_735_0 < arg_732_1.time_ and arg_732_1.time_ <= var_735_0 + arg_735_0 then
				arg_732_1.talkMaxDuration = 0

				arg_732_1.dialog_:SetActive(true)

				arg_732_1.dialogCg_.alpha = 0

				local var_735_2 = LeanTween.value(arg_732_1.dialog_, 0, 1, 0.3)

				var_735_2:setOnUpdate(LuaHelper.FloatAction(function(arg_736_0)
					arg_732_1.dialogCg_.alpha = arg_736_0
				end))
				var_735_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_732_1.dialog_)
					var_735_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_732_1.duration_ = arg_732_1.duration_ + 0.3

				SetActive(arg_732_1.leftNameGo_, false)

				arg_732_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_732_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_732_1:RecordName(arg_732_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_732_1.iconTrs_.gameObject, false)
				arg_732_1.callingController_:SetSelectedState("normal")

				local var_735_3 = arg_732_1:GetWordFromCfg(1109503173)
				local var_735_4 = arg_732_1:FormatText(var_735_3.content)

				arg_732_1.text_.text = var_735_4

				LuaForUtil.ClearLinePrefixSymbol(arg_732_1.text_)

				local var_735_5 = 26
				local var_735_6 = utf8.len(var_735_4)
				local var_735_7 = var_735_5 <= 0 and var_735_1 or var_735_1 * (var_735_6 / var_735_5)

				if var_735_7 > 0 and var_735_1 < var_735_7 then
					arg_732_1.talkMaxDuration = var_735_7
					var_735_0 = var_735_0 + 0.3

					if var_735_7 + var_735_0 > arg_732_1.duration_ then
						arg_732_1.duration_ = var_735_7 + var_735_0
					end
				end

				arg_732_1.text_.text = var_735_4
				arg_732_1.typewritter.percent = 0

				arg_732_1.typewritter:SetDirty()
				arg_732_1:ShowNextGo(false)
				arg_732_1:RecordContent(arg_732_1.text_.text)
			end

			local var_735_8 = var_735_0 + 0.3
			local var_735_9 = math.max(var_735_1, arg_732_1.talkMaxDuration)

			if var_735_8 <= arg_732_1.time_ and arg_732_1.time_ < var_735_8 + var_735_9 then
				arg_732_1.typewritter.percent = (arg_732_1.time_ - var_735_8) / var_735_9

				arg_732_1.typewritter:SetDirty()
			end

			if arg_732_1.time_ >= var_735_8 + var_735_9 and arg_732_1.time_ < var_735_8 + var_735_9 + arg_735_0 then
				arg_732_1.typewritter.percent = 1

				arg_732_1.typewritter:SetDirty()
				arg_732_1:ShowNextGo(true)
			end
		end

		arg_732_1.nodeConfigList_ = {}

		arg_732_1:InitPlayNodeList()
	end,
	Play1109503174 = function(arg_738_0, arg_738_1)
		arg_738_1.time_ = 0
		arg_738_1.frameCnt_ = 0
		arg_738_1.state_ = "playing"
		arg_738_1.curTalkId_ = 1109503174
		arg_738_1.duration_ = 4.03

		local var_738_0 = {
			zh = 2.866,
			ja = 4.033
		}
		local var_738_1 = manager.audio:GetLocalizationFlag()

		if var_738_0[var_738_1] ~= nil then
			arg_738_1.duration_ = var_738_0[var_738_1]
		end

		SetActive(arg_738_1.tipsGo_, false)

		function arg_738_1.onSingleLineFinish_()
			arg_738_1.onSingleLineUpdate_ = nil
			arg_738_1.onSingleLineFinish_ = nil
			arg_738_1.state_ = "waiting"
		end

		function arg_738_1.playNext_(arg_740_0)
			if arg_740_0 == 1 then
				arg_738_0:Play1109503175(arg_738_1)
			end
		end

		function arg_738_1.onSingleLineUpdate_(arg_741_0)
			local var_741_0 = 0
			local var_741_1 = 0.2

			if var_741_0 < arg_738_1.time_ and arg_738_1.time_ <= var_741_0 + arg_741_0 then
				arg_738_1.talkMaxDuration = 0
				arg_738_1.dialogCg_.alpha = 1

				arg_738_1.dialog_:SetActive(true)
				SetActive(arg_738_1.leftNameGo_, true)

				local var_741_2 = arg_738_1:FormatText(StoryNameCfg[664].name)

				arg_738_1.leftNameTxt_.text = var_741_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_738_1.leftNameTxt_.transform)

				arg_738_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_738_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_738_1:RecordName(arg_738_1.leftNameTxt_.text)
				SetActive(arg_738_1.iconTrs_.gameObject, true)
				arg_738_1.iconController_:SetSelectedState("hero")

				arg_738_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_738_1.callingController_:SetSelectedState("normal")

				arg_738_1.keyicon_.color = Color.New(1, 1, 1)
				arg_738_1.icon_.color = Color.New(1, 1, 1)

				local var_741_3 = arg_738_1:GetWordFromCfg(1109503174)
				local var_741_4 = arg_738_1:FormatText(var_741_3.content)

				arg_738_1.text_.text = var_741_4

				LuaForUtil.ClearLinePrefixSymbol(arg_738_1.text_)

				local var_741_5 = 8
				local var_741_6 = utf8.len(var_741_4)
				local var_741_7 = var_741_5 <= 0 and var_741_1 or var_741_1 * (var_741_6 / var_741_5)

				if var_741_7 > 0 and var_741_1 < var_741_7 then
					arg_738_1.talkMaxDuration = var_741_7

					if var_741_7 + var_741_0 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_7 + var_741_0
					end
				end

				arg_738_1.text_.text = var_741_4
				arg_738_1.typewritter.percent = 0

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503174", "story_v_side_new_1109503.awb") ~= 0 then
					local var_741_8 = manager.audio:GetVoiceLength("story_v_side_new_1109503", "1109503174", "story_v_side_new_1109503.awb") / 1000

					if var_741_8 + var_741_0 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_8 + var_741_0
					end

					if var_741_3.prefab_name ~= "" and arg_738_1.actors_[var_741_3.prefab_name] ~= nil then
						local var_741_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_738_1.actors_[var_741_3.prefab_name].transform, "story_v_side_new_1109503", "1109503174", "story_v_side_new_1109503.awb")

						arg_738_1:RecordAudio("1109503174", var_741_9)
						arg_738_1:RecordAudio("1109503174", var_741_9)
					else
						arg_738_1:AudioAction("play", "voice", "story_v_side_new_1109503", "1109503174", "story_v_side_new_1109503.awb")
					end

					arg_738_1:RecordHistoryTalkVoice("story_v_side_new_1109503", "1109503174", "story_v_side_new_1109503.awb")
				end

				arg_738_1:RecordContent(arg_738_1.text_.text)
			end

			local var_741_10 = math.max(var_741_1, arg_738_1.talkMaxDuration)

			if var_741_0 <= arg_738_1.time_ and arg_738_1.time_ < var_741_0 + var_741_10 then
				arg_738_1.typewritter.percent = (arg_738_1.time_ - var_741_0) / var_741_10

				arg_738_1.typewritter:SetDirty()
			end

			if arg_738_1.time_ >= var_741_0 + var_741_10 and arg_738_1.time_ < var_741_0 + var_741_10 + arg_741_0 then
				arg_738_1.typewritter.percent = 1

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(true)
			end
		end

		arg_738_1.nodeConfigList_ = {}

		arg_738_1:InitPlayNodeList()
	end,
	Play1109503175 = function(arg_742_0, arg_742_1)
		arg_742_1.time_ = 0
		arg_742_1.frameCnt_ = 0
		arg_742_1.state_ = "playing"
		arg_742_1.curTalkId_ = 1109503175
		arg_742_1.duration_ = 5

		SetActive(arg_742_1.tipsGo_, false)

		function arg_742_1.onSingleLineFinish_()
			arg_742_1.onSingleLineUpdate_ = nil
			arg_742_1.onSingleLineFinish_ = nil
			arg_742_1.state_ = "waiting"
			arg_742_1.auto_ = false
		end

		function arg_742_1.playNext_(arg_744_0)
			arg_742_1.onStoryFinished_()
		end

		function arg_742_1.onSingleLineUpdate_(arg_745_0)
			local var_745_0 = 0
			local var_745_1 = 0.25

			if var_745_0 < arg_742_1.time_ and arg_742_1.time_ <= var_745_0 + arg_745_0 then
				arg_742_1.talkMaxDuration = 0
				arg_742_1.dialogCg_.alpha = 1

				arg_742_1.dialog_:SetActive(true)
				SetActive(arg_742_1.leftNameGo_, true)

				local var_745_2 = arg_742_1:FormatText(StoryNameCfg[7].name)

				arg_742_1.leftNameTxt_.text = var_745_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_742_1.leftNameTxt_.transform)

				arg_742_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_742_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_742_1:RecordName(arg_742_1.leftNameTxt_.text)
				SetActive(arg_742_1.iconTrs_.gameObject, true)
				arg_742_1.iconController_:SetSelectedState("hero")

				arg_742_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_742_1.callingController_:SetSelectedState("normal")

				arg_742_1.keyicon_.color = Color.New(1, 1, 1)
				arg_742_1.icon_.color = Color.New(1, 1, 1)

				local var_745_3 = arg_742_1:GetWordFromCfg(1109503175)
				local var_745_4 = arg_742_1:FormatText(var_745_3.content)

				arg_742_1.text_.text = var_745_4

				LuaForUtil.ClearLinePrefixSymbol(arg_742_1.text_)

				local var_745_5 = 10
				local var_745_6 = utf8.len(var_745_4)
				local var_745_7 = var_745_5 <= 0 and var_745_1 or var_745_1 * (var_745_6 / var_745_5)

				if var_745_7 > 0 and var_745_1 < var_745_7 then
					arg_742_1.talkMaxDuration = var_745_7

					if var_745_7 + var_745_0 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_7 + var_745_0
					end
				end

				arg_742_1.text_.text = var_745_4
				arg_742_1.typewritter.percent = 0

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(false)
				arg_742_1:RecordContent(arg_742_1.text_.text)
			end

			local var_745_8 = math.max(var_745_1, arg_742_1.talkMaxDuration)

			if var_745_0 <= arg_742_1.time_ and arg_742_1.time_ < var_745_0 + var_745_8 then
				arg_742_1.typewritter.percent = (arg_742_1.time_ - var_745_0) / var_745_8

				arg_742_1.typewritter:SetDirty()
			end

			if arg_742_1.time_ >= var_745_0 + var_745_8 and arg_742_1.time_ < var_745_0 + var_745_8 + arg_745_0 then
				arg_742_1.typewritter.percent = 1

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(true)
			end
		end

		arg_742_1.nodeConfigList_ = {}

		arg_742_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F02a_1",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST04b",
		"TextureConfig/Background/F02a",
		"TextureConfig/Background/ST15"
	},
	voices = {
		"story_v_side_new_1109503.awb"
	}
}
