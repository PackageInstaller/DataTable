return {
	Play318041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318041001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST69"

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
				local var_4_5 = arg_1_1.bgs_.ST69

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
					if iter_4_0 ~= "ST69" then
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

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten")

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
			local var_4_35 = 0.55

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

				local var_4_37 = arg_1_1:GetWordFromCfg(318041001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 22
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
	Play318041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318041002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play318041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.8

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

				local var_12_2 = arg_9_1:GetWordFromCfg(318041002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 32
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
	Play318041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318041003
		arg_13_1.duration_ = 4.03

		local var_13_0 = {
			zh = 4.033,
			ja = 2.5
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
				arg_13_0:Play318041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1050ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1050ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1050ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1, -6.1)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1050ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1, -6.1)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1050ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1050ui_story == nil then
				arg_13_1.var_.characterEffect1050ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1050ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1050ui_story then
				arg_13_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_16_20 = 0
			local var_16_21 = 0.275

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[74].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(318041003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041003", "story_v_out_318041.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_318041", "318041003", "story_v_out_318041.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_318041", "318041003", "story_v_out_318041.awb")

						arg_13_1:RecordAudio("318041003", var_16_29)
						arg_13_1:RecordAudio("318041003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_318041", "318041003", "story_v_out_318041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_318041", "318041003", "story_v_out_318041.awb")
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
				actorName = "1050ui_story",
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
	Play318041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318041004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play318041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1050ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1050ui_story == nil then
				arg_17_1.var_.characterEffect1050ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1050ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1050ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1050ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1050ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.433333333333333

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				local var_20_8 = "play"
				local var_20_9 = "effect"

				arg_17_1:AudioAction(var_20_8, var_20_9, "se_story_1210", "se_story_1210_walk", "")
			end

			local var_20_10 = 0
			local var_20_11 = 0.35

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(318041004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_14 = 14
				local var_20_15 = utf8.len(var_20_13)
				local var_20_16 = var_20_14 <= 0 and var_20_11 or var_20_11 * (var_20_15 / var_20_14)

				if var_20_16 > 0 and var_20_11 < var_20_16 then
					arg_17_1.talkMaxDuration = var_20_16

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_17 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_17 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_17

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_17 and arg_17_1.time_ < var_20_10 + var_20_17 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play318041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318041005
		arg_21_1.duration_ = 6.03

		local var_21_0 = {
			zh = 6.033,
			ja = 4.733
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
				arg_21_0:Play318041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1050ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1050ui_story == nil then
				arg_21_1.var_.characterEffect1050ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1050ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1050ui_story then
				arg_21_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 0.325

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_6 = arg_21_1:FormatText(StoryNameCfg[74].name)

				arg_21_1.leftNameTxt_.text = var_24_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(318041005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041005", "story_v_out_318041.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_318041", "318041005", "story_v_out_318041.awb") / 1000

					if var_24_12 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_4
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_318041", "318041005", "story_v_out_318041.awb")

						arg_21_1:RecordAudio("318041005", var_24_13)
						arg_21_1:RecordAudio("318041005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_318041", "318041005", "story_v_out_318041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_318041", "318041005", "story_v_out_318041.awb")
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
	Play318041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318041006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play318041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1050ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1050ui_story == nil then
				arg_25_1.var_.characterEffect1050ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1050ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1050ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1050ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1050ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.433333333333333

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				local var_28_8 = "play"
				local var_28_9 = "effect"

				arg_25_1:AudioAction(var_28_8, var_28_9, "se_story_16", "se_story_16_door04", "")
			end

			local var_28_10 = 0
			local var_28_11 = 0.45

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_12 = arg_25_1:GetWordFromCfg(318041006)
				local var_28_13 = arg_25_1:FormatText(var_28_12.content)

				arg_25_1.text_.text = var_28_13

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_14 = 18
				local var_28_15 = utf8.len(var_28_13)
				local var_28_16 = var_28_14 <= 0 and var_28_11 or var_28_11 * (var_28_15 / var_28_14)

				if var_28_16 > 0 and var_28_11 < var_28_16 then
					arg_25_1.talkMaxDuration = var_28_16

					if var_28_16 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_13
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_17 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_17 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_10) / var_28_17

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_10 + var_28_17 and arg_25_1.time_ < var_28_10 + var_28_17 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play318041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318041007
		arg_29_1.duration_ = 3.93

		local var_29_0 = {
			zh = 3.933,
			ja = 3.1
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
				arg_29_0:Play318041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1050ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1050ui_story == nil then
				arg_29_1.var_.characterEffect1050ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1050ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1050ui_story then
				arg_29_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_32_4 = 0
			local var_32_5 = 0.225

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_6 = arg_29_1:FormatText(StoryNameCfg[74].name)

				arg_29_1.leftNameTxt_.text = var_32_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(318041007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 9
				local var_32_10 = utf8.len(var_32_8)
				local var_32_11 = var_32_9 <= 0 and var_32_5 or var_32_5 * (var_32_10 / var_32_9)

				if var_32_11 > 0 and var_32_5 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041007", "story_v_out_318041.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_318041", "318041007", "story_v_out_318041.awb") / 1000

					if var_32_12 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_4
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_318041", "318041007", "story_v_out_318041.awb")

						arg_29_1:RecordAudio("318041007", var_32_13)
						arg_29_1:RecordAudio("318041007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_318041", "318041007", "story_v_out_318041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_318041", "318041007", "story_v_out_318041.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_14 and arg_29_1.time_ < var_32_4 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play318041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318041008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play318041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1050ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1050ui_story == nil then
				arg_33_1.var_.characterEffect1050ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1050ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1050ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1050ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1050ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.433333333333333

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				local var_36_8 = "play"
				local var_36_9 = "effect"

				arg_33_1:AudioAction(var_36_8, var_36_9, "se_story_16", "se_story_16_door04", "")
			end

			local var_36_10 = 0
			local var_36_11 = 0.25

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_12 = arg_33_1:GetWordFromCfg(318041008)
				local var_36_13 = arg_33_1:FormatText(var_36_12.content)

				arg_33_1.text_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_14 = 10
				local var_36_15 = utf8.len(var_36_13)
				local var_36_16 = var_36_14 <= 0 and var_36_11 or var_36_11 * (var_36_15 / var_36_14)

				if var_36_16 > 0 and var_36_11 < var_36_16 then
					arg_33_1.talkMaxDuration = var_36_16

					if var_36_16 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_13
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_17 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_17 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_17

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_17 and arg_33_1.time_ < var_36_10 + var_36_17 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play318041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318041009
		arg_37_1.duration_ = 2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play318041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1050ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1050ui_story == nil then
				arg_37_1.var_.characterEffect1050ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1050ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1050ui_story then
				arg_37_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_40_5 = 0
			local var_40_6 = 0.075

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_7 = arg_37_1:FormatText(StoryNameCfg[74].name)

				arg_37_1.leftNameTxt_.text = var_40_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(318041009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041009", "story_v_out_318041.awb") ~= 0 then
					local var_40_13 = manager.audio:GetVoiceLength("story_v_out_318041", "318041009", "story_v_out_318041.awb") / 1000

					if var_40_13 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_5
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_318041", "318041009", "story_v_out_318041.awb")

						arg_37_1:RecordAudio("318041009", var_40_14)
						arg_37_1:RecordAudio("318041009", var_40_14)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_318041", "318041009", "story_v_out_318041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_318041", "318041009", "story_v_out_318041.awb")
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
	Play318041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318041010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play318041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1050ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1050ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0, 100, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1050ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, 100, 0)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1050ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1050ui_story == nil then
				arg_41_1.var_.characterEffect1050ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1050ui_story and not isNil(var_44_9) then
					local var_44_13 = Mathf.Lerp(0, 0.5, var_44_12)

					arg_41_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1050ui_story.fillRatio = var_44_13
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1050ui_story then
				local var_44_14 = 0.5

				arg_41_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1050ui_story.fillRatio = var_44_14
			end

			local var_44_15 = 0
			local var_44_16 = 0.625

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_17 = arg_41_1:GetWordFromCfg(318041010)
				local var_44_18 = arg_41_1:FormatText(var_44_17.content)

				arg_41_1.text_.text = var_44_18

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 25
				local var_44_20 = utf8.len(var_44_18)
				local var_44_21 = var_44_19 <= 0 and var_44_16 or var_44_16 * (var_44_20 / var_44_19)

				if var_44_21 > 0 and var_44_16 < var_44_21 then
					arg_41_1.talkMaxDuration = var_44_21

					if var_44_21 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_21 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_18
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_22 and arg_41_1.time_ < var_44_15 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play318041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318041011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play318041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.075

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(318041011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 43
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play318041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318041012
		arg_49_1.duration_ = 3.43

		local var_49_0 = {
			zh = 3.433,
			ja = 1.999999999999
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
				arg_49_0:Play318041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1050ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1050ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, -1, -6.1)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1050ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1050ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1050ui_story == nil then
				arg_49_1.var_.characterEffect1050ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect1050ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1050ui_story then
				arg_49_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_15 = 0
			local var_52_16 = 0.225

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[74].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(318041012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 9
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041012", "story_v_out_318041.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_318041", "318041012", "story_v_out_318041.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_318041", "318041012", "story_v_out_318041.awb")

						arg_49_1:RecordAudio("318041012", var_52_24)
						arg_49_1:RecordAudio("318041012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_318041", "318041012", "story_v_out_318041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_318041", "318041012", "story_v_out_318041.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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
	Play318041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318041013
		arg_53_1.duration_ = 8.6

		local var_53_0 = {
			zh = 6.1,
			ja = 8.6
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
				arg_53_0:Play318041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.675

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[74].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(318041013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041013", "story_v_out_318041.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041013", "story_v_out_318041.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_318041", "318041013", "story_v_out_318041.awb")

						arg_53_1:RecordAudio("318041013", var_56_9)
						arg_53_1:RecordAudio("318041013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_318041", "318041013", "story_v_out_318041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_318041", "318041013", "story_v_out_318041.awb")
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
	Play318041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318041014
		arg_57_1.duration_ = 2.5

		local var_57_0 = {
			zh = 2,
			ja = 2.5
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
				arg_57_0:Play318041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.433333333333333

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				local var_60_2 = "play"
				local var_60_3 = "music"

				arg_57_1:AudioAction(var_60_2, var_60_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_60_4 = ""
				local var_60_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_60_5 ~= "" then
					if arg_57_1.bgmTxt_.text ~= var_60_5 and arg_57_1.bgmTxt_.text ~= "" then
						if arg_57_1.bgmTxt2_.text ~= "" then
							arg_57_1.bgmTxt_.text = arg_57_1.bgmTxt2_.text
						end

						arg_57_1.bgmTxt2_.text = var_60_5

						arg_57_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_57_1.bgmTxt_.text = var_60_5
						arg_57_1.bgmTxt2_.text = var_60_5
					end

					if arg_57_1.bgmTimer then
						arg_57_1.bgmTimer:Stop()

						arg_57_1.bgmTimer = nil
					end

					if arg_57_1.settingData.show_music_name == 1 then
						arg_57_1.musicController:SetSelectedState("show")
						arg_57_1.musicAnimator_:Play("open", 0, 0)

						if arg_57_1.settingData.music_time ~= 0 then
							arg_57_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_57_1.settingData.music_time), function()
								if arg_57_1 == nil or isNil(arg_57_1.bgmTxt_) then
									return
								end

								arg_57_1.musicController:SetSelectedState("hide")
								arg_57_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_60_6 = 0
			local var_60_7 = 0.25

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[74].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_9 = arg_57_1:GetWordFromCfg(318041014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041014", "story_v_out_318041.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041014", "story_v_out_318041.awb") / 1000

					if var_60_14 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_out_318041", "318041014", "story_v_out_318041.awb")

						arg_57_1:RecordAudio("318041014", var_60_15)
						arg_57_1:RecordAudio("318041014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_318041", "318041014", "story_v_out_318041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_318041", "318041014", "story_v_out_318041.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_16 and arg_57_1.time_ < var_60_6 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play318041015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 318041015
		arg_62_1.duration_ = 6.5

		local var_62_0 = {
			zh = 6.366,
			ja = 6.5
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
				arg_62_0:Play318041016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = "ST16"

			if arg_62_1.bgs_[var_65_0] == nil then
				local var_65_1 = Object.Instantiate(arg_62_1.paintGo_)

				var_65_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_65_0)
				var_65_1.name = var_65_0
				var_65_1.transform.parent = arg_62_1.stage_.transform
				var_65_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.bgs_[var_65_0] = var_65_1
			end

			local var_65_2 = 2

			if var_65_2 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				local var_65_3 = manager.ui.mainCamera.transform.localPosition
				local var_65_4 = Vector3.New(0, 0, 10) + Vector3.New(var_65_3.x, var_65_3.y, 0)
				local var_65_5 = arg_62_1.bgs_.ST16

				var_65_5.transform.localPosition = var_65_4
				var_65_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_65_6 = var_65_5:GetComponent("SpriteRenderer")

				if var_65_6 and var_65_6.sprite then
					local var_65_7 = (var_65_5.transform.localPosition - var_65_3).z
					local var_65_8 = manager.ui.mainCameraCom_
					local var_65_9 = 2 * var_65_7 * Mathf.Tan(var_65_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_65_10 = var_65_9 * var_65_8.aspect
					local var_65_11 = var_65_6.sprite.bounds.size.x
					local var_65_12 = var_65_6.sprite.bounds.size.y
					local var_65_13 = var_65_10 / var_65_11
					local var_65_14 = var_65_9 / var_65_12
					local var_65_15 = var_65_14 < var_65_13 and var_65_13 or var_65_14

					var_65_5.transform.localScale = Vector3.New(var_65_15, var_65_15, 0)
				end

				for iter_65_0, iter_65_1 in pairs(arg_62_1.bgs_) do
					if iter_65_0 ~= "ST16" then
						iter_65_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_65_16 = 0

			if var_65_16 < arg_62_1.time_ and arg_62_1.time_ <= var_65_16 + arg_65_0 then
				arg_62_1.mask_.enabled = true
				arg_62_1.mask_.raycastTarget = true

				arg_62_1:SetGaussion(false)
			end

			local var_65_17 = 2

			if var_65_16 <= arg_62_1.time_ and arg_62_1.time_ < var_65_16 + var_65_17 then
				local var_65_18 = (arg_62_1.time_ - var_65_16) / var_65_17
				local var_65_19 = Color.New(0, 0, 0)

				var_65_19.a = Mathf.Lerp(0, 1, var_65_18)
				arg_62_1.mask_.color = var_65_19
			end

			if arg_62_1.time_ >= var_65_16 + var_65_17 and arg_62_1.time_ < var_65_16 + var_65_17 + arg_65_0 then
				local var_65_20 = Color.New(0, 0, 0)

				var_65_20.a = 1
				arg_62_1.mask_.color = var_65_20
			end

			local var_65_21 = 2

			if var_65_21 < arg_62_1.time_ and arg_62_1.time_ <= var_65_21 + arg_65_0 then
				arg_62_1.mask_.enabled = true
				arg_62_1.mask_.raycastTarget = true

				arg_62_1:SetGaussion(false)
			end

			local var_65_22 = 2

			if var_65_21 <= arg_62_1.time_ and arg_62_1.time_ < var_65_21 + var_65_22 then
				local var_65_23 = (arg_62_1.time_ - var_65_21) / var_65_22
				local var_65_24 = Color.New(0, 0, 0)

				var_65_24.a = Mathf.Lerp(1, 0, var_65_23)
				arg_62_1.mask_.color = var_65_24
			end

			if arg_62_1.time_ >= var_65_21 + var_65_22 and arg_62_1.time_ < var_65_21 + var_65_22 + arg_65_0 then
				local var_65_25 = Color.New(0, 0, 0)
				local var_65_26 = 0

				arg_62_1.mask_.enabled = false
				var_65_25.a = var_65_26
				arg_62_1.mask_.color = var_65_25
			end

			local var_65_27 = arg_62_1.actors_["1050ui_story"].transform
			local var_65_28 = 2

			if var_65_28 < arg_62_1.time_ and arg_62_1.time_ <= var_65_28 + arg_65_0 then
				arg_62_1.var_.moveOldPos1050ui_story = var_65_27.localPosition
			end

			local var_65_29 = 0.001

			if var_65_28 <= arg_62_1.time_ and arg_62_1.time_ < var_65_28 + var_65_29 then
				local var_65_30 = (arg_62_1.time_ - var_65_28) / var_65_29
				local var_65_31 = Vector3.New(0, 100, 0)

				var_65_27.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1050ui_story, var_65_31, var_65_30)

				local var_65_32 = manager.ui.mainCamera.transform.position - var_65_27.position

				var_65_27.forward = Vector3.New(var_65_32.x, var_65_32.y, var_65_32.z)

				local var_65_33 = var_65_27.localEulerAngles

				var_65_33.z = 0
				var_65_33.x = 0
				var_65_27.localEulerAngles = var_65_33
			end

			if arg_62_1.time_ >= var_65_28 + var_65_29 and arg_62_1.time_ < var_65_28 + var_65_29 + arg_65_0 then
				var_65_27.localPosition = Vector3.New(0, 100, 0)

				local var_65_34 = manager.ui.mainCamera.transform.position - var_65_27.position

				var_65_27.forward = Vector3.New(var_65_34.x, var_65_34.y, var_65_34.z)

				local var_65_35 = var_65_27.localEulerAngles

				var_65_35.z = 0
				var_65_35.x = 0
				var_65_27.localEulerAngles = var_65_35
			end

			local var_65_36 = arg_62_1.actors_["1050ui_story"]
			local var_65_37 = 2

			if var_65_37 < arg_62_1.time_ and arg_62_1.time_ <= var_65_37 + arg_65_0 and not isNil(var_65_36) and arg_62_1.var_.characterEffect1050ui_story == nil then
				arg_62_1.var_.characterEffect1050ui_story = var_65_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_38 = 0.200000002980232

			if var_65_37 <= arg_62_1.time_ and arg_62_1.time_ < var_65_37 + var_65_38 and not isNil(var_65_36) then
				local var_65_39 = (arg_62_1.time_ - var_65_37) / var_65_38

				if arg_62_1.var_.characterEffect1050ui_story and not isNil(var_65_36) then
					local var_65_40 = Mathf.Lerp(0, 0.5, var_65_39)

					arg_62_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1050ui_story.fillRatio = var_65_40
				end
			end

			if arg_62_1.time_ >= var_65_37 + var_65_38 and arg_62_1.time_ < var_65_37 + var_65_38 + arg_65_0 and not isNil(var_65_36) and arg_62_1.var_.characterEffect1050ui_story then
				local var_65_41 = 0.5

				arg_62_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1050ui_story.fillRatio = var_65_41
			end

			local var_65_42 = 2

			arg_62_1.isInRecall_ = false

			if var_65_42 < arg_62_1.time_ and arg_62_1.time_ <= var_65_42 + arg_65_0 then
				arg_62_1.screenFilterGo_:SetActive(true)

				arg_62_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_65_2, iter_65_3 in pairs(arg_62_1.actors_) do
					local var_65_43 = iter_65_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_65_4, iter_65_5 in ipairs(var_65_43) do
						if iter_65_5.color.r > 0.51 then
							iter_65_5.color = Color.New(1, 1, 1)
						else
							iter_65_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_65_44 = 2

			if var_65_42 <= arg_62_1.time_ and arg_62_1.time_ < var_65_42 + var_65_44 then
				local var_65_45 = (arg_62_1.time_ - var_65_42) / var_65_44

				arg_62_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_65_45)
			end

			if arg_62_1.time_ >= var_65_42 + var_65_44 and arg_62_1.time_ < var_65_42 + var_65_44 + arg_65_0 then
				arg_62_1.screenFilterEffect_.weight = 1
			end

			local var_65_46 = 0
			local var_65_47 = 0.433333333333333

			if var_65_46 < arg_62_1.time_ and arg_62_1.time_ <= var_65_46 + arg_65_0 then
				local var_65_48 = "play"
				local var_65_49 = "music"

				arg_62_1:AudioAction(var_65_48, var_65_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_65_50 = ""
				local var_65_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_65_51 ~= "" then
					if arg_62_1.bgmTxt_.text ~= var_65_51 and arg_62_1.bgmTxt_.text ~= "" then
						if arg_62_1.bgmTxt2_.text ~= "" then
							arg_62_1.bgmTxt_.text = arg_62_1.bgmTxt2_.text
						end

						arg_62_1.bgmTxt2_.text = var_65_51

						arg_62_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_62_1.bgmTxt_.text = var_65_51
						arg_62_1.bgmTxt2_.text = var_65_51
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

			local var_65_52 = 2.3
			local var_65_53 = 1

			if var_65_52 < arg_62_1.time_ and arg_62_1.time_ <= var_65_52 + arg_65_0 then
				local var_65_54 = "play"
				local var_65_55 = "music"

				arg_62_1:AudioAction(var_65_54, var_65_55, "bgm_activity_2_10_story_buzenbo", "bgm_activity_2_10_story_buzenbo", "bgm_activity_2_10_story_buzenbo.awb")

				local var_65_56 = ""
				local var_65_57 = manager.audio:GetAudioName("bgm_activity_2_10_story_buzenbo", "bgm_activity_2_10_story_buzenbo")

				if var_65_57 ~= "" then
					if arg_62_1.bgmTxt_.text ~= var_65_57 and arg_62_1.bgmTxt_.text ~= "" then
						if arg_62_1.bgmTxt2_.text ~= "" then
							arg_62_1.bgmTxt_.text = arg_62_1.bgmTxt2_.text
						end

						arg_62_1.bgmTxt2_.text = var_65_57

						arg_62_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_62_1.bgmTxt_.text = var_65_57
						arg_62_1.bgmTxt2_.text = var_65_57
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

			if arg_62_1.frameCnt_ <= 1 then
				arg_62_1.dialog_:SetActive(false)
			end

			local var_65_58 = 4
			local var_65_59 = 0.275

			if var_65_58 < arg_62_1.time_ and arg_62_1.time_ <= var_65_58 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				arg_62_1.dialog_:SetActive(true)

				arg_62_1.dialogCg_.alpha = 0

				local var_65_60 = LeanTween.value(arg_62_1.dialog_, 0, 1, 0.3)

				var_65_60:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_62_1.dialogCg_.alpha = arg_68_0
				end))
				var_65_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_62_1.dialog_)
					var_65_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_62_1.duration_ = arg_62_1.duration_ + 0.3

				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_61 = arg_62_1:FormatText(StoryNameCfg[637].name)

				arg_62_1.leftNameTxt_.text = var_65_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_62 = arg_62_1:GetWordFromCfg(318041015)
				local var_65_63 = arg_62_1:FormatText(var_65_62.content)

				arg_62_1.text_.text = var_65_63

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_64 = 11
				local var_65_65 = utf8.len(var_65_63)
				local var_65_66 = var_65_64 <= 0 and var_65_59 or var_65_59 * (var_65_65 / var_65_64)

				if var_65_66 > 0 and var_65_59 < var_65_66 then
					arg_62_1.talkMaxDuration = var_65_66
					var_65_58 = var_65_58 + 0.3

					if var_65_66 + var_65_58 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_66 + var_65_58
					end
				end

				arg_62_1.text_.text = var_65_63
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041015", "story_v_out_318041.awb") ~= 0 then
					local var_65_67 = manager.audio:GetVoiceLength("story_v_out_318041", "318041015", "story_v_out_318041.awb") / 1000

					if var_65_67 + var_65_58 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_67 + var_65_58
					end

					if var_65_62.prefab_name ~= "" and arg_62_1.actors_[var_65_62.prefab_name] ~= nil then
						local var_65_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_62.prefab_name].transform, "story_v_out_318041", "318041015", "story_v_out_318041.awb")

						arg_62_1:RecordAudio("318041015", var_65_68)
						arg_62_1:RecordAudio("318041015", var_65_68)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_318041", "318041015", "story_v_out_318041.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_318041", "318041015", "story_v_out_318041.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_69 = var_65_58 + 0.3
			local var_65_70 = math.max(var_65_59, arg_62_1.talkMaxDuration)

			if var_65_69 <= arg_62_1.time_ and arg_62_1.time_ < var_65_69 + var_65_70 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_69) / var_65_70

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_69 + var_65_70 and arg_62_1.time_ < var_65_69 + var_65_70 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play318041016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 318041016
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play318041017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1050ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1050ui_story = var_73_0.localPosition

				local var_73_2 = "1050ui_story"

				arg_70_1:ShowWeapon(arg_70_1.var_[var_73_2 .. "Animator"].transform, true)
			end

			local var_73_3 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_3 then
				local var_73_4 = (arg_70_1.time_ - var_73_1) / var_73_3
				local var_73_5 = Vector3.New(0, -1, -6.1)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1050ui_story, var_73_5, var_73_4)

				local var_73_6 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_6.x, var_73_6.y, var_73_6.z)

				local var_73_7 = var_73_0.localEulerAngles

				var_73_7.z = 0
				var_73_7.x = 0
				var_73_0.localEulerAngles = var_73_7
			end

			if arg_70_1.time_ >= var_73_1 + var_73_3 and arg_70_1.time_ < var_73_1 + var_73_3 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_73_8 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_8.x, var_73_8.y, var_73_8.z)

				local var_73_9 = var_73_0.localEulerAngles

				var_73_9.z = 0
				var_73_9.x = 0
				var_73_0.localEulerAngles = var_73_9
			end

			local var_73_10 = arg_70_1.actors_["1050ui_story"]
			local var_73_11 = 0

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 and not isNil(var_73_10) and arg_70_1.var_.characterEffect1050ui_story == nil then
				arg_70_1.var_.characterEffect1050ui_story = var_73_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_12 = 0.200000002980232

			if var_73_11 <= arg_70_1.time_ and arg_70_1.time_ < var_73_11 + var_73_12 and not isNil(var_73_10) then
				local var_73_13 = (arg_70_1.time_ - var_73_11) / var_73_12

				if arg_70_1.var_.characterEffect1050ui_story and not isNil(var_73_10) then
					arg_70_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_11 + var_73_12 and arg_70_1.time_ < var_73_11 + var_73_12 + arg_73_0 and not isNil(var_73_10) and arg_70_1.var_.characterEffect1050ui_story then
				arg_70_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_73_14 = 0

			if var_73_14 < arg_70_1.time_ and arg_70_1.time_ <= var_73_14 + arg_73_0 then
				arg_70_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			local var_73_15 = 0

			if var_73_15 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_73_16 = 0
			local var_73_17 = 0.125

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_18 = arg_70_1:FormatText(StoryNameCfg[74].name)

				arg_70_1.leftNameTxt_.text = var_73_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_19 = arg_70_1:GetWordFromCfg(318041016)
				local var_73_20 = arg_70_1:FormatText(var_73_19.content)

				arg_70_1.text_.text = var_73_20

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_21 = 5
				local var_73_22 = utf8.len(var_73_20)
				local var_73_23 = var_73_21 <= 0 and var_73_17 or var_73_17 * (var_73_22 / var_73_21)

				if var_73_23 > 0 and var_73_17 < var_73_23 then
					arg_70_1.talkMaxDuration = var_73_23

					if var_73_23 + var_73_16 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_23 + var_73_16
					end
				end

				arg_70_1.text_.text = var_73_20
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041016", "story_v_out_318041.awb") ~= 0 then
					local var_73_24 = manager.audio:GetVoiceLength("story_v_out_318041", "318041016", "story_v_out_318041.awb") / 1000

					if var_73_24 + var_73_16 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_24 + var_73_16
					end

					if var_73_19.prefab_name ~= "" and arg_70_1.actors_[var_73_19.prefab_name] ~= nil then
						local var_73_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_19.prefab_name].transform, "story_v_out_318041", "318041016", "story_v_out_318041.awb")

						arg_70_1:RecordAudio("318041016", var_73_25)
						arg_70_1:RecordAudio("318041016", var_73_25)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_318041", "318041016", "story_v_out_318041.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_318041", "318041016", "story_v_out_318041.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_26 = math.max(var_73_17, arg_70_1.talkMaxDuration)

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_26 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_16) / var_73_26

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_16 + var_73_26 and arg_70_1.time_ < var_73_16 + var_73_26 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play318041017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 318041017
		arg_74_1.duration_ = 3.37

		local var_74_0 = {
			zh = 2.033,
			ja = 3.366
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play318041018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1050ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1050ui_story == nil then
				arg_74_1.var_.characterEffect1050ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1050ui_story and not isNil(var_77_0) then
					local var_77_4 = Mathf.Lerp(0, 0.5, var_77_3)

					arg_74_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1050ui_story.fillRatio = var_77_4
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1050ui_story then
				local var_77_5 = 0.5

				arg_74_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1050ui_story.fillRatio = var_77_5
			end

			local var_77_6 = 0
			local var_77_7 = 0.2

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_8 = arg_74_1:FormatText(StoryNameCfg[637].name)

				arg_74_1.leftNameTxt_.text = var_77_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_9 = arg_74_1:GetWordFromCfg(318041017)
				local var_77_10 = arg_74_1:FormatText(var_77_9.content)

				arg_74_1.text_.text = var_77_10

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_11 = 8
				local var_77_12 = utf8.len(var_77_10)
				local var_77_13 = var_77_11 <= 0 and var_77_7 or var_77_7 * (var_77_12 / var_77_11)

				if var_77_13 > 0 and var_77_7 < var_77_13 then
					arg_74_1.talkMaxDuration = var_77_13

					if var_77_13 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_6
					end
				end

				arg_74_1.text_.text = var_77_10
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041017", "story_v_out_318041.awb") ~= 0 then
					local var_77_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041017", "story_v_out_318041.awb") / 1000

					if var_77_14 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_14 + var_77_6
					end

					if var_77_9.prefab_name ~= "" and arg_74_1.actors_[var_77_9.prefab_name] ~= nil then
						local var_77_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_9.prefab_name].transform, "story_v_out_318041", "318041017", "story_v_out_318041.awb")

						arg_74_1:RecordAudio("318041017", var_77_15)
						arg_74_1:RecordAudio("318041017", var_77_15)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_318041", "318041017", "story_v_out_318041.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_318041", "318041017", "story_v_out_318041.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_7, arg_74_1.talkMaxDuration)

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_6) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_6 + var_77_16 and arg_74_1.time_ < var_77_6 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play318041018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 318041018
		arg_78_1.duration_ = 1.5

		local var_78_0 = {
			zh = 1.1,
			ja = 1.5
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play318041019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1050ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1050ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1050ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["1050ui_story"]
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect1050ui_story == nil then
				arg_78_1.var_.characterEffect1050ui_story = var_81_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_11 = 0.200000002980232

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 and not isNil(var_81_9) then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11

				if arg_78_1.var_.characterEffect1050ui_story and not isNil(var_81_9) then
					arg_78_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect1050ui_story then
				arg_78_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_81_13 = 0
			local var_81_14 = 0.433333333333333

			if var_81_13 < arg_78_1.time_ and arg_78_1.time_ <= var_81_13 + arg_81_0 then
				local var_81_15 = "play"
				local var_81_16 = "effect"

				arg_78_1:AudioAction(var_81_15, var_81_16, "se_story_side_1199", "se_story_1199_whooshfinsh", "")
			end

			local var_81_17 = manager.ui.mainCamera.transform
			local var_81_18 = 0

			if var_81_18 < arg_78_1.time_ and arg_78_1.time_ <= var_81_18 + arg_81_0 then
				arg_78_1.var_.shakeOldPos = var_81_17.localPosition
			end

			local var_81_19 = 0.5

			if var_81_18 <= arg_78_1.time_ and arg_78_1.time_ < var_81_18 + var_81_19 then
				local var_81_20 = (arg_78_1.time_ - var_81_18) / 0.066
				local var_81_21, var_81_22 = math.modf(var_81_20)

				var_81_17.localPosition = Vector3.New(var_81_22 * 0.13, var_81_22 * 0.13, var_81_22 * 0.13) + arg_78_1.var_.shakeOldPos
			end

			if arg_78_1.time_ >= var_81_18 + var_81_19 and arg_78_1.time_ < var_81_18 + var_81_19 + arg_81_0 then
				var_81_17.localPosition = arg_78_1.var_.shakeOldPos
			end

			local var_81_23 = 0

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			local var_81_24 = 0.5

			if arg_78_1.time_ >= var_81_23 + var_81_24 and arg_78_1.time_ < var_81_23 + var_81_24 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end

			local var_81_25 = 0

			if var_81_25 < arg_78_1.time_ and arg_78_1.time_ <= var_81_25 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = false

				arg_78_1:SetGaussion(false)
			end

			local var_81_26 = 0.5

			if var_81_25 <= arg_78_1.time_ and arg_78_1.time_ < var_81_25 + var_81_26 then
				local var_81_27 = (arg_78_1.time_ - var_81_25) / var_81_26
				local var_81_28 = Color.New(1, 1, 1)

				var_81_28.a = Mathf.Lerp(1, 0, var_81_27)
				arg_78_1.mask_.color = var_81_28
			end

			if arg_78_1.time_ >= var_81_25 + var_81_26 and arg_78_1.time_ < var_81_25 + var_81_26 + arg_81_0 then
				local var_81_29 = Color.New(1, 1, 1)
				local var_81_30 = 0

				arg_78_1.mask_.enabled = false
				var_81_29.a = var_81_30
				arg_78_1.mask_.color = var_81_29
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_31 = 0.5
			local var_81_32 = 0.05

			if var_81_31 < arg_78_1.time_ and arg_78_1.time_ <= var_81_31 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_33 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_33:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_34 = arg_78_1:FormatText(StoryNameCfg[74].name)

				arg_78_1.leftNameTxt_.text = var_81_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_35 = arg_78_1:GetWordFromCfg(318041018)
				local var_81_36 = arg_78_1:FormatText(var_81_35.content)

				arg_78_1.text_.text = var_81_36

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_37 = 2
				local var_81_38 = utf8.len(var_81_36)
				local var_81_39 = var_81_37 <= 0 and var_81_32 or var_81_32 * (var_81_38 / var_81_37)

				if var_81_39 > 0 and var_81_32 < var_81_39 then
					arg_78_1.talkMaxDuration = var_81_39
					var_81_31 = var_81_31 + 0.3

					if var_81_39 + var_81_31 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_39 + var_81_31
					end
				end

				arg_78_1.text_.text = var_81_36
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041018", "story_v_out_318041.awb") ~= 0 then
					local var_81_40 = manager.audio:GetVoiceLength("story_v_out_318041", "318041018", "story_v_out_318041.awb") / 1000

					if var_81_40 + var_81_31 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_40 + var_81_31
					end

					if var_81_35.prefab_name ~= "" and arg_78_1.actors_[var_81_35.prefab_name] ~= nil then
						local var_81_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_35.prefab_name].transform, "story_v_out_318041", "318041018", "story_v_out_318041.awb")

						arg_78_1:RecordAudio("318041018", var_81_41)
						arg_78_1:RecordAudio("318041018", var_81_41)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_318041", "318041018", "story_v_out_318041.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_318041", "318041018", "story_v_out_318041.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_42 = var_81_31 + 0.3
			local var_81_43 = math.max(var_81_32, arg_78_1.talkMaxDuration)

			if var_81_42 <= arg_78_1.time_ and arg_78_1.time_ < var_81_42 + var_81_43 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_42) / var_81_43

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_42 + var_81_43 and arg_78_1.time_ < var_81_42 + var_81_43 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play318041019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 318041019
		arg_84_1.duration_ = 3.23

		local var_84_0 = {
			zh = 2.166,
			ja = 3.233
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
				arg_84_0:Play318041020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1050ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1050ui_story == nil then
				arg_84_1.var_.characterEffect1050ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1050ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1050ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1050ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1050ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 0.225

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[637].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_9 = arg_84_1:GetWordFromCfg(318041019)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 9
				local var_87_12 = utf8.len(var_87_10)
				local var_87_13 = var_87_11 <= 0 and var_87_7 or var_87_7 * (var_87_12 / var_87_11)

				if var_87_13 > 0 and var_87_7 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041019", "story_v_out_318041.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041019", "story_v_out_318041.awb") / 1000

					if var_87_14 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_6
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_318041", "318041019", "story_v_out_318041.awb")

						arg_84_1:RecordAudio("318041019", var_87_15)
						arg_84_1:RecordAudio("318041019", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_318041", "318041019", "story_v_out_318041.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_318041", "318041019", "story_v_out_318041.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_16 and arg_84_1.time_ < var_87_6 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play318041020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 318041020
		arg_88_1.duration_ = 1.43

		local var_88_0 = {
			zh = 1.033,
			ja = 1.433
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play318041021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.433333333333333

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				local var_91_2 = "play"
				local var_91_3 = "effect"

				arg_88_1:AudioAction(var_91_2, var_91_3, "se_story_side_1199", "se_story_1199_whooshfinsh", "")
			end

			local var_91_4 = manager.ui.mainCamera.transform
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.var_.shakeOldPos = var_91_4.localPosition
			end

			local var_91_6 = 0.5

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / 0.066
				local var_91_8, var_91_9 = math.modf(var_91_7)

				var_91_4.localPosition = Vector3.New(var_91_9 * 0.13, var_91_9 * 0.13, var_91_9 * 0.13) + arg_88_1.var_.shakeOldPos
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 then
				var_91_4.localPosition = arg_88_1.var_.shakeOldPos
			end

			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			local var_91_11 = 0.5

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_12 = 0

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = false

				arg_88_1:SetGaussion(false)
			end

			local var_91_13 = 0.5

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_13 then
				local var_91_14 = (arg_88_1.time_ - var_91_12) / var_91_13
				local var_91_15 = Color.New(1, 1, 1)

				var_91_15.a = Mathf.Lerp(1, 0, var_91_14)
				arg_88_1.mask_.color = var_91_15
			end

			if arg_88_1.time_ >= var_91_12 + var_91_13 and arg_88_1.time_ < var_91_12 + var_91_13 + arg_91_0 then
				local var_91_16 = Color.New(1, 1, 1)
				local var_91_17 = 0

				arg_88_1.mask_.enabled = false
				var_91_16.a = var_91_17
				arg_88_1.mask_.color = var_91_16
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_18 = 0.5
			local var_91_19 = 0.05

			if var_91_18 < arg_88_1.time_ and arg_88_1.time_ <= var_91_18 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_20 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_20:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_21 = arg_88_1:FormatText(StoryNameCfg[74].name)

				arg_88_1.leftNameTxt_.text = var_91_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_22 = arg_88_1:GetWordFromCfg(318041020)
				local var_91_23 = arg_88_1:FormatText(var_91_22.content)

				arg_88_1.text_.text = var_91_23

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_24 = 2
				local var_91_25 = utf8.len(var_91_23)
				local var_91_26 = var_91_24 <= 0 and var_91_19 or var_91_19 * (var_91_25 / var_91_24)

				if var_91_26 > 0 and var_91_19 < var_91_26 then
					arg_88_1.talkMaxDuration = var_91_26
					var_91_18 = var_91_18 + 0.3

					if var_91_26 + var_91_18 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_26 + var_91_18
					end
				end

				arg_88_1.text_.text = var_91_23
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041020", "story_v_out_318041.awb") ~= 0 then
					local var_91_27 = manager.audio:GetVoiceLength("story_v_out_318041", "318041020", "story_v_out_318041.awb") / 1000

					if var_91_27 + var_91_18 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_27 + var_91_18
					end

					if var_91_22.prefab_name ~= "" and arg_88_1.actors_[var_91_22.prefab_name] ~= nil then
						local var_91_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_22.prefab_name].transform, "story_v_out_318041", "318041020", "story_v_out_318041.awb")

						arg_88_1:RecordAudio("318041020", var_91_28)
						arg_88_1:RecordAudio("318041020", var_91_28)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_318041", "318041020", "story_v_out_318041.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_318041", "318041020", "story_v_out_318041.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_29 = var_91_18 + 0.3
			local var_91_30 = math.max(var_91_19, arg_88_1.talkMaxDuration)

			if var_91_29 <= arg_88_1.time_ and arg_88_1.time_ < var_91_29 + var_91_30 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_29) / var_91_30

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_29 + var_91_30 and arg_88_1.time_ < var_91_29 + var_91_30 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play318041021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 318041021
		arg_94_1.duration_ = 3.93

		local var_94_0 = {
			zh = 2.166,
			ja = 3.933
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
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play318041022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1050ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1050ui_story == nil then
				arg_94_1.var_.characterEffect1050ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1050ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1050ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1050ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1050ui_story.fillRatio = var_97_5
			end

			local var_97_6 = 0
			local var_97_7 = 0.225

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[637].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_9 = arg_94_1:GetWordFromCfg(318041021)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 9
				local var_97_12 = utf8.len(var_97_10)
				local var_97_13 = var_97_11 <= 0 and var_97_7 or var_97_7 * (var_97_12 / var_97_11)

				if var_97_13 > 0 and var_97_7 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041021", "story_v_out_318041.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041021", "story_v_out_318041.awb") / 1000

					if var_97_14 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_6
					end

					if var_97_9.prefab_name ~= "" and arg_94_1.actors_[var_97_9.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_9.prefab_name].transform, "story_v_out_318041", "318041021", "story_v_out_318041.awb")

						arg_94_1:RecordAudio("318041021", var_97_15)
						arg_94_1:RecordAudio("318041021", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_318041", "318041021", "story_v_out_318041.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_318041", "318041021", "story_v_out_318041.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_16 and arg_94_1.time_ < var_97_6 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play318041022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 318041022
		arg_98_1.duration_ = 1.3

		local var_98_0 = {
			zh = 0.999999999999,
			ja = 1.3
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play318041023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1050ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos1050ui_story = var_101_0.localPosition
			end

			local var_101_2 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2
				local var_101_4 = Vector3.New(0, -1, -6.1)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1050ui_story, var_101_4, var_101_3)

				local var_101_5 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_5.x, var_101_5.y, var_101_5.z)

				local var_101_6 = var_101_0.localEulerAngles

				var_101_6.z = 0
				var_101_6.x = 0
				var_101_0.localEulerAngles = var_101_6
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_101_7 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_7.x, var_101_7.y, var_101_7.z)

				local var_101_8 = var_101_0.localEulerAngles

				var_101_8.z = 0
				var_101_8.x = 0
				var_101_0.localEulerAngles = var_101_8
			end

			local var_101_9 = arg_98_1.actors_["1050ui_story"]
			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect1050ui_story == nil then
				arg_98_1.var_.characterEffect1050ui_story = var_101_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_11 = 0.200000002980232

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_11 and not isNil(var_101_9) then
				local var_101_12 = (arg_98_1.time_ - var_101_10) / var_101_11

				if arg_98_1.var_.characterEffect1050ui_story and not isNil(var_101_9) then
					arg_98_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_10 + var_101_11 and arg_98_1.time_ < var_101_10 + var_101_11 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect1050ui_story then
				arg_98_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_101_13 = 0
			local var_101_14 = 0.433333333333333

			if var_101_13 < arg_98_1.time_ and arg_98_1.time_ <= var_101_13 + arg_101_0 then
				local var_101_15 = "play"
				local var_101_16 = "effect"

				arg_98_1:AudioAction(var_101_15, var_101_16, "se_story_side_1199", "se_story_1199_whooshfinsh", "")
			end

			local var_101_17 = 0
			local var_101_18 = 0.05

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_19 = arg_98_1:FormatText(StoryNameCfg[74].name)

				arg_98_1.leftNameTxt_.text = var_101_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_20 = arg_98_1:GetWordFromCfg(318041022)
				local var_101_21 = arg_98_1:FormatText(var_101_20.content)

				arg_98_1.text_.text = var_101_21

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_22 = 2
				local var_101_23 = utf8.len(var_101_21)
				local var_101_24 = var_101_22 <= 0 and var_101_18 or var_101_18 * (var_101_23 / var_101_22)

				if var_101_24 > 0 and var_101_18 < var_101_24 then
					arg_98_1.talkMaxDuration = var_101_24

					if var_101_24 + var_101_17 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_24 + var_101_17
					end
				end

				arg_98_1.text_.text = var_101_21
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041022", "story_v_out_318041.awb") ~= 0 then
					local var_101_25 = manager.audio:GetVoiceLength("story_v_out_318041", "318041022", "story_v_out_318041.awb") / 1000

					if var_101_25 + var_101_17 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_25 + var_101_17
					end

					if var_101_20.prefab_name ~= "" and arg_98_1.actors_[var_101_20.prefab_name] ~= nil then
						local var_101_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_20.prefab_name].transform, "story_v_out_318041", "318041022", "story_v_out_318041.awb")

						arg_98_1:RecordAudio("318041022", var_101_26)
						arg_98_1:RecordAudio("318041022", var_101_26)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_318041", "318041022", "story_v_out_318041.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_318041", "318041022", "story_v_out_318041.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_27 = math.max(var_101_18, arg_98_1.talkMaxDuration)

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_27 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_17) / var_101_27

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_17 + var_101_27 and arg_98_1.time_ < var_101_17 + var_101_27 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play318041023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 318041023
		arg_102_1.duration_ = 6.47

		local var_102_0 = {
			zh = 3.6,
			ja = 6.466
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play318041024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1050ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1050ui_story == nil then
				arg_102_1.var_.characterEffect1050ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1050ui_story and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1050ui_story.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1050ui_story then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1050ui_story.fillRatio = var_105_5
			end

			local var_105_6 = 0
			local var_105_7 = 0.4

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[637].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_9 = arg_102_1:GetWordFromCfg(318041023)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 17
				local var_105_12 = utf8.len(var_105_10)
				local var_105_13 = var_105_11 <= 0 and var_105_7 or var_105_7 * (var_105_12 / var_105_11)

				if var_105_13 > 0 and var_105_7 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041023", "story_v_out_318041.awb") ~= 0 then
					local var_105_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041023", "story_v_out_318041.awb") / 1000

					if var_105_14 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_6
					end

					if var_105_9.prefab_name ~= "" and arg_102_1.actors_[var_105_9.prefab_name] ~= nil then
						local var_105_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_9.prefab_name].transform, "story_v_out_318041", "318041023", "story_v_out_318041.awb")

						arg_102_1:RecordAudio("318041023", var_105_15)
						arg_102_1:RecordAudio("318041023", var_105_15)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_318041", "318041023", "story_v_out_318041.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_318041", "318041023", "story_v_out_318041.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_16 and arg_102_1.time_ < var_105_6 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play318041024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 318041024
		arg_106_1.duration_ = 3.73

		local var_106_0 = {
			zh = 3.733,
			ja = 1.833
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play318041025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1050ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1050ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(0, 100, 0)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1050ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0, 100, 0)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["1050ui_story"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1050ui_story == nil then
				arg_106_1.var_.characterEffect1050ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.200000002980232

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect1050ui_story and not isNil(var_109_9) then
					arg_106_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1050ui_story then
				arg_106_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_109_13 = 0
			local var_109_14 = 0.433333333333333

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				local var_109_15 = "play"
				local var_109_16 = "effect"

				arg_106_1:AudioAction(var_109_15, var_109_16, "se_story_side_1199", "se_story_1199_whooshfinsh", "")
			end

			local var_109_17 = manager.ui.mainCamera.transform
			local var_109_18 = 0

			if var_109_18 < arg_106_1.time_ and arg_106_1.time_ <= var_109_18 + arg_109_0 then
				arg_106_1.var_.shakeOldPos = var_109_17.localPosition
			end

			local var_109_19 = 0.5

			if var_109_18 <= arg_106_1.time_ and arg_106_1.time_ < var_109_18 + var_109_19 then
				local var_109_20 = (arg_106_1.time_ - var_109_18) / 0.066
				local var_109_21, var_109_22 = math.modf(var_109_20)

				var_109_17.localPosition = Vector3.New(var_109_22 * 0.13, var_109_22 * 0.13, var_109_22 * 0.13) + arg_106_1.var_.shakeOldPos
			end

			if arg_106_1.time_ >= var_109_18 + var_109_19 and arg_106_1.time_ < var_109_18 + var_109_19 + arg_109_0 then
				var_109_17.localPosition = arg_106_1.var_.shakeOldPos
			end

			local var_109_23 = 0

			if var_109_23 < arg_106_1.time_ and arg_106_1.time_ <= var_109_23 + arg_109_0 then
				arg_106_1.allBtn_.enabled = false
			end

			local var_109_24 = 0.5

			if arg_106_1.time_ >= var_109_23 + var_109_24 and arg_106_1.time_ < var_109_23 + var_109_24 + arg_109_0 then
				arg_106_1.allBtn_.enabled = true
			end

			local var_109_25 = 0
			local var_109_26 = 0.1

			if var_109_25 < arg_106_1.time_ and arg_106_1.time_ <= var_109_25 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_27 = arg_106_1:FormatText(StoryNameCfg[74].name)

				arg_106_1.leftNameTxt_.text = var_109_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_28 = arg_106_1:GetWordFromCfg(318041024)
				local var_109_29 = arg_106_1:FormatText(var_109_28.content)

				arg_106_1.text_.text = var_109_29

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_30 = 4
				local var_109_31 = utf8.len(var_109_29)
				local var_109_32 = var_109_30 <= 0 and var_109_26 or var_109_26 * (var_109_31 / var_109_30)

				if var_109_32 > 0 and var_109_26 < var_109_32 then
					arg_106_1.talkMaxDuration = var_109_32

					if var_109_32 + var_109_25 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_32 + var_109_25
					end
				end

				arg_106_1.text_.text = var_109_29
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041024", "story_v_out_318041.awb") ~= 0 then
					local var_109_33 = manager.audio:GetVoiceLength("story_v_out_318041", "318041024", "story_v_out_318041.awb") / 1000

					if var_109_33 + var_109_25 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_33 + var_109_25
					end

					if var_109_28.prefab_name ~= "" and arg_106_1.actors_[var_109_28.prefab_name] ~= nil then
						local var_109_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_28.prefab_name].transform, "story_v_out_318041", "318041024", "story_v_out_318041.awb")

						arg_106_1:RecordAudio("318041024", var_109_34)
						arg_106_1:RecordAudio("318041024", var_109_34)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_318041", "318041024", "story_v_out_318041.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_318041", "318041024", "story_v_out_318041.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_35 = math.max(var_109_26, arg_106_1.talkMaxDuration)

			if var_109_25 <= arg_106_1.time_ and arg_106_1.time_ < var_109_25 + var_109_35 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_25) / var_109_35

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_25 + var_109_35 and arg_106_1.time_ < var_109_25 + var_109_35 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play318041025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 318041025
		arg_110_1.duration_ = 7.4

		local var_110_0 = {
			zh = 5.4,
			ja = 7.4
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play318041026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1050ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1050ui_story == nil then
				arg_110_1.var_.characterEffect1050ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1050ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1050ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1050ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1050ui_story.fillRatio = var_113_5
			end

			local var_113_6 = 0
			local var_113_7 = 0.425

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_8 = arg_110_1:FormatText(StoryNameCfg[637].name)

				arg_110_1.leftNameTxt_.text = var_113_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_9 = arg_110_1:GetWordFromCfg(318041025)
				local var_113_10 = arg_110_1:FormatText(var_113_9.content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 17
				local var_113_12 = utf8.len(var_113_10)
				local var_113_13 = var_113_11 <= 0 and var_113_7 or var_113_7 * (var_113_12 / var_113_11)

				if var_113_13 > 0 and var_113_7 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_10
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041025", "story_v_out_318041.awb") ~= 0 then
					local var_113_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041025", "story_v_out_318041.awb") / 1000

					if var_113_14 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_14 + var_113_6
					end

					if var_113_9.prefab_name ~= "" and arg_110_1.actors_[var_113_9.prefab_name] ~= nil then
						local var_113_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_9.prefab_name].transform, "story_v_out_318041", "318041025", "story_v_out_318041.awb")

						arg_110_1:RecordAudio("318041025", var_113_15)
						arg_110_1:RecordAudio("318041025", var_113_15)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_318041", "318041025", "story_v_out_318041.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_318041", "318041025", "story_v_out_318041.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_16 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_16 and arg_110_1.time_ < var_113_6 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play318041026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 318041026
		arg_114_1.duration_ = 2

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play318041027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1050ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1050ui_story = var_117_0.localPosition

				local var_117_2 = "1050ui_story"

				arg_114_1:ShowWeapon(arg_114_1.var_[var_117_2 .. "Animator"].transform, false)
			end

			local var_117_3 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_3 then
				local var_117_4 = (arg_114_1.time_ - var_117_1) / var_117_3
				local var_117_5 = Vector3.New(0, -1, -6.1)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1050ui_story, var_117_5, var_117_4)

				local var_117_6 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_6.x, var_117_6.y, var_117_6.z)

				local var_117_7 = var_117_0.localEulerAngles

				var_117_7.z = 0
				var_117_7.x = 0
				var_117_0.localEulerAngles = var_117_7
			end

			if arg_114_1.time_ >= var_117_1 + var_117_3 and arg_114_1.time_ < var_117_1 + var_117_3 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_117_8 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_8.x, var_117_8.y, var_117_8.z)

				local var_117_9 = var_117_0.localEulerAngles

				var_117_9.z = 0
				var_117_9.x = 0
				var_117_0.localEulerAngles = var_117_9
			end

			local var_117_10 = arg_114_1.actors_["1050ui_story"]
			local var_117_11 = 0

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 and not isNil(var_117_10) and arg_114_1.var_.characterEffect1050ui_story == nil then
				arg_114_1.var_.characterEffect1050ui_story = var_117_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_12 = 0.200000002980232

			if var_117_11 <= arg_114_1.time_ and arg_114_1.time_ < var_117_11 + var_117_12 and not isNil(var_117_10) then
				local var_117_13 = (arg_114_1.time_ - var_117_11) / var_117_12

				if arg_114_1.var_.characterEffect1050ui_story and not isNil(var_117_10) then
					arg_114_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_11 + var_117_12 and arg_114_1.time_ < var_117_11 + var_117_12 + arg_117_0 and not isNil(var_117_10) and arg_114_1.var_.characterEffect1050ui_story then
				arg_114_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_117_14 = 0

			if var_117_14 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				arg_114_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_117_15 = 0

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 then
				arg_114_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_117_16 = 0
			local var_117_17 = 0.1

			if var_117_16 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_18 = arg_114_1:FormatText(StoryNameCfg[74].name)

				arg_114_1.leftNameTxt_.text = var_117_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_19 = arg_114_1:GetWordFromCfg(318041026)
				local var_117_20 = arg_114_1:FormatText(var_117_19.content)

				arg_114_1.text_.text = var_117_20

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_21 = 4
				local var_117_22 = utf8.len(var_117_20)
				local var_117_23 = var_117_21 <= 0 and var_117_17 or var_117_17 * (var_117_22 / var_117_21)

				if var_117_23 > 0 and var_117_17 < var_117_23 then
					arg_114_1.talkMaxDuration = var_117_23

					if var_117_23 + var_117_16 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_23 + var_117_16
					end
				end

				arg_114_1.text_.text = var_117_20
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041026", "story_v_out_318041.awb") ~= 0 then
					local var_117_24 = manager.audio:GetVoiceLength("story_v_out_318041", "318041026", "story_v_out_318041.awb") / 1000

					if var_117_24 + var_117_16 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_24 + var_117_16
					end

					if var_117_19.prefab_name ~= "" and arg_114_1.actors_[var_117_19.prefab_name] ~= nil then
						local var_117_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_19.prefab_name].transform, "story_v_out_318041", "318041026", "story_v_out_318041.awb")

						arg_114_1:RecordAudio("318041026", var_117_25)
						arg_114_1:RecordAudio("318041026", var_117_25)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_318041", "318041026", "story_v_out_318041.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_318041", "318041026", "story_v_out_318041.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_26 = math.max(var_117_17, arg_114_1.talkMaxDuration)

			if var_117_16 <= arg_114_1.time_ and arg_114_1.time_ < var_117_16 + var_117_26 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_16) / var_117_26

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_16 + var_117_26 and arg_114_1.time_ < var_117_16 + var_117_26 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play318041027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 318041027
		arg_118_1.duration_ = 12.9

		local var_118_0 = {
			zh = 5.5,
			ja = 12.9
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play318041028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1050ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1050ui_story == nil then
				arg_118_1.var_.characterEffect1050ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1050ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1050ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1050ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1050ui_story.fillRatio = var_121_5
			end

			local var_121_6 = 0
			local var_121_7 = 0.525

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_8 = arg_118_1:FormatText(StoryNameCfg[637].name)

				arg_118_1.leftNameTxt_.text = var_121_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_9 = arg_118_1:GetWordFromCfg(318041027)
				local var_121_10 = arg_118_1:FormatText(var_121_9.content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 21
				local var_121_12 = utf8.len(var_121_10)
				local var_121_13 = var_121_11 <= 0 and var_121_7 or var_121_7 * (var_121_12 / var_121_11)

				if var_121_13 > 0 and var_121_7 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_10
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041027", "story_v_out_318041.awb") ~= 0 then
					local var_121_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041027", "story_v_out_318041.awb") / 1000

					if var_121_14 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_14 + var_121_6
					end

					if var_121_9.prefab_name ~= "" and arg_118_1.actors_[var_121_9.prefab_name] ~= nil then
						local var_121_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_9.prefab_name].transform, "story_v_out_318041", "318041027", "story_v_out_318041.awb")

						arg_118_1:RecordAudio("318041027", var_121_15)
						arg_118_1:RecordAudio("318041027", var_121_15)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_318041", "318041027", "story_v_out_318041.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_318041", "318041027", "story_v_out_318041.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_16 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_16 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_16

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_16 and arg_118_1.time_ < var_121_6 + var_121_16 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play318041028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 318041028
		arg_122_1.duration_ = 4.6

		local var_122_0 = {
			zh = 4.6,
			ja = 3.5
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play318041029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1050ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos1050ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(0, -1, -6.1)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1050ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = arg_122_1.actors_["1050ui_story"]
			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect1050ui_story == nil then
				arg_122_1.var_.characterEffect1050ui_story = var_125_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_11 = 0.200000002980232

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_11 and not isNil(var_125_9) then
				local var_125_12 = (arg_122_1.time_ - var_125_10) / var_125_11

				if arg_122_1.var_.characterEffect1050ui_story and not isNil(var_125_9) then
					arg_122_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_10 + var_125_11 and arg_122_1.time_ < var_125_10 + var_125_11 + arg_125_0 and not isNil(var_125_9) and arg_122_1.var_.characterEffect1050ui_story then
				arg_122_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_125_13 = 0

			if var_125_13 < arg_122_1.time_ and arg_122_1.time_ <= var_125_13 + arg_125_0 then
				arg_122_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_125_14 = 0

			if var_125_14 < arg_122_1.time_ and arg_122_1.time_ <= var_125_14 + arg_125_0 then
				arg_122_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_2")
			end

			local var_125_15 = 0
			local var_125_16 = 0.325

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_17 = arg_122_1:FormatText(StoryNameCfg[74].name)

				arg_122_1.leftNameTxt_.text = var_125_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_18 = arg_122_1:GetWordFromCfg(318041028)
				local var_125_19 = arg_122_1:FormatText(var_125_18.content)

				arg_122_1.text_.text = var_125_19

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_20 = 13
				local var_125_21 = utf8.len(var_125_19)
				local var_125_22 = var_125_20 <= 0 and var_125_16 or var_125_16 * (var_125_21 / var_125_20)

				if var_125_22 > 0 and var_125_16 < var_125_22 then
					arg_122_1.talkMaxDuration = var_125_22

					if var_125_22 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_22 + var_125_15
					end
				end

				arg_122_1.text_.text = var_125_19
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041028", "story_v_out_318041.awb") ~= 0 then
					local var_125_23 = manager.audio:GetVoiceLength("story_v_out_318041", "318041028", "story_v_out_318041.awb") / 1000

					if var_125_23 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_23 + var_125_15
					end

					if var_125_18.prefab_name ~= "" and arg_122_1.actors_[var_125_18.prefab_name] ~= nil then
						local var_125_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_18.prefab_name].transform, "story_v_out_318041", "318041028", "story_v_out_318041.awb")

						arg_122_1:RecordAudio("318041028", var_125_24)
						arg_122_1:RecordAudio("318041028", var_125_24)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_318041", "318041028", "story_v_out_318041.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_318041", "318041028", "story_v_out_318041.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_25 = math.max(var_125_16, arg_122_1.talkMaxDuration)

			if var_125_15 <= arg_122_1.time_ and arg_122_1.time_ < var_125_15 + var_125_25 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_15) / var_125_25

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_15 + var_125_25 and arg_122_1.time_ < var_125_15 + var_125_25 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play318041029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 318041029
		arg_126_1.duration_ = 2.47

		local var_126_0 = {
			zh = 1.3,
			ja = 2.466
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play318041030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1050ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1050ui_story == nil then
				arg_126_1.var_.characterEffect1050ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1050ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1050ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1050ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1050ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.125

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[637].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_9 = arg_126_1:GetWordFromCfg(318041029)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 5
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041029", "story_v_out_318041.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041029", "story_v_out_318041.awb") / 1000

					if var_129_14 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_6
					end

					if var_129_9.prefab_name ~= "" and arg_126_1.actors_[var_129_9.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_9.prefab_name].transform, "story_v_out_318041", "318041029", "story_v_out_318041.awb")

						arg_126_1:RecordAudio("318041029", var_129_15)
						arg_126_1:RecordAudio("318041029", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_318041", "318041029", "story_v_out_318041.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_318041", "318041029", "story_v_out_318041.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_16 and arg_126_1.time_ < var_129_6 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play318041030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 318041030
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play318041031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1050ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos1050ui_story = var_133_0.localPosition
			end

			local var_133_2 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2
				local var_133_4 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1050ui_story, var_133_4, var_133_3)

				local var_133_5 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_5.x, var_133_5.y, var_133_5.z)

				local var_133_6 = var_133_0.localEulerAngles

				var_133_6.z = 0
				var_133_6.x = 0
				var_133_0.localEulerAngles = var_133_6
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, 100, 0)

				local var_133_7 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_7.x, var_133_7.y, var_133_7.z)

				local var_133_8 = var_133_0.localEulerAngles

				var_133_8.z = 0
				var_133_8.x = 0
				var_133_0.localEulerAngles = var_133_8
			end

			local var_133_9 = arg_130_1.actors_["1050ui_story"]
			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 and not isNil(var_133_9) and arg_130_1.var_.characterEffect1050ui_story == nil then
				arg_130_1.var_.characterEffect1050ui_story = var_133_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_11 = 0.200000002980232

			if var_133_10 <= arg_130_1.time_ and arg_130_1.time_ < var_133_10 + var_133_11 and not isNil(var_133_9) then
				local var_133_12 = (arg_130_1.time_ - var_133_10) / var_133_11

				if arg_130_1.var_.characterEffect1050ui_story and not isNil(var_133_9) then
					local var_133_13 = Mathf.Lerp(0, 0.5, var_133_12)

					arg_130_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1050ui_story.fillRatio = var_133_13
				end
			end

			if arg_130_1.time_ >= var_133_10 + var_133_11 and arg_130_1.time_ < var_133_10 + var_133_11 + arg_133_0 and not isNil(var_133_9) and arg_130_1.var_.characterEffect1050ui_story then
				local var_133_14 = 0.5

				arg_130_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1050ui_story.fillRatio = var_133_14
			end

			local var_133_15 = 0
			local var_133_16 = 1.375

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_17 = arg_130_1:GetWordFromCfg(318041030)
				local var_133_18 = arg_130_1:FormatText(var_133_17.content)

				arg_130_1.text_.text = var_133_18

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_19 = 55
				local var_133_20 = utf8.len(var_133_18)
				local var_133_21 = var_133_19 <= 0 and var_133_16 or var_133_16 * (var_133_20 / var_133_19)

				if var_133_21 > 0 and var_133_16 < var_133_21 then
					arg_130_1.talkMaxDuration = var_133_21

					if var_133_21 + var_133_15 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_21 + var_133_15
					end
				end

				arg_130_1.text_.text = var_133_18
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_22 = math.max(var_133_16, arg_130_1.talkMaxDuration)

			if var_133_15 <= arg_130_1.time_ and arg_130_1.time_ < var_133_15 + var_133_22 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_15) / var_133_22

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_15 + var_133_22 and arg_130_1.time_ < var_133_15 + var_133_22 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play318041031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 318041031
		arg_134_1.duration_ = 3.2

		local var_134_0 = {
			zh = 1.999999999999,
			ja = 3.2
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play318041032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1050ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos1050ui_story = var_137_0.localPosition
			end

			local var_137_2 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2
				local var_137_4 = Vector3.New(0, -1, -6.1)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1050ui_story, var_137_4, var_137_3)

				local var_137_5 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_5.x, var_137_5.y, var_137_5.z)

				local var_137_6 = var_137_0.localEulerAngles

				var_137_6.z = 0
				var_137_6.x = 0
				var_137_0.localEulerAngles = var_137_6
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_137_7 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_7.x, var_137_7.y, var_137_7.z)

				local var_137_8 = var_137_0.localEulerAngles

				var_137_8.z = 0
				var_137_8.x = 0
				var_137_0.localEulerAngles = var_137_8
			end

			local var_137_9 = arg_134_1.actors_["1050ui_story"]
			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 and not isNil(var_137_9) and arg_134_1.var_.characterEffect1050ui_story == nil then
				arg_134_1.var_.characterEffect1050ui_story = var_137_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_11 = 0.200000002980232

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_11 and not isNil(var_137_9) then
				local var_137_12 = (arg_134_1.time_ - var_137_10) / var_137_11

				if arg_134_1.var_.characterEffect1050ui_story and not isNil(var_137_9) then
					arg_134_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_10 + var_137_11 and arg_134_1.time_ < var_137_10 + var_137_11 + arg_137_0 and not isNil(var_137_9) and arg_134_1.var_.characterEffect1050ui_story then
				arg_134_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_137_13 = 0

			if var_137_13 < arg_134_1.time_ and arg_134_1.time_ <= var_137_13 + arg_137_0 then
				arg_134_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_137_14 = 0

			if var_137_14 < arg_134_1.time_ and arg_134_1.time_ <= var_137_14 + arg_137_0 then
				arg_134_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_137_15 = 0
			local var_137_16 = 0.225

			if var_137_15 < arg_134_1.time_ and arg_134_1.time_ <= var_137_15 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_17 = arg_134_1:FormatText(StoryNameCfg[74].name)

				arg_134_1.leftNameTxt_.text = var_137_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_18 = arg_134_1:GetWordFromCfg(318041031)
				local var_137_19 = arg_134_1:FormatText(var_137_18.content)

				arg_134_1.text_.text = var_137_19

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_20 = 9
				local var_137_21 = utf8.len(var_137_19)
				local var_137_22 = var_137_20 <= 0 and var_137_16 or var_137_16 * (var_137_21 / var_137_20)

				if var_137_22 > 0 and var_137_16 < var_137_22 then
					arg_134_1.talkMaxDuration = var_137_22

					if var_137_22 + var_137_15 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_22 + var_137_15
					end
				end

				arg_134_1.text_.text = var_137_19
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041031", "story_v_out_318041.awb") ~= 0 then
					local var_137_23 = manager.audio:GetVoiceLength("story_v_out_318041", "318041031", "story_v_out_318041.awb") / 1000

					if var_137_23 + var_137_15 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_23 + var_137_15
					end

					if var_137_18.prefab_name ~= "" and arg_134_1.actors_[var_137_18.prefab_name] ~= nil then
						local var_137_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_18.prefab_name].transform, "story_v_out_318041", "318041031", "story_v_out_318041.awb")

						arg_134_1:RecordAudio("318041031", var_137_24)
						arg_134_1:RecordAudio("318041031", var_137_24)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_318041", "318041031", "story_v_out_318041.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_318041", "318041031", "story_v_out_318041.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_25 = math.max(var_137_16, arg_134_1.talkMaxDuration)

			if var_137_15 <= arg_134_1.time_ and arg_134_1.time_ < var_137_15 + var_137_25 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_15) / var_137_25

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_15 + var_137_25 and arg_134_1.time_ < var_137_15 + var_137_25 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play318041032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 318041032
		arg_138_1.duration_ = 5.07

		local var_138_0 = {
			zh = 2.666,
			ja = 5.066
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play318041033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1050ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1050ui_story == nil then
				arg_138_1.var_.characterEffect1050ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1050ui_story and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1050ui_story.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1050ui_story then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1050ui_story.fillRatio = var_141_5
			end

			local var_141_6 = 0
			local var_141_7 = 0.275

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_8 = arg_138_1:FormatText(StoryNameCfg[637].name)

				arg_138_1.leftNameTxt_.text = var_141_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_9 = arg_138_1:GetWordFromCfg(318041032)
				local var_141_10 = arg_138_1:FormatText(var_141_9.content)

				arg_138_1.text_.text = var_141_10

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 11
				local var_141_12 = utf8.len(var_141_10)
				local var_141_13 = var_141_11 <= 0 and var_141_7 or var_141_7 * (var_141_12 / var_141_11)

				if var_141_13 > 0 and var_141_7 < var_141_13 then
					arg_138_1.talkMaxDuration = var_141_13

					if var_141_13 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_10
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041032", "story_v_out_318041.awb") ~= 0 then
					local var_141_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041032", "story_v_out_318041.awb") / 1000

					if var_141_14 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_14 + var_141_6
					end

					if var_141_9.prefab_name ~= "" and arg_138_1.actors_[var_141_9.prefab_name] ~= nil then
						local var_141_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_9.prefab_name].transform, "story_v_out_318041", "318041032", "story_v_out_318041.awb")

						arg_138_1:RecordAudio("318041032", var_141_15)
						arg_138_1:RecordAudio("318041032", var_141_15)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_318041", "318041032", "story_v_out_318041.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_318041", "318041032", "story_v_out_318041.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_16 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_16 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_16

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_16 and arg_138_1.time_ < var_141_6 + var_141_16 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play318041033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 318041033
		arg_142_1.duration_ = 10.23

		local var_142_0 = {
			zh = 10.233,
			ja = 7.966
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play318041034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 1.05

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[637].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(318041033)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 42
				local var_145_6 = utf8.len(var_145_4)
				local var_145_7 = var_145_5 <= 0 and var_145_1 or var_145_1 * (var_145_6 / var_145_5)

				if var_145_7 > 0 and var_145_1 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041033", "story_v_out_318041.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041033", "story_v_out_318041.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_318041", "318041033", "story_v_out_318041.awb")

						arg_142_1:RecordAudio("318041033", var_145_9)
						arg_142_1:RecordAudio("318041033", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_318041", "318041033", "story_v_out_318041.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_318041", "318041033", "story_v_out_318041.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play318041034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 318041034
		arg_146_1.duration_ = 6.67

		local var_146_0 = {
			zh = 6.666,
			ja = 4.433
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play318041035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 0.7

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_2 = arg_146_1:FormatText(StoryNameCfg[637].name)

				arg_146_1.leftNameTxt_.text = var_149_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:GetWordFromCfg(318041034)
				local var_149_4 = arg_146_1:FormatText(var_149_3.content)

				arg_146_1.text_.text = var_149_4

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 28
				local var_149_6 = utf8.len(var_149_4)
				local var_149_7 = var_149_5 <= 0 and var_149_1 or var_149_1 * (var_149_6 / var_149_5)

				if var_149_7 > 0 and var_149_1 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_4
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041034", "story_v_out_318041.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041034", "story_v_out_318041.awb") / 1000

					if var_149_8 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_0
					end

					if var_149_3.prefab_name ~= "" and arg_146_1.actors_[var_149_3.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_3.prefab_name].transform, "story_v_out_318041", "318041034", "story_v_out_318041.awb")

						arg_146_1:RecordAudio("318041034", var_149_9)
						arg_146_1:RecordAudio("318041034", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_318041", "318041034", "story_v_out_318041.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_318041", "318041034", "story_v_out_318041.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_10 and arg_146_1.time_ < var_149_0 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play318041035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 318041035
		arg_150_1.duration_ = 4.93

		local var_150_0 = {
			zh = 2.766,
			ja = 4.933
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play318041036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1050ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos1050ui_story = var_153_0.localPosition
			end

			local var_153_2 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2
				local var_153_4 = Vector3.New(0, -1, -6.1)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1050ui_story, var_153_4, var_153_3)

				local var_153_5 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_5.x, var_153_5.y, var_153_5.z)

				local var_153_6 = var_153_0.localEulerAngles

				var_153_6.z = 0
				var_153_6.x = 0
				var_153_0.localEulerAngles = var_153_6
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_153_7 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_7.x, var_153_7.y, var_153_7.z)

				local var_153_8 = var_153_0.localEulerAngles

				var_153_8.z = 0
				var_153_8.x = 0
				var_153_0.localEulerAngles = var_153_8
			end

			local var_153_9 = arg_150_1.actors_["1050ui_story"]
			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 and not isNil(var_153_9) and arg_150_1.var_.characterEffect1050ui_story == nil then
				arg_150_1.var_.characterEffect1050ui_story = var_153_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_11 = 0.200000002980232

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_11 and not isNil(var_153_9) then
				local var_153_12 = (arg_150_1.time_ - var_153_10) / var_153_11

				if arg_150_1.var_.characterEffect1050ui_story and not isNil(var_153_9) then
					arg_150_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_10 + var_153_11 and arg_150_1.time_ < var_153_10 + var_153_11 + arg_153_0 and not isNil(var_153_9) and arg_150_1.var_.characterEffect1050ui_story then
				arg_150_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_153_13 = 0

			if var_153_13 < arg_150_1.time_ and arg_150_1.time_ <= var_153_13 + arg_153_0 then
				arg_150_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_153_14 = 0

			if var_153_14 < arg_150_1.time_ and arg_150_1.time_ <= var_153_14 + arg_153_0 then
				arg_150_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_153_15 = 0
			local var_153_16 = 0.35

			if var_153_15 < arg_150_1.time_ and arg_150_1.time_ <= var_153_15 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_17 = arg_150_1:FormatText(StoryNameCfg[74].name)

				arg_150_1.leftNameTxt_.text = var_153_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_18 = arg_150_1:GetWordFromCfg(318041035)
				local var_153_19 = arg_150_1:FormatText(var_153_18.content)

				arg_150_1.text_.text = var_153_19

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_20 = 14
				local var_153_21 = utf8.len(var_153_19)
				local var_153_22 = var_153_20 <= 0 and var_153_16 or var_153_16 * (var_153_21 / var_153_20)

				if var_153_22 > 0 and var_153_16 < var_153_22 then
					arg_150_1.talkMaxDuration = var_153_22

					if var_153_22 + var_153_15 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_22 + var_153_15
					end
				end

				arg_150_1.text_.text = var_153_19
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041035", "story_v_out_318041.awb") ~= 0 then
					local var_153_23 = manager.audio:GetVoiceLength("story_v_out_318041", "318041035", "story_v_out_318041.awb") / 1000

					if var_153_23 + var_153_15 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_23 + var_153_15
					end

					if var_153_18.prefab_name ~= "" and arg_150_1.actors_[var_153_18.prefab_name] ~= nil then
						local var_153_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_18.prefab_name].transform, "story_v_out_318041", "318041035", "story_v_out_318041.awb")

						arg_150_1:RecordAudio("318041035", var_153_24)
						arg_150_1:RecordAudio("318041035", var_153_24)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_318041", "318041035", "story_v_out_318041.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_318041", "318041035", "story_v_out_318041.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_25 = math.max(var_153_16, arg_150_1.talkMaxDuration)

			if var_153_15 <= arg_150_1.time_ and arg_150_1.time_ < var_153_15 + var_153_25 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_15) / var_153_25

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_15 + var_153_25 and arg_150_1.time_ < var_153_15 + var_153_25 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play318041036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 318041036
		arg_154_1.duration_ = 3.63

		local var_154_0 = {
			zh = 3.633,
			ja = 3.1
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play318041037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1050ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1050ui_story == nil then
				arg_154_1.var_.characterEffect1050ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1050ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1050ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1050ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1050ui_story.fillRatio = var_157_5
			end

			local var_157_6 = 0
			local var_157_7 = 0.25

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_8 = arg_154_1:FormatText(StoryNameCfg[637].name)

				arg_154_1.leftNameTxt_.text = var_157_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_9 = arg_154_1:GetWordFromCfg(318041036)
				local var_157_10 = arg_154_1:FormatText(var_157_9.content)

				arg_154_1.text_.text = var_157_10

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 10
				local var_157_12 = utf8.len(var_157_10)
				local var_157_13 = var_157_11 <= 0 and var_157_7 or var_157_7 * (var_157_12 / var_157_11)

				if var_157_13 > 0 and var_157_7 < var_157_13 then
					arg_154_1.talkMaxDuration = var_157_13

					if var_157_13 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_13 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_10
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041036", "story_v_out_318041.awb") ~= 0 then
					local var_157_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041036", "story_v_out_318041.awb") / 1000

					if var_157_14 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_14 + var_157_6
					end

					if var_157_9.prefab_name ~= "" and arg_154_1.actors_[var_157_9.prefab_name] ~= nil then
						local var_157_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_9.prefab_name].transform, "story_v_out_318041", "318041036", "story_v_out_318041.awb")

						arg_154_1:RecordAudio("318041036", var_157_15)
						arg_154_1:RecordAudio("318041036", var_157_15)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_318041", "318041036", "story_v_out_318041.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_318041", "318041036", "story_v_out_318041.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_16 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_16 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_16

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_16 and arg_154_1.time_ < var_157_6 + var_157_16 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play318041037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 318041037
		arg_158_1.duration_ = 9.3

		local var_158_0 = {
			zh = 7.933,
			ja = 9.3
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play318041038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1050ui_story"].transform
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.var_.moveOldPos1050ui_story = var_161_0.localPosition
			end

			local var_161_2 = 0.001

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2
				local var_161_4 = Vector3.New(0, -1, -6.1)

				var_161_0.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1050ui_story, var_161_4, var_161_3)

				local var_161_5 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_5.x, var_161_5.y, var_161_5.z)

				local var_161_6 = var_161_0.localEulerAngles

				var_161_6.z = 0
				var_161_6.x = 0
				var_161_0.localEulerAngles = var_161_6
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 then
				var_161_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_161_7 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_7.x, var_161_7.y, var_161_7.z)

				local var_161_8 = var_161_0.localEulerAngles

				var_161_8.z = 0
				var_161_8.x = 0
				var_161_0.localEulerAngles = var_161_8
			end

			local var_161_9 = arg_158_1.actors_["1050ui_story"]
			local var_161_10 = 0

			if var_161_10 < arg_158_1.time_ and arg_158_1.time_ <= var_161_10 + arg_161_0 and not isNil(var_161_9) and arg_158_1.var_.characterEffect1050ui_story == nil then
				arg_158_1.var_.characterEffect1050ui_story = var_161_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_11 = 0.200000002980232

			if var_161_10 <= arg_158_1.time_ and arg_158_1.time_ < var_161_10 + var_161_11 and not isNil(var_161_9) then
				local var_161_12 = (arg_158_1.time_ - var_161_10) / var_161_11

				if arg_158_1.var_.characterEffect1050ui_story and not isNil(var_161_9) then
					arg_158_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_10 + var_161_11 and arg_158_1.time_ < var_161_10 + var_161_11 + arg_161_0 and not isNil(var_161_9) and arg_158_1.var_.characterEffect1050ui_story then
				arg_158_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_161_13 = 0
			local var_161_14 = 0.925

			if var_161_13 < arg_158_1.time_ and arg_158_1.time_ <= var_161_13 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_15 = arg_158_1:FormatText(StoryNameCfg[74].name)

				arg_158_1.leftNameTxt_.text = var_161_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_16 = arg_158_1:GetWordFromCfg(318041037)
				local var_161_17 = arg_158_1:FormatText(var_161_16.content)

				arg_158_1.text_.text = var_161_17

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_18 = 37
				local var_161_19 = utf8.len(var_161_17)
				local var_161_20 = var_161_18 <= 0 and var_161_14 or var_161_14 * (var_161_19 / var_161_18)

				if var_161_20 > 0 and var_161_14 < var_161_20 then
					arg_158_1.talkMaxDuration = var_161_20

					if var_161_20 + var_161_13 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_20 + var_161_13
					end
				end

				arg_158_1.text_.text = var_161_17
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041037", "story_v_out_318041.awb") ~= 0 then
					local var_161_21 = manager.audio:GetVoiceLength("story_v_out_318041", "318041037", "story_v_out_318041.awb") / 1000

					if var_161_21 + var_161_13 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_21 + var_161_13
					end

					if var_161_16.prefab_name ~= "" and arg_158_1.actors_[var_161_16.prefab_name] ~= nil then
						local var_161_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_16.prefab_name].transform, "story_v_out_318041", "318041037", "story_v_out_318041.awb")

						arg_158_1:RecordAudio("318041037", var_161_22)
						arg_158_1:RecordAudio("318041037", var_161_22)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_318041", "318041037", "story_v_out_318041.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_318041", "318041037", "story_v_out_318041.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_23 = math.max(var_161_14, arg_158_1.talkMaxDuration)

			if var_161_13 <= arg_158_1.time_ and arg_158_1.time_ < var_161_13 + var_161_23 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_13) / var_161_23

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_13 + var_161_23 and arg_158_1.time_ < var_161_13 + var_161_23 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play318041038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 318041038
		arg_162_1.duration_ = 3.03

		local var_162_0 = {
			zh = 3,
			ja = 3.033
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
				arg_162_0:Play318041039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1050ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1050ui_story == nil then
				arg_162_1.var_.characterEffect1050ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1050ui_story and not isNil(var_165_0) then
					local var_165_4 = Mathf.Lerp(0, 0.5, var_165_3)

					arg_162_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1050ui_story.fillRatio = var_165_4
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1050ui_story then
				local var_165_5 = 0.5

				arg_162_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1050ui_story.fillRatio = var_165_5
			end

			local var_165_6 = 0
			local var_165_7 = 0.3

			if var_165_6 < arg_162_1.time_ and arg_162_1.time_ <= var_165_6 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_8 = arg_162_1:FormatText(StoryNameCfg[637].name)

				arg_162_1.leftNameTxt_.text = var_165_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_9 = arg_162_1:GetWordFromCfg(318041038)
				local var_165_10 = arg_162_1:FormatText(var_165_9.content)

				arg_162_1.text_.text = var_165_10

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_11 = 12
				local var_165_12 = utf8.len(var_165_10)
				local var_165_13 = var_165_11 <= 0 and var_165_7 or var_165_7 * (var_165_12 / var_165_11)

				if var_165_13 > 0 and var_165_7 < var_165_13 then
					arg_162_1.talkMaxDuration = var_165_13

					if var_165_13 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_13 + var_165_6
					end
				end

				arg_162_1.text_.text = var_165_10
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041038", "story_v_out_318041.awb") ~= 0 then
					local var_165_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041038", "story_v_out_318041.awb") / 1000

					if var_165_14 + var_165_6 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_6
					end

					if var_165_9.prefab_name ~= "" and arg_162_1.actors_[var_165_9.prefab_name] ~= nil then
						local var_165_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_9.prefab_name].transform, "story_v_out_318041", "318041038", "story_v_out_318041.awb")

						arg_162_1:RecordAudio("318041038", var_165_15)
						arg_162_1:RecordAudio("318041038", var_165_15)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_318041", "318041038", "story_v_out_318041.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_318041", "318041038", "story_v_out_318041.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_16 = math.max(var_165_7, arg_162_1.talkMaxDuration)

			if var_165_6 <= arg_162_1.time_ and arg_162_1.time_ < var_165_6 + var_165_16 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_6) / var_165_16

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_6 + var_165_16 and arg_162_1.time_ < var_165_6 + var_165_16 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play318041039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 318041039
		arg_166_1.duration_ = 10.03

		local var_166_0 = {
			zh = 10.033,
			ja = 5.033
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
				arg_166_0:Play318041040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 1

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_2 = arg_166_1:FormatText(StoryNameCfg[637].name)

				arg_166_1.leftNameTxt_.text = var_169_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:GetWordFromCfg(318041039)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 40
				local var_169_6 = utf8.len(var_169_4)
				local var_169_7 = var_169_5 <= 0 and var_169_1 or var_169_1 * (var_169_6 / var_169_5)

				if var_169_7 > 0 and var_169_1 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041039", "story_v_out_318041.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041039", "story_v_out_318041.awb") / 1000

					if var_169_8 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_0
					end

					if var_169_3.prefab_name ~= "" and arg_166_1.actors_[var_169_3.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_3.prefab_name].transform, "story_v_out_318041", "318041039", "story_v_out_318041.awb")

						arg_166_1:RecordAudio("318041039", var_169_9)
						arg_166_1:RecordAudio("318041039", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_318041", "318041039", "story_v_out_318041.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_318041", "318041039", "story_v_out_318041.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_10 and arg_166_1.time_ < var_169_0 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play318041040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 318041040
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play318041041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1050ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos1050ui_story = var_173_0.localPosition
			end

			local var_173_2 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2
				local var_173_4 = Vector3.New(0, 100, 0)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1050ui_story, var_173_4, var_173_3)

				local var_173_5 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_5.x, var_173_5.y, var_173_5.z)

				local var_173_6 = var_173_0.localEulerAngles

				var_173_6.z = 0
				var_173_6.x = 0
				var_173_0.localEulerAngles = var_173_6
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, 100, 0)

				local var_173_7 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_7.x, var_173_7.y, var_173_7.z)

				local var_173_8 = var_173_0.localEulerAngles

				var_173_8.z = 0
				var_173_8.x = 0
				var_173_0.localEulerAngles = var_173_8
			end

			local var_173_9 = arg_170_1.actors_["1050ui_story"]
			local var_173_10 = 0

			if var_173_10 < arg_170_1.time_ and arg_170_1.time_ <= var_173_10 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1050ui_story == nil then
				arg_170_1.var_.characterEffect1050ui_story = var_173_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_11 = 0.200000002980232

			if var_173_10 <= arg_170_1.time_ and arg_170_1.time_ < var_173_10 + var_173_11 and not isNil(var_173_9) then
				local var_173_12 = (arg_170_1.time_ - var_173_10) / var_173_11

				if arg_170_1.var_.characterEffect1050ui_story and not isNil(var_173_9) then
					local var_173_13 = Mathf.Lerp(0, 0.5, var_173_12)

					arg_170_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1050ui_story.fillRatio = var_173_13
				end
			end

			if arg_170_1.time_ >= var_173_10 + var_173_11 and arg_170_1.time_ < var_173_10 + var_173_11 + arg_173_0 and not isNil(var_173_9) and arg_170_1.var_.characterEffect1050ui_story then
				local var_173_14 = 0.5

				arg_170_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1050ui_story.fillRatio = var_173_14
			end

			local var_173_15 = 0
			local var_173_16 = 0.575

			if var_173_15 < arg_170_1.time_ and arg_170_1.time_ <= var_173_15 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_17 = arg_170_1:GetWordFromCfg(318041040)
				local var_173_18 = arg_170_1:FormatText(var_173_17.content)

				arg_170_1.text_.text = var_173_18

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_19 = 23
				local var_173_20 = utf8.len(var_173_18)
				local var_173_21 = var_173_19 <= 0 and var_173_16 or var_173_16 * (var_173_20 / var_173_19)

				if var_173_21 > 0 and var_173_16 < var_173_21 then
					arg_170_1.talkMaxDuration = var_173_21

					if var_173_21 + var_173_15 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_21 + var_173_15
					end
				end

				arg_170_1.text_.text = var_173_18
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_22 = math.max(var_173_16, arg_170_1.talkMaxDuration)

			if var_173_15 <= arg_170_1.time_ and arg_170_1.time_ < var_173_15 + var_173_22 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_15) / var_173_22

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_15 + var_173_22 and arg_170_1.time_ < var_173_15 + var_173_22 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play318041041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 318041041
		arg_174_1.duration_ = 9.2

		local var_174_0 = {
			zh = 6.4,
			ja = 9.2
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
				arg_174_0:Play318041042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1050ui_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos1050ui_story = var_177_0.localPosition
			end

			local var_177_2 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2
				local var_177_4 = Vector3.New(0, -1, -6.1)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1050ui_story, var_177_4, var_177_3)

				local var_177_5 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_5.x, var_177_5.y, var_177_5.z)

				local var_177_6 = var_177_0.localEulerAngles

				var_177_6.z = 0
				var_177_6.x = 0
				var_177_0.localEulerAngles = var_177_6
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_177_7 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_7.x, var_177_7.y, var_177_7.z)

				local var_177_8 = var_177_0.localEulerAngles

				var_177_8.z = 0
				var_177_8.x = 0
				var_177_0.localEulerAngles = var_177_8
			end

			local var_177_9 = arg_174_1.actors_["1050ui_story"]
			local var_177_10 = 0

			if var_177_10 < arg_174_1.time_ and arg_174_1.time_ <= var_177_10 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1050ui_story == nil then
				arg_174_1.var_.characterEffect1050ui_story = var_177_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_11 = 0.200000002980232

			if var_177_10 <= arg_174_1.time_ and arg_174_1.time_ < var_177_10 + var_177_11 and not isNil(var_177_9) then
				local var_177_12 = (arg_174_1.time_ - var_177_10) / var_177_11

				if arg_174_1.var_.characterEffect1050ui_story and not isNil(var_177_9) then
					arg_174_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_10 + var_177_11 and arg_174_1.time_ < var_177_10 + var_177_11 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1050ui_story then
				arg_174_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_177_13 = 0

			if var_177_13 < arg_174_1.time_ and arg_174_1.time_ <= var_177_13 + arg_177_0 then
				arg_174_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_2")
			end

			local var_177_14 = 0

			if var_177_14 < arg_174_1.time_ and arg_174_1.time_ <= var_177_14 + arg_177_0 then
				arg_174_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_177_15 = 0
			local var_177_16 = 0.775

			if var_177_15 < arg_174_1.time_ and arg_174_1.time_ <= var_177_15 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_17 = arg_174_1:FormatText(StoryNameCfg[74].name)

				arg_174_1.leftNameTxt_.text = var_177_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_18 = arg_174_1:GetWordFromCfg(318041041)
				local var_177_19 = arg_174_1:FormatText(var_177_18.content)

				arg_174_1.text_.text = var_177_19

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_20 = 31
				local var_177_21 = utf8.len(var_177_19)
				local var_177_22 = var_177_20 <= 0 and var_177_16 or var_177_16 * (var_177_21 / var_177_20)

				if var_177_22 > 0 and var_177_16 < var_177_22 then
					arg_174_1.talkMaxDuration = var_177_22

					if var_177_22 + var_177_15 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_22 + var_177_15
					end
				end

				arg_174_1.text_.text = var_177_19
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041041", "story_v_out_318041.awb") ~= 0 then
					local var_177_23 = manager.audio:GetVoiceLength("story_v_out_318041", "318041041", "story_v_out_318041.awb") / 1000

					if var_177_23 + var_177_15 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_23 + var_177_15
					end

					if var_177_18.prefab_name ~= "" and arg_174_1.actors_[var_177_18.prefab_name] ~= nil then
						local var_177_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_18.prefab_name].transform, "story_v_out_318041", "318041041", "story_v_out_318041.awb")

						arg_174_1:RecordAudio("318041041", var_177_24)
						arg_174_1:RecordAudio("318041041", var_177_24)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_318041", "318041041", "story_v_out_318041.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_318041", "318041041", "story_v_out_318041.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_25 = math.max(var_177_16, arg_174_1.talkMaxDuration)

			if var_177_15 <= arg_174_1.time_ and arg_174_1.time_ < var_177_15 + var_177_25 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_15) / var_177_25

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_15 + var_177_25 and arg_174_1.time_ < var_177_15 + var_177_25 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play318041042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 318041042
		arg_178_1.duration_ = 8.17

		local var_178_0 = {
			zh = 3,
			ja = 8.166
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
				arg_178_0:Play318041043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1050ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1050ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, -1, -6.1)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1050ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = arg_178_1.actors_["1050ui_story"]
			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1050ui_story == nil then
				arg_178_1.var_.characterEffect1050ui_story = var_181_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_11 = 0.200000002980232

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_11 and not isNil(var_181_9) then
				local var_181_12 = (arg_178_1.time_ - var_181_10) / var_181_11

				if arg_178_1.var_.characterEffect1050ui_story and not isNil(var_181_9) then
					arg_178_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_10 + var_181_11 and arg_178_1.time_ < var_181_10 + var_181_11 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1050ui_story then
				arg_178_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_181_13 = 0

			if var_181_13 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_181_14 = 0

			if var_181_14 < arg_178_1.time_ and arg_178_1.time_ <= var_181_14 + arg_181_0 then
				arg_178_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_15 = 0
			local var_181_16 = 0.375

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_17 = arg_178_1:FormatText(StoryNameCfg[74].name)

				arg_178_1.leftNameTxt_.text = var_181_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_18 = arg_178_1:GetWordFromCfg(318041042)
				local var_181_19 = arg_178_1:FormatText(var_181_18.content)

				arg_178_1.text_.text = var_181_19

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_20 = 15
				local var_181_21 = utf8.len(var_181_19)
				local var_181_22 = var_181_20 <= 0 and var_181_16 or var_181_16 * (var_181_21 / var_181_20)

				if var_181_22 > 0 and var_181_16 < var_181_22 then
					arg_178_1.talkMaxDuration = var_181_22

					if var_181_22 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_15
					end
				end

				arg_178_1.text_.text = var_181_19
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041042", "story_v_out_318041.awb") ~= 0 then
					local var_181_23 = manager.audio:GetVoiceLength("story_v_out_318041", "318041042", "story_v_out_318041.awb") / 1000

					if var_181_23 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_23 + var_181_15
					end

					if var_181_18.prefab_name ~= "" and arg_178_1.actors_[var_181_18.prefab_name] ~= nil then
						local var_181_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_18.prefab_name].transform, "story_v_out_318041", "318041042", "story_v_out_318041.awb")

						arg_178_1:RecordAudio("318041042", var_181_24)
						arg_178_1:RecordAudio("318041042", var_181_24)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_318041", "318041042", "story_v_out_318041.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_318041", "318041042", "story_v_out_318041.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_25 = math.max(var_181_16, arg_178_1.talkMaxDuration)

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_25 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_15) / var_181_25

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_15 + var_181_25 and arg_178_1.time_ < var_181_15 + var_181_25 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play318041043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 318041043
		arg_182_1.duration_ = 1.5

		local var_182_0 = {
			zh = 1.5,
			ja = 1.1
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
				arg_182_0:Play318041044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1050ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1050ui_story == nil then
				arg_182_1.var_.characterEffect1050ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1050ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1050ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1050ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1050ui_story.fillRatio = var_185_5
			end

			local var_185_6 = 0
			local var_185_7 = 0.125

			if var_185_6 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_8 = arg_182_1:FormatText(StoryNameCfg[637].name)

				arg_182_1.leftNameTxt_.text = var_185_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_9 = arg_182_1:GetWordFromCfg(318041043)
				local var_185_10 = arg_182_1:FormatText(var_185_9.content)

				arg_182_1.text_.text = var_185_10

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_11 = 5
				local var_185_12 = utf8.len(var_185_10)
				local var_185_13 = var_185_11 <= 0 and var_185_7 or var_185_7 * (var_185_12 / var_185_11)

				if var_185_13 > 0 and var_185_7 < var_185_13 then
					arg_182_1.talkMaxDuration = var_185_13

					if var_185_13 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_13 + var_185_6
					end
				end

				arg_182_1.text_.text = var_185_10
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041043", "story_v_out_318041.awb") ~= 0 then
					local var_185_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041043", "story_v_out_318041.awb") / 1000

					if var_185_14 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_6
					end

					if var_185_9.prefab_name ~= "" and arg_182_1.actors_[var_185_9.prefab_name] ~= nil then
						local var_185_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_9.prefab_name].transform, "story_v_out_318041", "318041043", "story_v_out_318041.awb")

						arg_182_1:RecordAudio("318041043", var_185_15)
						arg_182_1:RecordAudio("318041043", var_185_15)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_318041", "318041043", "story_v_out_318041.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_318041", "318041043", "story_v_out_318041.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_16 = math.max(var_185_7, arg_182_1.talkMaxDuration)

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_16 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_6) / var_185_16

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_6 + var_185_16 and arg_182_1.time_ < var_185_6 + var_185_16 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play318041044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 318041044
		arg_186_1.duration_ = 8.3

		local var_186_0 = {
			zh = 4.3,
			ja = 8.3
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
				arg_186_0:Play318041045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.4

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_2 = arg_186_1:FormatText(StoryNameCfg[637].name)

				arg_186_1.leftNameTxt_.text = var_189_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(318041044)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 16
				local var_189_6 = utf8.len(var_189_4)
				local var_189_7 = var_189_5 <= 0 and var_189_1 or var_189_1 * (var_189_6 / var_189_5)

				if var_189_7 > 0 and var_189_1 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041044", "story_v_out_318041.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041044", "story_v_out_318041.awb") / 1000

					if var_189_8 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_0
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_out_318041", "318041044", "story_v_out_318041.awb")

						arg_186_1:RecordAudio("318041044", var_189_9)
						arg_186_1:RecordAudio("318041044", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_318041", "318041044", "story_v_out_318041.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_318041", "318041044", "story_v_out_318041.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_10 and arg_186_1.time_ < var_189_0 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play318041045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 318041045
		arg_190_1.duration_ = 10.47

		local var_190_0 = {
			zh = 10.466,
			ja = 8
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
				arg_190_0:Play318041046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 2

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				local var_193_1 = manager.ui.mainCamera.transform.localPosition
				local var_193_2 = Vector3.New(0, 0, 10) + Vector3.New(var_193_1.x, var_193_1.y, 0)
				local var_193_3 = arg_190_1.bgs_.ST69

				var_193_3.transform.localPosition = var_193_2
				var_193_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_193_4 = var_193_3:GetComponent("SpriteRenderer")

				if var_193_4 and var_193_4.sprite then
					local var_193_5 = (var_193_3.transform.localPosition - var_193_1).z
					local var_193_6 = manager.ui.mainCameraCom_
					local var_193_7 = 2 * var_193_5 * Mathf.Tan(var_193_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_193_8 = var_193_7 * var_193_6.aspect
					local var_193_9 = var_193_4.sprite.bounds.size.x
					local var_193_10 = var_193_4.sprite.bounds.size.y
					local var_193_11 = var_193_8 / var_193_9
					local var_193_12 = var_193_7 / var_193_10
					local var_193_13 = var_193_12 < var_193_11 and var_193_11 or var_193_12

					var_193_3.transform.localScale = Vector3.New(var_193_13, var_193_13, 0)
				end

				for iter_193_0, iter_193_1 in pairs(arg_190_1.bgs_) do
					if iter_193_0 ~= "ST69" then
						iter_193_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_193_14 = 0

			if var_193_14 < arg_190_1.time_ and arg_190_1.time_ <= var_193_14 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_15 = 2

			if var_193_14 <= arg_190_1.time_ and arg_190_1.time_ < var_193_14 + var_193_15 then
				local var_193_16 = (arg_190_1.time_ - var_193_14) / var_193_15
				local var_193_17 = Color.New(0, 0, 0)

				var_193_17.a = Mathf.Lerp(0, 1, var_193_16)
				arg_190_1.mask_.color = var_193_17
			end

			if arg_190_1.time_ >= var_193_14 + var_193_15 and arg_190_1.time_ < var_193_14 + var_193_15 + arg_193_0 then
				local var_193_18 = Color.New(0, 0, 0)

				var_193_18.a = 1
				arg_190_1.mask_.color = var_193_18
			end

			local var_193_19 = 2

			if var_193_19 < arg_190_1.time_ and arg_190_1.time_ <= var_193_19 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_20 = 2

			if var_193_19 <= arg_190_1.time_ and arg_190_1.time_ < var_193_19 + var_193_20 then
				local var_193_21 = (arg_190_1.time_ - var_193_19) / var_193_20
				local var_193_22 = Color.New(0, 0, 0)

				var_193_22.a = Mathf.Lerp(1, 0, var_193_21)
				arg_190_1.mask_.color = var_193_22
			end

			if arg_190_1.time_ >= var_193_19 + var_193_20 and arg_190_1.time_ < var_193_19 + var_193_20 + arg_193_0 then
				local var_193_23 = Color.New(0, 0, 0)
				local var_193_24 = 0

				arg_190_1.mask_.enabled = false
				var_193_23.a = var_193_24
				arg_190_1.mask_.color = var_193_23
			end

			local var_193_25 = arg_190_1.actors_["1050ui_story"].transform
			local var_193_26 = 4

			if var_193_26 < arg_190_1.time_ and arg_190_1.time_ <= var_193_26 + arg_193_0 then
				arg_190_1.var_.moveOldPos1050ui_story = var_193_25.localPosition
			end

			local var_193_27 = 0.001

			if var_193_26 <= arg_190_1.time_ and arg_190_1.time_ < var_193_26 + var_193_27 then
				local var_193_28 = (arg_190_1.time_ - var_193_26) / var_193_27
				local var_193_29 = Vector3.New(0, -1, -6.1)

				var_193_25.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1050ui_story, var_193_29, var_193_28)

				local var_193_30 = manager.ui.mainCamera.transform.position - var_193_25.position

				var_193_25.forward = Vector3.New(var_193_30.x, var_193_30.y, var_193_30.z)

				local var_193_31 = var_193_25.localEulerAngles

				var_193_31.z = 0
				var_193_31.x = 0
				var_193_25.localEulerAngles = var_193_31
			end

			if arg_190_1.time_ >= var_193_26 + var_193_27 and arg_190_1.time_ < var_193_26 + var_193_27 + arg_193_0 then
				var_193_25.localPosition = Vector3.New(0, -1, -6.1)

				local var_193_32 = manager.ui.mainCamera.transform.position - var_193_25.position

				var_193_25.forward = Vector3.New(var_193_32.x, var_193_32.y, var_193_32.z)

				local var_193_33 = var_193_25.localEulerAngles

				var_193_33.z = 0
				var_193_33.x = 0
				var_193_25.localEulerAngles = var_193_33
			end

			local var_193_34 = arg_190_1.actors_["1050ui_story"]
			local var_193_35 = 4

			if var_193_35 < arg_190_1.time_ and arg_190_1.time_ <= var_193_35 + arg_193_0 and not isNil(var_193_34) and arg_190_1.var_.characterEffect1050ui_story == nil then
				arg_190_1.var_.characterEffect1050ui_story = var_193_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_36 = 0.200000002980232

			if var_193_35 <= arg_190_1.time_ and arg_190_1.time_ < var_193_35 + var_193_36 and not isNil(var_193_34) then
				local var_193_37 = (arg_190_1.time_ - var_193_35) / var_193_36

				if arg_190_1.var_.characterEffect1050ui_story and not isNil(var_193_34) then
					arg_190_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_35 + var_193_36 and arg_190_1.time_ < var_193_35 + var_193_36 + arg_193_0 and not isNil(var_193_34) and arg_190_1.var_.characterEffect1050ui_story then
				arg_190_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_193_38 = 4

			if var_193_38 < arg_190_1.time_ and arg_190_1.time_ <= var_193_38 + arg_193_0 then
				arg_190_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_1")
			end

			local var_193_39 = 4

			if var_193_39 < arg_190_1.time_ and arg_190_1.time_ <= var_193_39 + arg_193_0 then
				arg_190_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_193_40 = 1.98333333333333

			arg_190_1.isInRecall_ = false

			if var_193_40 < arg_190_1.time_ and arg_190_1.time_ <= var_193_40 + arg_193_0 then
				arg_190_1.screenFilterGo_:SetActive(false)

				for iter_193_2, iter_193_3 in pairs(arg_190_1.actors_) do
					local var_193_41 = iter_193_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_193_4, iter_193_5 in ipairs(var_193_41) do
						if iter_193_5.color.r > 0.51 then
							iter_193_5.color = Color.New(1, 1, 1)
						else
							iter_193_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_193_42 = 0.0166666666666666

			if var_193_40 <= arg_190_1.time_ and arg_190_1.time_ < var_193_40 + var_193_42 then
				local var_193_43 = (arg_190_1.time_ - var_193_40) / var_193_42

				arg_190_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_193_43)
			end

			if arg_190_1.time_ >= var_193_40 + var_193_42 and arg_190_1.time_ < var_193_40 + var_193_42 + arg_193_0 then
				arg_190_1.screenFilterEffect_.weight = 0
			end

			local var_193_44 = arg_190_1.actors_["1050ui_story"]
			local var_193_45 = 2

			if var_193_45 < arg_190_1.time_ and arg_190_1.time_ <= var_193_45 + arg_193_0 and not isNil(var_193_44) and arg_190_1.var_.characterEffect1050ui_story == nil then
				arg_190_1.var_.characterEffect1050ui_story = var_193_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_46 = 0.200000002980232

			if var_193_45 <= arg_190_1.time_ and arg_190_1.time_ < var_193_45 + var_193_46 and not isNil(var_193_44) then
				local var_193_47 = (arg_190_1.time_ - var_193_45) / var_193_46

				if arg_190_1.var_.characterEffect1050ui_story and not isNil(var_193_44) then
					local var_193_48 = Mathf.Lerp(0, 0.5, var_193_47)

					arg_190_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1050ui_story.fillRatio = var_193_48
				end
			end

			if arg_190_1.time_ >= var_193_45 + var_193_46 and arg_190_1.time_ < var_193_45 + var_193_46 + arg_193_0 and not isNil(var_193_44) and arg_190_1.var_.characterEffect1050ui_story then
				local var_193_49 = 0.5

				arg_190_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1050ui_story.fillRatio = var_193_49
			end

			local var_193_50 = arg_190_1.actors_["1050ui_story"].transform
			local var_193_51 = 2

			if var_193_51 < arg_190_1.time_ and arg_190_1.time_ <= var_193_51 + arg_193_0 then
				arg_190_1.var_.moveOldPos1050ui_story = var_193_50.localPosition
			end

			local var_193_52 = 0.001

			if var_193_51 <= arg_190_1.time_ and arg_190_1.time_ < var_193_51 + var_193_52 then
				local var_193_53 = (arg_190_1.time_ - var_193_51) / var_193_52
				local var_193_54 = Vector3.New(0, 100, 0)

				var_193_50.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1050ui_story, var_193_54, var_193_53)

				local var_193_55 = manager.ui.mainCamera.transform.position - var_193_50.position

				var_193_50.forward = Vector3.New(var_193_55.x, var_193_55.y, var_193_55.z)

				local var_193_56 = var_193_50.localEulerAngles

				var_193_56.z = 0
				var_193_56.x = 0
				var_193_50.localEulerAngles = var_193_56
			end

			if arg_190_1.time_ >= var_193_51 + var_193_52 and arg_190_1.time_ < var_193_51 + var_193_52 + arg_193_0 then
				var_193_50.localPosition = Vector3.New(0, 100, 0)

				local var_193_57 = manager.ui.mainCamera.transform.position - var_193_50.position

				var_193_50.forward = Vector3.New(var_193_57.x, var_193_57.y, var_193_57.z)

				local var_193_58 = var_193_50.localEulerAngles

				var_193_58.z = 0
				var_193_58.x = 0
				var_193_50.localEulerAngles = var_193_58
			end

			local var_193_59 = 0
			local var_193_60 = 0.433333333333333

			if var_193_59 < arg_190_1.time_ and arg_190_1.time_ <= var_193_59 + arg_193_0 then
				local var_193_61 = "play"
				local var_193_62 = "music"

				arg_190_1:AudioAction(var_193_61, var_193_62, "ui_battle", "ui_battle_stopbgm", "")

				local var_193_63 = ""
				local var_193_64 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_193_64 ~= "" then
					if arg_190_1.bgmTxt_.text ~= var_193_64 and arg_190_1.bgmTxt_.text ~= "" then
						if arg_190_1.bgmTxt2_.text ~= "" then
							arg_190_1.bgmTxt_.text = arg_190_1.bgmTxt2_.text
						end

						arg_190_1.bgmTxt2_.text = var_193_64

						arg_190_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_190_1.bgmTxt_.text = var_193_64
						arg_190_1.bgmTxt2_.text = var_193_64
					end

					if arg_190_1.bgmTimer then
						arg_190_1.bgmTimer:Stop()

						arg_190_1.bgmTimer = nil
					end

					if arg_190_1.settingData.show_music_name == 1 then
						arg_190_1.musicController:SetSelectedState("show")
						arg_190_1.musicAnimator_:Play("open", 0, 0)

						if arg_190_1.settingData.music_time ~= 0 then
							arg_190_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_190_1.settingData.music_time), function()
								if arg_190_1 == nil or isNil(arg_190_1.bgmTxt_) then
									return
								end

								arg_190_1.musicController:SetSelectedState("hide")
								arg_190_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_193_65 = 1.26666666666667
			local var_193_66 = 1

			if var_193_65 < arg_190_1.time_ and arg_190_1.time_ <= var_193_65 + arg_193_0 then
				local var_193_67 = "play"
				local var_193_68 = "music"

				arg_190_1:AudioAction(var_193_67, var_193_68, "bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten.awb")

				local var_193_69 = ""
				local var_193_70 = manager.audio:GetAudioName("bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten")

				if var_193_70 ~= "" then
					if arg_190_1.bgmTxt_.text ~= var_193_70 and arg_190_1.bgmTxt_.text ~= "" then
						if arg_190_1.bgmTxt2_.text ~= "" then
							arg_190_1.bgmTxt_.text = arg_190_1.bgmTxt2_.text
						end

						arg_190_1.bgmTxt2_.text = var_193_70

						arg_190_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_190_1.bgmTxt_.text = var_193_70
						arg_190_1.bgmTxt2_.text = var_193_70
					end

					if arg_190_1.bgmTimer then
						arg_190_1.bgmTimer:Stop()

						arg_190_1.bgmTimer = nil
					end

					if arg_190_1.settingData.show_music_name == 1 then
						arg_190_1.musicController:SetSelectedState("show")
						arg_190_1.musicAnimator_:Play("open", 0, 0)

						if arg_190_1.settingData.music_time ~= 0 then
							arg_190_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_190_1.settingData.music_time), function()
								if arg_190_1 == nil or isNil(arg_190_1.bgmTxt_) then
									return
								end

								arg_190_1.musicController:SetSelectedState("hide")
								arg_190_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_71 = 4
			local var_193_72 = 0.45

			if var_193_71 < arg_190_1.time_ and arg_190_1.time_ <= var_193_71 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_73 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_73:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_190_1.dialogCg_.alpha = arg_196_0
				end))
				var_193_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_74 = arg_190_1:FormatText(StoryNameCfg[74].name)

				arg_190_1.leftNameTxt_.text = var_193_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_75 = arg_190_1:GetWordFromCfg(318041045)
				local var_193_76 = arg_190_1:FormatText(var_193_75.content)

				arg_190_1.text_.text = var_193_76

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_77 = 18
				local var_193_78 = utf8.len(var_193_76)
				local var_193_79 = var_193_77 <= 0 and var_193_72 or var_193_72 * (var_193_78 / var_193_77)

				if var_193_79 > 0 and var_193_72 < var_193_79 then
					arg_190_1.talkMaxDuration = var_193_79
					var_193_71 = var_193_71 + 0.3

					if var_193_79 + var_193_71 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_79 + var_193_71
					end
				end

				arg_190_1.text_.text = var_193_76
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041045", "story_v_out_318041.awb") ~= 0 then
					local var_193_80 = manager.audio:GetVoiceLength("story_v_out_318041", "318041045", "story_v_out_318041.awb") / 1000

					if var_193_80 + var_193_71 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_80 + var_193_71
					end

					if var_193_75.prefab_name ~= "" and arg_190_1.actors_[var_193_75.prefab_name] ~= nil then
						local var_193_81 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_75.prefab_name].transform, "story_v_out_318041", "318041045", "story_v_out_318041.awb")

						arg_190_1:RecordAudio("318041045", var_193_81)
						arg_190_1:RecordAudio("318041045", var_193_81)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_318041", "318041045", "story_v_out_318041.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_318041", "318041045", "story_v_out_318041.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_82 = var_193_71 + 0.3
			local var_193_83 = math.max(var_193_72, arg_190_1.talkMaxDuration)

			if var_193_82 <= arg_190_1.time_ and arg_190_1.time_ < var_193_82 + var_193_83 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_82) / var_193_83

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_82 + var_193_83 and arg_190_1.time_ < var_193_82 + var_193_83 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play318041046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 318041046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play318041047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1050ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1050ui_story == nil then
				arg_198_1.var_.characterEffect1050ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1050ui_story and not isNil(var_201_0) then
					local var_201_4 = Mathf.Lerp(0, 0.5, var_201_3)

					arg_198_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1050ui_story.fillRatio = var_201_4
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1050ui_story then
				local var_201_5 = 0.5

				arg_198_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1050ui_story.fillRatio = var_201_5
			end

			local var_201_6 = 0
			local var_201_7 = 0.433333333333333

			if var_201_6 < arg_198_1.time_ and arg_198_1.time_ <= var_201_6 + arg_201_0 then
				local var_201_8 = "play"
				local var_201_9 = "effect"

				arg_198_1:AudioAction(var_201_8, var_201_9, "se_story_1210", "se_story_1210_cooking", "")
			end

			local var_201_10 = 0
			local var_201_11 = 1.675

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_12 = arg_198_1:GetWordFromCfg(318041046)
				local var_201_13 = arg_198_1:FormatText(var_201_12.content)

				arg_198_1.text_.text = var_201_13

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_14 = 67
				local var_201_15 = utf8.len(var_201_13)
				local var_201_16 = var_201_14 <= 0 and var_201_11 or var_201_11 * (var_201_15 / var_201_14)

				if var_201_16 > 0 and var_201_11 < var_201_16 then
					arg_198_1.talkMaxDuration = var_201_16

					if var_201_16 + var_201_10 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_16 + var_201_10
					end
				end

				arg_198_1.text_.text = var_201_13
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_17 = math.max(var_201_11, arg_198_1.talkMaxDuration)

			if var_201_10 <= arg_198_1.time_ and arg_198_1.time_ < var_201_10 + var_201_17 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_10) / var_201_17

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_10 + var_201_17 and arg_198_1.time_ < var_201_10 + var_201_17 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play318041047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 318041047
		arg_202_1.duration_ = 3.6

		local var_202_0 = {
			zh = 1.999999999999,
			ja = 3.6
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
				arg_202_0:Play318041048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1050ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos1050ui_story = var_205_0.localPosition
			end

			local var_205_2 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2
				local var_205_4 = Vector3.New(0, -1, -6.1)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1050ui_story, var_205_4, var_205_3)

				local var_205_5 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_5.x, var_205_5.y, var_205_5.z)

				local var_205_6 = var_205_0.localEulerAngles

				var_205_6.z = 0
				var_205_6.x = 0
				var_205_0.localEulerAngles = var_205_6
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_205_7 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_7.x, var_205_7.y, var_205_7.z)

				local var_205_8 = var_205_0.localEulerAngles

				var_205_8.z = 0
				var_205_8.x = 0
				var_205_0.localEulerAngles = var_205_8
			end

			local var_205_9 = arg_202_1.actors_["1050ui_story"]
			local var_205_10 = 0

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1050ui_story == nil then
				arg_202_1.var_.characterEffect1050ui_story = var_205_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_11 = 0.200000002980232

			if var_205_10 <= arg_202_1.time_ and arg_202_1.time_ < var_205_10 + var_205_11 and not isNil(var_205_9) then
				local var_205_12 = (arg_202_1.time_ - var_205_10) / var_205_11

				if arg_202_1.var_.characterEffect1050ui_story and not isNil(var_205_9) then
					arg_202_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_10 + var_205_11 and arg_202_1.time_ < var_205_10 + var_205_11 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1050ui_story then
				arg_202_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_205_13 = 0

			if var_205_13 < arg_202_1.time_ and arg_202_1.time_ <= var_205_13 + arg_205_0 then
				arg_202_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_2")
			end

			local var_205_14 = 0

			if var_205_14 < arg_202_1.time_ and arg_202_1.time_ <= var_205_14 + arg_205_0 then
				arg_202_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_205_15 = 0
			local var_205_16 = 0.2

			if var_205_15 < arg_202_1.time_ and arg_202_1.time_ <= var_205_15 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_17 = arg_202_1:FormatText(StoryNameCfg[74].name)

				arg_202_1.leftNameTxt_.text = var_205_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_18 = arg_202_1:GetWordFromCfg(318041047)
				local var_205_19 = arg_202_1:FormatText(var_205_18.content)

				arg_202_1.text_.text = var_205_19

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_20 = 8
				local var_205_21 = utf8.len(var_205_19)
				local var_205_22 = var_205_20 <= 0 and var_205_16 or var_205_16 * (var_205_21 / var_205_20)

				if var_205_22 > 0 and var_205_16 < var_205_22 then
					arg_202_1.talkMaxDuration = var_205_22

					if var_205_22 + var_205_15 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_22 + var_205_15
					end
				end

				arg_202_1.text_.text = var_205_19
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041047", "story_v_out_318041.awb") ~= 0 then
					local var_205_23 = manager.audio:GetVoiceLength("story_v_out_318041", "318041047", "story_v_out_318041.awb") / 1000

					if var_205_23 + var_205_15 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_23 + var_205_15
					end

					if var_205_18.prefab_name ~= "" and arg_202_1.actors_[var_205_18.prefab_name] ~= nil then
						local var_205_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_18.prefab_name].transform, "story_v_out_318041", "318041047", "story_v_out_318041.awb")

						arg_202_1:RecordAudio("318041047", var_205_24)
						arg_202_1:RecordAudio("318041047", var_205_24)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_318041", "318041047", "story_v_out_318041.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_318041", "318041047", "story_v_out_318041.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_25 = math.max(var_205_16, arg_202_1.talkMaxDuration)

			if var_205_15 <= arg_202_1.time_ and arg_202_1.time_ < var_205_15 + var_205_25 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_15) / var_205_25

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_15 + var_205_25 and arg_202_1.time_ < var_205_15 + var_205_25 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play318041048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 318041048
		arg_206_1.duration_ = 4.93

		local var_206_0 = {
			zh = 4.933,
			ja = 3.066
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
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play318041049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1050ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1050ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, -1, -6.1)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1050ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = 0
			local var_209_10 = 0.475

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_11 = arg_206_1:FormatText(StoryNameCfg[74].name)

				arg_206_1.leftNameTxt_.text = var_209_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_12 = arg_206_1:GetWordFromCfg(318041048)
				local var_209_13 = arg_206_1:FormatText(var_209_12.content)

				arg_206_1.text_.text = var_209_13

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_14 = 19
				local var_209_15 = utf8.len(var_209_13)
				local var_209_16 = var_209_14 <= 0 and var_209_10 or var_209_10 * (var_209_15 / var_209_14)

				if var_209_16 > 0 and var_209_10 < var_209_16 then
					arg_206_1.talkMaxDuration = var_209_16

					if var_209_16 + var_209_9 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_16 + var_209_9
					end
				end

				arg_206_1.text_.text = var_209_13
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041048", "story_v_out_318041.awb") ~= 0 then
					local var_209_17 = manager.audio:GetVoiceLength("story_v_out_318041", "318041048", "story_v_out_318041.awb") / 1000

					if var_209_17 + var_209_9 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_17 + var_209_9
					end

					if var_209_12.prefab_name ~= "" and arg_206_1.actors_[var_209_12.prefab_name] ~= nil then
						local var_209_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_12.prefab_name].transform, "story_v_out_318041", "318041048", "story_v_out_318041.awb")

						arg_206_1:RecordAudio("318041048", var_209_18)
						arg_206_1:RecordAudio("318041048", var_209_18)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_318041", "318041048", "story_v_out_318041.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_318041", "318041048", "story_v_out_318041.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_19 = math.max(var_209_10, arg_206_1.talkMaxDuration)

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_19 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_9) / var_209_19

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_9 + var_209_19 and arg_206_1.time_ < var_209_9 + var_209_19 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play318041049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 318041049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play318041050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1050ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1050ui_story == nil then
				arg_210_1.var_.characterEffect1050ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1050ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1050ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1050ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1050ui_story.fillRatio = var_213_5
			end

			local var_213_6 = 0
			local var_213_7 = 1

			if var_213_6 < arg_210_1.time_ and arg_210_1.time_ <= var_213_6 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_8 = arg_210_1:GetWordFromCfg(318041049)
				local var_213_9 = arg_210_1:FormatText(var_213_8.content)

				arg_210_1.text_.text = var_213_9

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_10 = 40
				local var_213_11 = utf8.len(var_213_9)
				local var_213_12 = var_213_10 <= 0 and var_213_7 or var_213_7 * (var_213_11 / var_213_10)

				if var_213_12 > 0 and var_213_7 < var_213_12 then
					arg_210_1.talkMaxDuration = var_213_12

					if var_213_12 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_12 + var_213_6
					end
				end

				arg_210_1.text_.text = var_213_9
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_13 = math.max(var_213_7, arg_210_1.talkMaxDuration)

			if var_213_6 <= arg_210_1.time_ and arg_210_1.time_ < var_213_6 + var_213_13 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_6) / var_213_13

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_6 + var_213_13 and arg_210_1.time_ < var_213_6 + var_213_13 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play318041050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 318041050
		arg_214_1.duration_ = 6.9

		local var_214_0 = {
			zh = 6.9,
			ja = 5.333
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play318041051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1050ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1050ui_story == nil then
				arg_214_1.var_.characterEffect1050ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1050ui_story and not isNil(var_217_0) then
					arg_214_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1050ui_story then
				arg_214_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_217_4 = 0

			if var_217_4 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			local var_217_5 = 0

			if var_217_5 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_217_6 = 0
			local var_217_7 = 0.675

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_8 = arg_214_1:FormatText(StoryNameCfg[74].name)

				arg_214_1.leftNameTxt_.text = var_217_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_9 = arg_214_1:GetWordFromCfg(318041050)
				local var_217_10 = arg_214_1:FormatText(var_217_9.content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 27
				local var_217_12 = utf8.len(var_217_10)
				local var_217_13 = var_217_11 <= 0 and var_217_7 or var_217_7 * (var_217_12 / var_217_11)

				if var_217_13 > 0 and var_217_7 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_10
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041050", "story_v_out_318041.awb") ~= 0 then
					local var_217_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041050", "story_v_out_318041.awb") / 1000

					if var_217_14 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_14 + var_217_6
					end

					if var_217_9.prefab_name ~= "" and arg_214_1.actors_[var_217_9.prefab_name] ~= nil then
						local var_217_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_9.prefab_name].transform, "story_v_out_318041", "318041050", "story_v_out_318041.awb")

						arg_214_1:RecordAudio("318041050", var_217_15)
						arg_214_1:RecordAudio("318041050", var_217_15)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_318041", "318041050", "story_v_out_318041.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_318041", "318041050", "story_v_out_318041.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_16 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_16 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_16

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_16 and arg_214_1.time_ < var_217_6 + var_217_16 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play318041051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 318041051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play318041052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1050ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1050ui_story == nil then
				arg_218_1.var_.characterEffect1050ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect1050ui_story and not isNil(var_221_0) then
					local var_221_4 = Mathf.Lerp(0, 0.5, var_221_3)

					arg_218_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1050ui_story.fillRatio = var_221_4
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1050ui_story then
				local var_221_5 = 0.5

				arg_218_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1050ui_story.fillRatio = var_221_5
			end

			local var_221_6 = arg_218_1.actors_["1050ui_story"].transform
			local var_221_7 = 0

			if var_221_7 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 then
				arg_218_1.var_.moveOldPos1050ui_story = var_221_6.localPosition
			end

			local var_221_8 = 0.001

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_8 then
				local var_221_9 = (arg_218_1.time_ - var_221_7) / var_221_8
				local var_221_10 = Vector3.New(0, 100, 0)

				var_221_6.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1050ui_story, var_221_10, var_221_9)

				local var_221_11 = manager.ui.mainCamera.transform.position - var_221_6.position

				var_221_6.forward = Vector3.New(var_221_11.x, var_221_11.y, var_221_11.z)

				local var_221_12 = var_221_6.localEulerAngles

				var_221_12.z = 0
				var_221_12.x = 0
				var_221_6.localEulerAngles = var_221_12
			end

			if arg_218_1.time_ >= var_221_7 + var_221_8 and arg_218_1.time_ < var_221_7 + var_221_8 + arg_221_0 then
				var_221_6.localPosition = Vector3.New(0, 100, 0)

				local var_221_13 = manager.ui.mainCamera.transform.position - var_221_6.position

				var_221_6.forward = Vector3.New(var_221_13.x, var_221_13.y, var_221_13.z)

				local var_221_14 = var_221_6.localEulerAngles

				var_221_14.z = 0
				var_221_14.x = 0
				var_221_6.localEulerAngles = var_221_14
			end

			local var_221_15 = 0
			local var_221_16 = 1.35

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_17 = arg_218_1:GetWordFromCfg(318041051)
				local var_221_18 = arg_218_1:FormatText(var_221_17.content)

				arg_218_1.text_.text = var_221_18

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_19 = 54
				local var_221_20 = utf8.len(var_221_18)
				local var_221_21 = var_221_19 <= 0 and var_221_16 or var_221_16 * (var_221_20 / var_221_19)

				if var_221_21 > 0 and var_221_16 < var_221_21 then
					arg_218_1.talkMaxDuration = var_221_21

					if var_221_21 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_21 + var_221_15
					end
				end

				arg_218_1.text_.text = var_221_18
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_22 = math.max(var_221_16, arg_218_1.talkMaxDuration)

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_22 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_15) / var_221_22

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_15 + var_221_22 and arg_218_1.time_ < var_221_15 + var_221_22 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play318041052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 318041052
		arg_222_1.duration_ = 5.03

		local var_222_0 = {
			zh = 4.166,
			ja = 5.033
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play318041053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.375

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[36].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:GetWordFromCfg(318041052)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 15
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041052", "story_v_out_318041.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041052", "story_v_out_318041.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_out_318041", "318041052", "story_v_out_318041.awb")

						arg_222_1:RecordAudio("318041052", var_225_9)
						arg_222_1:RecordAudio("318041052", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_318041", "318041052", "story_v_out_318041.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_318041", "318041052", "story_v_out_318041.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_10 and arg_222_1.time_ < var_225_0 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play318041053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 318041053
		arg_226_1.duration_ = 3.23

		local var_226_0 = {
			zh = 2.266,
			ja = 3.233
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play318041054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1050ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1050ui_story == nil then
				arg_226_1.var_.characterEffect1050ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1050ui_story and not isNil(var_229_0) then
					arg_226_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1050ui_story then
				arg_226_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_229_4 = arg_226_1.actors_["1050ui_story"].transform
			local var_229_5 = 0

			if var_229_5 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.var_.moveOldPos1050ui_story = var_229_4.localPosition
			end

			local var_229_6 = 0.001

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_6 then
				local var_229_7 = (arg_226_1.time_ - var_229_5) / var_229_6
				local var_229_8 = Vector3.New(0, -1, -6.1)

				var_229_4.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1050ui_story, var_229_8, var_229_7)

				local var_229_9 = manager.ui.mainCamera.transform.position - var_229_4.position

				var_229_4.forward = Vector3.New(var_229_9.x, var_229_9.y, var_229_9.z)

				local var_229_10 = var_229_4.localEulerAngles

				var_229_10.z = 0
				var_229_10.x = 0
				var_229_4.localEulerAngles = var_229_10
			end

			if arg_226_1.time_ >= var_229_5 + var_229_6 and arg_226_1.time_ < var_229_5 + var_229_6 + arg_229_0 then
				var_229_4.localPosition = Vector3.New(0, -1, -6.1)

				local var_229_11 = manager.ui.mainCamera.transform.position - var_229_4.position

				var_229_4.forward = Vector3.New(var_229_11.x, var_229_11.y, var_229_11.z)

				local var_229_12 = var_229_4.localEulerAngles

				var_229_12.z = 0
				var_229_12.x = 0
				var_229_4.localEulerAngles = var_229_12
			end

			local var_229_13 = 0

			if var_229_13 < arg_226_1.time_ and arg_226_1.time_ <= var_229_13 + arg_229_0 then
				arg_226_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_229_14 = 0

			if var_229_14 < arg_226_1.time_ and arg_226_1.time_ <= var_229_14 + arg_229_0 then
				arg_226_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_229_15 = 0
			local var_229_16 = 0.25

			if var_229_15 < arg_226_1.time_ and arg_226_1.time_ <= var_229_15 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_17 = arg_226_1:FormatText(StoryNameCfg[74].name)

				arg_226_1.leftNameTxt_.text = var_229_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_18 = arg_226_1:GetWordFromCfg(318041053)
				local var_229_19 = arg_226_1:FormatText(var_229_18.content)

				arg_226_1.text_.text = var_229_19

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_20 = 10
				local var_229_21 = utf8.len(var_229_19)
				local var_229_22 = var_229_20 <= 0 and var_229_16 or var_229_16 * (var_229_21 / var_229_20)

				if var_229_22 > 0 and var_229_16 < var_229_22 then
					arg_226_1.talkMaxDuration = var_229_22

					if var_229_22 + var_229_15 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_22 + var_229_15
					end
				end

				arg_226_1.text_.text = var_229_19
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041053", "story_v_out_318041.awb") ~= 0 then
					local var_229_23 = manager.audio:GetVoiceLength("story_v_out_318041", "318041053", "story_v_out_318041.awb") / 1000

					if var_229_23 + var_229_15 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_23 + var_229_15
					end

					if var_229_18.prefab_name ~= "" and arg_226_1.actors_[var_229_18.prefab_name] ~= nil then
						local var_229_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_18.prefab_name].transform, "story_v_out_318041", "318041053", "story_v_out_318041.awb")

						arg_226_1:RecordAudio("318041053", var_229_24)
						arg_226_1:RecordAudio("318041053", var_229_24)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_318041", "318041053", "story_v_out_318041.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_318041", "318041053", "story_v_out_318041.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_25 = math.max(var_229_16, arg_226_1.talkMaxDuration)

			if var_229_15 <= arg_226_1.time_ and arg_226_1.time_ < var_229_15 + var_229_25 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_15) / var_229_25

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_15 + var_229_25 and arg_226_1.time_ < var_229_15 + var_229_25 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play318041054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 318041054
		arg_230_1.duration_ = 6.4

		local var_230_0 = {
			zh = 3.866,
			ja = 6.4
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play318041055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = "10066ui_story"

			if arg_230_1.actors_[var_233_0] == nil then
				local var_233_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_233_1) then
					local var_233_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_230_1.stage_.transform)

					var_233_2.name = var_233_0
					var_233_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_230_1.actors_[var_233_0] = var_233_2

					local var_233_3 = var_233_2:GetComponentInChildren(typeof(CharacterEffect))

					var_233_3.enabled = true

					local var_233_4 = GameObjectTools.GetOrAddComponent(var_233_2, typeof(DynamicBoneHelper))

					if var_233_4 then
						var_233_4:EnableDynamicBone(false)
					end

					arg_230_1:ShowWeapon(var_233_3.transform, false)

					arg_230_1.var_[var_233_0 .. "Animator"] = var_233_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_230_1.var_[var_233_0 .. "Animator"].applyRootMotion = true
					arg_230_1.var_[var_233_0 .. "LipSync"] = var_233_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_233_5 = arg_230_1.actors_["10066ui_story"].transform
			local var_233_6 = 0

			if var_233_6 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.var_.moveOldPos10066ui_story = var_233_5.localPosition
			end

			local var_233_7 = 0.001

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_7 then
				local var_233_8 = (arg_230_1.time_ - var_233_6) / var_233_7
				local var_233_9 = Vector3.New(0.7, -0.99, -5.83)

				var_233_5.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10066ui_story, var_233_9, var_233_8)

				local var_233_10 = manager.ui.mainCamera.transform.position - var_233_5.position

				var_233_5.forward = Vector3.New(var_233_10.x, var_233_10.y, var_233_10.z)

				local var_233_11 = var_233_5.localEulerAngles

				var_233_11.z = 0
				var_233_11.x = 0
				var_233_5.localEulerAngles = var_233_11
			end

			if arg_230_1.time_ >= var_233_6 + var_233_7 and arg_230_1.time_ < var_233_6 + var_233_7 + arg_233_0 then
				var_233_5.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_233_12 = manager.ui.mainCamera.transform.position - var_233_5.position

				var_233_5.forward = Vector3.New(var_233_12.x, var_233_12.y, var_233_12.z)

				local var_233_13 = var_233_5.localEulerAngles

				var_233_13.z = 0
				var_233_13.x = 0
				var_233_5.localEulerAngles = var_233_13
			end

			local var_233_14 = arg_230_1.actors_["10066ui_story"]
			local var_233_15 = 0

			if var_233_15 < arg_230_1.time_ and arg_230_1.time_ <= var_233_15 + arg_233_0 and not isNil(var_233_14) and arg_230_1.var_.characterEffect10066ui_story == nil then
				arg_230_1.var_.characterEffect10066ui_story = var_233_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_16 = 0.200000002980232

			if var_233_15 <= arg_230_1.time_ and arg_230_1.time_ < var_233_15 + var_233_16 and not isNil(var_233_14) then
				local var_233_17 = (arg_230_1.time_ - var_233_15) / var_233_16

				if arg_230_1.var_.characterEffect10066ui_story and not isNil(var_233_14) then
					arg_230_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_15 + var_233_16 and arg_230_1.time_ < var_233_15 + var_233_16 + arg_233_0 and not isNil(var_233_14) and arg_230_1.var_.characterEffect10066ui_story then
				arg_230_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_233_18 = 0

			if var_233_18 < arg_230_1.time_ and arg_230_1.time_ <= var_233_18 + arg_233_0 then
				arg_230_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_233_19 = 0

			if var_233_19 < arg_230_1.time_ and arg_230_1.time_ <= var_233_19 + arg_233_0 then
				arg_230_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_233_20 = arg_230_1.actors_["1050ui_story"].transform
			local var_233_21 = 0

			if var_233_21 < arg_230_1.time_ and arg_230_1.time_ <= var_233_21 + arg_233_0 then
				arg_230_1.var_.moveOldPos1050ui_story = var_233_20.localPosition
			end

			local var_233_22 = 0.001

			if var_233_21 <= arg_230_1.time_ and arg_230_1.time_ < var_233_21 + var_233_22 then
				local var_233_23 = (arg_230_1.time_ - var_233_21) / var_233_22
				local var_233_24 = Vector3.New(-0.7, -1, -6.1)

				var_233_20.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1050ui_story, var_233_24, var_233_23)

				local var_233_25 = manager.ui.mainCamera.transform.position - var_233_20.position

				var_233_20.forward = Vector3.New(var_233_25.x, var_233_25.y, var_233_25.z)

				local var_233_26 = var_233_20.localEulerAngles

				var_233_26.z = 0
				var_233_26.x = 0
				var_233_20.localEulerAngles = var_233_26
			end

			if arg_230_1.time_ >= var_233_21 + var_233_22 and arg_230_1.time_ < var_233_21 + var_233_22 + arg_233_0 then
				var_233_20.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_233_27 = manager.ui.mainCamera.transform.position - var_233_20.position

				var_233_20.forward = Vector3.New(var_233_27.x, var_233_27.y, var_233_27.z)

				local var_233_28 = var_233_20.localEulerAngles

				var_233_28.z = 0
				var_233_28.x = 0
				var_233_20.localEulerAngles = var_233_28
			end

			local var_233_29 = arg_230_1.actors_["1050ui_story"]
			local var_233_30 = 0

			if var_233_30 < arg_230_1.time_ and arg_230_1.time_ <= var_233_30 + arg_233_0 and not isNil(var_233_29) and arg_230_1.var_.characterEffect1050ui_story == nil then
				arg_230_1.var_.characterEffect1050ui_story = var_233_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_31 = 0.200000002980232

			if var_233_30 <= arg_230_1.time_ and arg_230_1.time_ < var_233_30 + var_233_31 and not isNil(var_233_29) then
				local var_233_32 = (arg_230_1.time_ - var_233_30) / var_233_31

				if arg_230_1.var_.characterEffect1050ui_story and not isNil(var_233_29) then
					local var_233_33 = Mathf.Lerp(0, 0.5, var_233_32)

					arg_230_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1050ui_story.fillRatio = var_233_33
				end
			end

			if arg_230_1.time_ >= var_233_30 + var_233_31 and arg_230_1.time_ < var_233_30 + var_233_31 + arg_233_0 and not isNil(var_233_29) and arg_230_1.var_.characterEffect1050ui_story then
				local var_233_34 = 0.5

				arg_230_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1050ui_story.fillRatio = var_233_34
			end

			local var_233_35 = 0
			local var_233_36 = 0.375

			if var_233_35 < arg_230_1.time_ and arg_230_1.time_ <= var_233_35 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_37 = arg_230_1:FormatText(StoryNameCfg[640].name)

				arg_230_1.leftNameTxt_.text = var_233_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_38 = arg_230_1:GetWordFromCfg(318041054)
				local var_233_39 = arg_230_1:FormatText(var_233_38.content)

				arg_230_1.text_.text = var_233_39

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_40 = 15
				local var_233_41 = utf8.len(var_233_39)
				local var_233_42 = var_233_40 <= 0 and var_233_36 or var_233_36 * (var_233_41 / var_233_40)

				if var_233_42 > 0 and var_233_36 < var_233_42 then
					arg_230_1.talkMaxDuration = var_233_42

					if var_233_42 + var_233_35 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_42 + var_233_35
					end
				end

				arg_230_1.text_.text = var_233_39
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041054", "story_v_out_318041.awb") ~= 0 then
					local var_233_43 = manager.audio:GetVoiceLength("story_v_out_318041", "318041054", "story_v_out_318041.awb") / 1000

					if var_233_43 + var_233_35 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_43 + var_233_35
					end

					if var_233_38.prefab_name ~= "" and arg_230_1.actors_[var_233_38.prefab_name] ~= nil then
						local var_233_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_38.prefab_name].transform, "story_v_out_318041", "318041054", "story_v_out_318041.awb")

						arg_230_1:RecordAudio("318041054", var_233_44)
						arg_230_1:RecordAudio("318041054", var_233_44)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_318041", "318041054", "story_v_out_318041.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_318041", "318041054", "story_v_out_318041.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_45 = math.max(var_233_36, arg_230_1.talkMaxDuration)

			if var_233_35 <= arg_230_1.time_ and arg_230_1.time_ < var_233_35 + var_233_45 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_35) / var_233_45

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_35 + var_233_45 and arg_230_1.time_ < var_233_35 + var_233_45 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play318041055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 318041055
		arg_234_1.duration_ = 7.27

		local var_234_0 = {
			zh = 5.2,
			ja = 7.266
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play318041056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10066ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect10066ui_story == nil then
				arg_234_1.var_.characterEffect10066ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect10066ui_story and not isNil(var_237_0) then
					arg_234_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect10066ui_story then
				arg_234_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_237_4 = 0

			if var_237_4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action436")
			end

			local var_237_5 = 0

			if var_237_5 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 then
				arg_234_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_237_6 = 0
			local var_237_7 = 0.575

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_8 = arg_234_1:FormatText(StoryNameCfg[640].name)

				arg_234_1.leftNameTxt_.text = var_237_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_9 = arg_234_1:GetWordFromCfg(318041055)
				local var_237_10 = arg_234_1:FormatText(var_237_9.content)

				arg_234_1.text_.text = var_237_10

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 23
				local var_237_12 = utf8.len(var_237_10)
				local var_237_13 = var_237_11 <= 0 and var_237_7 or var_237_7 * (var_237_12 / var_237_11)

				if var_237_13 > 0 and var_237_7 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_10
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041055", "story_v_out_318041.awb") ~= 0 then
					local var_237_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041055", "story_v_out_318041.awb") / 1000

					if var_237_14 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_14 + var_237_6
					end

					if var_237_9.prefab_name ~= "" and arg_234_1.actors_[var_237_9.prefab_name] ~= nil then
						local var_237_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_9.prefab_name].transform, "story_v_out_318041", "318041055", "story_v_out_318041.awb")

						arg_234_1:RecordAudio("318041055", var_237_15)
						arg_234_1:RecordAudio("318041055", var_237_15)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_318041", "318041055", "story_v_out_318041.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_318041", "318041055", "story_v_out_318041.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_16 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_16 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_16

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_16 and arg_234_1.time_ < var_237_6 + var_237_16 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play318041056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 318041056
		arg_238_1.duration_ = 6.13

		local var_238_0 = {
			zh = 6.133,
			ja = 5.2
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play318041057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1050ui_story"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1050ui_story == nil then
				arg_238_1.var_.characterEffect1050ui_story = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect1050ui_story and not isNil(var_241_0) then
					arg_238_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1050ui_story then
				arg_238_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_241_4 = 0

			if var_241_4 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_2")
			end

			local var_241_5 = 0

			if var_241_5 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_241_6 = arg_238_1.actors_["10066ui_story"]
			local var_241_7 = 0

			if var_241_7 < arg_238_1.time_ and arg_238_1.time_ <= var_241_7 + arg_241_0 and not isNil(var_241_6) and arg_238_1.var_.characterEffect10066ui_story == nil then
				arg_238_1.var_.characterEffect10066ui_story = var_241_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_8 = 0.200000002980232

			if var_241_7 <= arg_238_1.time_ and arg_238_1.time_ < var_241_7 + var_241_8 and not isNil(var_241_6) then
				local var_241_9 = (arg_238_1.time_ - var_241_7) / var_241_8

				if arg_238_1.var_.characterEffect10066ui_story and not isNil(var_241_6) then
					local var_241_10 = Mathf.Lerp(0, 0.5, var_241_9)

					arg_238_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_238_1.var_.characterEffect10066ui_story.fillRatio = var_241_10
				end
			end

			if arg_238_1.time_ >= var_241_7 + var_241_8 and arg_238_1.time_ < var_241_7 + var_241_8 + arg_241_0 and not isNil(var_241_6) and arg_238_1.var_.characterEffect10066ui_story then
				local var_241_11 = 0.5

				arg_238_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_238_1.var_.characterEffect10066ui_story.fillRatio = var_241_11
			end

			local var_241_12 = 0
			local var_241_13 = 0.675

			if var_241_12 < arg_238_1.time_ and arg_238_1.time_ <= var_241_12 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_14 = arg_238_1:FormatText(StoryNameCfg[74].name)

				arg_238_1.leftNameTxt_.text = var_241_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_15 = arg_238_1:GetWordFromCfg(318041056)
				local var_241_16 = arg_238_1:FormatText(var_241_15.content)

				arg_238_1.text_.text = var_241_16

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_17 = 27
				local var_241_18 = utf8.len(var_241_16)
				local var_241_19 = var_241_17 <= 0 and var_241_13 or var_241_13 * (var_241_18 / var_241_17)

				if var_241_19 > 0 and var_241_13 < var_241_19 then
					arg_238_1.talkMaxDuration = var_241_19

					if var_241_19 + var_241_12 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_19 + var_241_12
					end
				end

				arg_238_1.text_.text = var_241_16
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041056", "story_v_out_318041.awb") ~= 0 then
					local var_241_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041056", "story_v_out_318041.awb") / 1000

					if var_241_20 + var_241_12 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_20 + var_241_12
					end

					if var_241_15.prefab_name ~= "" and arg_238_1.actors_[var_241_15.prefab_name] ~= nil then
						local var_241_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_15.prefab_name].transform, "story_v_out_318041", "318041056", "story_v_out_318041.awb")

						arg_238_1:RecordAudio("318041056", var_241_21)
						arg_238_1:RecordAudio("318041056", var_241_21)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_318041", "318041056", "story_v_out_318041.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_318041", "318041056", "story_v_out_318041.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_22 = math.max(var_241_13, arg_238_1.talkMaxDuration)

			if var_241_12 <= arg_238_1.time_ and arg_238_1.time_ < var_241_12 + var_241_22 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_12) / var_241_22

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_12 + var_241_22 and arg_238_1.time_ < var_241_12 + var_241_22 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play318041057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 318041057
		arg_242_1.duration_ = 14.9

		local var_242_0 = {
			zh = 8.033,
			ja = 14.9
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play318041058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10066ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10066ui_story == nil then
				arg_242_1.var_.characterEffect10066ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect10066ui_story and not isNil(var_245_0) then
					arg_242_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10066ui_story then
				arg_242_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_245_4 = 0

			if var_245_4 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_245_5 = arg_242_1.actors_["1050ui_story"]
			local var_245_6 = 0

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 and not isNil(var_245_5) and arg_242_1.var_.characterEffect1050ui_story == nil then
				arg_242_1.var_.characterEffect1050ui_story = var_245_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_7 = 0.200000002980232

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_7 and not isNil(var_245_5) then
				local var_245_8 = (arg_242_1.time_ - var_245_6) / var_245_7

				if arg_242_1.var_.characterEffect1050ui_story and not isNil(var_245_5) then
					local var_245_9 = Mathf.Lerp(0, 0.5, var_245_8)

					arg_242_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1050ui_story.fillRatio = var_245_9
				end
			end

			if arg_242_1.time_ >= var_245_6 + var_245_7 and arg_242_1.time_ < var_245_6 + var_245_7 + arg_245_0 and not isNil(var_245_5) and arg_242_1.var_.characterEffect1050ui_story then
				local var_245_10 = 0.5

				arg_242_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1050ui_story.fillRatio = var_245_10
			end

			local var_245_11 = 0
			local var_245_12 = 0.7

			if var_245_11 < arg_242_1.time_ and arg_242_1.time_ <= var_245_11 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_13 = arg_242_1:FormatText(StoryNameCfg[640].name)

				arg_242_1.leftNameTxt_.text = var_245_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_14 = arg_242_1:GetWordFromCfg(318041057)
				local var_245_15 = arg_242_1:FormatText(var_245_14.content)

				arg_242_1.text_.text = var_245_15

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_16 = 28
				local var_245_17 = utf8.len(var_245_15)
				local var_245_18 = var_245_16 <= 0 and var_245_12 or var_245_12 * (var_245_17 / var_245_16)

				if var_245_18 > 0 and var_245_12 < var_245_18 then
					arg_242_1.talkMaxDuration = var_245_18

					if var_245_18 + var_245_11 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_18 + var_245_11
					end
				end

				arg_242_1.text_.text = var_245_15
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041057", "story_v_out_318041.awb") ~= 0 then
					local var_245_19 = manager.audio:GetVoiceLength("story_v_out_318041", "318041057", "story_v_out_318041.awb") / 1000

					if var_245_19 + var_245_11 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_19 + var_245_11
					end

					if var_245_14.prefab_name ~= "" and arg_242_1.actors_[var_245_14.prefab_name] ~= nil then
						local var_245_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_14.prefab_name].transform, "story_v_out_318041", "318041057", "story_v_out_318041.awb")

						arg_242_1:RecordAudio("318041057", var_245_20)
						arg_242_1:RecordAudio("318041057", var_245_20)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_318041", "318041057", "story_v_out_318041.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_318041", "318041057", "story_v_out_318041.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_21 = math.max(var_245_12, arg_242_1.talkMaxDuration)

			if var_245_11 <= arg_242_1.time_ and arg_242_1.time_ < var_245_11 + var_245_21 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_11) / var_245_21

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_11 + var_245_21 and arg_242_1.time_ < var_245_11 + var_245_21 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play318041058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 318041058
		arg_246_1.duration_ = 5.3

		local var_246_0 = {
			zh = 5.3,
			ja = 3.333
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play318041059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1050ui_story"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1050ui_story == nil then
				arg_246_1.var_.characterEffect1050ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.characterEffect1050ui_story and not isNil(var_249_0) then
					arg_246_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1050ui_story then
				arg_246_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_249_4 = arg_246_1.actors_["10066ui_story"]
			local var_249_5 = 0

			if var_249_5 < arg_246_1.time_ and arg_246_1.time_ <= var_249_5 + arg_249_0 and not isNil(var_249_4) and arg_246_1.var_.characterEffect10066ui_story == nil then
				arg_246_1.var_.characterEffect10066ui_story = var_249_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_6 = 0.200000002980232

			if var_249_5 <= arg_246_1.time_ and arg_246_1.time_ < var_249_5 + var_249_6 and not isNil(var_249_4) then
				local var_249_7 = (arg_246_1.time_ - var_249_5) / var_249_6

				if arg_246_1.var_.characterEffect10066ui_story and not isNil(var_249_4) then
					local var_249_8 = Mathf.Lerp(0, 0.5, var_249_7)

					arg_246_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_246_1.var_.characterEffect10066ui_story.fillRatio = var_249_8
				end
			end

			if arg_246_1.time_ >= var_249_5 + var_249_6 and arg_246_1.time_ < var_249_5 + var_249_6 + arg_249_0 and not isNil(var_249_4) and arg_246_1.var_.characterEffect10066ui_story then
				local var_249_9 = 0.5

				arg_246_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_246_1.var_.characterEffect10066ui_story.fillRatio = var_249_9
			end

			local var_249_10 = 0
			local var_249_11 = 0.55

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_12 = arg_246_1:FormatText(StoryNameCfg[74].name)

				arg_246_1.leftNameTxt_.text = var_249_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_13 = arg_246_1:GetWordFromCfg(318041058)
				local var_249_14 = arg_246_1:FormatText(var_249_13.content)

				arg_246_1.text_.text = var_249_14

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_15 = 22
				local var_249_16 = utf8.len(var_249_14)
				local var_249_17 = var_249_15 <= 0 and var_249_11 or var_249_11 * (var_249_16 / var_249_15)

				if var_249_17 > 0 and var_249_11 < var_249_17 then
					arg_246_1.talkMaxDuration = var_249_17

					if var_249_17 + var_249_10 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_17 + var_249_10
					end
				end

				arg_246_1.text_.text = var_249_14
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041058", "story_v_out_318041.awb") ~= 0 then
					local var_249_18 = manager.audio:GetVoiceLength("story_v_out_318041", "318041058", "story_v_out_318041.awb") / 1000

					if var_249_18 + var_249_10 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_18 + var_249_10
					end

					if var_249_13.prefab_name ~= "" and arg_246_1.actors_[var_249_13.prefab_name] ~= nil then
						local var_249_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_13.prefab_name].transform, "story_v_out_318041", "318041058", "story_v_out_318041.awb")

						arg_246_1:RecordAudio("318041058", var_249_19)
						arg_246_1:RecordAudio("318041058", var_249_19)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_318041", "318041058", "story_v_out_318041.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_318041", "318041058", "story_v_out_318041.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_20 = math.max(var_249_11, arg_246_1.talkMaxDuration)

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_20 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_10) / var_249_20

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_10 + var_249_20 and arg_246_1.time_ < var_249_10 + var_249_20 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play318041059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 318041059
		arg_250_1.duration_ = 8.8

		local var_250_0 = {
			zh = 8.8,
			ja = 8.5
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play318041060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10066ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect10066ui_story == nil then
				arg_250_1.var_.characterEffect10066ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect10066ui_story and not isNil(var_253_0) then
					arg_250_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect10066ui_story then
				arg_250_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_253_4 = 0

			if var_253_4 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_253_5 = 0

			if var_253_5 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_253_6 = arg_250_1.actors_["1050ui_story"]
			local var_253_7 = 0

			if var_253_7 < arg_250_1.time_ and arg_250_1.time_ <= var_253_7 + arg_253_0 and not isNil(var_253_6) and arg_250_1.var_.characterEffect1050ui_story == nil then
				arg_250_1.var_.characterEffect1050ui_story = var_253_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_8 = 0.200000002980232

			if var_253_7 <= arg_250_1.time_ and arg_250_1.time_ < var_253_7 + var_253_8 and not isNil(var_253_6) then
				local var_253_9 = (arg_250_1.time_ - var_253_7) / var_253_8

				if arg_250_1.var_.characterEffect1050ui_story and not isNil(var_253_6) then
					local var_253_10 = Mathf.Lerp(0, 0.5, var_253_9)

					arg_250_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1050ui_story.fillRatio = var_253_10
				end
			end

			if arg_250_1.time_ >= var_253_7 + var_253_8 and arg_250_1.time_ < var_253_7 + var_253_8 + arg_253_0 and not isNil(var_253_6) and arg_250_1.var_.characterEffect1050ui_story then
				local var_253_11 = 0.5

				arg_250_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1050ui_story.fillRatio = var_253_11
			end

			local var_253_12 = 0
			local var_253_13 = 0.975

			if var_253_12 < arg_250_1.time_ and arg_250_1.time_ <= var_253_12 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_14 = arg_250_1:FormatText(StoryNameCfg[640].name)

				arg_250_1.leftNameTxt_.text = var_253_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_15 = arg_250_1:GetWordFromCfg(318041059)
				local var_253_16 = arg_250_1:FormatText(var_253_15.content)

				arg_250_1.text_.text = var_253_16

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_17 = 39
				local var_253_18 = utf8.len(var_253_16)
				local var_253_19 = var_253_17 <= 0 and var_253_13 or var_253_13 * (var_253_18 / var_253_17)

				if var_253_19 > 0 and var_253_13 < var_253_19 then
					arg_250_1.talkMaxDuration = var_253_19

					if var_253_19 + var_253_12 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_19 + var_253_12
					end
				end

				arg_250_1.text_.text = var_253_16
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041059", "story_v_out_318041.awb") ~= 0 then
					local var_253_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041059", "story_v_out_318041.awb") / 1000

					if var_253_20 + var_253_12 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_20 + var_253_12
					end

					if var_253_15.prefab_name ~= "" and arg_250_1.actors_[var_253_15.prefab_name] ~= nil then
						local var_253_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_15.prefab_name].transform, "story_v_out_318041", "318041059", "story_v_out_318041.awb")

						arg_250_1:RecordAudio("318041059", var_253_21)
						arg_250_1:RecordAudio("318041059", var_253_21)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_318041", "318041059", "story_v_out_318041.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_318041", "318041059", "story_v_out_318041.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_22 = math.max(var_253_13, arg_250_1.talkMaxDuration)

			if var_253_12 <= arg_250_1.time_ and arg_250_1.time_ < var_253_12 + var_253_22 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_12) / var_253_22

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_12 + var_253_22 and arg_250_1.time_ < var_253_12 + var_253_22 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play318041060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 318041060
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play318041061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["10066ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect10066ui_story == nil then
				arg_254_1.var_.characterEffect10066ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect10066ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_254_1.var_.characterEffect10066ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect10066ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_254_1.var_.characterEffect10066ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0
			local var_257_7 = 1.025

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_8 = arg_254_1:GetWordFromCfg(318041060)
				local var_257_9 = arg_254_1:FormatText(var_257_8.content)

				arg_254_1.text_.text = var_257_9

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_10 = 41
				local var_257_11 = utf8.len(var_257_9)
				local var_257_12 = var_257_10 <= 0 and var_257_7 or var_257_7 * (var_257_11 / var_257_10)

				if var_257_12 > 0 and var_257_7 < var_257_12 then
					arg_254_1.talkMaxDuration = var_257_12

					if var_257_12 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_12 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_9
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_13 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_13 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_13

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_13 and arg_254_1.time_ < var_257_6 + var_257_13 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play318041061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 318041061
		arg_258_1.duration_ = 5.8

		local var_258_0 = {
			zh = 5.8,
			ja = 4.533
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play318041062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["10066ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect10066ui_story == nil then
				arg_258_1.var_.characterEffect10066ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect10066ui_story and not isNil(var_261_0) then
					arg_258_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect10066ui_story then
				arg_258_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_261_4 = 0

			if var_261_4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_261_5 = 0
			local var_261_6 = 0.675

			if var_261_5 < arg_258_1.time_ and arg_258_1.time_ <= var_261_5 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_7 = arg_258_1:FormatText(StoryNameCfg[640].name)

				arg_258_1.leftNameTxt_.text = var_261_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_8 = arg_258_1:GetWordFromCfg(318041061)
				local var_261_9 = arg_258_1:FormatText(var_261_8.content)

				arg_258_1.text_.text = var_261_9

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_10 = 27
				local var_261_11 = utf8.len(var_261_9)
				local var_261_12 = var_261_10 <= 0 and var_261_6 or var_261_6 * (var_261_11 / var_261_10)

				if var_261_12 > 0 and var_261_6 < var_261_12 then
					arg_258_1.talkMaxDuration = var_261_12

					if var_261_12 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_5
					end
				end

				arg_258_1.text_.text = var_261_9
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041061", "story_v_out_318041.awb") ~= 0 then
					local var_261_13 = manager.audio:GetVoiceLength("story_v_out_318041", "318041061", "story_v_out_318041.awb") / 1000

					if var_261_13 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_5
					end

					if var_261_8.prefab_name ~= "" and arg_258_1.actors_[var_261_8.prefab_name] ~= nil then
						local var_261_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_8.prefab_name].transform, "story_v_out_318041", "318041061", "story_v_out_318041.awb")

						arg_258_1:RecordAudio("318041061", var_261_14)
						arg_258_1:RecordAudio("318041061", var_261_14)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_318041", "318041061", "story_v_out_318041.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_318041", "318041061", "story_v_out_318041.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_15 = math.max(var_261_6, arg_258_1.talkMaxDuration)

			if var_261_5 <= arg_258_1.time_ and arg_258_1.time_ < var_261_5 + var_261_15 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_5) / var_261_15

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_5 + var_261_15 and arg_258_1.time_ < var_261_5 + var_261_15 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play318041062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 318041062
		arg_262_1.duration_ = 6.8

		local var_262_0 = {
			zh = 6.8,
			ja = 5.4
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play318041063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1050ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1050ui_story == nil then
				arg_262_1.var_.characterEffect1050ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1050ui_story and not isNil(var_265_0) then
					arg_262_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1050ui_story then
				arg_262_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_265_4 = 0

			if var_265_4 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			local var_265_5 = 0

			if var_265_5 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 then
				arg_262_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_265_6 = arg_262_1.actors_["10066ui_story"]
			local var_265_7 = 0

			if var_265_7 < arg_262_1.time_ and arg_262_1.time_ <= var_265_7 + arg_265_0 and not isNil(var_265_6) and arg_262_1.var_.characterEffect10066ui_story == nil then
				arg_262_1.var_.characterEffect10066ui_story = var_265_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_8 = 0.200000002980232

			if var_265_7 <= arg_262_1.time_ and arg_262_1.time_ < var_265_7 + var_265_8 and not isNil(var_265_6) then
				local var_265_9 = (arg_262_1.time_ - var_265_7) / var_265_8

				if arg_262_1.var_.characterEffect10066ui_story and not isNil(var_265_6) then
					local var_265_10 = Mathf.Lerp(0, 0.5, var_265_9)

					arg_262_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_262_1.var_.characterEffect10066ui_story.fillRatio = var_265_10
				end
			end

			if arg_262_1.time_ >= var_265_7 + var_265_8 and arg_262_1.time_ < var_265_7 + var_265_8 + arg_265_0 and not isNil(var_265_6) and arg_262_1.var_.characterEffect10066ui_story then
				local var_265_11 = 0.5

				arg_262_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_262_1.var_.characterEffect10066ui_story.fillRatio = var_265_11
			end

			local var_265_12 = 0
			local var_265_13 = 0.6

			if var_265_12 < arg_262_1.time_ and arg_262_1.time_ <= var_265_12 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_14 = arg_262_1:FormatText(StoryNameCfg[74].name)

				arg_262_1.leftNameTxt_.text = var_265_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_15 = arg_262_1:GetWordFromCfg(318041062)
				local var_265_16 = arg_262_1:FormatText(var_265_15.content)

				arg_262_1.text_.text = var_265_16

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_17 = 24
				local var_265_18 = utf8.len(var_265_16)
				local var_265_19 = var_265_17 <= 0 and var_265_13 or var_265_13 * (var_265_18 / var_265_17)

				if var_265_19 > 0 and var_265_13 < var_265_19 then
					arg_262_1.talkMaxDuration = var_265_19

					if var_265_19 + var_265_12 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_19 + var_265_12
					end
				end

				arg_262_1.text_.text = var_265_16
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041062", "story_v_out_318041.awb") ~= 0 then
					local var_265_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041062", "story_v_out_318041.awb") / 1000

					if var_265_20 + var_265_12 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_20 + var_265_12
					end

					if var_265_15.prefab_name ~= "" and arg_262_1.actors_[var_265_15.prefab_name] ~= nil then
						local var_265_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_15.prefab_name].transform, "story_v_out_318041", "318041062", "story_v_out_318041.awb")

						arg_262_1:RecordAudio("318041062", var_265_21)
						arg_262_1:RecordAudio("318041062", var_265_21)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_318041", "318041062", "story_v_out_318041.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_318041", "318041062", "story_v_out_318041.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_22 = math.max(var_265_13, arg_262_1.talkMaxDuration)

			if var_265_12 <= arg_262_1.time_ and arg_262_1.time_ < var_265_12 + var_265_22 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_12) / var_265_22

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_12 + var_265_22 and arg_262_1.time_ < var_265_12 + var_265_22 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play318041063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 318041063
		arg_266_1.duration_ = 4.83

		local var_266_0 = {
			zh = 4.833,
			ja = 3.8
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play318041064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10066ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos10066ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0.7, -0.99, -5.83)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10066ui_story, var_269_4, var_269_3)

				local var_269_5 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_5.x, var_269_5.y, var_269_5.z)

				local var_269_6 = var_269_0.localEulerAngles

				var_269_6.z = 0
				var_269_6.x = 0
				var_269_0.localEulerAngles = var_269_6
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_269_7 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_7.x, var_269_7.y, var_269_7.z)

				local var_269_8 = var_269_0.localEulerAngles

				var_269_8.z = 0
				var_269_8.x = 0
				var_269_0.localEulerAngles = var_269_8
			end

			local var_269_9 = arg_266_1.actors_["10066ui_story"]
			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect10066ui_story == nil then
				arg_266_1.var_.characterEffect10066ui_story = var_269_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_11 = 0.200000002980232

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_11 and not isNil(var_269_9) then
				local var_269_12 = (arg_266_1.time_ - var_269_10) / var_269_11

				if arg_266_1.var_.characterEffect10066ui_story and not isNil(var_269_9) then
					arg_266_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect10066ui_story then
				arg_266_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_269_13 = 0

			if var_269_13 < arg_266_1.time_ and arg_266_1.time_ <= var_269_13 + arg_269_0 then
				arg_266_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_269_14 = 0

			if var_269_14 < arg_266_1.time_ and arg_266_1.time_ <= var_269_14 + arg_269_0 then
				arg_266_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_269_15 = arg_266_1.actors_["1050ui_story"]
			local var_269_16 = 0

			if var_269_16 < arg_266_1.time_ and arg_266_1.time_ <= var_269_16 + arg_269_0 and not isNil(var_269_15) and arg_266_1.var_.characterEffect1050ui_story == nil then
				arg_266_1.var_.characterEffect1050ui_story = var_269_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_17 = 0.200000002980232

			if var_269_16 <= arg_266_1.time_ and arg_266_1.time_ < var_269_16 + var_269_17 and not isNil(var_269_15) then
				local var_269_18 = (arg_266_1.time_ - var_269_16) / var_269_17

				if arg_266_1.var_.characterEffect1050ui_story and not isNil(var_269_15) then
					local var_269_19 = Mathf.Lerp(0, 0.5, var_269_18)

					arg_266_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1050ui_story.fillRatio = var_269_19
				end
			end

			if arg_266_1.time_ >= var_269_16 + var_269_17 and arg_266_1.time_ < var_269_16 + var_269_17 + arg_269_0 and not isNil(var_269_15) and arg_266_1.var_.characterEffect1050ui_story then
				local var_269_20 = 0.5

				arg_266_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1050ui_story.fillRatio = var_269_20
			end

			local var_269_21 = 0
			local var_269_22 = 0.3

			if var_269_21 < arg_266_1.time_ and arg_266_1.time_ <= var_269_21 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_23 = arg_266_1:FormatText(StoryNameCfg[640].name)

				arg_266_1.leftNameTxt_.text = var_269_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_24 = arg_266_1:GetWordFromCfg(318041063)
				local var_269_25 = arg_266_1:FormatText(var_269_24.content)

				arg_266_1.text_.text = var_269_25

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_26 = 12
				local var_269_27 = utf8.len(var_269_25)
				local var_269_28 = var_269_26 <= 0 and var_269_22 or var_269_22 * (var_269_27 / var_269_26)

				if var_269_28 > 0 and var_269_22 < var_269_28 then
					arg_266_1.talkMaxDuration = var_269_28

					if var_269_28 + var_269_21 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_28 + var_269_21
					end
				end

				arg_266_1.text_.text = var_269_25
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041063", "story_v_out_318041.awb") ~= 0 then
					local var_269_29 = manager.audio:GetVoiceLength("story_v_out_318041", "318041063", "story_v_out_318041.awb") / 1000

					if var_269_29 + var_269_21 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_29 + var_269_21
					end

					if var_269_24.prefab_name ~= "" and arg_266_1.actors_[var_269_24.prefab_name] ~= nil then
						local var_269_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_24.prefab_name].transform, "story_v_out_318041", "318041063", "story_v_out_318041.awb")

						arg_266_1:RecordAudio("318041063", var_269_30)
						arg_266_1:RecordAudio("318041063", var_269_30)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_318041", "318041063", "story_v_out_318041.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_318041", "318041063", "story_v_out_318041.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_31 = math.max(var_269_22, arg_266_1.talkMaxDuration)

			if var_269_21 <= arg_266_1.time_ and arg_266_1.time_ < var_269_21 + var_269_31 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_21) / var_269_31

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_21 + var_269_31 and arg_266_1.time_ < var_269_21 + var_269_31 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play318041064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 318041064
		arg_270_1.duration_ = 7.13

		local var_270_0 = {
			zh = 3,
			ja = 7.133
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play318041065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1050ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1050ui_story == nil then
				arg_270_1.var_.characterEffect1050ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1050ui_story and not isNil(var_273_0) then
					arg_270_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1050ui_story then
				arg_270_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_273_4 = arg_270_1.actors_["10066ui_story"]
			local var_273_5 = 0

			if var_273_5 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 and not isNil(var_273_4) and arg_270_1.var_.characterEffect10066ui_story == nil then
				arg_270_1.var_.characterEffect10066ui_story = var_273_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_6 = 0.200000002980232

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_6 and not isNil(var_273_4) then
				local var_273_7 = (arg_270_1.time_ - var_273_5) / var_273_6

				if arg_270_1.var_.characterEffect10066ui_story and not isNil(var_273_4) then
					local var_273_8 = Mathf.Lerp(0, 0.5, var_273_7)

					arg_270_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_270_1.var_.characterEffect10066ui_story.fillRatio = var_273_8
				end
			end

			if arg_270_1.time_ >= var_273_5 + var_273_6 and arg_270_1.time_ < var_273_5 + var_273_6 + arg_273_0 and not isNil(var_273_4) and arg_270_1.var_.characterEffect10066ui_story then
				local var_273_9 = 0.5

				arg_270_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_270_1.var_.characterEffect10066ui_story.fillRatio = var_273_9
			end

			local var_273_10 = 0
			local var_273_11 = 0.375

			if var_273_10 < arg_270_1.time_ and arg_270_1.time_ <= var_273_10 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_12 = arg_270_1:FormatText(StoryNameCfg[74].name)

				arg_270_1.leftNameTxt_.text = var_273_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_13 = arg_270_1:GetWordFromCfg(318041064)
				local var_273_14 = arg_270_1:FormatText(var_273_13.content)

				arg_270_1.text_.text = var_273_14

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_15 = 15
				local var_273_16 = utf8.len(var_273_14)
				local var_273_17 = var_273_15 <= 0 and var_273_11 or var_273_11 * (var_273_16 / var_273_15)

				if var_273_17 > 0 and var_273_11 < var_273_17 then
					arg_270_1.talkMaxDuration = var_273_17

					if var_273_17 + var_273_10 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_17 + var_273_10
					end
				end

				arg_270_1.text_.text = var_273_14
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041064", "story_v_out_318041.awb") ~= 0 then
					local var_273_18 = manager.audio:GetVoiceLength("story_v_out_318041", "318041064", "story_v_out_318041.awb") / 1000

					if var_273_18 + var_273_10 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_18 + var_273_10
					end

					if var_273_13.prefab_name ~= "" and arg_270_1.actors_[var_273_13.prefab_name] ~= nil then
						local var_273_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_13.prefab_name].transform, "story_v_out_318041", "318041064", "story_v_out_318041.awb")

						arg_270_1:RecordAudio("318041064", var_273_19)
						arg_270_1:RecordAudio("318041064", var_273_19)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_318041", "318041064", "story_v_out_318041.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_318041", "318041064", "story_v_out_318041.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_20 = math.max(var_273_11, arg_270_1.talkMaxDuration)

			if var_273_10 <= arg_270_1.time_ and arg_270_1.time_ < var_273_10 + var_273_20 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_10) / var_273_20

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_10 + var_273_20 and arg_270_1.time_ < var_273_10 + var_273_20 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play318041065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 318041065
		arg_274_1.duration_ = 6.33

		local var_274_0 = {
			zh = 4.1,
			ja = 6.333
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play318041066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["10066ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect10066ui_story == nil then
				arg_274_1.var_.characterEffect10066ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect10066ui_story and not isNil(var_277_0) then
					arg_274_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect10066ui_story then
				arg_274_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_277_4 = 0

			if var_277_4 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			local var_277_5 = 0

			if var_277_5 < arg_274_1.time_ and arg_274_1.time_ <= var_277_5 + arg_277_0 then
				arg_274_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_277_6 = arg_274_1.actors_["1050ui_story"]
			local var_277_7 = 0

			if var_277_7 < arg_274_1.time_ and arg_274_1.time_ <= var_277_7 + arg_277_0 and not isNil(var_277_6) and arg_274_1.var_.characterEffect1050ui_story == nil then
				arg_274_1.var_.characterEffect1050ui_story = var_277_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_8 = 0.200000002980232

			if var_277_7 <= arg_274_1.time_ and arg_274_1.time_ < var_277_7 + var_277_8 and not isNil(var_277_6) then
				local var_277_9 = (arg_274_1.time_ - var_277_7) / var_277_8

				if arg_274_1.var_.characterEffect1050ui_story and not isNil(var_277_6) then
					local var_277_10 = Mathf.Lerp(0, 0.5, var_277_9)

					arg_274_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1050ui_story.fillRatio = var_277_10
				end
			end

			if arg_274_1.time_ >= var_277_7 + var_277_8 and arg_274_1.time_ < var_277_7 + var_277_8 + arg_277_0 and not isNil(var_277_6) and arg_274_1.var_.characterEffect1050ui_story then
				local var_277_11 = 0.5

				arg_274_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1050ui_story.fillRatio = var_277_11
			end

			local var_277_12 = 0
			local var_277_13 = 0.275

			if var_277_12 < arg_274_1.time_ and arg_274_1.time_ <= var_277_12 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_14 = arg_274_1:FormatText(StoryNameCfg[640].name)

				arg_274_1.leftNameTxt_.text = var_277_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_15 = arg_274_1:GetWordFromCfg(318041065)
				local var_277_16 = arg_274_1:FormatText(var_277_15.content)

				arg_274_1.text_.text = var_277_16

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_17 = 11
				local var_277_18 = utf8.len(var_277_16)
				local var_277_19 = var_277_17 <= 0 and var_277_13 or var_277_13 * (var_277_18 / var_277_17)

				if var_277_19 > 0 and var_277_13 < var_277_19 then
					arg_274_1.talkMaxDuration = var_277_19

					if var_277_19 + var_277_12 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_19 + var_277_12
					end
				end

				arg_274_1.text_.text = var_277_16
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041065", "story_v_out_318041.awb") ~= 0 then
					local var_277_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041065", "story_v_out_318041.awb") / 1000

					if var_277_20 + var_277_12 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_20 + var_277_12
					end

					if var_277_15.prefab_name ~= "" and arg_274_1.actors_[var_277_15.prefab_name] ~= nil then
						local var_277_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_15.prefab_name].transform, "story_v_out_318041", "318041065", "story_v_out_318041.awb")

						arg_274_1:RecordAudio("318041065", var_277_21)
						arg_274_1:RecordAudio("318041065", var_277_21)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_318041", "318041065", "story_v_out_318041.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_318041", "318041065", "story_v_out_318041.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_22 = math.max(var_277_13, arg_274_1.talkMaxDuration)

			if var_277_12 <= arg_274_1.time_ and arg_274_1.time_ < var_277_12 + var_277_22 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_12) / var_277_22

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_12 + var_277_22 and arg_274_1.time_ < var_277_12 + var_277_22 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play318041066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 318041066
		arg_278_1.duration_ = 5.83

		local var_278_0 = {
			zh = 5.833,
			ja = 4.866
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play318041067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1050ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1050ui_story == nil then
				arg_278_1.var_.characterEffect1050ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect1050ui_story and not isNil(var_281_0) then
					arg_278_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1050ui_story then
				arg_278_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_281_4 = 0

			if var_281_4 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action452")
			end

			local var_281_5 = 0

			if var_281_5 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_281_6 = arg_278_1.actors_["10066ui_story"]
			local var_281_7 = 0

			if var_281_7 < arg_278_1.time_ and arg_278_1.time_ <= var_281_7 + arg_281_0 and not isNil(var_281_6) and arg_278_1.var_.characterEffect10066ui_story == nil then
				arg_278_1.var_.characterEffect10066ui_story = var_281_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_8 = 0.200000002980232

			if var_281_7 <= arg_278_1.time_ and arg_278_1.time_ < var_281_7 + var_281_8 and not isNil(var_281_6) then
				local var_281_9 = (arg_278_1.time_ - var_281_7) / var_281_8

				if arg_278_1.var_.characterEffect10066ui_story and not isNil(var_281_6) then
					local var_281_10 = Mathf.Lerp(0, 0.5, var_281_9)

					arg_278_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_278_1.var_.characterEffect10066ui_story.fillRatio = var_281_10
				end
			end

			if arg_278_1.time_ >= var_281_7 + var_281_8 and arg_278_1.time_ < var_281_7 + var_281_8 + arg_281_0 and not isNil(var_281_6) and arg_278_1.var_.characterEffect10066ui_story then
				local var_281_11 = 0.5

				arg_278_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_278_1.var_.characterEffect10066ui_story.fillRatio = var_281_11
			end

			local var_281_12 = 0
			local var_281_13 = 0.45

			if var_281_12 < arg_278_1.time_ and arg_278_1.time_ <= var_281_12 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_14 = arg_278_1:FormatText(StoryNameCfg[74].name)

				arg_278_1.leftNameTxt_.text = var_281_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_15 = arg_278_1:GetWordFromCfg(318041066)
				local var_281_16 = arg_278_1:FormatText(var_281_15.content)

				arg_278_1.text_.text = var_281_16

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_17 = 18
				local var_281_18 = utf8.len(var_281_16)
				local var_281_19 = var_281_17 <= 0 and var_281_13 or var_281_13 * (var_281_18 / var_281_17)

				if var_281_19 > 0 and var_281_13 < var_281_19 then
					arg_278_1.talkMaxDuration = var_281_19

					if var_281_19 + var_281_12 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_19 + var_281_12
					end
				end

				arg_278_1.text_.text = var_281_16
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041066", "story_v_out_318041.awb") ~= 0 then
					local var_281_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041066", "story_v_out_318041.awb") / 1000

					if var_281_20 + var_281_12 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_20 + var_281_12
					end

					if var_281_15.prefab_name ~= "" and arg_278_1.actors_[var_281_15.prefab_name] ~= nil then
						local var_281_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_15.prefab_name].transform, "story_v_out_318041", "318041066", "story_v_out_318041.awb")

						arg_278_1:RecordAudio("318041066", var_281_21)
						arg_278_1:RecordAudio("318041066", var_281_21)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_318041", "318041066", "story_v_out_318041.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_318041", "318041066", "story_v_out_318041.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_22 = math.max(var_281_13, arg_278_1.talkMaxDuration)

			if var_281_12 <= arg_278_1.time_ and arg_278_1.time_ < var_281_12 + var_281_22 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_12) / var_281_22

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_12 + var_281_22 and arg_278_1.time_ < var_281_12 + var_281_22 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play318041067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 318041067
		arg_282_1.duration_ = 5.8

		local var_282_0 = {
			zh = 5.8,
			ja = 3.3
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play318041068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10066ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect10066ui_story == nil then
				arg_282_1.var_.characterEffect10066ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect10066ui_story and not isNil(var_285_0) then
					arg_282_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect10066ui_story then
				arg_282_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_285_4 = 0

			if var_285_4 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action457")
			end

			local var_285_5 = 0

			if var_285_5 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_285_6 = arg_282_1.actors_["1050ui_story"]
			local var_285_7 = 0

			if var_285_7 < arg_282_1.time_ and arg_282_1.time_ <= var_285_7 + arg_285_0 and not isNil(var_285_6) and arg_282_1.var_.characterEffect1050ui_story == nil then
				arg_282_1.var_.characterEffect1050ui_story = var_285_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_8 = 0.200000002980232

			if var_285_7 <= arg_282_1.time_ and arg_282_1.time_ < var_285_7 + var_285_8 and not isNil(var_285_6) then
				local var_285_9 = (arg_282_1.time_ - var_285_7) / var_285_8

				if arg_282_1.var_.characterEffect1050ui_story and not isNil(var_285_6) then
					local var_285_10 = Mathf.Lerp(0, 0.5, var_285_9)

					arg_282_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1050ui_story.fillRatio = var_285_10
				end
			end

			if arg_282_1.time_ >= var_285_7 + var_285_8 and arg_282_1.time_ < var_285_7 + var_285_8 + arg_285_0 and not isNil(var_285_6) and arg_282_1.var_.characterEffect1050ui_story then
				local var_285_11 = 0.5

				arg_282_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1050ui_story.fillRatio = var_285_11
			end

			local var_285_12 = 0
			local var_285_13 = 0.5

			if var_285_12 < arg_282_1.time_ and arg_282_1.time_ <= var_285_12 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_14 = arg_282_1:FormatText(StoryNameCfg[640].name)

				arg_282_1.leftNameTxt_.text = var_285_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_15 = arg_282_1:GetWordFromCfg(318041067)
				local var_285_16 = arg_282_1:FormatText(var_285_15.content)

				arg_282_1.text_.text = var_285_16

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_17 = 20
				local var_285_18 = utf8.len(var_285_16)
				local var_285_19 = var_285_17 <= 0 and var_285_13 or var_285_13 * (var_285_18 / var_285_17)

				if var_285_19 > 0 and var_285_13 < var_285_19 then
					arg_282_1.talkMaxDuration = var_285_19

					if var_285_19 + var_285_12 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_19 + var_285_12
					end
				end

				arg_282_1.text_.text = var_285_16
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041067", "story_v_out_318041.awb") ~= 0 then
					local var_285_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041067", "story_v_out_318041.awb") / 1000

					if var_285_20 + var_285_12 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_20 + var_285_12
					end

					if var_285_15.prefab_name ~= "" and arg_282_1.actors_[var_285_15.prefab_name] ~= nil then
						local var_285_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_15.prefab_name].transform, "story_v_out_318041", "318041067", "story_v_out_318041.awb")

						arg_282_1:RecordAudio("318041067", var_285_21)
						arg_282_1:RecordAudio("318041067", var_285_21)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_318041", "318041067", "story_v_out_318041.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_318041", "318041067", "story_v_out_318041.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_22 = math.max(var_285_13, arg_282_1.talkMaxDuration)

			if var_285_12 <= arg_282_1.time_ and arg_282_1.time_ < var_285_12 + var_285_22 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_12) / var_285_22

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_12 + var_285_22 and arg_282_1.time_ < var_285_12 + var_285_22 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play318041068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 318041068
		arg_286_1.duration_ = 2.2

		local var_286_0 = {
			zh = 2.166,
			ja = 2.2
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play318041069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1050ui_story"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1050ui_story == nil then
				arg_286_1.var_.characterEffect1050ui_story = var_289_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.characterEffect1050ui_story and not isNil(var_289_0) then
					arg_286_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1050ui_story then
				arg_286_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_289_4 = arg_286_1.actors_["10066ui_story"]
			local var_289_5 = 0

			if var_289_5 < arg_286_1.time_ and arg_286_1.time_ <= var_289_5 + arg_289_0 and not isNil(var_289_4) and arg_286_1.var_.characterEffect10066ui_story == nil then
				arg_286_1.var_.characterEffect10066ui_story = var_289_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_6 = 0.200000002980232

			if var_289_5 <= arg_286_1.time_ and arg_286_1.time_ < var_289_5 + var_289_6 and not isNil(var_289_4) then
				local var_289_7 = (arg_286_1.time_ - var_289_5) / var_289_6

				if arg_286_1.var_.characterEffect10066ui_story and not isNil(var_289_4) then
					local var_289_8 = Mathf.Lerp(0, 0.5, var_289_7)

					arg_286_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_286_1.var_.characterEffect10066ui_story.fillRatio = var_289_8
				end
			end

			if arg_286_1.time_ >= var_289_5 + var_289_6 and arg_286_1.time_ < var_289_5 + var_289_6 + arg_289_0 and not isNil(var_289_4) and arg_286_1.var_.characterEffect10066ui_story then
				local var_289_9 = 0.5

				arg_286_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_286_1.var_.characterEffect10066ui_story.fillRatio = var_289_9
			end

			local var_289_10 = 0

			if var_289_10 < arg_286_1.time_ and arg_286_1.time_ <= var_289_10 + arg_289_0 then
				arg_286_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			local var_289_11 = 0

			if var_289_11 < arg_286_1.time_ and arg_286_1.time_ <= var_289_11 + arg_289_0 then
				arg_286_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_289_12 = 0
			local var_289_13 = 0.2

			if var_289_12 < arg_286_1.time_ and arg_286_1.time_ <= var_289_12 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_14 = arg_286_1:FormatText(StoryNameCfg[74].name)

				arg_286_1.leftNameTxt_.text = var_289_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_15 = arg_286_1:GetWordFromCfg(318041068)
				local var_289_16 = arg_286_1:FormatText(var_289_15.content)

				arg_286_1.text_.text = var_289_16

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_17 = 8
				local var_289_18 = utf8.len(var_289_16)
				local var_289_19 = var_289_17 <= 0 and var_289_13 or var_289_13 * (var_289_18 / var_289_17)

				if var_289_19 > 0 and var_289_13 < var_289_19 then
					arg_286_1.talkMaxDuration = var_289_19

					if var_289_19 + var_289_12 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_19 + var_289_12
					end
				end

				arg_286_1.text_.text = var_289_16
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041068", "story_v_out_318041.awb") ~= 0 then
					local var_289_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041068", "story_v_out_318041.awb") / 1000

					if var_289_20 + var_289_12 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_20 + var_289_12
					end

					if var_289_15.prefab_name ~= "" and arg_286_1.actors_[var_289_15.prefab_name] ~= nil then
						local var_289_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_15.prefab_name].transform, "story_v_out_318041", "318041068", "story_v_out_318041.awb")

						arg_286_1:RecordAudio("318041068", var_289_21)
						arg_286_1:RecordAudio("318041068", var_289_21)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_318041", "318041068", "story_v_out_318041.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_318041", "318041068", "story_v_out_318041.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_22 = math.max(var_289_13, arg_286_1.talkMaxDuration)

			if var_289_12 <= arg_286_1.time_ and arg_286_1.time_ < var_289_12 + var_289_22 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_12) / var_289_22

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_12 + var_289_22 and arg_286_1.time_ < var_289_12 + var_289_22 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play318041069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 318041069
		arg_290_1.duration_ = 9.67

		local var_290_0 = {
			zh = 3.3,
			ja = 9.666
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play318041070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["10066ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect10066ui_story == nil then
				arg_290_1.var_.characterEffect10066ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect10066ui_story and not isNil(var_293_0) then
					arg_290_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect10066ui_story then
				arg_290_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_293_4 = 0

			if var_293_4 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action474")
			end

			local var_293_5 = 0

			if var_293_5 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_293_6 = arg_290_1.actors_["1050ui_story"]
			local var_293_7 = 0

			if var_293_7 < arg_290_1.time_ and arg_290_1.time_ <= var_293_7 + arg_293_0 and not isNil(var_293_6) and arg_290_1.var_.characterEffect1050ui_story == nil then
				arg_290_1.var_.characterEffect1050ui_story = var_293_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_8 = 0.200000002980232

			if var_293_7 <= arg_290_1.time_ and arg_290_1.time_ < var_293_7 + var_293_8 and not isNil(var_293_6) then
				local var_293_9 = (arg_290_1.time_ - var_293_7) / var_293_8

				if arg_290_1.var_.characterEffect1050ui_story and not isNil(var_293_6) then
					local var_293_10 = Mathf.Lerp(0, 0.5, var_293_9)

					arg_290_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1050ui_story.fillRatio = var_293_10
				end
			end

			if arg_290_1.time_ >= var_293_7 + var_293_8 and arg_290_1.time_ < var_293_7 + var_293_8 + arg_293_0 and not isNil(var_293_6) and arg_290_1.var_.characterEffect1050ui_story then
				local var_293_11 = 0.5

				arg_290_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1050ui_story.fillRatio = var_293_11
			end

			local var_293_12 = 0
			local var_293_13 = 0.3

			if var_293_12 < arg_290_1.time_ and arg_290_1.time_ <= var_293_12 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_14 = arg_290_1:FormatText(StoryNameCfg[640].name)

				arg_290_1.leftNameTxt_.text = var_293_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_15 = arg_290_1:GetWordFromCfg(318041069)
				local var_293_16 = arg_290_1:FormatText(var_293_15.content)

				arg_290_1.text_.text = var_293_16

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_17 = 12
				local var_293_18 = utf8.len(var_293_16)
				local var_293_19 = var_293_17 <= 0 and var_293_13 or var_293_13 * (var_293_18 / var_293_17)

				if var_293_19 > 0 and var_293_13 < var_293_19 then
					arg_290_1.talkMaxDuration = var_293_19

					if var_293_19 + var_293_12 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_19 + var_293_12
					end
				end

				arg_290_1.text_.text = var_293_16
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041069", "story_v_out_318041.awb") ~= 0 then
					local var_293_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041069", "story_v_out_318041.awb") / 1000

					if var_293_20 + var_293_12 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_20 + var_293_12
					end

					if var_293_15.prefab_name ~= "" and arg_290_1.actors_[var_293_15.prefab_name] ~= nil then
						local var_293_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_15.prefab_name].transform, "story_v_out_318041", "318041069", "story_v_out_318041.awb")

						arg_290_1:RecordAudio("318041069", var_293_21)
						arg_290_1:RecordAudio("318041069", var_293_21)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_318041", "318041069", "story_v_out_318041.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_318041", "318041069", "story_v_out_318041.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_22 = math.max(var_293_13, arg_290_1.talkMaxDuration)

			if var_293_12 <= arg_290_1.time_ and arg_290_1.time_ < var_293_12 + var_293_22 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_12) / var_293_22

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_12 + var_293_22 and arg_290_1.time_ < var_293_12 + var_293_22 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play318041070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 318041070
		arg_294_1.duration_ = 2

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play318041071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1050ui_story"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1050ui_story == nil then
				arg_294_1.var_.characterEffect1050ui_story = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect1050ui_story and not isNil(var_297_0) then
					arg_294_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1050ui_story then
				arg_294_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_297_4 = 0

			if var_297_4 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action2_2")
			end

			local var_297_5 = 0

			if var_297_5 < arg_294_1.time_ and arg_294_1.time_ <= var_297_5 + arg_297_0 then
				arg_294_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_297_6 = arg_294_1.actors_["10066ui_story"]
			local var_297_7 = 0

			if var_297_7 < arg_294_1.time_ and arg_294_1.time_ <= var_297_7 + arg_297_0 and not isNil(var_297_6) and arg_294_1.var_.characterEffect10066ui_story == nil then
				arg_294_1.var_.characterEffect10066ui_story = var_297_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_8 = 0.200000002980232

			if var_297_7 <= arg_294_1.time_ and arg_294_1.time_ < var_297_7 + var_297_8 and not isNil(var_297_6) then
				local var_297_9 = (arg_294_1.time_ - var_297_7) / var_297_8

				if arg_294_1.var_.characterEffect10066ui_story and not isNil(var_297_6) then
					local var_297_10 = Mathf.Lerp(0, 0.5, var_297_9)

					arg_294_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_294_1.var_.characterEffect10066ui_story.fillRatio = var_297_10
				end
			end

			if arg_294_1.time_ >= var_297_7 + var_297_8 and arg_294_1.time_ < var_297_7 + var_297_8 + arg_297_0 and not isNil(var_297_6) and arg_294_1.var_.characterEffect10066ui_story then
				local var_297_11 = 0.5

				arg_294_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_294_1.var_.characterEffect10066ui_story.fillRatio = var_297_11
			end

			local var_297_12 = 0
			local var_297_13 = 0.1

			if var_297_12 < arg_294_1.time_ and arg_294_1.time_ <= var_297_12 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_14 = arg_294_1:FormatText(StoryNameCfg[74].name)

				arg_294_1.leftNameTxt_.text = var_297_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_15 = arg_294_1:GetWordFromCfg(318041070)
				local var_297_16 = arg_294_1:FormatText(var_297_15.content)

				arg_294_1.text_.text = var_297_16

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_17 = 4
				local var_297_18 = utf8.len(var_297_16)
				local var_297_19 = var_297_17 <= 0 and var_297_13 or var_297_13 * (var_297_18 / var_297_17)

				if var_297_19 > 0 and var_297_13 < var_297_19 then
					arg_294_1.talkMaxDuration = var_297_19

					if var_297_19 + var_297_12 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_19 + var_297_12
					end
				end

				arg_294_1.text_.text = var_297_16
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041070", "story_v_out_318041.awb") ~= 0 then
					local var_297_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041070", "story_v_out_318041.awb") / 1000

					if var_297_20 + var_297_12 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_20 + var_297_12
					end

					if var_297_15.prefab_name ~= "" and arg_294_1.actors_[var_297_15.prefab_name] ~= nil then
						local var_297_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_15.prefab_name].transform, "story_v_out_318041", "318041070", "story_v_out_318041.awb")

						arg_294_1:RecordAudio("318041070", var_297_21)
						arg_294_1:RecordAudio("318041070", var_297_21)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_318041", "318041070", "story_v_out_318041.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_318041", "318041070", "story_v_out_318041.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_22 = math.max(var_297_13, arg_294_1.talkMaxDuration)

			if var_297_12 <= arg_294_1.time_ and arg_294_1.time_ < var_297_12 + var_297_22 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_12) / var_297_22

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_12 + var_297_22 and arg_294_1.time_ < var_297_12 + var_297_22 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play318041071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 318041071
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play318041072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["10066ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos10066ui_story = var_301_0.localPosition
			end

			local var_301_2 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2
				local var_301_4 = Vector3.New(0, 100, 0)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10066ui_story, var_301_4, var_301_3)

				local var_301_5 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_5.x, var_301_5.y, var_301_5.z)

				local var_301_6 = var_301_0.localEulerAngles

				var_301_6.z = 0
				var_301_6.x = 0
				var_301_0.localEulerAngles = var_301_6
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(0, 100, 0)

				local var_301_7 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_7.x, var_301_7.y, var_301_7.z)

				local var_301_8 = var_301_0.localEulerAngles

				var_301_8.z = 0
				var_301_8.x = 0
				var_301_0.localEulerAngles = var_301_8
			end

			local var_301_9 = arg_298_1.actors_["10066ui_story"]
			local var_301_10 = 0

			if var_301_10 < arg_298_1.time_ and arg_298_1.time_ <= var_301_10 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect10066ui_story == nil then
				arg_298_1.var_.characterEffect10066ui_story = var_301_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_11 = 0.200000002980232

			if var_301_10 <= arg_298_1.time_ and arg_298_1.time_ < var_301_10 + var_301_11 and not isNil(var_301_9) then
				local var_301_12 = (arg_298_1.time_ - var_301_10) / var_301_11

				if arg_298_1.var_.characterEffect10066ui_story and not isNil(var_301_9) then
					local var_301_13 = Mathf.Lerp(0, 0.5, var_301_12)

					arg_298_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_298_1.var_.characterEffect10066ui_story.fillRatio = var_301_13
				end
			end

			if arg_298_1.time_ >= var_301_10 + var_301_11 and arg_298_1.time_ < var_301_10 + var_301_11 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect10066ui_story then
				local var_301_14 = 0.5

				arg_298_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_298_1.var_.characterEffect10066ui_story.fillRatio = var_301_14
			end

			local var_301_15 = arg_298_1.actors_["1050ui_story"].transform
			local var_301_16 = 0

			if var_301_16 < arg_298_1.time_ and arg_298_1.time_ <= var_301_16 + arg_301_0 then
				arg_298_1.var_.moveOldPos1050ui_story = var_301_15.localPosition
			end

			local var_301_17 = 0.001

			if var_301_16 <= arg_298_1.time_ and arg_298_1.time_ < var_301_16 + var_301_17 then
				local var_301_18 = (arg_298_1.time_ - var_301_16) / var_301_17
				local var_301_19 = Vector3.New(0, -1, -6.1)

				var_301_15.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1050ui_story, var_301_19, var_301_18)

				local var_301_20 = manager.ui.mainCamera.transform.position - var_301_15.position

				var_301_15.forward = Vector3.New(var_301_20.x, var_301_20.y, var_301_20.z)

				local var_301_21 = var_301_15.localEulerAngles

				var_301_21.z = 0
				var_301_21.x = 0
				var_301_15.localEulerAngles = var_301_21
			end

			if arg_298_1.time_ >= var_301_16 + var_301_17 and arg_298_1.time_ < var_301_16 + var_301_17 + arg_301_0 then
				var_301_15.localPosition = Vector3.New(0, -1, -6.1)

				local var_301_22 = manager.ui.mainCamera.transform.position - var_301_15.position

				var_301_15.forward = Vector3.New(var_301_22.x, var_301_22.y, var_301_22.z)

				local var_301_23 = var_301_15.localEulerAngles

				var_301_23.z = 0
				var_301_23.x = 0
				var_301_15.localEulerAngles = var_301_23
			end

			local var_301_24 = arg_298_1.actors_["1050ui_story"]
			local var_301_25 = 0

			if var_301_25 < arg_298_1.time_ and arg_298_1.time_ <= var_301_25 + arg_301_0 and not isNil(var_301_24) and arg_298_1.var_.characterEffect1050ui_story == nil then
				arg_298_1.var_.characterEffect1050ui_story = var_301_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_26 = 0.200000002980232

			if var_301_25 <= arg_298_1.time_ and arg_298_1.time_ < var_301_25 + var_301_26 and not isNil(var_301_24) then
				local var_301_27 = (arg_298_1.time_ - var_301_25) / var_301_26

				if arg_298_1.var_.characterEffect1050ui_story and not isNil(var_301_24) then
					local var_301_28 = Mathf.Lerp(0, 0.5, var_301_27)

					arg_298_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1050ui_story.fillRatio = var_301_28
				end
			end

			if arg_298_1.time_ >= var_301_25 + var_301_26 and arg_298_1.time_ < var_301_25 + var_301_26 + arg_301_0 and not isNil(var_301_24) and arg_298_1.var_.characterEffect1050ui_story then
				local var_301_29 = 0.5

				arg_298_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1050ui_story.fillRatio = var_301_29
			end

			local var_301_30 = 0
			local var_301_31 = 0.725

			if var_301_30 < arg_298_1.time_ and arg_298_1.time_ <= var_301_30 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_32 = arg_298_1:GetWordFromCfg(318041071)
				local var_301_33 = arg_298_1:FormatText(var_301_32.content)

				arg_298_1.text_.text = var_301_33

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_34 = 29
				local var_301_35 = utf8.len(var_301_33)
				local var_301_36 = var_301_34 <= 0 and var_301_31 or var_301_31 * (var_301_35 / var_301_34)

				if var_301_36 > 0 and var_301_31 < var_301_36 then
					arg_298_1.talkMaxDuration = var_301_36

					if var_301_36 + var_301_30 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_36 + var_301_30
					end
				end

				arg_298_1.text_.text = var_301_33
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_37 = math.max(var_301_31, arg_298_1.talkMaxDuration)

			if var_301_30 <= arg_298_1.time_ and arg_298_1.time_ < var_301_30 + var_301_37 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_30) / var_301_37

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_30 + var_301_37 and arg_298_1.time_ < var_301_30 + var_301_37 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play318041072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 318041072
		arg_302_1.duration_ = 3.63

		local var_302_0 = {
			zh = 3.1,
			ja = 3.633
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play318041073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1050ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1050ui_story == nil then
				arg_302_1.var_.characterEffect1050ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect1050ui_story and not isNil(var_305_0) then
					arg_302_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1050ui_story then
				arg_302_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_305_4 = 0

			if var_305_4 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_305_5 = 0

			if var_305_5 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_305_6 = 0
			local var_305_7 = 0.35

			if var_305_6 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_8 = arg_302_1:FormatText(StoryNameCfg[74].name)

				arg_302_1.leftNameTxt_.text = var_305_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_9 = arg_302_1:GetWordFromCfg(318041072)
				local var_305_10 = arg_302_1:FormatText(var_305_9.content)

				arg_302_1.text_.text = var_305_10

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_11 = 14
				local var_305_12 = utf8.len(var_305_10)
				local var_305_13 = var_305_11 <= 0 and var_305_7 or var_305_7 * (var_305_12 / var_305_11)

				if var_305_13 > 0 and var_305_7 < var_305_13 then
					arg_302_1.talkMaxDuration = var_305_13

					if var_305_13 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_6
					end
				end

				arg_302_1.text_.text = var_305_10
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041072", "story_v_out_318041.awb") ~= 0 then
					local var_305_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041072", "story_v_out_318041.awb") / 1000

					if var_305_14 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_14 + var_305_6
					end

					if var_305_9.prefab_name ~= "" and arg_302_1.actors_[var_305_9.prefab_name] ~= nil then
						local var_305_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_9.prefab_name].transform, "story_v_out_318041", "318041072", "story_v_out_318041.awb")

						arg_302_1:RecordAudio("318041072", var_305_15)
						arg_302_1:RecordAudio("318041072", var_305_15)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_318041", "318041072", "story_v_out_318041.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_318041", "318041072", "story_v_out_318041.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_16 = math.max(var_305_7, arg_302_1.talkMaxDuration)

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_16 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_6) / var_305_16

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_6 + var_305_16 and arg_302_1.time_ < var_305_6 + var_305_16 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play318041073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 318041073
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play318041074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1050ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1050ui_story == nil then
				arg_306_1.var_.characterEffect1050ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect1050ui_story and not isNil(var_309_0) then
					local var_309_4 = Mathf.Lerp(0, 0.5, var_309_3)

					arg_306_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1050ui_story.fillRatio = var_309_4
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1050ui_story then
				local var_309_5 = 0.5

				arg_306_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1050ui_story.fillRatio = var_309_5
			end

			local var_309_6 = arg_306_1.actors_["1050ui_story"].transform
			local var_309_7 = 0

			if var_309_7 < arg_306_1.time_ and arg_306_1.time_ <= var_309_7 + arg_309_0 then
				arg_306_1.var_.moveOldPos1050ui_story = var_309_6.localPosition
			end

			local var_309_8 = 0.001

			if var_309_7 <= arg_306_1.time_ and arg_306_1.time_ < var_309_7 + var_309_8 then
				local var_309_9 = (arg_306_1.time_ - var_309_7) / var_309_8
				local var_309_10 = Vector3.New(0, 100, 0)

				var_309_6.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1050ui_story, var_309_10, var_309_9)

				local var_309_11 = manager.ui.mainCamera.transform.position - var_309_6.position

				var_309_6.forward = Vector3.New(var_309_11.x, var_309_11.y, var_309_11.z)

				local var_309_12 = var_309_6.localEulerAngles

				var_309_12.z = 0
				var_309_12.x = 0
				var_309_6.localEulerAngles = var_309_12
			end

			if arg_306_1.time_ >= var_309_7 + var_309_8 and arg_306_1.time_ < var_309_7 + var_309_8 + arg_309_0 then
				var_309_6.localPosition = Vector3.New(0, 100, 0)

				local var_309_13 = manager.ui.mainCamera.transform.position - var_309_6.position

				var_309_6.forward = Vector3.New(var_309_13.x, var_309_13.y, var_309_13.z)

				local var_309_14 = var_309_6.localEulerAngles

				var_309_14.z = 0
				var_309_14.x = 0
				var_309_6.localEulerAngles = var_309_14
			end

			local var_309_15 = 0
			local var_309_16 = 1.05

			if var_309_15 < arg_306_1.time_ and arg_306_1.time_ <= var_309_15 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_17 = arg_306_1:GetWordFromCfg(318041073)
				local var_309_18 = arg_306_1:FormatText(var_309_17.content)

				arg_306_1.text_.text = var_309_18

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_19 = 42
				local var_309_20 = utf8.len(var_309_18)
				local var_309_21 = var_309_19 <= 0 and var_309_16 or var_309_16 * (var_309_20 / var_309_19)

				if var_309_21 > 0 and var_309_16 < var_309_21 then
					arg_306_1.talkMaxDuration = var_309_21

					if var_309_21 + var_309_15 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_21 + var_309_15
					end
				end

				arg_306_1.text_.text = var_309_18
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_22 = math.max(var_309_16, arg_306_1.talkMaxDuration)

			if var_309_15 <= arg_306_1.time_ and arg_306_1.time_ < var_309_15 + var_309_22 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_15) / var_309_22

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_15 + var_309_22 and arg_306_1.time_ < var_309_15 + var_309_22 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play318041074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 318041074
		arg_310_1.duration_ = 5.8

		local var_310_0 = {
			zh = 5.8,
			ja = 5.6
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play318041075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 2

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				local var_313_1 = manager.ui.mainCamera.transform.localPosition
				local var_313_2 = Vector3.New(0, 0, 10) + Vector3.New(var_313_1.x, var_313_1.y, 0)
				local var_313_3 = arg_310_1.bgs_.ST69

				var_313_3.transform.localPosition = var_313_2
				var_313_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_313_4 = var_313_3:GetComponent("SpriteRenderer")

				if var_313_4 and var_313_4.sprite then
					local var_313_5 = (var_313_3.transform.localPosition - var_313_1).z
					local var_313_6 = manager.ui.mainCameraCom_
					local var_313_7 = 2 * var_313_5 * Mathf.Tan(var_313_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_313_8 = var_313_7 * var_313_6.aspect
					local var_313_9 = var_313_4.sprite.bounds.size.x
					local var_313_10 = var_313_4.sprite.bounds.size.y
					local var_313_11 = var_313_8 / var_313_9
					local var_313_12 = var_313_7 / var_313_10
					local var_313_13 = var_313_12 < var_313_11 and var_313_11 or var_313_12

					var_313_3.transform.localScale = Vector3.New(var_313_13, var_313_13, 0)
				end

				for iter_313_0, iter_313_1 in pairs(arg_310_1.bgs_) do
					if iter_313_0 ~= "ST69" then
						iter_313_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_313_14 = 0

			if var_313_14 < arg_310_1.time_ and arg_310_1.time_ <= var_313_14 + arg_313_0 then
				arg_310_1.mask_.enabled = true
				arg_310_1.mask_.raycastTarget = true

				arg_310_1:SetGaussion(false)
			end

			local var_313_15 = 2

			if var_313_14 <= arg_310_1.time_ and arg_310_1.time_ < var_313_14 + var_313_15 then
				local var_313_16 = (arg_310_1.time_ - var_313_14) / var_313_15
				local var_313_17 = Color.New(0, 0, 0)

				var_313_17.a = Mathf.Lerp(0, 1, var_313_16)
				arg_310_1.mask_.color = var_313_17
			end

			if arg_310_1.time_ >= var_313_14 + var_313_15 and arg_310_1.time_ < var_313_14 + var_313_15 + arg_313_0 then
				local var_313_18 = Color.New(0, 0, 0)

				var_313_18.a = 1
				arg_310_1.mask_.color = var_313_18
			end

			local var_313_19 = 2

			if var_313_19 < arg_310_1.time_ and arg_310_1.time_ <= var_313_19 + arg_313_0 then
				arg_310_1.mask_.enabled = true
				arg_310_1.mask_.raycastTarget = true

				arg_310_1:SetGaussion(false)
			end

			local var_313_20 = 2

			if var_313_19 <= arg_310_1.time_ and arg_310_1.time_ < var_313_19 + var_313_20 then
				local var_313_21 = (arg_310_1.time_ - var_313_19) / var_313_20
				local var_313_22 = Color.New(0, 0, 0)

				var_313_22.a = Mathf.Lerp(1, 0, var_313_21)
				arg_310_1.mask_.color = var_313_22
			end

			if arg_310_1.time_ >= var_313_19 + var_313_20 and arg_310_1.time_ < var_313_19 + var_313_20 + arg_313_0 then
				local var_313_23 = Color.New(0, 0, 0)
				local var_313_24 = 0

				arg_310_1.mask_.enabled = false
				var_313_23.a = var_313_24
				arg_310_1.mask_.color = var_313_23
			end

			local var_313_25 = arg_310_1.actors_["1050ui_story"].transform
			local var_313_26 = 2

			if var_313_26 < arg_310_1.time_ and arg_310_1.time_ <= var_313_26 + arg_313_0 then
				arg_310_1.var_.moveOldPos1050ui_story = var_313_25.localPosition
			end

			local var_313_27 = 0.001

			if var_313_26 <= arg_310_1.time_ and arg_310_1.time_ < var_313_26 + var_313_27 then
				local var_313_28 = (arg_310_1.time_ - var_313_26) / var_313_27
				local var_313_29 = Vector3.New(0, -1, -6.1)

				var_313_25.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1050ui_story, var_313_29, var_313_28)

				local var_313_30 = manager.ui.mainCamera.transform.position - var_313_25.position

				var_313_25.forward = Vector3.New(var_313_30.x, var_313_30.y, var_313_30.z)

				local var_313_31 = var_313_25.localEulerAngles

				var_313_31.z = 0
				var_313_31.x = 0
				var_313_25.localEulerAngles = var_313_31
			end

			if arg_310_1.time_ >= var_313_26 + var_313_27 and arg_310_1.time_ < var_313_26 + var_313_27 + arg_313_0 then
				var_313_25.localPosition = Vector3.New(0, -1, -6.1)

				local var_313_32 = manager.ui.mainCamera.transform.position - var_313_25.position

				var_313_25.forward = Vector3.New(var_313_32.x, var_313_32.y, var_313_32.z)

				local var_313_33 = var_313_25.localEulerAngles

				var_313_33.z = 0
				var_313_33.x = 0
				var_313_25.localEulerAngles = var_313_33
			end

			local var_313_34 = arg_310_1.actors_["1050ui_story"]
			local var_313_35 = 2

			if var_313_35 < arg_310_1.time_ and arg_310_1.time_ <= var_313_35 + arg_313_0 and not isNil(var_313_34) and arg_310_1.var_.characterEffect1050ui_story == nil then
				arg_310_1.var_.characterEffect1050ui_story = var_313_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_36 = 0.200000002980232

			if var_313_35 <= arg_310_1.time_ and arg_310_1.time_ < var_313_35 + var_313_36 and not isNil(var_313_34) then
				local var_313_37 = (arg_310_1.time_ - var_313_35) / var_313_36

				if arg_310_1.var_.characterEffect1050ui_story and not isNil(var_313_34) then
					arg_310_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_35 + var_313_36 and arg_310_1.time_ < var_313_35 + var_313_36 + arg_313_0 and not isNil(var_313_34) and arg_310_1.var_.characterEffect1050ui_story then
				arg_310_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_313_38 = 2

			if var_313_38 < arg_310_1.time_ and arg_310_1.time_ <= var_313_38 + arg_313_0 then
				arg_310_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_313_39 = 2

			if var_313_39 < arg_310_1.time_ and arg_310_1.time_ <= var_313_39 + arg_313_0 then
				arg_310_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_310_1.frameCnt_ <= 1 then
				arg_310_1.dialog_:SetActive(false)
			end

			local var_313_40 = 4
			local var_313_41 = 0.15

			if var_313_40 < arg_310_1.time_ and arg_310_1.time_ <= var_313_40 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0

				arg_310_1.dialog_:SetActive(true)

				arg_310_1.dialogCg_.alpha = 0

				local var_313_42 = LeanTween.value(arg_310_1.dialog_, 0, 1, 0.3)

				var_313_42:setOnUpdate(LuaHelper.FloatAction(function(arg_314_0)
					arg_310_1.dialogCg_.alpha = arg_314_0
				end))
				var_313_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_310_1.dialog_)
					var_313_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_310_1.duration_ = arg_310_1.duration_ + 0.3

				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_43 = arg_310_1:FormatText(StoryNameCfg[74].name)

				arg_310_1.leftNameTxt_.text = var_313_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_44 = arg_310_1:GetWordFromCfg(318041074)
				local var_313_45 = arg_310_1:FormatText(var_313_44.content)

				arg_310_1.text_.text = var_313_45

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_46 = 6
				local var_313_47 = utf8.len(var_313_45)
				local var_313_48 = var_313_46 <= 0 and var_313_41 or var_313_41 * (var_313_47 / var_313_46)

				if var_313_48 > 0 and var_313_41 < var_313_48 then
					arg_310_1.talkMaxDuration = var_313_48
					var_313_40 = var_313_40 + 0.3

					if var_313_48 + var_313_40 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_48 + var_313_40
					end
				end

				arg_310_1.text_.text = var_313_45
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041074", "story_v_out_318041.awb") ~= 0 then
					local var_313_49 = manager.audio:GetVoiceLength("story_v_out_318041", "318041074", "story_v_out_318041.awb") / 1000

					if var_313_49 + var_313_40 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_49 + var_313_40
					end

					if var_313_44.prefab_name ~= "" and arg_310_1.actors_[var_313_44.prefab_name] ~= nil then
						local var_313_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_44.prefab_name].transform, "story_v_out_318041", "318041074", "story_v_out_318041.awb")

						arg_310_1:RecordAudio("318041074", var_313_50)
						arg_310_1:RecordAudio("318041074", var_313_50)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_318041", "318041074", "story_v_out_318041.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_318041", "318041074", "story_v_out_318041.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_51 = var_313_40 + 0.3
			local var_313_52 = math.max(var_313_41, arg_310_1.talkMaxDuration)

			if var_313_51 <= arg_310_1.time_ and arg_310_1.time_ < var_313_51 + var_313_52 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_51) / var_313_52

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_51 + var_313_52 and arg_310_1.time_ < var_313_51 + var_313_52 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play318041075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 318041075
		arg_316_1.duration_ = 2.17

		local var_316_0 = {
			zh = 2,
			ja = 2.166
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
				arg_316_0:Play318041076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["10066ui_story"].transform
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.var_.moveOldPos10066ui_story = var_319_0.localPosition
			end

			local var_319_2 = 0.001

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2
				local var_319_4 = Vector3.New(0.7, -0.99, -5.83)

				var_319_0.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10066ui_story, var_319_4, var_319_3)

				local var_319_5 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_5.x, var_319_5.y, var_319_5.z)

				local var_319_6 = var_319_0.localEulerAngles

				var_319_6.z = 0
				var_319_6.x = 0
				var_319_0.localEulerAngles = var_319_6
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 then
				var_319_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_319_7 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_7.x, var_319_7.y, var_319_7.z)

				local var_319_8 = var_319_0.localEulerAngles

				var_319_8.z = 0
				var_319_8.x = 0
				var_319_0.localEulerAngles = var_319_8
			end

			local var_319_9 = arg_316_1.actors_["10066ui_story"]
			local var_319_10 = 0

			if var_319_10 < arg_316_1.time_ and arg_316_1.time_ <= var_319_10 + arg_319_0 and not isNil(var_319_9) and arg_316_1.var_.characterEffect10066ui_story == nil then
				arg_316_1.var_.characterEffect10066ui_story = var_319_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_11 = 0.200000002980232

			if var_319_10 <= arg_316_1.time_ and arg_316_1.time_ < var_319_10 + var_319_11 and not isNil(var_319_9) then
				local var_319_12 = (arg_316_1.time_ - var_319_10) / var_319_11

				if arg_316_1.var_.characterEffect10066ui_story and not isNil(var_319_9) then
					arg_316_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_10 + var_319_11 and arg_316_1.time_ < var_319_10 + var_319_11 + arg_319_0 and not isNil(var_319_9) and arg_316_1.var_.characterEffect10066ui_story then
				arg_316_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_319_13 = 0

			if var_319_13 < arg_316_1.time_ and arg_316_1.time_ <= var_319_13 + arg_319_0 then
				arg_316_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_319_14 = 0

			if var_319_14 < arg_316_1.time_ and arg_316_1.time_ <= var_319_14 + arg_319_0 then
				arg_316_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_319_15 = arg_316_1.actors_["1050ui_story"].transform
			local var_319_16 = 0

			if var_319_16 < arg_316_1.time_ and arg_316_1.time_ <= var_319_16 + arg_319_0 then
				arg_316_1.var_.moveOldPos1050ui_story = var_319_15.localPosition
			end

			local var_319_17 = 0.001

			if var_319_16 <= arg_316_1.time_ and arg_316_1.time_ < var_319_16 + var_319_17 then
				local var_319_18 = (arg_316_1.time_ - var_319_16) / var_319_17
				local var_319_19 = Vector3.New(-0.7, -1, -6.1)

				var_319_15.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1050ui_story, var_319_19, var_319_18)

				local var_319_20 = manager.ui.mainCamera.transform.position - var_319_15.position

				var_319_15.forward = Vector3.New(var_319_20.x, var_319_20.y, var_319_20.z)

				local var_319_21 = var_319_15.localEulerAngles

				var_319_21.z = 0
				var_319_21.x = 0
				var_319_15.localEulerAngles = var_319_21
			end

			if arg_316_1.time_ >= var_319_16 + var_319_17 and arg_316_1.time_ < var_319_16 + var_319_17 + arg_319_0 then
				var_319_15.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_319_22 = manager.ui.mainCamera.transform.position - var_319_15.position

				var_319_15.forward = Vector3.New(var_319_22.x, var_319_22.y, var_319_22.z)

				local var_319_23 = var_319_15.localEulerAngles

				var_319_23.z = 0
				var_319_23.x = 0
				var_319_15.localEulerAngles = var_319_23
			end

			local var_319_24 = arg_316_1.actors_["1050ui_story"]
			local var_319_25 = 0

			if var_319_25 < arg_316_1.time_ and arg_316_1.time_ <= var_319_25 + arg_319_0 and not isNil(var_319_24) and arg_316_1.var_.characterEffect1050ui_story == nil then
				arg_316_1.var_.characterEffect1050ui_story = var_319_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_26 = 0.200000002980232

			if var_319_25 <= arg_316_1.time_ and arg_316_1.time_ < var_319_25 + var_319_26 and not isNil(var_319_24) then
				local var_319_27 = (arg_316_1.time_ - var_319_25) / var_319_26

				if arg_316_1.var_.characterEffect1050ui_story and not isNil(var_319_24) then
					local var_319_28 = Mathf.Lerp(0, 0.5, var_319_27)

					arg_316_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1050ui_story.fillRatio = var_319_28
				end
			end

			if arg_316_1.time_ >= var_319_25 + var_319_26 and arg_316_1.time_ < var_319_25 + var_319_26 + arg_319_0 and not isNil(var_319_24) and arg_316_1.var_.characterEffect1050ui_story then
				local var_319_29 = 0.5

				arg_316_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1050ui_story.fillRatio = var_319_29
			end

			local var_319_30 = 0
			local var_319_31 = 0.1

			if var_319_30 < arg_316_1.time_ and arg_316_1.time_ <= var_319_30 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_32 = arg_316_1:FormatText(StoryNameCfg[640].name)

				arg_316_1.leftNameTxt_.text = var_319_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_33 = arg_316_1:GetWordFromCfg(318041075)
				local var_319_34 = arg_316_1:FormatText(var_319_33.content)

				arg_316_1.text_.text = var_319_34

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_35 = 4
				local var_319_36 = utf8.len(var_319_34)
				local var_319_37 = var_319_35 <= 0 and var_319_31 or var_319_31 * (var_319_36 / var_319_35)

				if var_319_37 > 0 and var_319_31 < var_319_37 then
					arg_316_1.talkMaxDuration = var_319_37

					if var_319_37 + var_319_30 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_37 + var_319_30
					end
				end

				arg_316_1.text_.text = var_319_34
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041075", "story_v_out_318041.awb") ~= 0 then
					local var_319_38 = manager.audio:GetVoiceLength("story_v_out_318041", "318041075", "story_v_out_318041.awb") / 1000

					if var_319_38 + var_319_30 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_38 + var_319_30
					end

					if var_319_33.prefab_name ~= "" and arg_316_1.actors_[var_319_33.prefab_name] ~= nil then
						local var_319_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_33.prefab_name].transform, "story_v_out_318041", "318041075", "story_v_out_318041.awb")

						arg_316_1:RecordAudio("318041075", var_319_39)
						arg_316_1:RecordAudio("318041075", var_319_39)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_318041", "318041075", "story_v_out_318041.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_318041", "318041075", "story_v_out_318041.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_40 = math.max(var_319_31, arg_316_1.talkMaxDuration)

			if var_319_30 <= arg_316_1.time_ and arg_316_1.time_ < var_319_30 + var_319_40 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_30) / var_319_40

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_30 + var_319_40 and arg_316_1.time_ < var_319_30 + var_319_40 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play318041076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 318041076
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play318041077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["10066ui_story"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect10066ui_story == nil then
				arg_320_1.var_.characterEffect10066ui_story = var_323_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.characterEffect10066ui_story and not isNil(var_323_0) then
					local var_323_4 = Mathf.Lerp(0, 0.5, var_323_3)

					arg_320_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_320_1.var_.characterEffect10066ui_story.fillRatio = var_323_4
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect10066ui_story then
				local var_323_5 = 0.5

				arg_320_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_320_1.var_.characterEffect10066ui_story.fillRatio = var_323_5
			end

			local var_323_6 = 0
			local var_323_7 = 1.075

			if var_323_6 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_8 = arg_320_1:GetWordFromCfg(318041076)
				local var_323_9 = arg_320_1:FormatText(var_323_8.content)

				arg_320_1.text_.text = var_323_9

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_10 = 43
				local var_323_11 = utf8.len(var_323_9)
				local var_323_12 = var_323_10 <= 0 and var_323_7 or var_323_7 * (var_323_11 / var_323_10)

				if var_323_12 > 0 and var_323_7 < var_323_12 then
					arg_320_1.talkMaxDuration = var_323_12

					if var_323_12 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_12 + var_323_6
					end
				end

				arg_320_1.text_.text = var_323_9
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_13 = math.max(var_323_7, arg_320_1.talkMaxDuration)

			if var_323_6 <= arg_320_1.time_ and arg_320_1.time_ < var_323_6 + var_323_13 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_6) / var_323_13

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_6 + var_323_13 and arg_320_1.time_ < var_323_6 + var_323_13 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play318041077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 318041077
		arg_324_1.duration_ = 7.67

		local var_324_0 = {
			zh = 3.833,
			ja = 7.666
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play318041078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1050ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1050ui_story == nil then
				arg_324_1.var_.characterEffect1050ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect1050ui_story and not isNil(var_327_0) then
					arg_324_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1050ui_story then
				arg_324_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_327_4 = 0

			if var_327_4 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				arg_324_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_327_5 = 0

			if var_327_5 < arg_324_1.time_ and arg_324_1.time_ <= var_327_5 + arg_327_0 then
				arg_324_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_327_6 = 0
			local var_327_7 = 0.325

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_8 = arg_324_1:FormatText(StoryNameCfg[74].name)

				arg_324_1.leftNameTxt_.text = var_327_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_9 = arg_324_1:GetWordFromCfg(318041077)
				local var_327_10 = arg_324_1:FormatText(var_327_9.content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 13
				local var_327_12 = utf8.len(var_327_10)
				local var_327_13 = var_327_11 <= 0 and var_327_7 or var_327_7 * (var_327_12 / var_327_11)

				if var_327_13 > 0 and var_327_7 < var_327_13 then
					arg_324_1.talkMaxDuration = var_327_13

					if var_327_13 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_13 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_10
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041077", "story_v_out_318041.awb") ~= 0 then
					local var_327_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041077", "story_v_out_318041.awb") / 1000

					if var_327_14 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_14 + var_327_6
					end

					if var_327_9.prefab_name ~= "" and arg_324_1.actors_[var_327_9.prefab_name] ~= nil then
						local var_327_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_9.prefab_name].transform, "story_v_out_318041", "318041077", "story_v_out_318041.awb")

						arg_324_1:RecordAudio("318041077", var_327_15)
						arg_324_1:RecordAudio("318041077", var_327_15)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_318041", "318041077", "story_v_out_318041.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_318041", "318041077", "story_v_out_318041.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_16 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_16 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_16

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_16 and arg_324_1.time_ < var_327_6 + var_327_16 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play318041078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 318041078
		arg_328_1.duration_ = 3.8

		local var_328_0 = {
			zh = 2.333,
			ja = 3.8
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
				arg_328_0:Play318041079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["10066ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect10066ui_story == nil then
				arg_328_1.var_.characterEffect10066ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.200000002980232

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect10066ui_story and not isNil(var_331_0) then
					arg_328_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect10066ui_story then
				arg_328_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_331_4 = 0

			if var_331_4 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action437")
			end

			local var_331_5 = 0

			if var_331_5 < arg_328_1.time_ and arg_328_1.time_ <= var_331_5 + arg_331_0 then
				arg_328_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_331_6 = arg_328_1.actors_["1050ui_story"]
			local var_331_7 = 0

			if var_331_7 < arg_328_1.time_ and arg_328_1.time_ <= var_331_7 + arg_331_0 and not isNil(var_331_6) and arg_328_1.var_.characterEffect1050ui_story == nil then
				arg_328_1.var_.characterEffect1050ui_story = var_331_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_8 = 0.200000002980232

			if var_331_7 <= arg_328_1.time_ and arg_328_1.time_ < var_331_7 + var_331_8 and not isNil(var_331_6) then
				local var_331_9 = (arg_328_1.time_ - var_331_7) / var_331_8

				if arg_328_1.var_.characterEffect1050ui_story and not isNil(var_331_6) then
					local var_331_10 = Mathf.Lerp(0, 0.5, var_331_9)

					arg_328_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1050ui_story.fillRatio = var_331_10
				end
			end

			if arg_328_1.time_ >= var_331_7 + var_331_8 and arg_328_1.time_ < var_331_7 + var_331_8 + arg_331_0 and not isNil(var_331_6) and arg_328_1.var_.characterEffect1050ui_story then
				local var_331_11 = 0.5

				arg_328_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1050ui_story.fillRatio = var_331_11
			end

			local var_331_12 = 0
			local var_331_13 = 0.2

			if var_331_12 < arg_328_1.time_ and arg_328_1.time_ <= var_331_12 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_14 = arg_328_1:FormatText(StoryNameCfg[640].name)

				arg_328_1.leftNameTxt_.text = var_331_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_15 = arg_328_1:GetWordFromCfg(318041078)
				local var_331_16 = arg_328_1:FormatText(var_331_15.content)

				arg_328_1.text_.text = var_331_16

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_17 = 8
				local var_331_18 = utf8.len(var_331_16)
				local var_331_19 = var_331_17 <= 0 and var_331_13 or var_331_13 * (var_331_18 / var_331_17)

				if var_331_19 > 0 and var_331_13 < var_331_19 then
					arg_328_1.talkMaxDuration = var_331_19

					if var_331_19 + var_331_12 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_19 + var_331_12
					end
				end

				arg_328_1.text_.text = var_331_16
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041078", "story_v_out_318041.awb") ~= 0 then
					local var_331_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041078", "story_v_out_318041.awb") / 1000

					if var_331_20 + var_331_12 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_20 + var_331_12
					end

					if var_331_15.prefab_name ~= "" and arg_328_1.actors_[var_331_15.prefab_name] ~= nil then
						local var_331_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_15.prefab_name].transform, "story_v_out_318041", "318041078", "story_v_out_318041.awb")

						arg_328_1:RecordAudio("318041078", var_331_21)
						arg_328_1:RecordAudio("318041078", var_331_21)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_318041", "318041078", "story_v_out_318041.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_318041", "318041078", "story_v_out_318041.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_22 = math.max(var_331_13, arg_328_1.talkMaxDuration)

			if var_331_12 <= arg_328_1.time_ and arg_328_1.time_ < var_331_12 + var_331_22 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_12) / var_331_22

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_12 + var_331_22 and arg_328_1.time_ < var_331_12 + var_331_22 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play318041079 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 318041079
		arg_332_1.duration_ = 5.8

		local var_332_0 = {
			zh = 4.6,
			ja = 5.8
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play318041080(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_335_1 = 0
			local var_335_2 = 0.475

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_3 = arg_332_1:FormatText(StoryNameCfg[640].name)

				arg_332_1.leftNameTxt_.text = var_335_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_4 = arg_332_1:GetWordFromCfg(318041079)
				local var_335_5 = arg_332_1:FormatText(var_335_4.content)

				arg_332_1.text_.text = var_335_5

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_6 = 19
				local var_335_7 = utf8.len(var_335_5)
				local var_335_8 = var_335_6 <= 0 and var_335_2 or var_335_2 * (var_335_7 / var_335_6)

				if var_335_8 > 0 and var_335_2 < var_335_8 then
					arg_332_1.talkMaxDuration = var_335_8

					if var_335_8 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_1
					end
				end

				arg_332_1.text_.text = var_335_5
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041079", "story_v_out_318041.awb") ~= 0 then
					local var_335_9 = manager.audio:GetVoiceLength("story_v_out_318041", "318041079", "story_v_out_318041.awb") / 1000

					if var_335_9 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_9 + var_335_1
					end

					if var_335_4.prefab_name ~= "" and arg_332_1.actors_[var_335_4.prefab_name] ~= nil then
						local var_335_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_4.prefab_name].transform, "story_v_out_318041", "318041079", "story_v_out_318041.awb")

						arg_332_1:RecordAudio("318041079", var_335_10)
						arg_332_1:RecordAudio("318041079", var_335_10)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_318041", "318041079", "story_v_out_318041.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_318041", "318041079", "story_v_out_318041.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_11 = math.max(var_335_2, arg_332_1.talkMaxDuration)

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_11 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_1) / var_335_11

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_1 + var_335_11 and arg_332_1.time_ < var_335_1 + var_335_11 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play318041080 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 318041080
		arg_336_1.duration_ = 4.6

		local var_336_0 = {
			zh = 4.6,
			ja = 2.5
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play318041081(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1050ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1050ui_story == nil then
				arg_336_1.var_.characterEffect1050ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect1050ui_story and not isNil(var_339_0) then
					arg_336_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1050ui_story then
				arg_336_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_339_4 = 0

			if var_339_4 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			local var_339_5 = 0

			if var_339_5 < arg_336_1.time_ and arg_336_1.time_ <= var_339_5 + arg_339_0 then
				arg_336_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_339_6 = arg_336_1.actors_["10066ui_story"]
			local var_339_7 = 0

			if var_339_7 < arg_336_1.time_ and arg_336_1.time_ <= var_339_7 + arg_339_0 and not isNil(var_339_6) and arg_336_1.var_.characterEffect10066ui_story == nil then
				arg_336_1.var_.characterEffect10066ui_story = var_339_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_8 = 0.200000002980232

			if var_339_7 <= arg_336_1.time_ and arg_336_1.time_ < var_339_7 + var_339_8 and not isNil(var_339_6) then
				local var_339_9 = (arg_336_1.time_ - var_339_7) / var_339_8

				if arg_336_1.var_.characterEffect10066ui_story and not isNil(var_339_6) then
					local var_339_10 = Mathf.Lerp(0, 0.5, var_339_9)

					arg_336_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_336_1.var_.characterEffect10066ui_story.fillRatio = var_339_10
				end
			end

			if arg_336_1.time_ >= var_339_7 + var_339_8 and arg_336_1.time_ < var_339_7 + var_339_8 + arg_339_0 and not isNil(var_339_6) and arg_336_1.var_.characterEffect10066ui_story then
				local var_339_11 = 0.5

				arg_336_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_336_1.var_.characterEffect10066ui_story.fillRatio = var_339_11
			end

			local var_339_12 = 0
			local var_339_13 = 0.4

			if var_339_12 < arg_336_1.time_ and arg_336_1.time_ <= var_339_12 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_14 = arg_336_1:FormatText(StoryNameCfg[74].name)

				arg_336_1.leftNameTxt_.text = var_339_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_15 = arg_336_1:GetWordFromCfg(318041080)
				local var_339_16 = arg_336_1:FormatText(var_339_15.content)

				arg_336_1.text_.text = var_339_16

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_17 = 16
				local var_339_18 = utf8.len(var_339_16)
				local var_339_19 = var_339_17 <= 0 and var_339_13 or var_339_13 * (var_339_18 / var_339_17)

				if var_339_19 > 0 and var_339_13 < var_339_19 then
					arg_336_1.talkMaxDuration = var_339_19

					if var_339_19 + var_339_12 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_19 + var_339_12
					end
				end

				arg_336_1.text_.text = var_339_16
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041080", "story_v_out_318041.awb") ~= 0 then
					local var_339_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041080", "story_v_out_318041.awb") / 1000

					if var_339_20 + var_339_12 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_20 + var_339_12
					end

					if var_339_15.prefab_name ~= "" and arg_336_1.actors_[var_339_15.prefab_name] ~= nil then
						local var_339_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_15.prefab_name].transform, "story_v_out_318041", "318041080", "story_v_out_318041.awb")

						arg_336_1:RecordAudio("318041080", var_339_21)
						arg_336_1:RecordAudio("318041080", var_339_21)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_318041", "318041080", "story_v_out_318041.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_318041", "318041080", "story_v_out_318041.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_22 = math.max(var_339_13, arg_336_1.talkMaxDuration)

			if var_339_12 <= arg_336_1.time_ and arg_336_1.time_ < var_339_12 + var_339_22 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_12) / var_339_22

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_12 + var_339_22 and arg_336_1.time_ < var_339_12 + var_339_22 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play318041081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 318041081
		arg_340_1.duration_ = 9.4

		local var_340_0 = {
			zh = 9.4,
			ja = 8.733
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
				arg_340_0:Play318041082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["10066ui_story"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect10066ui_story == nil then
				arg_340_1.var_.characterEffect10066ui_story = var_343_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.characterEffect10066ui_story and not isNil(var_343_0) then
					arg_340_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect10066ui_story then
				arg_340_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_343_4 = 0

			if var_343_4 < arg_340_1.time_ and arg_340_1.time_ <= var_343_4 + arg_343_0 then
				arg_340_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action476")
			end

			local var_343_5 = 0

			if var_343_5 < arg_340_1.time_ and arg_340_1.time_ <= var_343_5 + arg_343_0 then
				arg_340_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_343_6 = arg_340_1.actors_["1050ui_story"]
			local var_343_7 = 0

			if var_343_7 < arg_340_1.time_ and arg_340_1.time_ <= var_343_7 + arg_343_0 and not isNil(var_343_6) and arg_340_1.var_.characterEffect1050ui_story == nil then
				arg_340_1.var_.characterEffect1050ui_story = var_343_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_8 = 0.200000002980232

			if var_343_7 <= arg_340_1.time_ and arg_340_1.time_ < var_343_7 + var_343_8 and not isNil(var_343_6) then
				local var_343_9 = (arg_340_1.time_ - var_343_7) / var_343_8

				if arg_340_1.var_.characterEffect1050ui_story and not isNil(var_343_6) then
					local var_343_10 = Mathf.Lerp(0, 0.5, var_343_9)

					arg_340_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1050ui_story.fillRatio = var_343_10
				end
			end

			if arg_340_1.time_ >= var_343_7 + var_343_8 and arg_340_1.time_ < var_343_7 + var_343_8 + arg_343_0 and not isNil(var_343_6) and arg_340_1.var_.characterEffect1050ui_story then
				local var_343_11 = 0.5

				arg_340_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1050ui_story.fillRatio = var_343_11
			end

			local var_343_12 = 0
			local var_343_13 = 1.2

			if var_343_12 < arg_340_1.time_ and arg_340_1.time_ <= var_343_12 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_14 = arg_340_1:FormatText(StoryNameCfg[640].name)

				arg_340_1.leftNameTxt_.text = var_343_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_15 = arg_340_1:GetWordFromCfg(318041081)
				local var_343_16 = arg_340_1:FormatText(var_343_15.content)

				arg_340_1.text_.text = var_343_16

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_17 = 48
				local var_343_18 = utf8.len(var_343_16)
				local var_343_19 = var_343_17 <= 0 and var_343_13 or var_343_13 * (var_343_18 / var_343_17)

				if var_343_19 > 0 and var_343_13 < var_343_19 then
					arg_340_1.talkMaxDuration = var_343_19

					if var_343_19 + var_343_12 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_19 + var_343_12
					end
				end

				arg_340_1.text_.text = var_343_16
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041081", "story_v_out_318041.awb") ~= 0 then
					local var_343_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041081", "story_v_out_318041.awb") / 1000

					if var_343_20 + var_343_12 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_20 + var_343_12
					end

					if var_343_15.prefab_name ~= "" and arg_340_1.actors_[var_343_15.prefab_name] ~= nil then
						local var_343_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_15.prefab_name].transform, "story_v_out_318041", "318041081", "story_v_out_318041.awb")

						arg_340_1:RecordAudio("318041081", var_343_21)
						arg_340_1:RecordAudio("318041081", var_343_21)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_318041", "318041081", "story_v_out_318041.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_318041", "318041081", "story_v_out_318041.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_22 = math.max(var_343_13, arg_340_1.talkMaxDuration)

			if var_343_12 <= arg_340_1.time_ and arg_340_1.time_ < var_343_12 + var_343_22 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_12) / var_343_22

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_12 + var_343_22 and arg_340_1.time_ < var_343_12 + var_343_22 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play318041082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 318041082
		arg_344_1.duration_ = 10.17

		local var_344_0 = {
			zh = 5.6,
			ja = 10.166
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play318041083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["10066ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect10066ui_story == nil then
				arg_344_1.var_.characterEffect10066ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect10066ui_story and not isNil(var_347_0) then
					arg_344_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect10066ui_story then
				arg_344_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_347_4 = 0

			if var_347_4 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_347_5 = 0
			local var_347_6 = 0.6

			if var_347_5 < arg_344_1.time_ and arg_344_1.time_ <= var_347_5 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_7 = arg_344_1:FormatText(StoryNameCfg[640].name)

				arg_344_1.leftNameTxt_.text = var_347_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_8 = arg_344_1:GetWordFromCfg(318041082)
				local var_347_9 = arg_344_1:FormatText(var_347_8.content)

				arg_344_1.text_.text = var_347_9

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_10 = 24
				local var_347_11 = utf8.len(var_347_9)
				local var_347_12 = var_347_10 <= 0 and var_347_6 or var_347_6 * (var_347_11 / var_347_10)

				if var_347_12 > 0 and var_347_6 < var_347_12 then
					arg_344_1.talkMaxDuration = var_347_12

					if var_347_12 + var_347_5 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_12 + var_347_5
					end
				end

				arg_344_1.text_.text = var_347_9
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041082", "story_v_out_318041.awb") ~= 0 then
					local var_347_13 = manager.audio:GetVoiceLength("story_v_out_318041", "318041082", "story_v_out_318041.awb") / 1000

					if var_347_13 + var_347_5 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_5
					end

					if var_347_8.prefab_name ~= "" and arg_344_1.actors_[var_347_8.prefab_name] ~= nil then
						local var_347_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_8.prefab_name].transform, "story_v_out_318041", "318041082", "story_v_out_318041.awb")

						arg_344_1:RecordAudio("318041082", var_347_14)
						arg_344_1:RecordAudio("318041082", var_347_14)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_318041", "318041082", "story_v_out_318041.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_318041", "318041082", "story_v_out_318041.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_15 = math.max(var_347_6, arg_344_1.talkMaxDuration)

			if var_347_5 <= arg_344_1.time_ and arg_344_1.time_ < var_347_5 + var_347_15 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_5) / var_347_15

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_5 + var_347_15 and arg_344_1.time_ < var_347_5 + var_347_15 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play318041083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 318041083
		arg_348_1.duration_ = 9.03

		local var_348_0 = {
			zh = 6.566,
			ja = 9.033
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play318041084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1050ui_story"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1050ui_story == nil then
				arg_348_1.var_.characterEffect1050ui_story = var_351_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.characterEffect1050ui_story and not isNil(var_351_0) then
					arg_348_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1050ui_story then
				arg_348_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_351_4 = 0

			if var_351_4 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_2")
			end

			local var_351_5 = 0

			if var_351_5 < arg_348_1.time_ and arg_348_1.time_ <= var_351_5 + arg_351_0 then
				arg_348_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_351_6 = arg_348_1.actors_["10066ui_story"]
			local var_351_7 = 0

			if var_351_7 < arg_348_1.time_ and arg_348_1.time_ <= var_351_7 + arg_351_0 and not isNil(var_351_6) and arg_348_1.var_.characterEffect10066ui_story == nil then
				arg_348_1.var_.characterEffect10066ui_story = var_351_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_8 = 0.200000002980232

			if var_351_7 <= arg_348_1.time_ and arg_348_1.time_ < var_351_7 + var_351_8 and not isNil(var_351_6) then
				local var_351_9 = (arg_348_1.time_ - var_351_7) / var_351_8

				if arg_348_1.var_.characterEffect10066ui_story and not isNil(var_351_6) then
					local var_351_10 = Mathf.Lerp(0, 0.5, var_351_9)

					arg_348_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_348_1.var_.characterEffect10066ui_story.fillRatio = var_351_10
				end
			end

			if arg_348_1.time_ >= var_351_7 + var_351_8 and arg_348_1.time_ < var_351_7 + var_351_8 + arg_351_0 and not isNil(var_351_6) and arg_348_1.var_.characterEffect10066ui_story then
				local var_351_11 = 0.5

				arg_348_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_348_1.var_.characterEffect10066ui_story.fillRatio = var_351_11
			end

			local var_351_12 = 0
			local var_351_13 = 0.725

			if var_351_12 < arg_348_1.time_ and arg_348_1.time_ <= var_351_12 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_14 = arg_348_1:FormatText(StoryNameCfg[74].name)

				arg_348_1.leftNameTxt_.text = var_351_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_15 = arg_348_1:GetWordFromCfg(318041083)
				local var_351_16 = arg_348_1:FormatText(var_351_15.content)

				arg_348_1.text_.text = var_351_16

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_17 = 29
				local var_351_18 = utf8.len(var_351_16)
				local var_351_19 = var_351_17 <= 0 and var_351_13 or var_351_13 * (var_351_18 / var_351_17)

				if var_351_19 > 0 and var_351_13 < var_351_19 then
					arg_348_1.talkMaxDuration = var_351_19

					if var_351_19 + var_351_12 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_19 + var_351_12
					end
				end

				arg_348_1.text_.text = var_351_16
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041083", "story_v_out_318041.awb") ~= 0 then
					local var_351_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041083", "story_v_out_318041.awb") / 1000

					if var_351_20 + var_351_12 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_20 + var_351_12
					end

					if var_351_15.prefab_name ~= "" and arg_348_1.actors_[var_351_15.prefab_name] ~= nil then
						local var_351_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_15.prefab_name].transform, "story_v_out_318041", "318041083", "story_v_out_318041.awb")

						arg_348_1:RecordAudio("318041083", var_351_21)
						arg_348_1:RecordAudio("318041083", var_351_21)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_318041", "318041083", "story_v_out_318041.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_318041", "318041083", "story_v_out_318041.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_22 = math.max(var_351_13, arg_348_1.talkMaxDuration)

			if var_351_12 <= arg_348_1.time_ and arg_348_1.time_ < var_351_12 + var_351_22 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_12) / var_351_22

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_12 + var_351_22 and arg_348_1.time_ < var_351_12 + var_351_22 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play318041084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 318041084
		arg_352_1.duration_ = 8.43

		local var_352_0 = {
			zh = 7.466,
			ja = 8.433
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play318041085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["10066ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect10066ui_story == nil then
				arg_352_1.var_.characterEffect10066ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect10066ui_story and not isNil(var_355_0) then
					arg_352_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect10066ui_story then
				arg_352_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_355_4 = 0

			if var_355_4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_355_5 = 0

			if var_355_5 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_355_6 = arg_352_1.actors_["1050ui_story"]
			local var_355_7 = 0

			if var_355_7 < arg_352_1.time_ and arg_352_1.time_ <= var_355_7 + arg_355_0 and not isNil(var_355_6) and arg_352_1.var_.characterEffect1050ui_story == nil then
				arg_352_1.var_.characterEffect1050ui_story = var_355_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_8 = 0.200000002980232

			if var_355_7 <= arg_352_1.time_ and arg_352_1.time_ < var_355_7 + var_355_8 and not isNil(var_355_6) then
				local var_355_9 = (arg_352_1.time_ - var_355_7) / var_355_8

				if arg_352_1.var_.characterEffect1050ui_story and not isNil(var_355_6) then
					local var_355_10 = Mathf.Lerp(0, 0.5, var_355_9)

					arg_352_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1050ui_story.fillRatio = var_355_10
				end
			end

			if arg_352_1.time_ >= var_355_7 + var_355_8 and arg_352_1.time_ < var_355_7 + var_355_8 + arg_355_0 and not isNil(var_355_6) and arg_352_1.var_.characterEffect1050ui_story then
				local var_355_11 = 0.5

				arg_352_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1050ui_story.fillRatio = var_355_11
			end

			local var_355_12 = 0
			local var_355_13 = 0.725

			if var_355_12 < arg_352_1.time_ and arg_352_1.time_ <= var_355_12 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_14 = arg_352_1:FormatText(StoryNameCfg[640].name)

				arg_352_1.leftNameTxt_.text = var_355_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_15 = arg_352_1:GetWordFromCfg(318041084)
				local var_355_16 = arg_352_1:FormatText(var_355_15.content)

				arg_352_1.text_.text = var_355_16

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_17 = 29
				local var_355_18 = utf8.len(var_355_16)
				local var_355_19 = var_355_17 <= 0 and var_355_13 or var_355_13 * (var_355_18 / var_355_17)

				if var_355_19 > 0 and var_355_13 < var_355_19 then
					arg_352_1.talkMaxDuration = var_355_19

					if var_355_19 + var_355_12 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_19 + var_355_12
					end
				end

				arg_352_1.text_.text = var_355_16
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041084", "story_v_out_318041.awb") ~= 0 then
					local var_355_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041084", "story_v_out_318041.awb") / 1000

					if var_355_20 + var_355_12 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_20 + var_355_12
					end

					if var_355_15.prefab_name ~= "" and arg_352_1.actors_[var_355_15.prefab_name] ~= nil then
						local var_355_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_15.prefab_name].transform, "story_v_out_318041", "318041084", "story_v_out_318041.awb")

						arg_352_1:RecordAudio("318041084", var_355_21)
						arg_352_1:RecordAudio("318041084", var_355_21)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_318041", "318041084", "story_v_out_318041.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_318041", "318041084", "story_v_out_318041.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_22 = math.max(var_355_13, arg_352_1.talkMaxDuration)

			if var_355_12 <= arg_352_1.time_ and arg_352_1.time_ < var_355_12 + var_355_22 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_12) / var_355_22

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_12 + var_355_22 and arg_352_1.time_ < var_355_12 + var_355_22 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play318041085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 318041085
		arg_356_1.duration_ = 6.27

		local var_356_0 = {
			zh = 6.266,
			ja = 4.733
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
				arg_356_0:Play318041086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1050ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1050ui_story == nil then
				arg_356_1.var_.characterEffect1050ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect1050ui_story and not isNil(var_359_0) then
					arg_356_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1050ui_story then
				arg_356_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_359_4 = 0

			if var_359_4 < arg_356_1.time_ and arg_356_1.time_ <= var_359_4 + arg_359_0 then
				arg_356_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_359_5 = 0

			if var_359_5 < arg_356_1.time_ and arg_356_1.time_ <= var_359_5 + arg_359_0 then
				arg_356_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_359_6 = arg_356_1.actors_["10066ui_story"]
			local var_359_7 = 0

			if var_359_7 < arg_356_1.time_ and arg_356_1.time_ <= var_359_7 + arg_359_0 and not isNil(var_359_6) and arg_356_1.var_.characterEffect10066ui_story == nil then
				arg_356_1.var_.characterEffect10066ui_story = var_359_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_8 = 0.200000002980232

			if var_359_7 <= arg_356_1.time_ and arg_356_1.time_ < var_359_7 + var_359_8 and not isNil(var_359_6) then
				local var_359_9 = (arg_356_1.time_ - var_359_7) / var_359_8

				if arg_356_1.var_.characterEffect10066ui_story and not isNil(var_359_6) then
					local var_359_10 = Mathf.Lerp(0, 0.5, var_359_9)

					arg_356_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_356_1.var_.characterEffect10066ui_story.fillRatio = var_359_10
				end
			end

			if arg_356_1.time_ >= var_359_7 + var_359_8 and arg_356_1.time_ < var_359_7 + var_359_8 + arg_359_0 and not isNil(var_359_6) and arg_356_1.var_.characterEffect10066ui_story then
				local var_359_11 = 0.5

				arg_356_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_356_1.var_.characterEffect10066ui_story.fillRatio = var_359_11
			end

			local var_359_12 = 0
			local var_359_13 = 0.625

			if var_359_12 < arg_356_1.time_ and arg_356_1.time_ <= var_359_12 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_14 = arg_356_1:FormatText(StoryNameCfg[74].name)

				arg_356_1.leftNameTxt_.text = var_359_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_15 = arg_356_1:GetWordFromCfg(318041085)
				local var_359_16 = arg_356_1:FormatText(var_359_15.content)

				arg_356_1.text_.text = var_359_16

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_17 = 25
				local var_359_18 = utf8.len(var_359_16)
				local var_359_19 = var_359_17 <= 0 and var_359_13 or var_359_13 * (var_359_18 / var_359_17)

				if var_359_19 > 0 and var_359_13 < var_359_19 then
					arg_356_1.talkMaxDuration = var_359_19

					if var_359_19 + var_359_12 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_19 + var_359_12
					end
				end

				arg_356_1.text_.text = var_359_16
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041085", "story_v_out_318041.awb") ~= 0 then
					local var_359_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041085", "story_v_out_318041.awb") / 1000

					if var_359_20 + var_359_12 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_20 + var_359_12
					end

					if var_359_15.prefab_name ~= "" and arg_356_1.actors_[var_359_15.prefab_name] ~= nil then
						local var_359_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_15.prefab_name].transform, "story_v_out_318041", "318041085", "story_v_out_318041.awb")

						arg_356_1:RecordAudio("318041085", var_359_21)
						arg_356_1:RecordAudio("318041085", var_359_21)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_318041", "318041085", "story_v_out_318041.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_318041", "318041085", "story_v_out_318041.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_22 = math.max(var_359_13, arg_356_1.talkMaxDuration)

			if var_359_12 <= arg_356_1.time_ and arg_356_1.time_ < var_359_12 + var_359_22 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_12) / var_359_22

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_12 + var_359_22 and arg_356_1.time_ < var_359_12 + var_359_22 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play318041086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 318041086
		arg_360_1.duration_ = 8.13

		local var_360_0 = {
			zh = 4.533,
			ja = 8.133
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play318041087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["10066ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10066ui_story == nil then
				arg_360_1.var_.characterEffect10066ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect10066ui_story and not isNil(var_363_0) then
					arg_360_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10066ui_story then
				arg_360_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_363_4 = 0

			if var_363_4 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_363_5 = 0

			if var_363_5 < arg_360_1.time_ and arg_360_1.time_ <= var_363_5 + arg_363_0 then
				arg_360_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_363_6 = arg_360_1.actors_["1050ui_story"]
			local var_363_7 = 0

			if var_363_7 < arg_360_1.time_ and arg_360_1.time_ <= var_363_7 + arg_363_0 and not isNil(var_363_6) and arg_360_1.var_.characterEffect1050ui_story == nil then
				arg_360_1.var_.characterEffect1050ui_story = var_363_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_8 = 0.200000002980232

			if var_363_7 <= arg_360_1.time_ and arg_360_1.time_ < var_363_7 + var_363_8 and not isNil(var_363_6) then
				local var_363_9 = (arg_360_1.time_ - var_363_7) / var_363_8

				if arg_360_1.var_.characterEffect1050ui_story and not isNil(var_363_6) then
					local var_363_10 = Mathf.Lerp(0, 0.5, var_363_9)

					arg_360_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1050ui_story.fillRatio = var_363_10
				end
			end

			if arg_360_1.time_ >= var_363_7 + var_363_8 and arg_360_1.time_ < var_363_7 + var_363_8 + arg_363_0 and not isNil(var_363_6) and arg_360_1.var_.characterEffect1050ui_story then
				local var_363_11 = 0.5

				arg_360_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1050ui_story.fillRatio = var_363_11
			end

			local var_363_12 = 0
			local var_363_13 = 0.5

			if var_363_12 < arg_360_1.time_ and arg_360_1.time_ <= var_363_12 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_14 = arg_360_1:FormatText(StoryNameCfg[640].name)

				arg_360_1.leftNameTxt_.text = var_363_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_15 = arg_360_1:GetWordFromCfg(318041086)
				local var_363_16 = arg_360_1:FormatText(var_363_15.content)

				arg_360_1.text_.text = var_363_16

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_17 = 20
				local var_363_18 = utf8.len(var_363_16)
				local var_363_19 = var_363_17 <= 0 and var_363_13 or var_363_13 * (var_363_18 / var_363_17)

				if var_363_19 > 0 and var_363_13 < var_363_19 then
					arg_360_1.talkMaxDuration = var_363_19

					if var_363_19 + var_363_12 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_19 + var_363_12
					end
				end

				arg_360_1.text_.text = var_363_16
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041086", "story_v_out_318041.awb") ~= 0 then
					local var_363_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041086", "story_v_out_318041.awb") / 1000

					if var_363_20 + var_363_12 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_20 + var_363_12
					end

					if var_363_15.prefab_name ~= "" and arg_360_1.actors_[var_363_15.prefab_name] ~= nil then
						local var_363_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_15.prefab_name].transform, "story_v_out_318041", "318041086", "story_v_out_318041.awb")

						arg_360_1:RecordAudio("318041086", var_363_21)
						arg_360_1:RecordAudio("318041086", var_363_21)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_318041", "318041086", "story_v_out_318041.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_318041", "318041086", "story_v_out_318041.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_22 = math.max(var_363_13, arg_360_1.talkMaxDuration)

			if var_363_12 <= arg_360_1.time_ and arg_360_1.time_ < var_363_12 + var_363_22 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_12) / var_363_22

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_12 + var_363_22 and arg_360_1.time_ < var_363_12 + var_363_22 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play318041087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 318041087
		arg_364_1.duration_ = 14.6

		local var_364_0 = {
			zh = 6.566,
			ja = 14.6
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play318041088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["10066ui_story"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10066ui_story == nil then
				arg_364_1.var_.characterEffect10066ui_story = var_367_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.characterEffect10066ui_story and not isNil(var_367_0) then
					arg_364_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10066ui_story then
				arg_364_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_367_4 = 0

			if var_367_4 < arg_364_1.time_ and arg_364_1.time_ <= var_367_4 + arg_367_0 then
				arg_364_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_367_5 = 0

			if var_367_5 < arg_364_1.time_ and arg_364_1.time_ <= var_367_5 + arg_367_0 then
				arg_364_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_367_6 = 0
			local var_367_7 = 0.825

			if var_367_6 < arg_364_1.time_ and arg_364_1.time_ <= var_367_6 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_8 = arg_364_1:FormatText(StoryNameCfg[640].name)

				arg_364_1.leftNameTxt_.text = var_367_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_9 = arg_364_1:GetWordFromCfg(318041087)
				local var_367_10 = arg_364_1:FormatText(var_367_9.content)

				arg_364_1.text_.text = var_367_10

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_11 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041087", "story_v_out_318041.awb") ~= 0 then
					local var_367_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041087", "story_v_out_318041.awb") / 1000

					if var_367_14 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_14 + var_367_6
					end

					if var_367_9.prefab_name ~= "" and arg_364_1.actors_[var_367_9.prefab_name] ~= nil then
						local var_367_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_9.prefab_name].transform, "story_v_out_318041", "318041087", "story_v_out_318041.awb")

						arg_364_1:RecordAudio("318041087", var_367_15)
						arg_364_1:RecordAudio("318041087", var_367_15)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_318041", "318041087", "story_v_out_318041.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_318041", "318041087", "story_v_out_318041.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_16 = math.max(var_367_7, arg_364_1.talkMaxDuration)

			if var_367_6 <= arg_364_1.time_ and arg_364_1.time_ < var_367_6 + var_367_16 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_6) / var_367_16

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_6 + var_367_16 and arg_364_1.time_ < var_367_6 + var_367_16 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play318041088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 318041088
		arg_368_1.duration_ = 8.83

		local var_368_0 = {
			zh = 5.233,
			ja = 8.833
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
				arg_368_0:Play318041089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1050ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1050ui_story == nil then
				arg_368_1.var_.characterEffect1050ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect1050ui_story and not isNil(var_371_0) then
					arg_368_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect1050ui_story then
				arg_368_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_371_4 = 0

			if var_371_4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_371_5 = 0

			if var_371_5 < arg_368_1.time_ and arg_368_1.time_ <= var_371_5 + arg_371_0 then
				arg_368_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_371_6 = arg_368_1.actors_["10066ui_story"]
			local var_371_7 = 0

			if var_371_7 < arg_368_1.time_ and arg_368_1.time_ <= var_371_7 + arg_371_0 and not isNil(var_371_6) and arg_368_1.var_.characterEffect10066ui_story == nil then
				arg_368_1.var_.characterEffect10066ui_story = var_371_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_8 = 0.200000002980232

			if var_371_7 <= arg_368_1.time_ and arg_368_1.time_ < var_371_7 + var_371_8 and not isNil(var_371_6) then
				local var_371_9 = (arg_368_1.time_ - var_371_7) / var_371_8

				if arg_368_1.var_.characterEffect10066ui_story and not isNil(var_371_6) then
					local var_371_10 = Mathf.Lerp(0, 0.5, var_371_9)

					arg_368_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_368_1.var_.characterEffect10066ui_story.fillRatio = var_371_10
				end
			end

			if arg_368_1.time_ >= var_371_7 + var_371_8 and arg_368_1.time_ < var_371_7 + var_371_8 + arg_371_0 and not isNil(var_371_6) and arg_368_1.var_.characterEffect10066ui_story then
				local var_371_11 = 0.5

				arg_368_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_368_1.var_.characterEffect10066ui_story.fillRatio = var_371_11
			end

			local var_371_12 = 0
			local var_371_13 = 0.625

			if var_371_12 < arg_368_1.time_ and arg_368_1.time_ <= var_371_12 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_14 = arg_368_1:FormatText(StoryNameCfg[74].name)

				arg_368_1.leftNameTxt_.text = var_371_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_15 = arg_368_1:GetWordFromCfg(318041088)
				local var_371_16 = arg_368_1:FormatText(var_371_15.content)

				arg_368_1.text_.text = var_371_16

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_17 = 25
				local var_371_18 = utf8.len(var_371_16)
				local var_371_19 = var_371_17 <= 0 and var_371_13 or var_371_13 * (var_371_18 / var_371_17)

				if var_371_19 > 0 and var_371_13 < var_371_19 then
					arg_368_1.talkMaxDuration = var_371_19

					if var_371_19 + var_371_12 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_19 + var_371_12
					end
				end

				arg_368_1.text_.text = var_371_16
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041088", "story_v_out_318041.awb") ~= 0 then
					local var_371_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041088", "story_v_out_318041.awb") / 1000

					if var_371_20 + var_371_12 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_20 + var_371_12
					end

					if var_371_15.prefab_name ~= "" and arg_368_1.actors_[var_371_15.prefab_name] ~= nil then
						local var_371_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_15.prefab_name].transform, "story_v_out_318041", "318041088", "story_v_out_318041.awb")

						arg_368_1:RecordAudio("318041088", var_371_21)
						arg_368_1:RecordAudio("318041088", var_371_21)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_318041", "318041088", "story_v_out_318041.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_318041", "318041088", "story_v_out_318041.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_22 = math.max(var_371_13, arg_368_1.talkMaxDuration)

			if var_371_12 <= arg_368_1.time_ and arg_368_1.time_ < var_371_12 + var_371_22 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_12) / var_371_22

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_12 + var_371_22 and arg_368_1.time_ < var_371_12 + var_371_22 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play318041089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 318041089
		arg_372_1.duration_ = 7.27

		local var_372_0 = {
			zh = 3.566,
			ja = 7.266
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play318041090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["10066ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10066ui_story == nil then
				arg_372_1.var_.characterEffect10066ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect10066ui_story and not isNil(var_375_0) then
					arg_372_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10066ui_story then
				arg_372_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_375_4 = 0

			if var_375_4 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action436")
			end

			local var_375_5 = 0

			if var_375_5 < arg_372_1.time_ and arg_372_1.time_ <= var_375_5 + arg_375_0 then
				arg_372_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_375_6 = arg_372_1.actors_["1050ui_story"]
			local var_375_7 = 0

			if var_375_7 < arg_372_1.time_ and arg_372_1.time_ <= var_375_7 + arg_375_0 and not isNil(var_375_6) and arg_372_1.var_.characterEffect1050ui_story == nil then
				arg_372_1.var_.characterEffect1050ui_story = var_375_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_8 = 0.200000002980232

			if var_375_7 <= arg_372_1.time_ and arg_372_1.time_ < var_375_7 + var_375_8 and not isNil(var_375_6) then
				local var_375_9 = (arg_372_1.time_ - var_375_7) / var_375_8

				if arg_372_1.var_.characterEffect1050ui_story and not isNil(var_375_6) then
					local var_375_10 = Mathf.Lerp(0, 0.5, var_375_9)

					arg_372_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1050ui_story.fillRatio = var_375_10
				end
			end

			if arg_372_1.time_ >= var_375_7 + var_375_8 and arg_372_1.time_ < var_375_7 + var_375_8 + arg_375_0 and not isNil(var_375_6) and arg_372_1.var_.characterEffect1050ui_story then
				local var_375_11 = 0.5

				arg_372_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1050ui_story.fillRatio = var_375_11
			end

			local var_375_12 = 0
			local var_375_13 = 0.35

			if var_375_12 < arg_372_1.time_ and arg_372_1.time_ <= var_375_12 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_14 = arg_372_1:FormatText(StoryNameCfg[640].name)

				arg_372_1.leftNameTxt_.text = var_375_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_15 = arg_372_1:GetWordFromCfg(318041089)
				local var_375_16 = arg_372_1:FormatText(var_375_15.content)

				arg_372_1.text_.text = var_375_16

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_17 = 14
				local var_375_18 = utf8.len(var_375_16)
				local var_375_19 = var_375_17 <= 0 and var_375_13 or var_375_13 * (var_375_18 / var_375_17)

				if var_375_19 > 0 and var_375_13 < var_375_19 then
					arg_372_1.talkMaxDuration = var_375_19

					if var_375_19 + var_375_12 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_19 + var_375_12
					end
				end

				arg_372_1.text_.text = var_375_16
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041089", "story_v_out_318041.awb") ~= 0 then
					local var_375_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041089", "story_v_out_318041.awb") / 1000

					if var_375_20 + var_375_12 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_20 + var_375_12
					end

					if var_375_15.prefab_name ~= "" and arg_372_1.actors_[var_375_15.prefab_name] ~= nil then
						local var_375_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_15.prefab_name].transform, "story_v_out_318041", "318041089", "story_v_out_318041.awb")

						arg_372_1:RecordAudio("318041089", var_375_21)
						arg_372_1:RecordAudio("318041089", var_375_21)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_318041", "318041089", "story_v_out_318041.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_318041", "318041089", "story_v_out_318041.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_22 = math.max(var_375_13, arg_372_1.talkMaxDuration)

			if var_375_12 <= arg_372_1.time_ and arg_372_1.time_ < var_375_12 + var_375_22 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_12) / var_375_22

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_12 + var_375_22 and arg_372_1.time_ < var_375_12 + var_375_22 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play318041090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 318041090
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play318041091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["10066ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10066ui_story == nil then
				arg_376_1.var_.characterEffect10066ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect10066ui_story and not isNil(var_379_0) then
					local var_379_4 = Mathf.Lerp(0, 0.5, var_379_3)

					arg_376_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_376_1.var_.characterEffect10066ui_story.fillRatio = var_379_4
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10066ui_story then
				local var_379_5 = 0.5

				arg_376_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_376_1.var_.characterEffect10066ui_story.fillRatio = var_379_5
			end

			local var_379_6 = arg_376_1.actors_["1050ui_story"]
			local var_379_7 = 0

			if var_379_7 < arg_376_1.time_ and arg_376_1.time_ <= var_379_7 + arg_379_0 and not isNil(var_379_6) and arg_376_1.var_.characterEffect1050ui_story == nil then
				arg_376_1.var_.characterEffect1050ui_story = var_379_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_8 = 0.200000002980232

			if var_379_7 <= arg_376_1.time_ and arg_376_1.time_ < var_379_7 + var_379_8 and not isNil(var_379_6) then
				local var_379_9 = (arg_376_1.time_ - var_379_7) / var_379_8

				if arg_376_1.var_.characterEffect1050ui_story and not isNil(var_379_6) then
					local var_379_10 = Mathf.Lerp(0, 0.5, var_379_9)

					arg_376_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_376_1.var_.characterEffect1050ui_story.fillRatio = var_379_10
				end
			end

			if arg_376_1.time_ >= var_379_7 + var_379_8 and arg_376_1.time_ < var_379_7 + var_379_8 + arg_379_0 and not isNil(var_379_6) and arg_376_1.var_.characterEffect1050ui_story then
				local var_379_11 = 0.5

				arg_376_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_376_1.var_.characterEffect1050ui_story.fillRatio = var_379_11
			end

			local var_379_12 = 0
			local var_379_13 = 0.8

			if var_379_12 < arg_376_1.time_ and arg_376_1.time_ <= var_379_12 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_14 = arg_376_1:GetWordFromCfg(318041090)
				local var_379_15 = arg_376_1:FormatText(var_379_14.content)

				arg_376_1.text_.text = var_379_15

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_16 = 32
				local var_379_17 = utf8.len(var_379_15)
				local var_379_18 = var_379_16 <= 0 and var_379_13 or var_379_13 * (var_379_17 / var_379_16)

				if var_379_18 > 0 and var_379_13 < var_379_18 then
					arg_376_1.talkMaxDuration = var_379_18

					if var_379_18 + var_379_12 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_18 + var_379_12
					end
				end

				arg_376_1.text_.text = var_379_15
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_19 = math.max(var_379_13, arg_376_1.talkMaxDuration)

			if var_379_12 <= arg_376_1.time_ and arg_376_1.time_ < var_379_12 + var_379_19 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_12) / var_379_19

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_12 + var_379_19 and arg_376_1.time_ < var_379_12 + var_379_19 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play318041091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 318041091
		arg_380_1.duration_ = 6.53

		local var_380_0 = {
			zh = 4.733,
			ja = 6.533
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
				arg_380_0:Play318041092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["10066ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect10066ui_story == nil then
				arg_380_1.var_.characterEffect10066ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.200000002980232

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect10066ui_story and not isNil(var_383_0) then
					arg_380_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect10066ui_story then
				arg_380_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_383_4 = 0

			if var_383_4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action463")
			end

			local var_383_5 = 0

			if var_383_5 < arg_380_1.time_ and arg_380_1.time_ <= var_383_5 + arg_383_0 then
				arg_380_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_383_6 = 0
			local var_383_7 = 0.5

			if var_383_6 < arg_380_1.time_ and arg_380_1.time_ <= var_383_6 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_8 = arg_380_1:FormatText(StoryNameCfg[640].name)

				arg_380_1.leftNameTxt_.text = var_383_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_9 = arg_380_1:GetWordFromCfg(318041091)
				local var_383_10 = arg_380_1:FormatText(var_383_9.content)

				arg_380_1.text_.text = var_383_10

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041091", "story_v_out_318041.awb") ~= 0 then
					local var_383_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041091", "story_v_out_318041.awb") / 1000

					if var_383_14 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_14 + var_383_6
					end

					if var_383_9.prefab_name ~= "" and arg_380_1.actors_[var_383_9.prefab_name] ~= nil then
						local var_383_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_9.prefab_name].transform, "story_v_out_318041", "318041091", "story_v_out_318041.awb")

						arg_380_1:RecordAudio("318041091", var_383_15)
						arg_380_1:RecordAudio("318041091", var_383_15)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_318041", "318041091", "story_v_out_318041.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_318041", "318041091", "story_v_out_318041.awb")
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
	Play318041092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 318041092
		arg_384_1.duration_ = 2.1

		local var_384_0 = {
			zh = 2.033,
			ja = 2.1
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play318041093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1050ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1050ui_story == nil then
				arg_384_1.var_.characterEffect1050ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect1050ui_story and not isNil(var_387_0) then
					arg_384_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1050ui_story then
				arg_384_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_387_4 = arg_384_1.actors_["10066ui_story"]
			local var_387_5 = 0

			if var_387_5 < arg_384_1.time_ and arg_384_1.time_ <= var_387_5 + arg_387_0 and not isNil(var_387_4) and arg_384_1.var_.characterEffect10066ui_story == nil then
				arg_384_1.var_.characterEffect10066ui_story = var_387_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_6 = 0.200000002980232

			if var_387_5 <= arg_384_1.time_ and arg_384_1.time_ < var_387_5 + var_387_6 and not isNil(var_387_4) then
				local var_387_7 = (arg_384_1.time_ - var_387_5) / var_387_6

				if arg_384_1.var_.characterEffect10066ui_story and not isNil(var_387_4) then
					local var_387_8 = Mathf.Lerp(0, 0.5, var_387_7)

					arg_384_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_384_1.var_.characterEffect10066ui_story.fillRatio = var_387_8
				end
			end

			if arg_384_1.time_ >= var_387_5 + var_387_6 and arg_384_1.time_ < var_387_5 + var_387_6 + arg_387_0 and not isNil(var_387_4) and arg_384_1.var_.characterEffect10066ui_story then
				local var_387_9 = 0.5

				arg_384_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_384_1.var_.characterEffect10066ui_story.fillRatio = var_387_9
			end

			local var_387_10 = 0
			local var_387_11 = 0.15

			if var_387_10 < arg_384_1.time_ and arg_384_1.time_ <= var_387_10 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_12 = arg_384_1:FormatText(StoryNameCfg[74].name)

				arg_384_1.leftNameTxt_.text = var_387_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_13 = arg_384_1:GetWordFromCfg(318041092)
				local var_387_14 = arg_384_1:FormatText(var_387_13.content)

				arg_384_1.text_.text = var_387_14

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_15 = 6
				local var_387_16 = utf8.len(var_387_14)
				local var_387_17 = var_387_15 <= 0 and var_387_11 or var_387_11 * (var_387_16 / var_387_15)

				if var_387_17 > 0 and var_387_11 < var_387_17 then
					arg_384_1.talkMaxDuration = var_387_17

					if var_387_17 + var_387_10 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_17 + var_387_10
					end
				end

				arg_384_1.text_.text = var_387_14
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041092", "story_v_out_318041.awb") ~= 0 then
					local var_387_18 = manager.audio:GetVoiceLength("story_v_out_318041", "318041092", "story_v_out_318041.awb") / 1000

					if var_387_18 + var_387_10 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_18 + var_387_10
					end

					if var_387_13.prefab_name ~= "" and arg_384_1.actors_[var_387_13.prefab_name] ~= nil then
						local var_387_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_13.prefab_name].transform, "story_v_out_318041", "318041092", "story_v_out_318041.awb")

						arg_384_1:RecordAudio("318041092", var_387_19)
						arg_384_1:RecordAudio("318041092", var_387_19)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_318041", "318041092", "story_v_out_318041.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_318041", "318041092", "story_v_out_318041.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_20 = math.max(var_387_11, arg_384_1.talkMaxDuration)

			if var_387_10 <= arg_384_1.time_ and arg_384_1.time_ < var_387_10 + var_387_20 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_10) / var_387_20

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_10 + var_387_20 and arg_384_1.time_ < var_387_10 + var_387_20 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play318041093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 318041093
		arg_388_1.duration_ = 7.03

		local var_388_0 = {
			zh = 5.2,
			ja = 7.033
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
				arg_388_0:Play318041094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["10066ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect10066ui_story == nil then
				arg_388_1.var_.characterEffect10066ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect10066ui_story and not isNil(var_391_0) then
					arg_388_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect10066ui_story then
				arg_388_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_391_4 = 0

			if var_391_4 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_391_5 = arg_388_1.actors_["1050ui_story"]
			local var_391_6 = 0

			if var_391_6 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 and not isNil(var_391_5) and arg_388_1.var_.characterEffect1050ui_story == nil then
				arg_388_1.var_.characterEffect1050ui_story = var_391_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_7 = 0.200000002980232

			if var_391_6 <= arg_388_1.time_ and arg_388_1.time_ < var_391_6 + var_391_7 and not isNil(var_391_5) then
				local var_391_8 = (arg_388_1.time_ - var_391_6) / var_391_7

				if arg_388_1.var_.characterEffect1050ui_story and not isNil(var_391_5) then
					local var_391_9 = Mathf.Lerp(0, 0.5, var_391_8)

					arg_388_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1050ui_story.fillRatio = var_391_9
				end
			end

			if arg_388_1.time_ >= var_391_6 + var_391_7 and arg_388_1.time_ < var_391_6 + var_391_7 + arg_391_0 and not isNil(var_391_5) and arg_388_1.var_.characterEffect1050ui_story then
				local var_391_10 = 0.5

				arg_388_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1050ui_story.fillRatio = var_391_10
			end

			local var_391_11 = 0
			local var_391_12 = 0.4

			if var_391_11 < arg_388_1.time_ and arg_388_1.time_ <= var_391_11 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_13 = arg_388_1:FormatText(StoryNameCfg[640].name)

				arg_388_1.leftNameTxt_.text = var_391_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_14 = arg_388_1:GetWordFromCfg(318041093)
				local var_391_15 = arg_388_1:FormatText(var_391_14.content)

				arg_388_1.text_.text = var_391_15

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_16 = 16
				local var_391_17 = utf8.len(var_391_15)
				local var_391_18 = var_391_16 <= 0 and var_391_12 or var_391_12 * (var_391_17 / var_391_16)

				if var_391_18 > 0 and var_391_12 < var_391_18 then
					arg_388_1.talkMaxDuration = var_391_18

					if var_391_18 + var_391_11 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_18 + var_391_11
					end
				end

				arg_388_1.text_.text = var_391_15
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041093", "story_v_out_318041.awb") ~= 0 then
					local var_391_19 = manager.audio:GetVoiceLength("story_v_out_318041", "318041093", "story_v_out_318041.awb") / 1000

					if var_391_19 + var_391_11 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_19 + var_391_11
					end

					if var_391_14.prefab_name ~= "" and arg_388_1.actors_[var_391_14.prefab_name] ~= nil then
						local var_391_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_14.prefab_name].transform, "story_v_out_318041", "318041093", "story_v_out_318041.awb")

						arg_388_1:RecordAudio("318041093", var_391_20)
						arg_388_1:RecordAudio("318041093", var_391_20)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_318041", "318041093", "story_v_out_318041.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_318041", "318041093", "story_v_out_318041.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_21 = math.max(var_391_12, arg_388_1.talkMaxDuration)

			if var_391_11 <= arg_388_1.time_ and arg_388_1.time_ < var_391_11 + var_391_21 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_11) / var_391_21

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_11 + var_391_21 and arg_388_1.time_ < var_391_11 + var_391_21 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play318041094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 318041094
		arg_392_1.duration_ = 5.53

		local var_392_0 = {
			zh = 5.533,
			ja = 3.066
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play318041095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1050ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1050ui_story == nil then
				arg_392_1.var_.characterEffect1050ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect1050ui_story and not isNil(var_395_0) then
					arg_392_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1050ui_story then
				arg_392_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_395_4 = 0

			if var_395_4 < arg_392_1.time_ and arg_392_1.time_ <= var_395_4 + arg_395_0 then
				arg_392_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_395_5 = 0

			if var_395_5 < arg_392_1.time_ and arg_392_1.time_ <= var_395_5 + arg_395_0 then
				arg_392_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_395_6 = arg_392_1.actors_["10066ui_story"]
			local var_395_7 = 0

			if var_395_7 < arg_392_1.time_ and arg_392_1.time_ <= var_395_7 + arg_395_0 and not isNil(var_395_6) and arg_392_1.var_.characterEffect10066ui_story == nil then
				arg_392_1.var_.characterEffect10066ui_story = var_395_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_8 = 0.200000002980232

			if var_395_7 <= arg_392_1.time_ and arg_392_1.time_ < var_395_7 + var_395_8 and not isNil(var_395_6) then
				local var_395_9 = (arg_392_1.time_ - var_395_7) / var_395_8

				if arg_392_1.var_.characterEffect10066ui_story and not isNil(var_395_6) then
					local var_395_10 = Mathf.Lerp(0, 0.5, var_395_9)

					arg_392_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_392_1.var_.characterEffect10066ui_story.fillRatio = var_395_10
				end
			end

			if arg_392_1.time_ >= var_395_7 + var_395_8 and arg_392_1.time_ < var_395_7 + var_395_8 + arg_395_0 and not isNil(var_395_6) and arg_392_1.var_.characterEffect10066ui_story then
				local var_395_11 = 0.5

				arg_392_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_392_1.var_.characterEffect10066ui_story.fillRatio = var_395_11
			end

			local var_395_12 = 0
			local var_395_13 = 0.525

			if var_395_12 < arg_392_1.time_ and arg_392_1.time_ <= var_395_12 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_14 = arg_392_1:FormatText(StoryNameCfg[74].name)

				arg_392_1.leftNameTxt_.text = var_395_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_15 = arg_392_1:GetWordFromCfg(318041094)
				local var_395_16 = arg_392_1:FormatText(var_395_15.content)

				arg_392_1.text_.text = var_395_16

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_17 = 21
				local var_395_18 = utf8.len(var_395_16)
				local var_395_19 = var_395_17 <= 0 and var_395_13 or var_395_13 * (var_395_18 / var_395_17)

				if var_395_19 > 0 and var_395_13 < var_395_19 then
					arg_392_1.talkMaxDuration = var_395_19

					if var_395_19 + var_395_12 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_19 + var_395_12
					end
				end

				arg_392_1.text_.text = var_395_16
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041094", "story_v_out_318041.awb") ~= 0 then
					local var_395_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041094", "story_v_out_318041.awb") / 1000

					if var_395_20 + var_395_12 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_20 + var_395_12
					end

					if var_395_15.prefab_name ~= "" and arg_392_1.actors_[var_395_15.prefab_name] ~= nil then
						local var_395_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_15.prefab_name].transform, "story_v_out_318041", "318041094", "story_v_out_318041.awb")

						arg_392_1:RecordAudio("318041094", var_395_21)
						arg_392_1:RecordAudio("318041094", var_395_21)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_318041", "318041094", "story_v_out_318041.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_318041", "318041094", "story_v_out_318041.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_22 = math.max(var_395_13, arg_392_1.talkMaxDuration)

			if var_395_12 <= arg_392_1.time_ and arg_392_1.time_ < var_395_12 + var_395_22 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_12) / var_395_22

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_12 + var_395_22 and arg_392_1.time_ < var_395_12 + var_395_22 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play318041095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 318041095
		arg_396_1.duration_ = 10.6

		local var_396_0 = {
			zh = 10.6,
			ja = 5.9
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
				arg_396_0:Play318041096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1050ui_story"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1050ui_story == nil then
				arg_396_1.var_.characterEffect1050ui_story = var_399_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.characterEffect1050ui_story and not isNil(var_399_0) then
					arg_396_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1050ui_story then
				arg_396_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_399_4 = 0
			local var_399_5 = 1.05

			if var_399_4 < arg_396_1.time_ and arg_396_1.time_ <= var_399_4 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_6 = arg_396_1:FormatText(StoryNameCfg[74].name)

				arg_396_1.leftNameTxt_.text = var_399_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_7 = arg_396_1:GetWordFromCfg(318041095)
				local var_399_8 = arg_396_1:FormatText(var_399_7.content)

				arg_396_1.text_.text = var_399_8

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_9 = 42
				local var_399_10 = utf8.len(var_399_8)
				local var_399_11 = var_399_9 <= 0 and var_399_5 or var_399_5 * (var_399_10 / var_399_9)

				if var_399_11 > 0 and var_399_5 < var_399_11 then
					arg_396_1.talkMaxDuration = var_399_11

					if var_399_11 + var_399_4 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_11 + var_399_4
					end
				end

				arg_396_1.text_.text = var_399_8
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041095", "story_v_out_318041.awb") ~= 0 then
					local var_399_12 = manager.audio:GetVoiceLength("story_v_out_318041", "318041095", "story_v_out_318041.awb") / 1000

					if var_399_12 + var_399_4 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_12 + var_399_4
					end

					if var_399_7.prefab_name ~= "" and arg_396_1.actors_[var_399_7.prefab_name] ~= nil then
						local var_399_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_7.prefab_name].transform, "story_v_out_318041", "318041095", "story_v_out_318041.awb")

						arg_396_1:RecordAudio("318041095", var_399_13)
						arg_396_1:RecordAudio("318041095", var_399_13)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_318041", "318041095", "story_v_out_318041.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_318041", "318041095", "story_v_out_318041.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_14 = math.max(var_399_5, arg_396_1.talkMaxDuration)

			if var_399_4 <= arg_396_1.time_ and arg_396_1.time_ < var_399_4 + var_399_14 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_4) / var_399_14

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_4 + var_399_14 and arg_396_1.time_ < var_399_4 + var_399_14 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play318041096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 318041096
		arg_400_1.duration_ = 7.1

		local var_400_0 = {
			zh = 7.1,
			ja = 5.4
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play318041097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["1050ui_story"]
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect1050ui_story == nil then
				arg_400_1.var_.characterEffect1050ui_story = var_403_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_2 = 0.200000002980232

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 and not isNil(var_403_0) then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2

				if arg_400_1.var_.characterEffect1050ui_story and not isNil(var_403_0) then
					arg_400_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect1050ui_story then
				arg_400_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_403_4 = 0
			local var_403_5 = 0.775

			if var_403_4 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_6 = arg_400_1:FormatText(StoryNameCfg[74].name)

				arg_400_1.leftNameTxt_.text = var_403_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_7 = arg_400_1:GetWordFromCfg(318041096)
				local var_403_8 = arg_400_1:FormatText(var_403_7.content)

				arg_400_1.text_.text = var_403_8

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_9 = 31
				local var_403_10 = utf8.len(var_403_8)
				local var_403_11 = var_403_9 <= 0 and var_403_5 or var_403_5 * (var_403_10 / var_403_9)

				if var_403_11 > 0 and var_403_5 < var_403_11 then
					arg_400_1.talkMaxDuration = var_403_11

					if var_403_11 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_11 + var_403_4
					end
				end

				arg_400_1.text_.text = var_403_8
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041096", "story_v_out_318041.awb") ~= 0 then
					local var_403_12 = manager.audio:GetVoiceLength("story_v_out_318041", "318041096", "story_v_out_318041.awb") / 1000

					if var_403_12 + var_403_4 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_12 + var_403_4
					end

					if var_403_7.prefab_name ~= "" and arg_400_1.actors_[var_403_7.prefab_name] ~= nil then
						local var_403_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_7.prefab_name].transform, "story_v_out_318041", "318041096", "story_v_out_318041.awb")

						arg_400_1:RecordAudio("318041096", var_403_13)
						arg_400_1:RecordAudio("318041096", var_403_13)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_318041", "318041096", "story_v_out_318041.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_318041", "318041096", "story_v_out_318041.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_14 = math.max(var_403_5, arg_400_1.talkMaxDuration)

			if var_403_4 <= arg_400_1.time_ and arg_400_1.time_ < var_403_4 + var_403_14 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_4) / var_403_14

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_4 + var_403_14 and arg_400_1.time_ < var_403_4 + var_403_14 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play318041097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 318041097
		arg_404_1.duration_ = 9.8

		local var_404_0 = {
			zh = 6.833,
			ja = 9.8
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play318041098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["10066ui_story"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect10066ui_story == nil then
				arg_404_1.var_.characterEffect10066ui_story = var_407_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.characterEffect10066ui_story and not isNil(var_407_0) then
					arg_404_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect10066ui_story then
				arg_404_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_407_4 = 0

			if var_407_4 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action435")
			end

			local var_407_5 = 0

			if var_407_5 < arg_404_1.time_ and arg_404_1.time_ <= var_407_5 + arg_407_0 then
				arg_404_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_407_6 = arg_404_1.actors_["1050ui_story"]
			local var_407_7 = 0

			if var_407_7 < arg_404_1.time_ and arg_404_1.time_ <= var_407_7 + arg_407_0 and not isNil(var_407_6) and arg_404_1.var_.characterEffect1050ui_story == nil then
				arg_404_1.var_.characterEffect1050ui_story = var_407_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_8 = 0.200000002980232

			if var_407_7 <= arg_404_1.time_ and arg_404_1.time_ < var_407_7 + var_407_8 and not isNil(var_407_6) then
				local var_407_9 = (arg_404_1.time_ - var_407_7) / var_407_8

				if arg_404_1.var_.characterEffect1050ui_story and not isNil(var_407_6) then
					local var_407_10 = Mathf.Lerp(0, 0.5, var_407_9)

					arg_404_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1050ui_story.fillRatio = var_407_10
				end
			end

			if arg_404_1.time_ >= var_407_7 + var_407_8 and arg_404_1.time_ < var_407_7 + var_407_8 + arg_407_0 and not isNil(var_407_6) and arg_404_1.var_.characterEffect1050ui_story then
				local var_407_11 = 0.5

				arg_404_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1050ui_story.fillRatio = var_407_11
			end

			local var_407_12 = 0
			local var_407_13 = 0.325

			if var_407_12 < arg_404_1.time_ and arg_404_1.time_ <= var_407_12 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_14 = arg_404_1:FormatText(StoryNameCfg[640].name)

				arg_404_1.leftNameTxt_.text = var_407_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_15 = arg_404_1:GetWordFromCfg(318041097)
				local var_407_16 = arg_404_1:FormatText(var_407_15.content)

				arg_404_1.text_.text = var_407_16

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_17 = 13
				local var_407_18 = utf8.len(var_407_16)
				local var_407_19 = var_407_17 <= 0 and var_407_13 or var_407_13 * (var_407_18 / var_407_17)

				if var_407_19 > 0 and var_407_13 < var_407_19 then
					arg_404_1.talkMaxDuration = var_407_19

					if var_407_19 + var_407_12 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_19 + var_407_12
					end
				end

				arg_404_1.text_.text = var_407_16
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041097", "story_v_out_318041.awb") ~= 0 then
					local var_407_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041097", "story_v_out_318041.awb") / 1000

					if var_407_20 + var_407_12 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_20 + var_407_12
					end

					if var_407_15.prefab_name ~= "" and arg_404_1.actors_[var_407_15.prefab_name] ~= nil then
						local var_407_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_15.prefab_name].transform, "story_v_out_318041", "318041097", "story_v_out_318041.awb")

						arg_404_1:RecordAudio("318041097", var_407_21)
						arg_404_1:RecordAudio("318041097", var_407_21)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_318041", "318041097", "story_v_out_318041.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_318041", "318041097", "story_v_out_318041.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_22 = math.max(var_407_13, arg_404_1.talkMaxDuration)

			if var_407_12 <= arg_404_1.time_ and arg_404_1.time_ < var_407_12 + var_407_22 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_12) / var_407_22

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_12 + var_407_22 and arg_404_1.time_ < var_407_12 + var_407_22 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play318041098 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 318041098
		arg_408_1.duration_ = 9.13

		local var_408_0 = {
			zh = 4.466,
			ja = 9.133
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play318041099(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["10066ui_story"]
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect10066ui_story == nil then
				arg_408_1.var_.characterEffect10066ui_story = var_411_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 and not isNil(var_411_0) then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2

				if arg_408_1.var_.characterEffect10066ui_story and not isNil(var_411_0) then
					arg_408_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect10066ui_story then
				arg_408_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_411_4 = 0

			if var_411_4 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_2")
			end

			local var_411_5 = 0

			if var_411_5 < arg_408_1.time_ and arg_408_1.time_ <= var_411_5 + arg_411_0 then
				arg_408_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_411_6 = 0
			local var_411_7 = 0.5

			if var_411_6 < arg_408_1.time_ and arg_408_1.time_ <= var_411_6 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_8 = arg_408_1:FormatText(StoryNameCfg[640].name)

				arg_408_1.leftNameTxt_.text = var_411_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_9 = arg_408_1:GetWordFromCfg(318041098)
				local var_411_10 = arg_408_1:FormatText(var_411_9.content)

				arg_408_1.text_.text = var_411_10

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_11 = 20
				local var_411_12 = utf8.len(var_411_10)
				local var_411_13 = var_411_11 <= 0 and var_411_7 or var_411_7 * (var_411_12 / var_411_11)

				if var_411_13 > 0 and var_411_7 < var_411_13 then
					arg_408_1.talkMaxDuration = var_411_13

					if var_411_13 + var_411_6 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_13 + var_411_6
					end
				end

				arg_408_1.text_.text = var_411_10
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041098", "story_v_out_318041.awb") ~= 0 then
					local var_411_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041098", "story_v_out_318041.awb") / 1000

					if var_411_14 + var_411_6 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_14 + var_411_6
					end

					if var_411_9.prefab_name ~= "" and arg_408_1.actors_[var_411_9.prefab_name] ~= nil then
						local var_411_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_9.prefab_name].transform, "story_v_out_318041", "318041098", "story_v_out_318041.awb")

						arg_408_1:RecordAudio("318041098", var_411_15)
						arg_408_1:RecordAudio("318041098", var_411_15)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_318041", "318041098", "story_v_out_318041.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_318041", "318041098", "story_v_out_318041.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_16 = math.max(var_411_7, arg_408_1.talkMaxDuration)

			if var_411_6 <= arg_408_1.time_ and arg_408_1.time_ < var_411_6 + var_411_16 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_6) / var_411_16

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_6 + var_411_16 and arg_408_1.time_ < var_411_6 + var_411_16 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play318041099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 318041099
		arg_412_1.duration_ = 7.47

		local var_412_0 = {
			zh = 7.466,
			ja = 6.2
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play318041100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.85

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[640].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_3 = arg_412_1:GetWordFromCfg(318041099)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 34
				local var_415_6 = utf8.len(var_415_4)
				local var_415_7 = var_415_5 <= 0 and var_415_1 or var_415_1 * (var_415_6 / var_415_5)

				if var_415_7 > 0 and var_415_1 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041099", "story_v_out_318041.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041099", "story_v_out_318041.awb") / 1000

					if var_415_8 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_0
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_out_318041", "318041099", "story_v_out_318041.awb")

						arg_412_1:RecordAudio("318041099", var_415_9)
						arg_412_1:RecordAudio("318041099", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_318041", "318041099", "story_v_out_318041.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_318041", "318041099", "story_v_out_318041.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_10 and arg_412_1.time_ < var_415_0 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play318041100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 318041100
		arg_416_1.duration_ = 8.6

		local var_416_0 = {
			zh = 8.6,
			ja = 6
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play318041101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 1.025

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[640].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_3 = arg_416_1:GetWordFromCfg(318041100)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 41
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041100", "story_v_out_318041.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041100", "story_v_out_318041.awb") / 1000

					if var_419_8 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_0
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_out_318041", "318041100", "story_v_out_318041.awb")

						arg_416_1:RecordAudio("318041100", var_419_9)
						arg_416_1:RecordAudio("318041100", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_318041", "318041100", "story_v_out_318041.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_318041", "318041100", "story_v_out_318041.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_10 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_10 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_10

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_10 and arg_416_1.time_ < var_419_0 + var_419_10 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play318041101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 318041101
		arg_420_1.duration_ = 3.83

		local var_420_0 = {
			zh = 3.833,
			ja = 3.8
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play318041102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1050ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1050ui_story == nil then
				arg_420_1.var_.characterEffect1050ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect1050ui_story and not isNil(var_423_0) then
					arg_420_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1050ui_story then
				arg_420_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_423_4 = arg_420_1.actors_["10066ui_story"]
			local var_423_5 = 0

			if var_423_5 < arg_420_1.time_ and arg_420_1.time_ <= var_423_5 + arg_423_0 and not isNil(var_423_4) and arg_420_1.var_.characterEffect10066ui_story == nil then
				arg_420_1.var_.characterEffect10066ui_story = var_423_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_6 = 0.200000002980232

			if var_423_5 <= arg_420_1.time_ and arg_420_1.time_ < var_423_5 + var_423_6 and not isNil(var_423_4) then
				local var_423_7 = (arg_420_1.time_ - var_423_5) / var_423_6

				if arg_420_1.var_.characterEffect10066ui_story and not isNil(var_423_4) then
					local var_423_8 = Mathf.Lerp(0, 0.5, var_423_7)

					arg_420_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_420_1.var_.characterEffect10066ui_story.fillRatio = var_423_8
				end
			end

			if arg_420_1.time_ >= var_423_5 + var_423_6 and arg_420_1.time_ < var_423_5 + var_423_6 + arg_423_0 and not isNil(var_423_4) and arg_420_1.var_.characterEffect10066ui_story then
				local var_423_9 = 0.5

				arg_420_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_420_1.var_.characterEffect10066ui_story.fillRatio = var_423_9
			end

			local var_423_10 = 0
			local var_423_11 = 0.275

			if var_423_10 < arg_420_1.time_ and arg_420_1.time_ <= var_423_10 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_12 = arg_420_1:FormatText(StoryNameCfg[74].name)

				arg_420_1.leftNameTxt_.text = var_423_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_13 = arg_420_1:GetWordFromCfg(318041101)
				local var_423_14 = arg_420_1:FormatText(var_423_13.content)

				arg_420_1.text_.text = var_423_14

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_15 = 11
				local var_423_16 = utf8.len(var_423_14)
				local var_423_17 = var_423_15 <= 0 and var_423_11 or var_423_11 * (var_423_16 / var_423_15)

				if var_423_17 > 0 and var_423_11 < var_423_17 then
					arg_420_1.talkMaxDuration = var_423_17

					if var_423_17 + var_423_10 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_17 + var_423_10
					end
				end

				arg_420_1.text_.text = var_423_14
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041101", "story_v_out_318041.awb") ~= 0 then
					local var_423_18 = manager.audio:GetVoiceLength("story_v_out_318041", "318041101", "story_v_out_318041.awb") / 1000

					if var_423_18 + var_423_10 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_18 + var_423_10
					end

					if var_423_13.prefab_name ~= "" and arg_420_1.actors_[var_423_13.prefab_name] ~= nil then
						local var_423_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_13.prefab_name].transform, "story_v_out_318041", "318041101", "story_v_out_318041.awb")

						arg_420_1:RecordAudio("318041101", var_423_19)
						arg_420_1:RecordAudio("318041101", var_423_19)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_318041", "318041101", "story_v_out_318041.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_318041", "318041101", "story_v_out_318041.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_20 = math.max(var_423_11, arg_420_1.talkMaxDuration)

			if var_423_10 <= arg_420_1.time_ and arg_420_1.time_ < var_423_10 + var_423_20 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_10) / var_423_20

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_10 + var_423_20 and arg_420_1.time_ < var_423_10 + var_423_20 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play318041102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 318041102
		arg_424_1.duration_ = 9

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play318041103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 2

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				local var_427_1 = manager.ui.mainCamera.transform.localPosition
				local var_427_2 = Vector3.New(0, 0, 10) + Vector3.New(var_427_1.x, var_427_1.y, 0)
				local var_427_3 = arg_424_1.bgs_.ST69

				var_427_3.transform.localPosition = var_427_2
				var_427_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_427_4 = var_427_3:GetComponent("SpriteRenderer")

				if var_427_4 and var_427_4.sprite then
					local var_427_5 = (var_427_3.transform.localPosition - var_427_1).z
					local var_427_6 = manager.ui.mainCameraCom_
					local var_427_7 = 2 * var_427_5 * Mathf.Tan(var_427_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_427_8 = var_427_7 * var_427_6.aspect
					local var_427_9 = var_427_4.sprite.bounds.size.x
					local var_427_10 = var_427_4.sprite.bounds.size.y
					local var_427_11 = var_427_8 / var_427_9
					local var_427_12 = var_427_7 / var_427_10
					local var_427_13 = var_427_12 < var_427_11 and var_427_11 or var_427_12

					var_427_3.transform.localScale = Vector3.New(var_427_13, var_427_13, 0)
				end

				for iter_427_0, iter_427_1 in pairs(arg_424_1.bgs_) do
					if iter_427_0 ~= "ST69" then
						iter_427_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_427_14 = 0

			if var_427_14 < arg_424_1.time_ and arg_424_1.time_ <= var_427_14 + arg_427_0 then
				arg_424_1.mask_.enabled = true
				arg_424_1.mask_.raycastTarget = true

				arg_424_1:SetGaussion(false)
			end

			local var_427_15 = 2

			if var_427_14 <= arg_424_1.time_ and arg_424_1.time_ < var_427_14 + var_427_15 then
				local var_427_16 = (arg_424_1.time_ - var_427_14) / var_427_15
				local var_427_17 = Color.New(0, 0, 0)

				var_427_17.a = Mathf.Lerp(0, 1, var_427_16)
				arg_424_1.mask_.color = var_427_17
			end

			if arg_424_1.time_ >= var_427_14 + var_427_15 and arg_424_1.time_ < var_427_14 + var_427_15 + arg_427_0 then
				local var_427_18 = Color.New(0, 0, 0)

				var_427_18.a = 1
				arg_424_1.mask_.color = var_427_18
			end

			local var_427_19 = 2

			if var_427_19 < arg_424_1.time_ and arg_424_1.time_ <= var_427_19 + arg_427_0 then
				arg_424_1.mask_.enabled = true
				arg_424_1.mask_.raycastTarget = true

				arg_424_1:SetGaussion(false)
			end

			local var_427_20 = 2

			if var_427_19 <= arg_424_1.time_ and arg_424_1.time_ < var_427_19 + var_427_20 then
				local var_427_21 = (arg_424_1.time_ - var_427_19) / var_427_20
				local var_427_22 = Color.New(0, 0, 0)

				var_427_22.a = Mathf.Lerp(1, 0, var_427_21)
				arg_424_1.mask_.color = var_427_22
			end

			if arg_424_1.time_ >= var_427_19 + var_427_20 and arg_424_1.time_ < var_427_19 + var_427_20 + arg_427_0 then
				local var_427_23 = Color.New(0, 0, 0)
				local var_427_24 = 0

				arg_424_1.mask_.enabled = false
				var_427_23.a = var_427_24
				arg_424_1.mask_.color = var_427_23
			end

			local var_427_25 = arg_424_1.actors_["1050ui_story"].transform
			local var_427_26 = 2

			if var_427_26 < arg_424_1.time_ and arg_424_1.time_ <= var_427_26 + arg_427_0 then
				arg_424_1.var_.moveOldPos1050ui_story = var_427_25.localPosition
			end

			local var_427_27 = 0.001

			if var_427_26 <= arg_424_1.time_ and arg_424_1.time_ < var_427_26 + var_427_27 then
				local var_427_28 = (arg_424_1.time_ - var_427_26) / var_427_27
				local var_427_29 = Vector3.New(0, 100, 0)

				var_427_25.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1050ui_story, var_427_29, var_427_28)

				local var_427_30 = manager.ui.mainCamera.transform.position - var_427_25.position

				var_427_25.forward = Vector3.New(var_427_30.x, var_427_30.y, var_427_30.z)

				local var_427_31 = var_427_25.localEulerAngles

				var_427_31.z = 0
				var_427_31.x = 0
				var_427_25.localEulerAngles = var_427_31
			end

			if arg_424_1.time_ >= var_427_26 + var_427_27 and arg_424_1.time_ < var_427_26 + var_427_27 + arg_427_0 then
				var_427_25.localPosition = Vector3.New(0, 100, 0)

				local var_427_32 = manager.ui.mainCamera.transform.position - var_427_25.position

				var_427_25.forward = Vector3.New(var_427_32.x, var_427_32.y, var_427_32.z)

				local var_427_33 = var_427_25.localEulerAngles

				var_427_33.z = 0
				var_427_33.x = 0
				var_427_25.localEulerAngles = var_427_33
			end

			local var_427_34 = arg_424_1.actors_["1050ui_story"]
			local var_427_35 = 2

			if var_427_35 < arg_424_1.time_ and arg_424_1.time_ <= var_427_35 + arg_427_0 and not isNil(var_427_34) and arg_424_1.var_.characterEffect1050ui_story == nil then
				arg_424_1.var_.characterEffect1050ui_story = var_427_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_36 = 0.200000002980232

			if var_427_35 <= arg_424_1.time_ and arg_424_1.time_ < var_427_35 + var_427_36 and not isNil(var_427_34) then
				local var_427_37 = (arg_424_1.time_ - var_427_35) / var_427_36

				if arg_424_1.var_.characterEffect1050ui_story and not isNil(var_427_34) then
					local var_427_38 = Mathf.Lerp(0, 0.5, var_427_37)

					arg_424_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1050ui_story.fillRatio = var_427_38
				end
			end

			if arg_424_1.time_ >= var_427_35 + var_427_36 and arg_424_1.time_ < var_427_35 + var_427_36 + arg_427_0 and not isNil(var_427_34) and arg_424_1.var_.characterEffect1050ui_story then
				local var_427_39 = 0.5

				arg_424_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1050ui_story.fillRatio = var_427_39
			end

			local var_427_40 = arg_424_1.actors_["10066ui_story"].transform
			local var_427_41 = 2

			if var_427_41 < arg_424_1.time_ and arg_424_1.time_ <= var_427_41 + arg_427_0 then
				arg_424_1.var_.moveOldPos10066ui_story = var_427_40.localPosition
			end

			local var_427_42 = 0.001

			if var_427_41 <= arg_424_1.time_ and arg_424_1.time_ < var_427_41 + var_427_42 then
				local var_427_43 = (arg_424_1.time_ - var_427_41) / var_427_42
				local var_427_44 = Vector3.New(0, 100, 0)

				var_427_40.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10066ui_story, var_427_44, var_427_43)

				local var_427_45 = manager.ui.mainCamera.transform.position - var_427_40.position

				var_427_40.forward = Vector3.New(var_427_45.x, var_427_45.y, var_427_45.z)

				local var_427_46 = var_427_40.localEulerAngles

				var_427_46.z = 0
				var_427_46.x = 0
				var_427_40.localEulerAngles = var_427_46
			end

			if arg_424_1.time_ >= var_427_41 + var_427_42 and arg_424_1.time_ < var_427_41 + var_427_42 + arg_427_0 then
				var_427_40.localPosition = Vector3.New(0, 100, 0)

				local var_427_47 = manager.ui.mainCamera.transform.position - var_427_40.position

				var_427_40.forward = Vector3.New(var_427_47.x, var_427_47.y, var_427_47.z)

				local var_427_48 = var_427_40.localEulerAngles

				var_427_48.z = 0
				var_427_48.x = 0
				var_427_40.localEulerAngles = var_427_48
			end

			if arg_424_1.frameCnt_ <= 1 then
				arg_424_1.dialog_:SetActive(false)
			end

			local var_427_49 = 4
			local var_427_50 = 0.525

			if var_427_49 < arg_424_1.time_ and arg_424_1.time_ <= var_427_49 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0

				arg_424_1.dialog_:SetActive(true)

				arg_424_1.dialogCg_.alpha = 0

				local var_427_51 = LeanTween.value(arg_424_1.dialog_, 0, 1, 0.3)

				var_427_51:setOnUpdate(LuaHelper.FloatAction(function(arg_428_0)
					arg_424_1.dialogCg_.alpha = arg_428_0
				end))
				var_427_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_424_1.dialog_)
					var_427_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_424_1.duration_ = arg_424_1.duration_ + 0.3

				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_52 = arg_424_1:GetWordFromCfg(318041102)
				local var_427_53 = arg_424_1:FormatText(var_427_52.content)

				arg_424_1.text_.text = var_427_53

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_54 = 21
				local var_427_55 = utf8.len(var_427_53)
				local var_427_56 = var_427_54 <= 0 and var_427_50 or var_427_50 * (var_427_55 / var_427_54)

				if var_427_56 > 0 and var_427_50 < var_427_56 then
					arg_424_1.talkMaxDuration = var_427_56
					var_427_49 = var_427_49 + 0.3

					if var_427_56 + var_427_49 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_56 + var_427_49
					end
				end

				arg_424_1.text_.text = var_427_53
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_57 = var_427_49 + 0.3
			local var_427_58 = math.max(var_427_50, arg_424_1.talkMaxDuration)

			if var_427_57 <= arg_424_1.time_ and arg_424_1.time_ < var_427_57 + var_427_58 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_57) / var_427_58

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_57 + var_427_58 and arg_424_1.time_ < var_427_57 + var_427_58 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play318041103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 318041103
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play318041104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 0.875

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_2 = arg_430_1:GetWordFromCfg(318041103)
				local var_433_3 = arg_430_1:FormatText(var_433_2.content)

				arg_430_1.text_.text = var_433_3

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 35
				local var_433_5 = utf8.len(var_433_3)
				local var_433_6 = var_433_4 <= 0 and var_433_1 or var_433_1 * (var_433_5 / var_433_4)

				if var_433_6 > 0 and var_433_1 < var_433_6 then
					arg_430_1.talkMaxDuration = var_433_6

					if var_433_6 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_6 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_3
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_7 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_7 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_7

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_7 and arg_430_1.time_ < var_433_0 + var_433_7 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play318041104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 318041104
		arg_434_1.duration_ = 9.2

		local var_434_0 = {
			zh = 7.4,
			ja = 9.2
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play318041105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1050ui_story"].transform
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.var_.moveOldPos1050ui_story = var_437_0.localPosition
			end

			local var_437_2 = 0.001

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2
				local var_437_4 = Vector3.New(0, -1, -6.1)

				var_437_0.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1050ui_story, var_437_4, var_437_3)

				local var_437_5 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_5.x, var_437_5.y, var_437_5.z)

				local var_437_6 = var_437_0.localEulerAngles

				var_437_6.z = 0
				var_437_6.x = 0
				var_437_0.localEulerAngles = var_437_6
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 then
				var_437_0.localPosition = Vector3.New(0, -1, -6.1)

				local var_437_7 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_7.x, var_437_7.y, var_437_7.z)

				local var_437_8 = var_437_0.localEulerAngles

				var_437_8.z = 0
				var_437_8.x = 0
				var_437_0.localEulerAngles = var_437_8
			end

			local var_437_9 = arg_434_1.actors_["1050ui_story"]
			local var_437_10 = 0

			if var_437_10 < arg_434_1.time_ and arg_434_1.time_ <= var_437_10 + arg_437_0 and not isNil(var_437_9) and arg_434_1.var_.characterEffect1050ui_story == nil then
				arg_434_1.var_.characterEffect1050ui_story = var_437_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_11 = 0.200000002980232

			if var_437_10 <= arg_434_1.time_ and arg_434_1.time_ < var_437_10 + var_437_11 and not isNil(var_437_9) then
				local var_437_12 = (arg_434_1.time_ - var_437_10) / var_437_11

				if arg_434_1.var_.characterEffect1050ui_story and not isNil(var_437_9) then
					arg_434_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= var_437_10 + var_437_11 and arg_434_1.time_ < var_437_10 + var_437_11 + arg_437_0 and not isNil(var_437_9) and arg_434_1.var_.characterEffect1050ui_story then
				arg_434_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_437_13 = 0

			if var_437_13 < arg_434_1.time_ and arg_434_1.time_ <= var_437_13 + arg_437_0 then
				arg_434_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			local var_437_14 = 0

			if var_437_14 < arg_434_1.time_ and arg_434_1.time_ <= var_437_14 + arg_437_0 then
				arg_434_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_437_15 = 0
			local var_437_16 = 0.45

			if var_437_15 < arg_434_1.time_ and arg_434_1.time_ <= var_437_15 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_17 = arg_434_1:FormatText(StoryNameCfg[74].name)

				arg_434_1.leftNameTxt_.text = var_437_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_18 = arg_434_1:GetWordFromCfg(318041104)
				local var_437_19 = arg_434_1:FormatText(var_437_18.content)

				arg_434_1.text_.text = var_437_19

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_20 = 18
				local var_437_21 = utf8.len(var_437_19)
				local var_437_22 = var_437_20 <= 0 and var_437_16 or var_437_16 * (var_437_21 / var_437_20)

				if var_437_22 > 0 and var_437_16 < var_437_22 then
					arg_434_1.talkMaxDuration = var_437_22

					if var_437_22 + var_437_15 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_22 + var_437_15
					end
				end

				arg_434_1.text_.text = var_437_19
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041104", "story_v_out_318041.awb") ~= 0 then
					local var_437_23 = manager.audio:GetVoiceLength("story_v_out_318041", "318041104", "story_v_out_318041.awb") / 1000

					if var_437_23 + var_437_15 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_23 + var_437_15
					end

					if var_437_18.prefab_name ~= "" and arg_434_1.actors_[var_437_18.prefab_name] ~= nil then
						local var_437_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_18.prefab_name].transform, "story_v_out_318041", "318041104", "story_v_out_318041.awb")

						arg_434_1:RecordAudio("318041104", var_437_24)
						arg_434_1:RecordAudio("318041104", var_437_24)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_318041", "318041104", "story_v_out_318041.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_318041", "318041104", "story_v_out_318041.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_25 = math.max(var_437_16, arg_434_1.talkMaxDuration)

			if var_437_15 <= arg_434_1.time_ and arg_434_1.time_ < var_437_15 + var_437_25 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_15) / var_437_25

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_15 + var_437_25 and arg_434_1.time_ < var_437_15 + var_437_25 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play318041105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 318041105
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play318041106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1050ui_story"].transform
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.var_.moveOldPos1050ui_story = var_441_0.localPosition
			end

			local var_441_2 = 0.001

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2
				local var_441_4 = Vector3.New(0, 100, 0)

				var_441_0.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1050ui_story, var_441_4, var_441_3)

				local var_441_5 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_5.x, var_441_5.y, var_441_5.z)

				local var_441_6 = var_441_0.localEulerAngles

				var_441_6.z = 0
				var_441_6.x = 0
				var_441_0.localEulerAngles = var_441_6
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 then
				var_441_0.localPosition = Vector3.New(0, 100, 0)

				local var_441_7 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_7.x, var_441_7.y, var_441_7.z)

				local var_441_8 = var_441_0.localEulerAngles

				var_441_8.z = 0
				var_441_8.x = 0
				var_441_0.localEulerAngles = var_441_8
			end

			local var_441_9 = arg_438_1.actors_["1050ui_story"]
			local var_441_10 = 0

			if var_441_10 < arg_438_1.time_ and arg_438_1.time_ <= var_441_10 + arg_441_0 and not isNil(var_441_9) and arg_438_1.var_.characterEffect1050ui_story == nil then
				arg_438_1.var_.characterEffect1050ui_story = var_441_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_11 = 0.200000002980232

			if var_441_10 <= arg_438_1.time_ and arg_438_1.time_ < var_441_10 + var_441_11 and not isNil(var_441_9) then
				local var_441_12 = (arg_438_1.time_ - var_441_10) / var_441_11

				if arg_438_1.var_.characterEffect1050ui_story and not isNil(var_441_9) then
					local var_441_13 = Mathf.Lerp(0, 0.5, var_441_12)

					arg_438_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_438_1.var_.characterEffect1050ui_story.fillRatio = var_441_13
				end
			end

			if arg_438_1.time_ >= var_441_10 + var_441_11 and arg_438_1.time_ < var_441_10 + var_441_11 + arg_441_0 and not isNil(var_441_9) and arg_438_1.var_.characterEffect1050ui_story then
				local var_441_14 = 0.5

				arg_438_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_438_1.var_.characterEffect1050ui_story.fillRatio = var_441_14
			end

			local var_441_15 = 0
			local var_441_16 = 1.025

			if var_441_15 < arg_438_1.time_ and arg_438_1.time_ <= var_441_15 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_17 = arg_438_1:GetWordFromCfg(318041105)
				local var_441_18 = arg_438_1:FormatText(var_441_17.content)

				arg_438_1.text_.text = var_441_18

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_19 = 41
				local var_441_20 = utf8.len(var_441_18)
				local var_441_21 = var_441_19 <= 0 and var_441_16 or var_441_16 * (var_441_20 / var_441_19)

				if var_441_21 > 0 and var_441_16 < var_441_21 then
					arg_438_1.talkMaxDuration = var_441_21

					if var_441_21 + var_441_15 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_21 + var_441_15
					end
				end

				arg_438_1.text_.text = var_441_18
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_22 = math.max(var_441_16, arg_438_1.talkMaxDuration)

			if var_441_15 <= arg_438_1.time_ and arg_438_1.time_ < var_441_15 + var_441_22 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_15) / var_441_22

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_15 + var_441_22 and arg_438_1.time_ < var_441_15 + var_441_22 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play318041106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 318041106
		arg_442_1.duration_ = 3.4

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play318041107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = "STblack"

			if arg_442_1.bgs_[var_445_0] == nil then
				local var_445_1 = Object.Instantiate(arg_442_1.paintGo_)

				var_445_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_445_0)
				var_445_1.name = var_445_0
				var_445_1.transform.parent = arg_442_1.stage_.transform
				var_445_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_442_1.bgs_[var_445_0] = var_445_1
			end

			local var_445_2 = 0

			if var_445_2 < arg_442_1.time_ and arg_442_1.time_ <= var_445_2 + arg_445_0 then
				local var_445_3 = manager.ui.mainCamera.transform.localPosition
				local var_445_4 = Vector3.New(0, 0, 10) + Vector3.New(var_445_3.x, var_445_3.y, 0)
				local var_445_5 = arg_442_1.bgs_.STblack

				var_445_5.transform.localPosition = var_445_4
				var_445_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_445_6 = var_445_5:GetComponent("SpriteRenderer")

				if var_445_6 and var_445_6.sprite then
					local var_445_7 = (var_445_5.transform.localPosition - var_445_3).z
					local var_445_8 = manager.ui.mainCameraCom_
					local var_445_9 = 2 * var_445_7 * Mathf.Tan(var_445_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_445_10 = var_445_9 * var_445_8.aspect
					local var_445_11 = var_445_6.sprite.bounds.size.x
					local var_445_12 = var_445_6.sprite.bounds.size.y
					local var_445_13 = var_445_10 / var_445_11
					local var_445_14 = var_445_9 / var_445_12
					local var_445_15 = var_445_14 < var_445_13 and var_445_13 or var_445_14

					var_445_5.transform.localScale = Vector3.New(var_445_15, var_445_15, 0)
				end

				for iter_445_0, iter_445_1 in pairs(arg_442_1.bgs_) do
					if iter_445_0 ~= "STblack" then
						iter_445_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_445_16 = 0

			if var_445_16 < arg_442_1.time_ and arg_442_1.time_ <= var_445_16 + arg_445_0 then
				arg_442_1.mask_.enabled = true
				arg_442_1.mask_.raycastTarget = true

				arg_442_1:SetGaussion(false)
			end

			local var_445_17 = 1

			if var_445_16 <= arg_442_1.time_ and arg_442_1.time_ < var_445_16 + var_445_17 then
				local var_445_18 = (arg_442_1.time_ - var_445_16) / var_445_17
				local var_445_19 = Color.New(1, 1, 1)

				var_445_19.a = Mathf.Lerp(1, 0, var_445_18)
				arg_442_1.mask_.color = var_445_19
			end

			if arg_442_1.time_ >= var_445_16 + var_445_17 and arg_442_1.time_ < var_445_16 + var_445_17 + arg_445_0 then
				local var_445_20 = Color.New(1, 1, 1)
				local var_445_21 = 0

				arg_442_1.mask_.enabled = false
				var_445_20.a = var_445_21
				arg_442_1.mask_.color = var_445_20
			end

			if arg_442_1.frameCnt_ <= 1 then
				arg_442_1.dialog_:SetActive(false)
			end

			local var_445_22 = 1.20000000298023
			local var_445_23 = 0.075

			if var_445_22 < arg_442_1.time_ and arg_442_1.time_ <= var_445_22 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0

				arg_442_1.dialog_:SetActive(true)

				arg_442_1.dialogCg_.alpha = 0

				local var_445_24 = LeanTween.value(arg_442_1.dialog_, 0, 1, 0.3)

				var_445_24:setOnUpdate(LuaHelper.FloatAction(function(arg_446_0)
					arg_442_1.dialogCg_.alpha = arg_446_0
				end))
				var_445_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_442_1.dialog_)
					var_445_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_442_1.duration_ = arg_442_1.duration_ + 0.3

				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_25 = arg_442_1:FormatText(StoryNameCfg[74].name)

				arg_442_1.leftNameTxt_.text = var_445_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_26 = arg_442_1:GetWordFromCfg(318041106)
				local var_445_27 = arg_442_1:FormatText(var_445_26.content)

				arg_442_1.text_.text = var_445_27

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_28 = 3
				local var_445_29 = utf8.len(var_445_27)
				local var_445_30 = var_445_28 <= 0 and var_445_23 or var_445_23 * (var_445_29 / var_445_28)

				if var_445_30 > 0 and var_445_23 < var_445_30 then
					arg_442_1.talkMaxDuration = var_445_30
					var_445_22 = var_445_22 + 0.3

					if var_445_30 + var_445_22 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_30 + var_445_22
					end
				end

				arg_442_1.text_.text = var_445_27
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041106", "story_v_out_318041.awb") ~= 0 then
					local var_445_31 = manager.audio:GetVoiceLength("story_v_out_318041", "318041106", "story_v_out_318041.awb") / 1000

					if var_445_31 + var_445_22 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_31 + var_445_22
					end

					if var_445_26.prefab_name ~= "" and arg_442_1.actors_[var_445_26.prefab_name] ~= nil then
						local var_445_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_26.prefab_name].transform, "story_v_out_318041", "318041106", "story_v_out_318041.awb")

						arg_442_1:RecordAudio("318041106", var_445_32)
						arg_442_1:RecordAudio("318041106", var_445_32)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_318041", "318041106", "story_v_out_318041.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_318041", "318041106", "story_v_out_318041.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_33 = var_445_22 + 0.3
			local var_445_34 = math.max(var_445_23, arg_442_1.talkMaxDuration)

			if var_445_33 <= arg_442_1.time_ and arg_442_1.time_ < var_445_33 + var_445_34 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_33) / var_445_34

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_33 + var_445_34 and arg_442_1.time_ < var_445_33 + var_445_34 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play318041107 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 318041107
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play318041108(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["1050ui_story"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1050ui_story == nil then
				arg_448_1.var_.characterEffect1050ui_story = var_451_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.characterEffect1050ui_story and not isNil(var_451_0) then
					local var_451_4 = Mathf.Lerp(0, 0.5, var_451_3)

					arg_448_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1050ui_story.fillRatio = var_451_4
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1050ui_story then
				local var_451_5 = 0.5

				arg_448_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1050ui_story.fillRatio = var_451_5
			end

			local var_451_6 = 0
			local var_451_7 = 1

			if var_451_6 < arg_448_1.time_ and arg_448_1.time_ <= var_451_6 + arg_451_0 then
				local var_451_8 = "play"
				local var_451_9 = "effect"

				arg_448_1:AudioAction(var_451_8, var_451_9, "se_story_122_03", "se_story_122_03_swordlight", "")
			end

			local var_451_10 = 0
			local var_451_11 = 1.075

			if var_451_10 < arg_448_1.time_ and arg_448_1.time_ <= var_451_10 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_12 = arg_448_1:GetWordFromCfg(318041107)
				local var_451_13 = arg_448_1:FormatText(var_451_12.content)

				arg_448_1.text_.text = var_451_13

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_14 = 43
				local var_451_15 = utf8.len(var_451_13)
				local var_451_16 = var_451_14 <= 0 and var_451_11 or var_451_11 * (var_451_15 / var_451_14)

				if var_451_16 > 0 and var_451_11 < var_451_16 then
					arg_448_1.talkMaxDuration = var_451_16

					if var_451_16 + var_451_10 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_16 + var_451_10
					end
				end

				arg_448_1.text_.text = var_451_13
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_17 = math.max(var_451_11, arg_448_1.talkMaxDuration)

			if var_451_10 <= arg_448_1.time_ and arg_448_1.time_ < var_451_10 + var_451_17 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_10) / var_451_17

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_10 + var_451_17 and arg_448_1.time_ < var_451_10 + var_451_17 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play318041108 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 318041108
		arg_452_1.duration_ = 2.97

		local var_452_0 = {
			zh = 2.166,
			ja = 2.966
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play318041109(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 0.433333333333333

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				local var_455_2 = "play"
				local var_455_3 = "music"

				arg_452_1:AudioAction(var_455_2, var_455_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_455_4 = ""
				local var_455_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_455_5 ~= "" then
					if arg_452_1.bgmTxt_.text ~= var_455_5 and arg_452_1.bgmTxt_.text ~= "" then
						if arg_452_1.bgmTxt2_.text ~= "" then
							arg_452_1.bgmTxt_.text = arg_452_1.bgmTxt2_.text
						end

						arg_452_1.bgmTxt2_.text = var_455_5

						arg_452_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_452_1.bgmTxt_.text = var_455_5
						arg_452_1.bgmTxt2_.text = var_455_5
					end

					if arg_452_1.bgmTimer then
						arg_452_1.bgmTimer:Stop()

						arg_452_1.bgmTimer = nil
					end

					if arg_452_1.settingData.show_music_name == 1 then
						arg_452_1.musicController:SetSelectedState("show")
						arg_452_1.musicAnimator_:Play("open", 0, 0)

						if arg_452_1.settingData.music_time ~= 0 then
							arg_452_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_452_1.settingData.music_time), function()
								if arg_452_1 == nil or isNil(arg_452_1.bgmTxt_) then
									return
								end

								arg_452_1.musicController:SetSelectedState("hide")
								arg_452_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_455_6 = 0
			local var_455_7 = 0.125

			if var_455_6 < arg_452_1.time_ and arg_452_1.time_ <= var_455_6 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0

				arg_452_1.dialog_:SetActive(true)

				arg_452_1.dialogCg_.alpha = 0

				local var_455_8 = LeanTween.value(arg_452_1.dialog_, 0, 1, 0.3)

				var_455_8:setOnUpdate(LuaHelper.FloatAction(function(arg_457_0)
					arg_452_1.dialogCg_.alpha = arg_457_0
				end))
				var_455_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_452_1.dialog_)
					var_455_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_452_1.duration_ = arg_452_1.duration_ + 0.3

				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_9 = arg_452_1:FormatText(StoryNameCfg[640].name)

				arg_452_1.leftNameTxt_.text = var_455_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_10 = arg_452_1:GetWordFromCfg(318041108)
				local var_455_11 = arg_452_1:FormatText(var_455_10.content)

				arg_452_1.text_.text = var_455_11

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_12 = 5
				local var_455_13 = utf8.len(var_455_11)
				local var_455_14 = var_455_12 <= 0 and var_455_7 or var_455_7 * (var_455_13 / var_455_12)

				if var_455_14 > 0 and var_455_7 < var_455_14 then
					arg_452_1.talkMaxDuration = var_455_14
					var_455_6 = var_455_6 + 0.3

					if var_455_14 + var_455_6 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_14 + var_455_6
					end
				end

				arg_452_1.text_.text = var_455_11
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041108", "story_v_out_318041.awb") ~= 0 then
					local var_455_15 = manager.audio:GetVoiceLength("story_v_out_318041", "318041108", "story_v_out_318041.awb") / 1000

					if var_455_15 + var_455_6 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_15 + var_455_6
					end

					if var_455_10.prefab_name ~= "" and arg_452_1.actors_[var_455_10.prefab_name] ~= nil then
						local var_455_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_10.prefab_name].transform, "story_v_out_318041", "318041108", "story_v_out_318041.awb")

						arg_452_1:RecordAudio("318041108", var_455_16)
						arg_452_1:RecordAudio("318041108", var_455_16)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_318041", "318041108", "story_v_out_318041.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_318041", "318041108", "story_v_out_318041.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_17 = var_455_6 + 0.3
			local var_455_18 = math.max(var_455_7, arg_452_1.talkMaxDuration)

			if var_455_17 <= arg_452_1.time_ and arg_452_1.time_ < var_455_17 + var_455_18 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_17) / var_455_18

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_17 + var_455_18 and arg_452_1.time_ < var_455_17 + var_455_18 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play318041109 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 318041109
		arg_459_1.duration_ = 7

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play318041110(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = "LX0102"

			if arg_459_1.bgs_[var_462_0] == nil then
				local var_462_1 = Object.Instantiate(arg_459_1.paintGo_)

				var_462_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_462_0)
				var_462_1.name = var_462_0
				var_462_1.transform.parent = arg_459_1.stage_.transform
				var_462_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_459_1.bgs_[var_462_0] = var_462_1
			end

			local var_462_2 = 0

			if var_462_2 < arg_459_1.time_ and arg_459_1.time_ <= var_462_2 + arg_462_0 then
				local var_462_3 = manager.ui.mainCamera.transform.localPosition
				local var_462_4 = Vector3.New(0, 0, 10) + Vector3.New(var_462_3.x, var_462_3.y, 0)
				local var_462_5 = arg_459_1.bgs_.LX0102

				var_462_5.transform.localPosition = var_462_4
				var_462_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_462_6 = var_462_5:GetComponent("SpriteRenderer")

				if var_462_6 and var_462_6.sprite then
					local var_462_7 = (var_462_5.transform.localPosition - var_462_3).z
					local var_462_8 = manager.ui.mainCameraCom_
					local var_462_9 = 2 * var_462_7 * Mathf.Tan(var_462_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_462_10 = var_462_9 * var_462_8.aspect
					local var_462_11 = var_462_6.sprite.bounds.size.x
					local var_462_12 = var_462_6.sprite.bounds.size.y
					local var_462_13 = var_462_10 / var_462_11
					local var_462_14 = var_462_9 / var_462_12
					local var_462_15 = var_462_14 < var_462_13 and var_462_13 or var_462_14

					var_462_5.transform.localScale = Vector3.New(var_462_15, var_462_15, 0)
				end

				for iter_462_0, iter_462_1 in pairs(arg_459_1.bgs_) do
					if iter_462_0 ~= "LX0102" then
						iter_462_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_462_16 = 0

			if var_462_16 < arg_459_1.time_ and arg_459_1.time_ <= var_462_16 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_17 = 2

			if var_462_16 <= arg_459_1.time_ and arg_459_1.time_ < var_462_16 + var_462_17 then
				local var_462_18 = (arg_459_1.time_ - var_462_16) / var_462_17
				local var_462_19 = Color.New(1, 1, 1)

				var_462_19.a = Mathf.Lerp(1, 0, var_462_18)
				arg_459_1.mask_.color = var_462_19
			end

			if arg_459_1.time_ >= var_462_16 + var_462_17 and arg_459_1.time_ < var_462_16 + var_462_17 + arg_462_0 then
				local var_462_20 = Color.New(1, 1, 1)
				local var_462_21 = 0

				arg_459_1.mask_.enabled = false
				var_462_20.a = var_462_21
				arg_459_1.mask_.color = var_462_20
			end

			local var_462_22 = 0
			local var_462_23 = 0.433333333333333

			if var_462_22 < arg_459_1.time_ and arg_459_1.time_ <= var_462_22 + arg_462_0 then
				local var_462_24 = "play"
				local var_462_25 = "effect"

				arg_459_1:AudioAction(var_462_24, var_462_25, "se_story_120_00", "se_story_120_00_lingguang03", "")
			end

			local var_462_26 = arg_459_1.actors_["1050ui_story"].transform
			local var_462_27 = 2

			if var_462_27 < arg_459_1.time_ and arg_459_1.time_ <= var_462_27 + arg_462_0 then
				arg_459_1.var_.moveOldPos1050ui_story = var_462_26.localPosition
			end

			local var_462_28 = 0.001

			if var_462_27 <= arg_459_1.time_ and arg_459_1.time_ < var_462_27 + var_462_28 then
				local var_462_29 = (arg_459_1.time_ - var_462_27) / var_462_28
				local var_462_30 = Vector3.New(0, 100, 0)

				var_462_26.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos1050ui_story, var_462_30, var_462_29)

				local var_462_31 = manager.ui.mainCamera.transform.position - var_462_26.position

				var_462_26.forward = Vector3.New(var_462_31.x, var_462_31.y, var_462_31.z)

				local var_462_32 = var_462_26.localEulerAngles

				var_462_32.z = 0
				var_462_32.x = 0
				var_462_26.localEulerAngles = var_462_32
			end

			if arg_459_1.time_ >= var_462_27 + var_462_28 and arg_459_1.time_ < var_462_27 + var_462_28 + arg_462_0 then
				var_462_26.localPosition = Vector3.New(0, 100, 0)

				local var_462_33 = manager.ui.mainCamera.transform.position - var_462_26.position

				var_462_26.forward = Vector3.New(var_462_33.x, var_462_33.y, var_462_33.z)

				local var_462_34 = var_462_26.localEulerAngles

				var_462_34.z = 0
				var_462_34.x = 0
				var_462_26.localEulerAngles = var_462_34
			end

			local var_462_35 = arg_459_1.bgs_.LX0102.transform
			local var_462_36 = 0

			if var_462_36 < arg_459_1.time_ and arg_459_1.time_ <= var_462_36 + arg_462_0 then
				arg_459_1.var_.moveOldPosLX0102 = var_462_35.localPosition
			end

			local var_462_37 = 0.001

			if var_462_36 <= arg_459_1.time_ and arg_459_1.time_ < var_462_36 + var_462_37 then
				local var_462_38 = (arg_459_1.time_ - var_462_36) / var_462_37
				local var_462_39 = Vector3.New(0, 1, 6)

				var_462_35.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPosLX0102, var_462_39, var_462_38)
			end

			if arg_459_1.time_ >= var_462_36 + var_462_37 and arg_459_1.time_ < var_462_36 + var_462_37 + arg_462_0 then
				var_462_35.localPosition = Vector3.New(0, 1, 6)
			end

			local var_462_40 = arg_459_1.bgs_.LX0102.transform
			local var_462_41 = 0.0166666666666667

			if var_462_41 < arg_459_1.time_ and arg_459_1.time_ <= var_462_41 + arg_462_0 then
				arg_459_1.var_.moveOldPosLX0102 = var_462_40.localPosition
			end

			local var_462_42 = 6.5

			if var_462_41 <= arg_459_1.time_ and arg_459_1.time_ < var_462_41 + var_462_42 then
				local var_462_43 = (arg_459_1.time_ - var_462_41) / var_462_42
				local var_462_44 = Vector3.New(0, 1, 9.5)

				var_462_40.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPosLX0102, var_462_44, var_462_43)
			end

			if arg_459_1.time_ >= var_462_41 + var_462_42 and arg_459_1.time_ < var_462_41 + var_462_42 + arg_462_0 then
				var_462_40.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_462_45 = 2.03400000184774

			if var_462_45 < arg_459_1.time_ and arg_459_1.time_ <= var_462_45 + arg_462_0 then
				arg_459_1.allBtn_.enabled = false
			end

			local var_462_46 = 4.48266666481892

			if arg_459_1.time_ >= var_462_45 + var_462_46 and arg_459_1.time_ < var_462_45 + var_462_46 + arg_462_0 then
				arg_459_1.allBtn_.enabled = true
			end

			local var_462_47 = 0
			local var_462_48 = 0.433333333333333

			if var_462_47 < arg_459_1.time_ and arg_459_1.time_ <= var_462_47 + arg_462_0 then
				local var_462_49 = "play"
				local var_462_50 = "effect"

				arg_459_1:AudioAction(var_462_49, var_462_50, "se_story_1210", "se_story_1210_loop_wind", "")
			end

			if arg_459_1.frameCnt_ <= 1 then
				arg_459_1.dialog_:SetActive(false)
			end

			local var_462_51 = 2
			local var_462_52 = 0.25

			if var_462_51 < arg_459_1.time_ and arg_459_1.time_ <= var_462_51 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0

				arg_459_1.dialog_:SetActive(true)

				arg_459_1.dialogCg_.alpha = 0

				local var_462_53 = LeanTween.value(arg_459_1.dialog_, 0, 1, 0.3)

				var_462_53:setOnUpdate(LuaHelper.FloatAction(function(arg_463_0)
					arg_459_1.dialogCg_.alpha = arg_463_0
				end))
				var_462_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_459_1.dialog_)
					var_462_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_459_1.duration_ = arg_459_1.duration_ + 0.3

				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_54 = arg_459_1:GetWordFromCfg(318041109)
				local var_462_55 = arg_459_1:FormatText(var_462_54.content)

				arg_459_1.text_.text = var_462_55

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_56 = 10
				local var_462_57 = utf8.len(var_462_55)
				local var_462_58 = var_462_56 <= 0 and var_462_52 or var_462_52 * (var_462_57 / var_462_56)

				if var_462_58 > 0 and var_462_52 < var_462_58 then
					arg_459_1.talkMaxDuration = var_462_58
					var_462_51 = var_462_51 + 0.3

					if var_462_58 + var_462_51 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_58 + var_462_51
					end
				end

				arg_459_1.text_.text = var_462_55
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_59 = var_462_51 + 0.3
			local var_462_60 = math.max(var_462_52, arg_459_1.talkMaxDuration)

			if var_462_59 <= arg_459_1.time_ and arg_459_1.time_ < var_462_59 + var_462_60 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_59) / var_462_60

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_59 + var_462_60 and arg_459_1.time_ < var_462_59 + var_462_60 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "LX0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LX0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play318041110 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 318041110
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play318041111(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 1.025

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_2 = arg_465_1:GetWordFromCfg(318041110)
				local var_468_3 = arg_465_1:FormatText(var_468_2.content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 41
				local var_468_5 = utf8.len(var_468_3)
				local var_468_6 = var_468_4 <= 0 and var_468_1 or var_468_1 * (var_468_5 / var_468_4)

				if var_468_6 > 0 and var_468_1 < var_468_6 then
					arg_465_1.talkMaxDuration = var_468_6

					if var_468_6 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_7 and arg_465_1.time_ < var_468_0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play318041111 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 318041111
		arg_469_1.duration_ = 3.13

		local var_469_0 = {
			zh = 1.266,
			ja = 3.133
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
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play318041112(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.15

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[36].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_3 = arg_469_1:GetWordFromCfg(318041111)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 6
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_1 or var_472_1 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_1 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041111", "story_v_out_318041.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041111", "story_v_out_318041.awb") / 1000

					if var_472_8 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_0
					end

					if var_472_3.prefab_name ~= "" and arg_469_1.actors_[var_472_3.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_3.prefab_name].transform, "story_v_out_318041", "318041111", "story_v_out_318041.awb")

						arg_469_1:RecordAudio("318041111", var_472_9)
						arg_469_1:RecordAudio("318041111", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_318041", "318041111", "story_v_out_318041.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_318041", "318041111", "story_v_out_318041.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_10 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_10 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_10

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_10 and arg_469_1.time_ < var_472_0 + var_472_10 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play318041112 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 318041112
		arg_473_1.duration_ = 9.93

		local var_473_0 = {
			zh = 5.333,
			ja = 9.933
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play318041113(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.6

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[650].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_3 = arg_473_1:GetWordFromCfg(318041112)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041112", "story_v_out_318041.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041112", "story_v_out_318041.awb") / 1000

					if var_476_8 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_0
					end

					if var_476_3.prefab_name ~= "" and arg_473_1.actors_[var_476_3.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_3.prefab_name].transform, "story_v_out_318041", "318041112", "story_v_out_318041.awb")

						arg_473_1:RecordAudio("318041112", var_476_9)
						arg_473_1:RecordAudio("318041112", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_318041", "318041112", "story_v_out_318041.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_318041", "318041112", "story_v_out_318041.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_10 and arg_473_1.time_ < var_476_0 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play318041113 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 318041113
		arg_477_1.duration_ = 8.2

		local var_477_0 = {
			zh = 5,
			ja = 8.2
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play318041114(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 0.65

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_2 = arg_477_1:FormatText(StoryNameCfg[36].name)

				arg_477_1.leftNameTxt_.text = var_480_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_3 = arg_477_1:GetWordFromCfg(318041113)
				local var_480_4 = arg_477_1:FormatText(var_480_3.content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 26
				local var_480_6 = utf8.len(var_480_4)
				local var_480_7 = var_480_5 <= 0 and var_480_1 or var_480_1 * (var_480_6 / var_480_5)

				if var_480_7 > 0 and var_480_1 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_4
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041113", "story_v_out_318041.awb") ~= 0 then
					local var_480_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041113", "story_v_out_318041.awb") / 1000

					if var_480_8 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_0
					end

					if var_480_3.prefab_name ~= "" and arg_477_1.actors_[var_480_3.prefab_name] ~= nil then
						local var_480_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_3.prefab_name].transform, "story_v_out_318041", "318041113", "story_v_out_318041.awb")

						arg_477_1:RecordAudio("318041113", var_480_9)
						arg_477_1:RecordAudio("318041113", var_480_9)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_318041", "318041113", "story_v_out_318041.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_318041", "318041113", "story_v_out_318041.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_10 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_10 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_10

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_10 and arg_477_1.time_ < var_480_0 + var_480_10 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play318041114 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 318041114
		arg_481_1.duration_ = 7.9

		local var_481_0 = {
			zh = 7.9,
			ja = 6.333
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play318041115(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.75

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_2 = arg_481_1:FormatText(StoryNameCfg[650].name)

				arg_481_1.leftNameTxt_.text = var_484_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_3 = arg_481_1:GetWordFromCfg(318041114)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 30
				local var_484_6 = utf8.len(var_484_4)
				local var_484_7 = var_484_5 <= 0 and var_484_1 or var_484_1 * (var_484_6 / var_484_5)

				if var_484_7 > 0 and var_484_1 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041114", "story_v_out_318041.awb") ~= 0 then
					local var_484_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041114", "story_v_out_318041.awb") / 1000

					if var_484_8 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_8 + var_484_0
					end

					if var_484_3.prefab_name ~= "" and arg_481_1.actors_[var_484_3.prefab_name] ~= nil then
						local var_484_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_3.prefab_name].transform, "story_v_out_318041", "318041114", "story_v_out_318041.awb")

						arg_481_1:RecordAudio("318041114", var_484_9)
						arg_481_1:RecordAudio("318041114", var_484_9)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_318041", "318041114", "story_v_out_318041.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_318041", "318041114", "story_v_out_318041.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_10 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_10 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_10

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_10 and arg_481_1.time_ < var_484_0 + var_484_10 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play318041115 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 318041115
		arg_485_1.duration_ = 3.93

		local var_485_0 = {
			zh = 2.933,
			ja = 3.933
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play318041116(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0
			local var_488_1 = 0.25

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_2 = arg_485_1:FormatText(StoryNameCfg[650].name)

				arg_485_1.leftNameTxt_.text = var_488_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_3 = arg_485_1:GetWordFromCfg(318041115)
				local var_488_4 = arg_485_1:FormatText(var_488_3.content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 10
				local var_488_6 = utf8.len(var_488_4)
				local var_488_7 = var_488_5 <= 0 and var_488_1 or var_488_1 * (var_488_6 / var_488_5)

				if var_488_7 > 0 and var_488_1 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_4
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041115", "story_v_out_318041.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041115", "story_v_out_318041.awb") / 1000

					if var_488_8 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_0
					end

					if var_488_3.prefab_name ~= "" and arg_485_1.actors_[var_488_3.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_3.prefab_name].transform, "story_v_out_318041", "318041115", "story_v_out_318041.awb")

						arg_485_1:RecordAudio("318041115", var_488_9)
						arg_485_1:RecordAudio("318041115", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_318041", "318041115", "story_v_out_318041.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_318041", "318041115", "story_v_out_318041.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_10 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_10 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_10

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_10 and arg_485_1.time_ < var_488_0 + var_488_10 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play318041116 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 318041116
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play318041117(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.bgs_.LX0102.transform
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.var_.moveOldPosLX0102 = var_492_0.localPosition
			end

			local var_492_2 = 0.001

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2
				local var_492_4 = Vector3.New(0, 1, 9)

				var_492_0.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPosLX0102, var_492_4, var_492_3)
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 then
				var_492_0.localPosition = Vector3.New(0, 1, 9)
			end

			local var_492_5 = arg_489_1.bgs_.LX0102.transform
			local var_492_6 = 0.0166666666666667

			if var_492_6 < arg_489_1.time_ and arg_489_1.time_ <= var_492_6 + arg_492_0 then
				arg_489_1.var_.moveOldPosLX0102 = var_492_5.localPosition
			end

			local var_492_7 = 3.5

			if var_492_6 <= arg_489_1.time_ and arg_489_1.time_ < var_492_6 + var_492_7 then
				local var_492_8 = (arg_489_1.time_ - var_492_6) / var_492_7
				local var_492_9 = Vector3.New(0, 1, 10)

				var_492_5.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPosLX0102, var_492_9, var_492_8)
			end

			if arg_489_1.time_ >= var_492_6 + var_492_7 and arg_489_1.time_ < var_492_6 + var_492_7 + arg_492_0 then
				var_492_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_492_10 = 0.433333333333333

			if var_492_10 < arg_489_1.time_ and arg_489_1.time_ <= var_492_10 + arg_492_0 then
				arg_489_1.allBtn_.enabled = false
			end

			local var_492_11 = 3.08333333333333

			if arg_489_1.time_ >= var_492_10 + var_492_11 and arg_489_1.time_ < var_492_10 + var_492_11 + arg_492_0 then
				arg_489_1.allBtn_.enabled = true
			end

			local var_492_12 = 0
			local var_492_13 = 1.025

			if var_492_12 < arg_489_1.time_ and arg_489_1.time_ <= var_492_12 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_14 = arg_489_1:GetWordFromCfg(318041116)
				local var_492_15 = arg_489_1:FormatText(var_492_14.content)

				arg_489_1.text_.text = var_492_15

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_16 = 41
				local var_492_17 = utf8.len(var_492_15)
				local var_492_18 = var_492_16 <= 0 and var_492_13 or var_492_13 * (var_492_17 / var_492_16)

				if var_492_18 > 0 and var_492_13 < var_492_18 then
					arg_489_1.talkMaxDuration = var_492_18

					if var_492_18 + var_492_12 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_18 + var_492_12
					end
				end

				arg_489_1.text_.text = var_492_15
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_19 = math.max(var_492_13, arg_489_1.talkMaxDuration)

			if var_492_12 <= arg_489_1.time_ and arg_489_1.time_ < var_492_12 + var_492_19 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_12) / var_492_19

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_12 + var_492_19 and arg_489_1.time_ < var_492_12 + var_492_19 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "LX0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LX0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play318041117 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 318041117
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play318041118(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0
			local var_496_1 = 1.2

			if var_496_0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_2 = arg_493_1:GetWordFromCfg(318041117)
				local var_496_3 = arg_493_1:FormatText(var_496_2.content)

				arg_493_1.text_.text = var_496_3

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_4 = 48
				local var_496_5 = utf8.len(var_496_3)
				local var_496_6 = var_496_4 <= 0 and var_496_1 or var_496_1 * (var_496_5 / var_496_4)

				if var_496_6 > 0 and var_496_1 < var_496_6 then
					arg_493_1.talkMaxDuration = var_496_6

					if var_496_6 + var_496_0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_6 + var_496_0
					end
				end

				arg_493_1.text_.text = var_496_3
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_7 = math.max(var_496_1, arg_493_1.talkMaxDuration)

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_7 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_0) / var_496_7

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_0 + var_496_7 and arg_493_1.time_ < var_496_0 + var_496_7 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play318041118 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 318041118
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play318041119(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0
			local var_500_1 = 1.25

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_2 = arg_497_1:GetWordFromCfg(318041118)
				local var_500_3 = arg_497_1:FormatText(var_500_2.content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 50
				local var_500_5 = utf8.len(var_500_3)
				local var_500_6 = var_500_4 <= 0 and var_500_1 or var_500_1 * (var_500_5 / var_500_4)

				if var_500_6 > 0 and var_500_1 < var_500_6 then
					arg_497_1.talkMaxDuration = var_500_6

					if var_500_6 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_6 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_0) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_0 + var_500_7 and arg_497_1.time_ < var_500_0 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play318041119 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 318041119
		arg_501_1.duration_ = 8.87

		local var_501_0 = {
			zh = 4.333,
			ja = 8.866
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play318041120(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0
			local var_504_1 = 0.45

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_2 = arg_501_1:FormatText(StoryNameCfg[650].name)

				arg_501_1.leftNameTxt_.text = var_504_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_3 = arg_501_1:GetWordFromCfg(318041119)
				local var_504_4 = arg_501_1:FormatText(var_504_3.content)

				arg_501_1.text_.text = var_504_4

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041119", "story_v_out_318041.awb") ~= 0 then
					local var_504_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041119", "story_v_out_318041.awb") / 1000

					if var_504_8 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_8 + var_504_0
					end

					if var_504_3.prefab_name ~= "" and arg_501_1.actors_[var_504_3.prefab_name] ~= nil then
						local var_504_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_3.prefab_name].transform, "story_v_out_318041", "318041119", "story_v_out_318041.awb")

						arg_501_1:RecordAudio("318041119", var_504_9)
						arg_501_1:RecordAudio("318041119", var_504_9)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_318041", "318041119", "story_v_out_318041.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_318041", "318041119", "story_v_out_318041.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_10 = math.max(var_504_1, arg_501_1.talkMaxDuration)

			if var_504_0 <= arg_501_1.time_ and arg_501_1.time_ < var_504_0 + var_504_10 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_0) / var_504_10

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_0 + var_504_10 and arg_501_1.time_ < var_504_0 + var_504_10 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play318041120 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 318041120
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play318041121(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0
			local var_508_1 = 1.225

			if var_508_0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_2 = arg_505_1:GetWordFromCfg(318041120)
				local var_508_3 = arg_505_1:FormatText(var_508_2.content)

				arg_505_1.text_.text = var_508_3

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_4 = 49
				local var_508_5 = utf8.len(var_508_3)
				local var_508_6 = var_508_4 <= 0 and var_508_1 or var_508_1 * (var_508_5 / var_508_4)

				if var_508_6 > 0 and var_508_1 < var_508_6 then
					arg_505_1.talkMaxDuration = var_508_6

					if var_508_6 + var_508_0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_6 + var_508_0
					end
				end

				arg_505_1.text_.text = var_508_3
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_7 = math.max(var_508_1, arg_505_1.talkMaxDuration)

			if var_508_0 <= arg_505_1.time_ and arg_505_1.time_ < var_508_0 + var_508_7 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_0) / var_508_7

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_0 + var_508_7 and arg_505_1.time_ < var_508_0 + var_508_7 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play318041121 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 318041121
		arg_509_1.duration_ = 3.7

		local var_509_0 = {
			zh = 1.633,
			ja = 3.7
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play318041122(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0
			local var_512_1 = 0.175

			if var_512_0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_2 = arg_509_1:FormatText(StoryNameCfg[650].name)

				arg_509_1.leftNameTxt_.text = var_512_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_3 = arg_509_1:GetWordFromCfg(318041121)
				local var_512_4 = arg_509_1:FormatText(var_512_3.content)

				arg_509_1.text_.text = var_512_4

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 7
				local var_512_6 = utf8.len(var_512_4)
				local var_512_7 = var_512_5 <= 0 and var_512_1 or var_512_1 * (var_512_6 / var_512_5)

				if var_512_7 > 0 and var_512_1 < var_512_7 then
					arg_509_1.talkMaxDuration = var_512_7

					if var_512_7 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_7 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_4
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041121", "story_v_out_318041.awb") ~= 0 then
					local var_512_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041121", "story_v_out_318041.awb") / 1000

					if var_512_8 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_8 + var_512_0
					end

					if var_512_3.prefab_name ~= "" and arg_509_1.actors_[var_512_3.prefab_name] ~= nil then
						local var_512_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_3.prefab_name].transform, "story_v_out_318041", "318041121", "story_v_out_318041.awb")

						arg_509_1:RecordAudio("318041121", var_512_9)
						arg_509_1:RecordAudio("318041121", var_512_9)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_318041", "318041121", "story_v_out_318041.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_318041", "318041121", "story_v_out_318041.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_10 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_10 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_10

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_10 and arg_509_1.time_ < var_512_0 + var_512_10 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play318041122 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 318041122
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play318041123(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.975

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_2 = arg_513_1:GetWordFromCfg(318041122)
				local var_516_3 = arg_513_1:FormatText(var_516_2.content)

				arg_513_1.text_.text = var_516_3

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_4 = 39
				local var_516_5 = utf8.len(var_516_3)
				local var_516_6 = var_516_4 <= 0 and var_516_1 or var_516_1 * (var_516_5 / var_516_4)

				if var_516_6 > 0 and var_516_1 < var_516_6 then
					arg_513_1.talkMaxDuration = var_516_6

					if var_516_6 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_6 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_3
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_7 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_7 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_7

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_7 and arg_513_1.time_ < var_516_0 + var_516_7 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play318041123 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 318041123
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play318041124(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0
			local var_520_1 = 0.675

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_2 = arg_517_1:GetWordFromCfg(318041123)
				local var_520_3 = arg_517_1:FormatText(var_520_2.content)

				arg_517_1.text_.text = var_520_3

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 27
				local var_520_5 = utf8.len(var_520_3)
				local var_520_6 = var_520_4 <= 0 and var_520_1 or var_520_1 * (var_520_5 / var_520_4)

				if var_520_6 > 0 and var_520_1 < var_520_6 then
					arg_517_1.talkMaxDuration = var_520_6

					if var_520_6 + var_520_0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_6 + var_520_0
					end
				end

				arg_517_1.text_.text = var_520_3
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_1, arg_517_1.talkMaxDuration)

			if var_520_0 <= arg_517_1.time_ and arg_517_1.time_ < var_520_0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_0 + var_520_7 and arg_517_1.time_ < var_520_0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play318041124 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 318041124
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play318041125(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0
			local var_524_1 = 0.475

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_2 = arg_521_1:GetWordFromCfg(318041124)
				local var_524_3 = arg_521_1:FormatText(var_524_2.content)

				arg_521_1.text_.text = var_524_3

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 19
				local var_524_5 = utf8.len(var_524_3)
				local var_524_6 = var_524_4 <= 0 and var_524_1 or var_524_1 * (var_524_5 / var_524_4)

				if var_524_6 > 0 and var_524_1 < var_524_6 then
					arg_521_1.talkMaxDuration = var_524_6

					if var_524_6 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_6 + var_524_0
					end
				end

				arg_521_1.text_.text = var_524_3
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_1, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_7 and arg_521_1.time_ < var_524_0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play318041125 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 318041125
		arg_525_1.duration_ = 3.37

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play318041126(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = "LX0102_blur"

			if arg_525_1.bgs_[var_528_0] == nil then
				local var_528_1 = Object.Instantiate(arg_525_1.paintGo_)

				var_528_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_528_0)
				var_528_1.name = var_528_0
				var_528_1.transform.parent = arg_525_1.stage_.transform
				var_528_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_525_1.bgs_[var_528_0] = var_528_1
			end

			local var_528_2 = 1

			if var_528_2 < arg_525_1.time_ and arg_525_1.time_ <= var_528_2 + arg_528_0 then
				local var_528_3 = manager.ui.mainCamera.transform.localPosition
				local var_528_4 = Vector3.New(0, 0, 10) + Vector3.New(var_528_3.x, var_528_3.y, 0)
				local var_528_5 = arg_525_1.bgs_.LX0102_blur

				var_528_5.transform.localPosition = var_528_4
				var_528_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_528_6 = var_528_5:GetComponent("SpriteRenderer")

				if var_528_6 and var_528_6.sprite then
					local var_528_7 = (var_528_5.transform.localPosition - var_528_3).z
					local var_528_8 = manager.ui.mainCameraCom_
					local var_528_9 = 2 * var_528_7 * Mathf.Tan(var_528_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_528_10 = var_528_9 * var_528_8.aspect
					local var_528_11 = var_528_6.sprite.bounds.size.x
					local var_528_12 = var_528_6.sprite.bounds.size.y
					local var_528_13 = var_528_10 / var_528_11
					local var_528_14 = var_528_9 / var_528_12
					local var_528_15 = var_528_14 < var_528_13 and var_528_13 or var_528_14

					var_528_5.transform.localScale = Vector3.New(var_528_15, var_528_15, 0)
				end

				for iter_528_0, iter_528_1 in pairs(arg_525_1.bgs_) do
					if iter_528_0 ~= "LX0102_blur" then
						iter_528_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_528_16 = "LX0102_blur"

			if arg_525_1.bgs_[var_528_16] == nil then
				local var_528_17 = Object.Instantiate(arg_525_1.blurPaintGo_)
				local var_528_18 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_528_16)

				var_528_17:GetComponent("SpriteRenderer").sprite = var_528_18
				var_528_17.name = var_528_16
				var_528_17.transform.parent = arg_525_1.stage_.transform
				var_528_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_525_1.bgs_[var_528_16] = var_528_17
			end

			local var_528_19 = 1
			local var_528_20 = arg_525_1.bgs_[var_528_16]

			if var_528_19 < arg_525_1.time_ and arg_525_1.time_ <= var_528_19 + arg_528_0 then
				local var_528_21 = manager.ui.mainCamera.transform.localPosition
				local var_528_22 = Vector3.New(0, 0, 10) + Vector3.New(var_528_21.x, var_528_21.y, 0)

				var_528_20.transform.localPosition = var_528_22
				var_528_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_528_23 = var_528_20:GetComponent("SpriteRenderer")

				if var_528_23 and var_528_23.sprite then
					local var_528_24 = (var_528_20.transform.localPosition - var_528_21).z
					local var_528_25 = manager.ui.mainCameraCom_
					local var_528_26 = 2 * var_528_24 * Mathf.Tan(var_528_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_528_27 = var_528_26 * var_528_25.aspect
					local var_528_28 = var_528_23.sprite.bounds.size.x
					local var_528_29 = var_528_23.sprite.bounds.size.y
					local var_528_30 = var_528_27 / var_528_28
					local var_528_31 = var_528_26 / var_528_29
					local var_528_32 = var_528_31 < var_528_30 and var_528_30 or var_528_31

					var_528_20.transform.localScale = Vector3.New(var_528_32, var_528_32, 0)
				end
			end

			local var_528_33 = 2

			if var_528_19 <= arg_525_1.time_ and arg_525_1.time_ < var_528_19 + var_528_33 then
				local var_528_34 = (arg_525_1.time_ - var_528_19) / var_528_33
				local var_528_35 = Color.New(1, 1, 1)

				var_528_35.a = Mathf.Lerp(0, 1, var_528_34)

				var_528_20:GetComponent("SpriteRenderer").material:SetColor("_Color", var_528_35)
			end

			local var_528_36 = arg_525_1.bgs_.LX0102.transform
			local var_528_37 = 1

			if var_528_37 < arg_525_1.time_ and arg_525_1.time_ <= var_528_37 + arg_528_0 then
				arg_525_1.var_.moveOldPosLX0102 = var_528_36.localPosition
			end

			local var_528_38 = 2

			if var_528_37 <= arg_525_1.time_ and arg_525_1.time_ < var_528_37 + var_528_38 then
				local var_528_39 = (arg_525_1.time_ - var_528_37) / var_528_38
				local var_528_40 = Vector3.New(0, 1, 9.5)

				var_528_36.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPosLX0102, var_528_40, var_528_39)
			end

			if arg_525_1.time_ >= var_528_37 + var_528_38 and arg_525_1.time_ < var_528_37 + var_528_38 + arg_528_0 then
				var_528_36.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_528_41 = 0

			if var_528_41 < arg_525_1.time_ and arg_525_1.time_ <= var_528_41 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_42 = 1

			if var_528_41 <= arg_525_1.time_ and arg_525_1.time_ < var_528_41 + var_528_42 then
				local var_528_43 = (arg_525_1.time_ - var_528_41) / var_528_42
				local var_528_44 = Color.New(0, 0, 0)

				var_528_44.a = Mathf.Lerp(0, 1, var_528_43)
				arg_525_1.mask_.color = var_528_44
			end

			if arg_525_1.time_ >= var_528_41 + var_528_42 and arg_525_1.time_ < var_528_41 + var_528_42 + arg_528_0 then
				local var_528_45 = Color.New(0, 0, 0)

				var_528_45.a = 1
				arg_525_1.mask_.color = var_528_45
			end

			local var_528_46 = 1

			if var_528_46 < arg_525_1.time_ and arg_525_1.time_ <= var_528_46 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_47 = 1

			if var_528_46 <= arg_525_1.time_ and arg_525_1.time_ < var_528_46 + var_528_47 then
				local var_528_48 = (arg_525_1.time_ - var_528_46) / var_528_47
				local var_528_49 = Color.New(0, 0, 0)

				var_528_49.a = Mathf.Lerp(1, 0, var_528_48)
				arg_525_1.mask_.color = var_528_49
			end

			if arg_525_1.time_ >= var_528_46 + var_528_47 and arg_525_1.time_ < var_528_46 + var_528_47 + arg_528_0 then
				local var_528_50 = Color.New(0, 0, 0)
				local var_528_51 = 0

				arg_525_1.mask_.enabled = false
				var_528_50.a = var_528_51
				arg_525_1.mask_.color = var_528_50
			end

			if arg_525_1.frameCnt_ <= 1 then
				arg_525_1.dialog_:SetActive(false)
			end

			local var_528_52 = 1
			local var_528_53 = 0.125

			if var_528_52 < arg_525_1.time_ and arg_525_1.time_ <= var_528_52 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0

				arg_525_1.dialog_:SetActive(true)

				arg_525_1.dialogCg_.alpha = 0

				local var_528_54 = LeanTween.value(arg_525_1.dialog_, 0, 1, 0.3)

				var_528_54:setOnUpdate(LuaHelper.FloatAction(function(arg_529_0)
					arg_525_1.dialogCg_.alpha = arg_529_0
				end))
				var_528_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_525_1.dialog_)
					var_528_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_525_1.duration_ = arg_525_1.duration_ + 0.3

				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_55 = arg_525_1:FormatText(StoryNameCfg[74].name)

				arg_525_1.leftNameTxt_.text = var_528_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_56 = arg_525_1:GetWordFromCfg(318041125)
				local var_528_57 = arg_525_1:FormatText(var_528_56.content)

				arg_525_1.text_.text = var_528_57

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_58 = 5
				local var_528_59 = utf8.len(var_528_57)
				local var_528_60 = var_528_58 <= 0 and var_528_53 or var_528_53 * (var_528_59 / var_528_58)

				if var_528_60 > 0 and var_528_53 < var_528_60 then
					arg_525_1.talkMaxDuration = var_528_60
					var_528_52 = var_528_52 + 0.3

					if var_528_60 + var_528_52 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_60 + var_528_52
					end
				end

				arg_525_1.text_.text = var_528_57
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041125", "story_v_out_318041.awb") ~= 0 then
					local var_528_61 = manager.audio:GetVoiceLength("story_v_out_318041", "318041125", "story_v_out_318041.awb") / 1000

					if var_528_61 + var_528_52 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_61 + var_528_52
					end

					if var_528_56.prefab_name ~= "" and arg_525_1.actors_[var_528_56.prefab_name] ~= nil then
						local var_528_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_56.prefab_name].transform, "story_v_out_318041", "318041125", "story_v_out_318041.awb")

						arg_525_1:RecordAudio("318041125", var_528_62)
						arg_525_1:RecordAudio("318041125", var_528_62)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_318041", "318041125", "story_v_out_318041.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_318041", "318041125", "story_v_out_318041.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_63 = var_528_52 + 0.3
			local var_528_64 = math.max(var_528_53, arg_525_1.talkMaxDuration)

			if var_528_63 <= arg_525_1.time_ and arg_525_1.time_ < var_528_63 + var_528_64 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_63) / var_528_64

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_63 + var_528_64 and arg_525_1.time_ < var_528_63 + var_528_64 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "LX0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play318041126 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 318041126
		arg_531_1.duration_ = 4.9

		local var_531_0 = {
			zh = 3.833,
			ja = 4.9
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play318041127(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0
			local var_534_1 = 0.225

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_2 = arg_531_1:FormatText(StoryNameCfg[74].name)

				arg_531_1.leftNameTxt_.text = var_534_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_3 = arg_531_1:GetWordFromCfg(318041126)
				local var_534_4 = arg_531_1:FormatText(var_534_3.content)

				arg_531_1.text_.text = var_534_4

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_5 = 9
				local var_534_6 = utf8.len(var_534_4)
				local var_534_7 = var_534_5 <= 0 and var_534_1 or var_534_1 * (var_534_6 / var_534_5)

				if var_534_7 > 0 and var_534_1 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_0
					end
				end

				arg_531_1.text_.text = var_534_4
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041126", "story_v_out_318041.awb") ~= 0 then
					local var_534_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041126", "story_v_out_318041.awb") / 1000

					if var_534_8 + var_534_0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_8 + var_534_0
					end

					if var_534_3.prefab_name ~= "" and arg_531_1.actors_[var_534_3.prefab_name] ~= nil then
						local var_534_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_3.prefab_name].transform, "story_v_out_318041", "318041126", "story_v_out_318041.awb")

						arg_531_1:RecordAudio("318041126", var_534_9)
						arg_531_1:RecordAudio("318041126", var_534_9)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_318041", "318041126", "story_v_out_318041.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_318041", "318041126", "story_v_out_318041.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_10 = math.max(var_534_1, arg_531_1.talkMaxDuration)

			if var_534_0 <= arg_531_1.time_ and arg_531_1.time_ < var_534_0 + var_534_10 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_0) / var_534_10

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_0 + var_534_10 and arg_531_1.time_ < var_534_0 + var_534_10 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play318041127 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 318041127
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play318041128(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0
			local var_538_1 = 1.15

			if var_538_0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0

				arg_535_1.dialog_:SetActive(true)

				arg_535_1.dialogCg_.alpha = 0

				local var_538_2 = LeanTween.value(arg_535_1.dialog_, 0, 1, 0.3)

				var_538_2:setOnUpdate(LuaHelper.FloatAction(function(arg_539_0)
					arg_535_1.dialogCg_.alpha = arg_539_0
				end))
				var_538_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_535_1.dialog_)
					var_538_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_535_1.duration_ = arg_535_1.duration_ + 0.3

				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_3 = arg_535_1:GetWordFromCfg(318041127)
				local var_538_4 = arg_535_1:FormatText(var_538_3.content)

				arg_535_1.text_.text = var_538_4

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 46
				local var_538_6 = utf8.len(var_538_4)
				local var_538_7 = var_538_5 <= 0 and var_538_1 or var_538_1 * (var_538_6 / var_538_5)

				if var_538_7 > 0 and var_538_1 < var_538_7 then
					arg_535_1.talkMaxDuration = var_538_7
					var_538_0 = var_538_0 + 0.3

					if var_538_7 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_0
					end
				end

				arg_535_1.text_.text = var_538_4
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_8 = var_538_0 + 0.3
			local var_538_9 = math.max(var_538_1, arg_535_1.talkMaxDuration)

			if var_538_8 <= arg_535_1.time_ and arg_535_1.time_ < var_538_8 + var_538_9 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_8) / var_538_9

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_8 + var_538_9 and arg_535_1.time_ < var_538_8 + var_538_9 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play318041128 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 318041128
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play318041129(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 1.675

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_2 = arg_541_1:GetWordFromCfg(318041128)
				local var_544_3 = arg_541_1:FormatText(var_544_2.content)

				arg_541_1.text_.text = var_544_3

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_4 = 67
				local var_544_5 = utf8.len(var_544_3)
				local var_544_6 = var_544_4 <= 0 and var_544_1 or var_544_1 * (var_544_5 / var_544_4)

				if var_544_6 > 0 and var_544_1 < var_544_6 then
					arg_541_1.talkMaxDuration = var_544_6

					if var_544_6 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_6 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_3
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_7 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_7 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_7

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_7 and arg_541_1.time_ < var_544_0 + var_544_7 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play318041129 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 318041129
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play318041130(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 0.25

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_2 = arg_545_1:GetWordFromCfg(318041129)
				local var_548_3 = arg_545_1:FormatText(var_548_2.content)

				arg_545_1.text_.text = var_548_3

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_4 = 10
				local var_548_5 = utf8.len(var_548_3)
				local var_548_6 = var_548_4 <= 0 and var_548_1 or var_548_1 * (var_548_5 / var_548_4)

				if var_548_6 > 0 and var_548_1 < var_548_6 then
					arg_545_1.talkMaxDuration = var_548_6

					if var_548_6 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_6 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_3
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_7 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_7 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_7

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_7 and arg_545_1.time_ < var_548_0 + var_548_7 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play318041130 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 318041130
		arg_549_1.duration_ = 3.07

		local var_549_0 = {
			zh = 2.1,
			ja = 3.066
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play318041131(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.175

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_2 = arg_549_1:FormatText(StoryNameCfg[650].name)

				arg_549_1.leftNameTxt_.text = var_552_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_3 = arg_549_1:GetWordFromCfg(318041130)
				local var_552_4 = arg_549_1:FormatText(var_552_3.content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041130", "story_v_out_318041.awb") ~= 0 then
					local var_552_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041130", "story_v_out_318041.awb") / 1000

					if var_552_8 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_8 + var_552_0
					end

					if var_552_3.prefab_name ~= "" and arg_549_1.actors_[var_552_3.prefab_name] ~= nil then
						local var_552_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_3.prefab_name].transform, "story_v_out_318041", "318041130", "story_v_out_318041.awb")

						arg_549_1:RecordAudio("318041130", var_552_9)
						arg_549_1:RecordAudio("318041130", var_552_9)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_318041", "318041130", "story_v_out_318041.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_318041", "318041130", "story_v_out_318041.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_10 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_10 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_10

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_10 and arg_549_1.time_ < var_552_0 + var_552_10 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play318041131 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 318041131
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play318041132(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0
			local var_556_1 = 1.475

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_2 = arg_553_1:GetWordFromCfg(318041131)
				local var_556_3 = arg_553_1:FormatText(var_556_2.content)

				arg_553_1.text_.text = var_556_3

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_4 = 59
				local var_556_5 = utf8.len(var_556_3)
				local var_556_6 = var_556_4 <= 0 and var_556_1 or var_556_1 * (var_556_5 / var_556_4)

				if var_556_6 > 0 and var_556_1 < var_556_6 then
					arg_553_1.talkMaxDuration = var_556_6

					if var_556_6 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_6 + var_556_0
					end
				end

				arg_553_1.text_.text = var_556_3
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_7 = math.max(var_556_1, arg_553_1.talkMaxDuration)

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_7 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_0) / var_556_7

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_0 + var_556_7 and arg_553_1.time_ < var_556_0 + var_556_7 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play318041132 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 318041132
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play318041133(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0
			local var_560_1 = 1.45

			if var_560_0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_2 = arg_557_1:GetWordFromCfg(318041132)
				local var_560_3 = arg_557_1:FormatText(var_560_2.content)

				arg_557_1.text_.text = var_560_3

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_4 = 58
				local var_560_5 = utf8.len(var_560_3)
				local var_560_6 = var_560_4 <= 0 and var_560_1 or var_560_1 * (var_560_5 / var_560_4)

				if var_560_6 > 0 and var_560_1 < var_560_6 then
					arg_557_1.talkMaxDuration = var_560_6

					if var_560_6 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_6 + var_560_0
					end
				end

				arg_557_1.text_.text = var_560_3
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_7 = math.max(var_560_1, arg_557_1.talkMaxDuration)

			if var_560_0 <= arg_557_1.time_ and arg_557_1.time_ < var_560_0 + var_560_7 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_0) / var_560_7

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_0 + var_560_7 and arg_557_1.time_ < var_560_0 + var_560_7 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play318041133 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 318041133
		arg_561_1.duration_ = 3.1

		local var_561_0 = {
			zh = 2.466,
			ja = 3.1
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play318041134(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 0.15

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_2 = arg_561_1:FormatText(StoryNameCfg[74].name)

				arg_561_1.leftNameTxt_.text = var_564_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_3 = arg_561_1:GetWordFromCfg(318041133)
				local var_564_4 = arg_561_1:FormatText(var_564_3.content)

				arg_561_1.text_.text = var_564_4

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041133", "story_v_out_318041.awb") ~= 0 then
					local var_564_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041133", "story_v_out_318041.awb") / 1000

					if var_564_8 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_8 + var_564_0
					end

					if var_564_3.prefab_name ~= "" and arg_561_1.actors_[var_564_3.prefab_name] ~= nil then
						local var_564_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_3.prefab_name].transform, "story_v_out_318041", "318041133", "story_v_out_318041.awb")

						arg_561_1:RecordAudio("318041133", var_564_9)
						arg_561_1:RecordAudio("318041133", var_564_9)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_318041", "318041133", "story_v_out_318041.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_318041", "318041133", "story_v_out_318041.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_10 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_10 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_10

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_10 and arg_561_1.time_ < var_564_0 + var_564_10 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play318041134 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 318041134
		arg_565_1.duration_ = 6

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play318041135(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 1

			if var_568_0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_0 + arg_568_0 then
				local var_568_1 = manager.ui.mainCamera.transform.localPosition
				local var_568_2 = Vector3.New(0, 0, 10) + Vector3.New(var_568_1.x, var_568_1.y, 0)
				local var_568_3 = arg_565_1.bgs_.STblack

				var_568_3.transform.localPosition = var_568_2
				var_568_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_568_4 = var_568_3:GetComponent("SpriteRenderer")

				if var_568_4 and var_568_4.sprite then
					local var_568_5 = (var_568_3.transform.localPosition - var_568_1).z
					local var_568_6 = manager.ui.mainCameraCom_
					local var_568_7 = 2 * var_568_5 * Mathf.Tan(var_568_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_568_8 = var_568_7 * var_568_6.aspect
					local var_568_9 = var_568_4.sprite.bounds.size.x
					local var_568_10 = var_568_4.sprite.bounds.size.y
					local var_568_11 = var_568_8 / var_568_9
					local var_568_12 = var_568_7 / var_568_10
					local var_568_13 = var_568_12 < var_568_11 and var_568_11 or var_568_12

					var_568_3.transform.localScale = Vector3.New(var_568_13, var_568_13, 0)
				end

				for iter_568_0, iter_568_1 in pairs(arg_565_1.bgs_) do
					if iter_568_0 ~= "STblack" then
						iter_568_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_568_14 = 0

			if var_568_14 < arg_565_1.time_ and arg_565_1.time_ <= var_568_14 + arg_568_0 then
				arg_565_1.mask_.enabled = true
				arg_565_1.mask_.raycastTarget = true

				arg_565_1:SetGaussion(false)
			end

			local var_568_15 = 1

			if var_568_14 <= arg_565_1.time_ and arg_565_1.time_ < var_568_14 + var_568_15 then
				local var_568_16 = (arg_565_1.time_ - var_568_14) / var_568_15
				local var_568_17 = Color.New(0, 0, 0)

				var_568_17.a = Mathf.Lerp(0, 1, var_568_16)
				arg_565_1.mask_.color = var_568_17
			end

			if arg_565_1.time_ >= var_568_14 + var_568_15 and arg_565_1.time_ < var_568_14 + var_568_15 + arg_568_0 then
				local var_568_18 = Color.New(0, 0, 0)

				var_568_18.a = 1
				arg_565_1.mask_.color = var_568_18
			end

			local var_568_19 = 1

			if var_568_19 < arg_565_1.time_ and arg_565_1.time_ <= var_568_19 + arg_568_0 then
				arg_565_1.mask_.enabled = true
				arg_565_1.mask_.raycastTarget = true

				arg_565_1:SetGaussion(false)
			end

			local var_568_20 = 1

			if var_568_19 <= arg_565_1.time_ and arg_565_1.time_ < var_568_19 + var_568_20 then
				local var_568_21 = (arg_565_1.time_ - var_568_19) / var_568_20
				local var_568_22 = Color.New(0, 0, 0)

				var_568_22.a = Mathf.Lerp(1, 0, var_568_21)
				arg_565_1.mask_.color = var_568_22
			end

			if arg_565_1.time_ >= var_568_19 + var_568_20 and arg_565_1.time_ < var_568_19 + var_568_20 + arg_568_0 then
				local var_568_23 = Color.New(0, 0, 0)
				local var_568_24 = 0

				arg_565_1.mask_.enabled = false
				var_568_23.a = var_568_24
				arg_565_1.mask_.color = var_568_23
			end

			if arg_565_1.frameCnt_ <= 1 then
				arg_565_1.dialog_:SetActive(false)
			end

			local var_568_25 = 1
			local var_568_26 = 1.25

			if var_568_25 < arg_565_1.time_ and arg_565_1.time_ <= var_568_25 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0

				arg_565_1.dialog_:SetActive(true)

				arg_565_1.dialogCg_.alpha = 0

				local var_568_27 = LeanTween.value(arg_565_1.dialog_, 0, 1, 0.3)

				var_568_27:setOnUpdate(LuaHelper.FloatAction(function(arg_569_0)
					arg_565_1.dialogCg_.alpha = arg_569_0
				end))
				var_568_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_565_1.dialog_)
					var_568_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_565_1.duration_ = arg_565_1.duration_ + 0.3

				SetActive(arg_565_1.leftNameGo_, false)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_28 = arg_565_1:GetWordFromCfg(318041134)
				local var_568_29 = arg_565_1:FormatText(var_568_28.content)

				arg_565_1.text_.text = var_568_29

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_30 = 50
				local var_568_31 = utf8.len(var_568_29)
				local var_568_32 = var_568_30 <= 0 and var_568_26 or var_568_26 * (var_568_31 / var_568_30)

				if var_568_32 > 0 and var_568_26 < var_568_32 then
					arg_565_1.talkMaxDuration = var_568_32
					var_568_25 = var_568_25 + 0.3

					if var_568_32 + var_568_25 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_32 + var_568_25
					end
				end

				arg_565_1.text_.text = var_568_29
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_33 = var_568_25 + 0.3
			local var_568_34 = math.max(var_568_26, arg_565_1.talkMaxDuration)

			if var_568_33 <= arg_565_1.time_ and arg_565_1.time_ < var_568_33 + var_568_34 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_33) / var_568_34

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_33 + var_568_34 and arg_565_1.time_ < var_568_33 + var_568_34 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play318041135 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 318041135
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play318041136(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0
			local var_574_1 = 0.875

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, false)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_2 = arg_571_1:GetWordFromCfg(318041135)
				local var_574_3 = arg_571_1:FormatText(var_574_2.content)

				arg_571_1.text_.text = var_574_3

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_4 = 35
				local var_574_5 = utf8.len(var_574_3)
				local var_574_6 = var_574_4 <= 0 and var_574_1 or var_574_1 * (var_574_5 / var_574_4)

				if var_574_6 > 0 and var_574_1 < var_574_6 then
					arg_571_1.talkMaxDuration = var_574_6

					if var_574_6 + var_574_0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_6 + var_574_0
					end
				end

				arg_571_1.text_.text = var_574_3
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_7 = math.max(var_574_1, arg_571_1.talkMaxDuration)

			if var_574_0 <= arg_571_1.time_ and arg_571_1.time_ < var_574_0 + var_574_7 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_0) / var_574_7

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_0 + var_574_7 and arg_571_1.time_ < var_574_0 + var_574_7 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play318041136 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 318041136
		arg_575_1.duration_ = 9

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play318041137(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 2

			if var_578_0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_0 + arg_578_0 then
				local var_578_1 = manager.ui.mainCamera.transform.localPosition
				local var_578_2 = Vector3.New(0, 0, 10) + Vector3.New(var_578_1.x, var_578_1.y, 0)
				local var_578_3 = arg_575_1.bgs_.STblack

				var_578_3.transform.localPosition = var_578_2
				var_578_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_578_4 = var_578_3:GetComponent("SpriteRenderer")

				if var_578_4 and var_578_4.sprite then
					local var_578_5 = (var_578_3.transform.localPosition - var_578_1).z
					local var_578_6 = manager.ui.mainCameraCom_
					local var_578_7 = 2 * var_578_5 * Mathf.Tan(var_578_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_578_8 = var_578_7 * var_578_6.aspect
					local var_578_9 = var_578_4.sprite.bounds.size.x
					local var_578_10 = var_578_4.sprite.bounds.size.y
					local var_578_11 = var_578_8 / var_578_9
					local var_578_12 = var_578_7 / var_578_10
					local var_578_13 = var_578_12 < var_578_11 and var_578_11 or var_578_12

					var_578_3.transform.localScale = Vector3.New(var_578_13, var_578_13, 0)
				end

				for iter_578_0, iter_578_1 in pairs(arg_575_1.bgs_) do
					if iter_578_0 ~= "STblack" then
						iter_578_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_578_14 = 0

			if var_578_14 < arg_575_1.time_ and arg_575_1.time_ <= var_578_14 + arg_578_0 then
				arg_575_1.mask_.enabled = true
				arg_575_1.mask_.raycastTarget = true

				arg_575_1:SetGaussion(false)
			end

			local var_578_15 = 2

			if var_578_14 <= arg_575_1.time_ and arg_575_1.time_ < var_578_14 + var_578_15 then
				local var_578_16 = (arg_575_1.time_ - var_578_14) / var_578_15
				local var_578_17 = Color.New(0, 0, 0)

				var_578_17.a = Mathf.Lerp(0, 1, var_578_16)
				arg_575_1.mask_.color = var_578_17
			end

			if arg_575_1.time_ >= var_578_14 + var_578_15 and arg_575_1.time_ < var_578_14 + var_578_15 + arg_578_0 then
				local var_578_18 = Color.New(0, 0, 0)

				var_578_18.a = 1
				arg_575_1.mask_.color = var_578_18
			end

			local var_578_19 = 2

			if var_578_19 < arg_575_1.time_ and arg_575_1.time_ <= var_578_19 + arg_578_0 then
				arg_575_1.mask_.enabled = true
				arg_575_1.mask_.raycastTarget = true

				arg_575_1:SetGaussion(false)
			end

			local var_578_20 = 2

			if var_578_19 <= arg_575_1.time_ and arg_575_1.time_ < var_578_19 + var_578_20 then
				local var_578_21 = (arg_575_1.time_ - var_578_19) / var_578_20
				local var_578_22 = Color.New(0, 0, 0)

				var_578_22.a = Mathf.Lerp(1, 0, var_578_21)
				arg_575_1.mask_.color = var_578_22
			end

			if arg_575_1.time_ >= var_578_19 + var_578_20 and arg_575_1.time_ < var_578_19 + var_578_20 + arg_578_0 then
				local var_578_23 = Color.New(0, 0, 0)
				local var_578_24 = 0

				arg_575_1.mask_.enabled = false
				var_578_23.a = var_578_24
				arg_575_1.mask_.color = var_578_23
			end

			if arg_575_1.frameCnt_ <= 1 then
				arg_575_1.dialog_:SetActive(false)
			end

			local var_578_25 = 4
			local var_578_26 = 1.4

			if var_578_25 < arg_575_1.time_ and arg_575_1.time_ <= var_578_25 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0

				arg_575_1.dialog_:SetActive(true)

				arg_575_1.dialogCg_.alpha = 0

				local var_578_27 = LeanTween.value(arg_575_1.dialog_, 0, 1, 0.3)

				var_578_27:setOnUpdate(LuaHelper.FloatAction(function(arg_579_0)
					arg_575_1.dialogCg_.alpha = arg_579_0
				end))
				var_578_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_575_1.dialog_)
					var_578_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_575_1.duration_ = arg_575_1.duration_ + 0.3

				SetActive(arg_575_1.leftNameGo_, false)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_28 = arg_575_1:GetWordFromCfg(318041136)
				local var_578_29 = arg_575_1:FormatText(var_578_28.content)

				arg_575_1.text_.text = var_578_29

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_30 = 56
				local var_578_31 = utf8.len(var_578_29)
				local var_578_32 = var_578_30 <= 0 and var_578_26 or var_578_26 * (var_578_31 / var_578_30)

				if var_578_32 > 0 and var_578_26 < var_578_32 then
					arg_575_1.talkMaxDuration = var_578_32
					var_578_25 = var_578_25 + 0.3

					if var_578_32 + var_578_25 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_32 + var_578_25
					end
				end

				arg_575_1.text_.text = var_578_29
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_33 = var_578_25 + 0.3
			local var_578_34 = math.max(var_578_26, arg_575_1.talkMaxDuration)

			if var_578_33 <= arg_575_1.time_ and arg_575_1.time_ < var_578_33 + var_578_34 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_33) / var_578_34

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_33 + var_578_34 and arg_575_1.time_ < var_578_33 + var_578_34 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play318041137 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 318041137
		arg_581_1.duration_ = 5.77

		local var_581_0 = {
			zh = 2.633,
			ja = 5.766
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
				arg_581_0:Play318041138(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0
			local var_584_1 = 0.433333333333333

			if var_584_0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_0 + arg_584_0 then
				local var_584_2 = "stop"
				local var_584_3 = "effect"

				arg_581_1:AudioAction(var_584_2, var_584_3, "se_story_1210", "se_story_1210_loop_wind", "")
			end

			local var_584_4 = 0
			local var_584_5 = 0.175

			if var_584_4 < arg_581_1.time_ and arg_581_1.time_ <= var_584_4 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_6 = arg_581_1:FormatText(StoryNameCfg[640].name)

				arg_581_1.leftNameTxt_.text = var_584_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_7 = arg_581_1:GetWordFromCfg(318041137)
				local var_584_8 = arg_581_1:FormatText(var_584_7.content)

				arg_581_1.text_.text = var_584_8

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_9 = 7
				local var_584_10 = utf8.len(var_584_8)
				local var_584_11 = var_584_9 <= 0 and var_584_5 or var_584_5 * (var_584_10 / var_584_9)

				if var_584_11 > 0 and var_584_5 < var_584_11 then
					arg_581_1.talkMaxDuration = var_584_11

					if var_584_11 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_11 + var_584_4
					end
				end

				arg_581_1.text_.text = var_584_8
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041137", "story_v_out_318041.awb") ~= 0 then
					local var_584_12 = manager.audio:GetVoiceLength("story_v_out_318041", "318041137", "story_v_out_318041.awb") / 1000

					if var_584_12 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_12 + var_584_4
					end

					if var_584_7.prefab_name ~= "" and arg_581_1.actors_[var_584_7.prefab_name] ~= nil then
						local var_584_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_7.prefab_name].transform, "story_v_out_318041", "318041137", "story_v_out_318041.awb")

						arg_581_1:RecordAudio("318041137", var_584_13)
						arg_581_1:RecordAudio("318041137", var_584_13)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_318041", "318041137", "story_v_out_318041.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_318041", "318041137", "story_v_out_318041.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_14 = math.max(var_584_5, arg_581_1.talkMaxDuration)

			if var_584_4 <= arg_581_1.time_ and arg_581_1.time_ < var_584_4 + var_584_14 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_4) / var_584_14

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_4 + var_584_14 and arg_581_1.time_ < var_584_4 + var_584_14 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play318041138 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 318041138
		arg_585_1.duration_ = 5.67

		local var_585_0 = {
			zh = 5.666,
			ja = 5.166
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play318041139(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				local var_588_1 = manager.ui.mainCamera.transform.localPosition
				local var_588_2 = Vector3.New(0, 0, 10) + Vector3.New(var_588_1.x, var_588_1.y, 0)
				local var_588_3 = arg_585_1.bgs_.ST69

				var_588_3.transform.localPosition = var_588_2
				var_588_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_588_4 = var_588_3:GetComponent("SpriteRenderer")

				if var_588_4 and var_588_4.sprite then
					local var_588_5 = (var_588_3.transform.localPosition - var_588_1).z
					local var_588_6 = manager.ui.mainCameraCom_
					local var_588_7 = 2 * var_588_5 * Mathf.Tan(var_588_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_588_8 = var_588_7 * var_588_6.aspect
					local var_588_9 = var_588_4.sprite.bounds.size.x
					local var_588_10 = var_588_4.sprite.bounds.size.y
					local var_588_11 = var_588_8 / var_588_9
					local var_588_12 = var_588_7 / var_588_10
					local var_588_13 = var_588_12 < var_588_11 and var_588_11 or var_588_12

					var_588_3.transform.localScale = Vector3.New(var_588_13, var_588_13, 0)
				end

				for iter_588_0, iter_588_1 in pairs(arg_585_1.bgs_) do
					if iter_588_0 ~= "ST69" then
						iter_588_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_588_14 = 0

			if var_588_14 < arg_585_1.time_ and arg_585_1.time_ <= var_588_14 + arg_588_0 then
				arg_585_1.mask_.enabled = true
				arg_585_1.mask_.raycastTarget = true

				arg_585_1:SetGaussion(false)
			end

			local var_588_15 = 2

			if var_588_14 <= arg_585_1.time_ and arg_585_1.time_ < var_588_14 + var_588_15 then
				local var_588_16 = (arg_585_1.time_ - var_588_14) / var_588_15
				local var_588_17 = Color.New(0, 0, 0)

				var_588_17.a = Mathf.Lerp(1, 0, var_588_16)
				arg_585_1.mask_.color = var_588_17
			end

			if arg_585_1.time_ >= var_588_14 + var_588_15 and arg_585_1.time_ < var_588_14 + var_588_15 + arg_588_0 then
				local var_588_18 = Color.New(0, 0, 0)
				local var_588_19 = 0

				arg_585_1.mask_.enabled = false
				var_588_18.a = var_588_19
				arg_585_1.mask_.color = var_588_18
			end

			local var_588_20 = arg_585_1.actors_["1050ui_story"].transform
			local var_588_21 = 1.9

			if var_588_21 < arg_585_1.time_ and arg_585_1.time_ <= var_588_21 + arg_588_0 then
				arg_585_1.var_.moveOldPos1050ui_story = var_588_20.localPosition
			end

			local var_588_22 = 0.001

			if var_588_21 <= arg_585_1.time_ and arg_585_1.time_ < var_588_21 + var_588_22 then
				local var_588_23 = (arg_585_1.time_ - var_588_21) / var_588_22
				local var_588_24 = Vector3.New(0, -1, -6.1)

				var_588_20.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos1050ui_story, var_588_24, var_588_23)

				local var_588_25 = manager.ui.mainCamera.transform.position - var_588_20.position

				var_588_20.forward = Vector3.New(var_588_25.x, var_588_25.y, var_588_25.z)

				local var_588_26 = var_588_20.localEulerAngles

				var_588_26.z = 0
				var_588_26.x = 0
				var_588_20.localEulerAngles = var_588_26
			end

			if arg_585_1.time_ >= var_588_21 + var_588_22 and arg_585_1.time_ < var_588_21 + var_588_22 + arg_588_0 then
				var_588_20.localPosition = Vector3.New(0, -1, -6.1)

				local var_588_27 = manager.ui.mainCamera.transform.position - var_588_20.position

				var_588_20.forward = Vector3.New(var_588_27.x, var_588_27.y, var_588_27.z)

				local var_588_28 = var_588_20.localEulerAngles

				var_588_28.z = 0
				var_588_28.x = 0
				var_588_20.localEulerAngles = var_588_28
			end

			local var_588_29 = arg_585_1.actors_["1050ui_story"]
			local var_588_30 = 1.9

			if var_588_30 < arg_585_1.time_ and arg_585_1.time_ <= var_588_30 + arg_588_0 and not isNil(var_588_29) and arg_585_1.var_.characterEffect1050ui_story == nil then
				arg_585_1.var_.characterEffect1050ui_story = var_588_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_31 = 0.200000002980232

			if var_588_30 <= arg_585_1.time_ and arg_585_1.time_ < var_588_30 + var_588_31 and not isNil(var_588_29) then
				local var_588_32 = (arg_585_1.time_ - var_588_30) / var_588_31

				if arg_585_1.var_.characterEffect1050ui_story and not isNil(var_588_29) then
					arg_585_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= var_588_30 + var_588_31 and arg_585_1.time_ < var_588_30 + var_588_31 + arg_588_0 and not isNil(var_588_29) and arg_585_1.var_.characterEffect1050ui_story then
				arg_585_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_588_33 = 1.9

			if var_588_33 < arg_585_1.time_ and arg_585_1.time_ <= var_588_33 + arg_588_0 then
				arg_585_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_588_34 = 1.9

			if var_588_34 < arg_585_1.time_ and arg_585_1.time_ <= var_588_34 + arg_588_0 then
				arg_585_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_588_35 = 0
			local var_588_36 = 0.433333333333333

			if var_588_35 < arg_585_1.time_ and arg_585_1.time_ <= var_588_35 + arg_588_0 then
				local var_588_37 = "play"
				local var_588_38 = "music"

				arg_585_1:AudioAction(var_588_37, var_588_38, "ui_battle", "ui_battle_stopbgm", "")

				local var_588_39 = ""
				local var_588_40 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_588_40 ~= "" then
					if arg_585_1.bgmTxt_.text ~= var_588_40 and arg_585_1.bgmTxt_.text ~= "" then
						if arg_585_1.bgmTxt2_.text ~= "" then
							arg_585_1.bgmTxt_.text = arg_585_1.bgmTxt2_.text
						end

						arg_585_1.bgmTxt2_.text = var_588_40

						arg_585_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_585_1.bgmTxt_.text = var_588_40
						arg_585_1.bgmTxt2_.text = var_588_40
					end

					if arg_585_1.bgmTimer then
						arg_585_1.bgmTimer:Stop()

						arg_585_1.bgmTimer = nil
					end

					if arg_585_1.settingData.show_music_name == 1 then
						arg_585_1.musicController:SetSelectedState("show")
						arg_585_1.musicAnimator_:Play("open", 0, 0)

						if arg_585_1.settingData.music_time ~= 0 then
							arg_585_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_585_1.settingData.music_time), function()
								if arg_585_1 == nil or isNil(arg_585_1.bgmTxt_) then
									return
								end

								arg_585_1.musicController:SetSelectedState("hide")
								arg_585_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_588_41 = 0.766666666666667
			local var_588_42 = 1

			if var_588_41 < arg_585_1.time_ and arg_585_1.time_ <= var_588_41 + arg_588_0 then
				local var_588_43 = "play"
				local var_588_44 = "music"

				arg_585_1:AudioAction(var_588_43, var_588_44, "bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten.awb")

				local var_588_45 = ""
				local var_588_46 = manager.audio:GetAudioName("bgm_activity_2_10_story_reiten", "bgm_activity_2_10_story_reiten")

				if var_588_46 ~= "" then
					if arg_585_1.bgmTxt_.text ~= var_588_46 and arg_585_1.bgmTxt_.text ~= "" then
						if arg_585_1.bgmTxt2_.text ~= "" then
							arg_585_1.bgmTxt_.text = arg_585_1.bgmTxt2_.text
						end

						arg_585_1.bgmTxt2_.text = var_588_46

						arg_585_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_585_1.bgmTxt_.text = var_588_46
						arg_585_1.bgmTxt2_.text = var_588_46
					end

					if arg_585_1.bgmTimer then
						arg_585_1.bgmTimer:Stop()

						arg_585_1.bgmTimer = nil
					end

					if arg_585_1.settingData.show_music_name == 1 then
						arg_585_1.musicController:SetSelectedState("show")
						arg_585_1.musicAnimator_:Play("open", 0, 0)

						if arg_585_1.settingData.music_time ~= 0 then
							arg_585_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_585_1.settingData.music_time), function()
								if arg_585_1 == nil or isNil(arg_585_1.bgmTxt_) then
									return
								end

								arg_585_1.musicController:SetSelectedState("hide")
								arg_585_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_585_1.frameCnt_ <= 1 then
				arg_585_1.dialog_:SetActive(false)
			end

			local var_588_47 = 1.9
			local var_588_48 = 0.15

			if var_588_47 < arg_585_1.time_ and arg_585_1.time_ <= var_588_47 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0

				arg_585_1.dialog_:SetActive(true)

				arg_585_1.dialogCg_.alpha = 0

				local var_588_49 = LeanTween.value(arg_585_1.dialog_, 0, 1, 0.3)

				var_588_49:setOnUpdate(LuaHelper.FloatAction(function(arg_591_0)
					arg_585_1.dialogCg_.alpha = arg_591_0
				end))
				var_588_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_585_1.dialog_)
					var_588_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_585_1.duration_ = arg_585_1.duration_ + 0.3

				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_50 = arg_585_1:FormatText(StoryNameCfg[74].name)

				arg_585_1.leftNameTxt_.text = var_588_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_51 = arg_585_1:GetWordFromCfg(318041138)
				local var_588_52 = arg_585_1:FormatText(var_588_51.content)

				arg_585_1.text_.text = var_588_52

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_53 = 6
				local var_588_54 = utf8.len(var_588_52)
				local var_588_55 = var_588_53 <= 0 and var_588_48 or var_588_48 * (var_588_54 / var_588_53)

				if var_588_55 > 0 and var_588_48 < var_588_55 then
					arg_585_1.talkMaxDuration = var_588_55
					var_588_47 = var_588_47 + 0.3

					if var_588_55 + var_588_47 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_55 + var_588_47
					end
				end

				arg_585_1.text_.text = var_588_52
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041138", "story_v_out_318041.awb") ~= 0 then
					local var_588_56 = manager.audio:GetVoiceLength("story_v_out_318041", "318041138", "story_v_out_318041.awb") / 1000

					if var_588_56 + var_588_47 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_56 + var_588_47
					end

					if var_588_51.prefab_name ~= "" and arg_585_1.actors_[var_588_51.prefab_name] ~= nil then
						local var_588_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_51.prefab_name].transform, "story_v_out_318041", "318041138", "story_v_out_318041.awb")

						arg_585_1:RecordAudio("318041138", var_588_57)
						arg_585_1:RecordAudio("318041138", var_588_57)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_318041", "318041138", "story_v_out_318041.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_318041", "318041138", "story_v_out_318041.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_58 = var_588_47 + 0.3
			local var_588_59 = math.max(var_588_48, arg_585_1.talkMaxDuration)

			if var_588_58 <= arg_585_1.time_ and arg_585_1.time_ < var_588_58 + var_588_59 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_58) / var_588_59

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_58 + var_588_59 and arg_585_1.time_ < var_588_58 + var_588_59 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_585_1:InitPlayNodeList()
	end,
	Play318041139 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 318041139
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play318041140(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = arg_593_1.actors_["1050ui_story"]
			local var_596_1 = 0

			if var_596_1 < arg_593_1.time_ and arg_593_1.time_ <= var_596_1 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect1050ui_story == nil then
				arg_593_1.var_.characterEffect1050ui_story = var_596_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_2 = 0.200000002980232

			if var_596_1 <= arg_593_1.time_ and arg_593_1.time_ < var_596_1 + var_596_2 and not isNil(var_596_0) then
				local var_596_3 = (arg_593_1.time_ - var_596_1) / var_596_2

				if arg_593_1.var_.characterEffect1050ui_story and not isNil(var_596_0) then
					local var_596_4 = Mathf.Lerp(0, 0.5, var_596_3)

					arg_593_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_593_1.var_.characterEffect1050ui_story.fillRatio = var_596_4
				end
			end

			if arg_593_1.time_ >= var_596_1 + var_596_2 and arg_593_1.time_ < var_596_1 + var_596_2 + arg_596_0 and not isNil(var_596_0) and arg_593_1.var_.characterEffect1050ui_story then
				local var_596_5 = 0.5

				arg_593_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_593_1.var_.characterEffect1050ui_story.fillRatio = var_596_5
			end

			local var_596_6 = 0
			local var_596_7 = 0.95

			if var_596_6 < arg_593_1.time_ and arg_593_1.time_ <= var_596_6 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, false)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_8 = arg_593_1:GetWordFromCfg(318041139)
				local var_596_9 = arg_593_1:FormatText(var_596_8.content)

				arg_593_1.text_.text = var_596_9

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_10 = 38
				local var_596_11 = utf8.len(var_596_9)
				local var_596_12 = var_596_10 <= 0 and var_596_7 or var_596_7 * (var_596_11 / var_596_10)

				if var_596_12 > 0 and var_596_7 < var_596_12 then
					arg_593_1.talkMaxDuration = var_596_12

					if var_596_12 + var_596_6 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_12 + var_596_6
					end
				end

				arg_593_1.text_.text = var_596_9
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_13 = math.max(var_596_7, arg_593_1.talkMaxDuration)

			if var_596_6 <= arg_593_1.time_ and arg_593_1.time_ < var_596_6 + var_596_13 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_6) / var_596_13

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_6 + var_596_13 and arg_593_1.time_ < var_596_6 + var_596_13 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play318041140 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 318041140
		arg_597_1.duration_ = 2.4

		local var_597_0 = {
			zh = 2.166,
			ja = 2.4
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
				arg_597_0:Play318041141(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = arg_597_1.actors_["10066ui_story"].transform
			local var_600_1 = 0

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 then
				arg_597_1.var_.moveOldPos10066ui_story = var_600_0.localPosition
			end

			local var_600_2 = 0.001

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_2 then
				local var_600_3 = (arg_597_1.time_ - var_600_1) / var_600_2
				local var_600_4 = Vector3.New(0.7, -0.99, -5.83)

				var_600_0.localPosition = Vector3.Lerp(arg_597_1.var_.moveOldPos10066ui_story, var_600_4, var_600_3)

				local var_600_5 = manager.ui.mainCamera.transform.position - var_600_0.position

				var_600_0.forward = Vector3.New(var_600_5.x, var_600_5.y, var_600_5.z)

				local var_600_6 = var_600_0.localEulerAngles

				var_600_6.z = 0
				var_600_6.x = 0
				var_600_0.localEulerAngles = var_600_6
			end

			if arg_597_1.time_ >= var_600_1 + var_600_2 and arg_597_1.time_ < var_600_1 + var_600_2 + arg_600_0 then
				var_600_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_600_7 = manager.ui.mainCamera.transform.position - var_600_0.position

				var_600_0.forward = Vector3.New(var_600_7.x, var_600_7.y, var_600_7.z)

				local var_600_8 = var_600_0.localEulerAngles

				var_600_8.z = 0
				var_600_8.x = 0
				var_600_0.localEulerAngles = var_600_8
			end

			local var_600_9 = arg_597_1.actors_["10066ui_story"]
			local var_600_10 = 0

			if var_600_10 < arg_597_1.time_ and arg_597_1.time_ <= var_600_10 + arg_600_0 and not isNil(var_600_9) and arg_597_1.var_.characterEffect10066ui_story == nil then
				arg_597_1.var_.characterEffect10066ui_story = var_600_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_11 = 0.200000002980232

			if var_600_10 <= arg_597_1.time_ and arg_597_1.time_ < var_600_10 + var_600_11 and not isNil(var_600_9) then
				local var_600_12 = (arg_597_1.time_ - var_600_10) / var_600_11

				if arg_597_1.var_.characterEffect10066ui_story and not isNil(var_600_9) then
					arg_597_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_597_1.time_ >= var_600_10 + var_600_11 and arg_597_1.time_ < var_600_10 + var_600_11 + arg_600_0 and not isNil(var_600_9) and arg_597_1.var_.characterEffect10066ui_story then
				arg_597_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_600_13 = 0

			if var_600_13 < arg_597_1.time_ and arg_597_1.time_ <= var_600_13 + arg_600_0 then
				arg_597_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_600_14 = 0

			if var_600_14 < arg_597_1.time_ and arg_597_1.time_ <= var_600_14 + arg_600_0 then
				arg_597_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_600_15 = arg_597_1.actors_["1050ui_story"].transform
			local var_600_16 = 0

			if var_600_16 < arg_597_1.time_ and arg_597_1.time_ <= var_600_16 + arg_600_0 then
				arg_597_1.var_.moveOldPos1050ui_story = var_600_15.localPosition
			end

			local var_600_17 = 0.001

			if var_600_16 <= arg_597_1.time_ and arg_597_1.time_ < var_600_16 + var_600_17 then
				local var_600_18 = (arg_597_1.time_ - var_600_16) / var_600_17
				local var_600_19 = Vector3.New(-0.7, -1, -6.1)

				var_600_15.localPosition = Vector3.Lerp(arg_597_1.var_.moveOldPos1050ui_story, var_600_19, var_600_18)

				local var_600_20 = manager.ui.mainCamera.transform.position - var_600_15.position

				var_600_15.forward = Vector3.New(var_600_20.x, var_600_20.y, var_600_20.z)

				local var_600_21 = var_600_15.localEulerAngles

				var_600_21.z = 0
				var_600_21.x = 0
				var_600_15.localEulerAngles = var_600_21
			end

			if arg_597_1.time_ >= var_600_16 + var_600_17 and arg_597_1.time_ < var_600_16 + var_600_17 + arg_600_0 then
				var_600_15.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_600_22 = manager.ui.mainCamera.transform.position - var_600_15.position

				var_600_15.forward = Vector3.New(var_600_22.x, var_600_22.y, var_600_22.z)

				local var_600_23 = var_600_15.localEulerAngles

				var_600_23.z = 0
				var_600_23.x = 0
				var_600_15.localEulerAngles = var_600_23
			end

			local var_600_24 = 0
			local var_600_25 = 0.1

			if var_600_24 < arg_597_1.time_ and arg_597_1.time_ <= var_600_24 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_26 = arg_597_1:FormatText(StoryNameCfg[640].name)

				arg_597_1.leftNameTxt_.text = var_600_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_27 = arg_597_1:GetWordFromCfg(318041140)
				local var_600_28 = arg_597_1:FormatText(var_600_27.content)

				arg_597_1.text_.text = var_600_28

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_29 = 4
				local var_600_30 = utf8.len(var_600_28)
				local var_600_31 = var_600_29 <= 0 and var_600_25 or var_600_25 * (var_600_30 / var_600_29)

				if var_600_31 > 0 and var_600_25 < var_600_31 then
					arg_597_1.talkMaxDuration = var_600_31

					if var_600_31 + var_600_24 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_31 + var_600_24
					end
				end

				arg_597_1.text_.text = var_600_28
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041140", "story_v_out_318041.awb") ~= 0 then
					local var_600_32 = manager.audio:GetVoiceLength("story_v_out_318041", "318041140", "story_v_out_318041.awb") / 1000

					if var_600_32 + var_600_24 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_32 + var_600_24
					end

					if var_600_27.prefab_name ~= "" and arg_597_1.actors_[var_600_27.prefab_name] ~= nil then
						local var_600_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_27.prefab_name].transform, "story_v_out_318041", "318041140", "story_v_out_318041.awb")

						arg_597_1:RecordAudio("318041140", var_600_33)
						arg_597_1:RecordAudio("318041140", var_600_33)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_318041", "318041140", "story_v_out_318041.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_318041", "318041140", "story_v_out_318041.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_34 = math.max(var_600_25, arg_597_1.talkMaxDuration)

			if var_600_24 <= arg_597_1.time_ and arg_597_1.time_ < var_600_24 + var_600_34 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_24) / var_600_34

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_24 + var_600_34 and arg_597_1.time_ < var_600_24 + var_600_34 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_597_1:InitPlayNodeList()
	end,
	Play318041141 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 318041141
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play318041142(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = arg_601_1.actors_["10066ui_story"]
			local var_604_1 = 0

			if var_604_1 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect10066ui_story == nil then
				arg_601_1.var_.characterEffect10066ui_story = var_604_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_2 = 0.200000002980232

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_2 and not isNil(var_604_0) then
				local var_604_3 = (arg_601_1.time_ - var_604_1) / var_604_2

				if arg_601_1.var_.characterEffect10066ui_story and not isNil(var_604_0) then
					local var_604_4 = Mathf.Lerp(0, 0.5, var_604_3)

					arg_601_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_601_1.var_.characterEffect10066ui_story.fillRatio = var_604_4
				end
			end

			if arg_601_1.time_ >= var_604_1 + var_604_2 and arg_601_1.time_ < var_604_1 + var_604_2 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect10066ui_story then
				local var_604_5 = 0.5

				arg_601_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_601_1.var_.characterEffect10066ui_story.fillRatio = var_604_5
			end

			local var_604_6 = 0
			local var_604_7 = 0.35

			if var_604_6 < arg_601_1.time_ and arg_601_1.time_ <= var_604_6 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_8 = arg_601_1:GetWordFromCfg(318041141)
				local var_604_9 = arg_601_1:FormatText(var_604_8.content)

				arg_601_1.text_.text = var_604_9

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_10 = 14
				local var_604_11 = utf8.len(var_604_9)
				local var_604_12 = var_604_10 <= 0 and var_604_7 or var_604_7 * (var_604_11 / var_604_10)

				if var_604_12 > 0 and var_604_7 < var_604_12 then
					arg_601_1.talkMaxDuration = var_604_12

					if var_604_12 + var_604_6 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_12 + var_604_6
					end
				end

				arg_601_1.text_.text = var_604_9
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_13 = math.max(var_604_7, arg_601_1.talkMaxDuration)

			if var_604_6 <= arg_601_1.time_ and arg_601_1.time_ < var_604_6 + var_604_13 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_6) / var_604_13

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_6 + var_604_13 and arg_601_1.time_ < var_604_6 + var_604_13 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play318041142 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 318041142
		arg_605_1.duration_ = 4.57

		local var_605_0 = {
			zh = 3.166,
			ja = 4.566
		}
		local var_605_1 = manager.audio:GetLocalizationFlag()

		if var_605_0[var_605_1] ~= nil then
			arg_605_1.duration_ = var_605_0[var_605_1]
		end

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play318041143(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = arg_605_1.actors_["10066ui_story"]
			local var_608_1 = 0

			if var_608_1 < arg_605_1.time_ and arg_605_1.time_ <= var_608_1 + arg_608_0 and not isNil(var_608_0) and arg_605_1.var_.characterEffect10066ui_story == nil then
				arg_605_1.var_.characterEffect10066ui_story = var_608_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_608_2 = 0.200000002980232

			if var_608_1 <= arg_605_1.time_ and arg_605_1.time_ < var_608_1 + var_608_2 and not isNil(var_608_0) then
				local var_608_3 = (arg_605_1.time_ - var_608_1) / var_608_2

				if arg_605_1.var_.characterEffect10066ui_story and not isNil(var_608_0) then
					arg_605_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_605_1.time_ >= var_608_1 + var_608_2 and arg_605_1.time_ < var_608_1 + var_608_2 + arg_608_0 and not isNil(var_608_0) and arg_605_1.var_.characterEffect10066ui_story then
				arg_605_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_608_4 = 0

			if var_608_4 < arg_605_1.time_ and arg_605_1.time_ <= var_608_4 + arg_608_0 then
				arg_605_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			local var_608_5 = 0

			if var_608_5 < arg_605_1.time_ and arg_605_1.time_ <= var_608_5 + arg_608_0 then
				arg_605_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_608_6 = 0
			local var_608_7 = 0.25

			if var_608_6 < arg_605_1.time_ and arg_605_1.time_ <= var_608_6 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_8 = arg_605_1:FormatText(StoryNameCfg[640].name)

				arg_605_1.leftNameTxt_.text = var_608_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_9 = arg_605_1:GetWordFromCfg(318041142)
				local var_608_10 = arg_605_1:FormatText(var_608_9.content)

				arg_605_1.text_.text = var_608_10

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_11 = 10
				local var_608_12 = utf8.len(var_608_10)
				local var_608_13 = var_608_11 <= 0 and var_608_7 or var_608_7 * (var_608_12 / var_608_11)

				if var_608_13 > 0 and var_608_7 < var_608_13 then
					arg_605_1.talkMaxDuration = var_608_13

					if var_608_13 + var_608_6 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_13 + var_608_6
					end
				end

				arg_605_1.text_.text = var_608_10
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041142", "story_v_out_318041.awb") ~= 0 then
					local var_608_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041142", "story_v_out_318041.awb") / 1000

					if var_608_14 + var_608_6 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_14 + var_608_6
					end

					if var_608_9.prefab_name ~= "" and arg_605_1.actors_[var_608_9.prefab_name] ~= nil then
						local var_608_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_9.prefab_name].transform, "story_v_out_318041", "318041142", "story_v_out_318041.awb")

						arg_605_1:RecordAudio("318041142", var_608_15)
						arg_605_1:RecordAudio("318041142", var_608_15)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_out_318041", "318041142", "story_v_out_318041.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_out_318041", "318041142", "story_v_out_318041.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_16 = math.max(var_608_7, arg_605_1.talkMaxDuration)

			if var_608_6 <= arg_605_1.time_ and arg_605_1.time_ < var_608_6 + var_608_16 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_6) / var_608_16

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_6 + var_608_16 and arg_605_1.time_ < var_608_6 + var_608_16 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play318041143 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 318041143
		arg_609_1.duration_ = 9.8

		local var_609_0 = {
			zh = 6.1,
			ja = 9.8
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
				arg_609_0:Play318041144(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0
			local var_612_1 = 0.825

			if var_612_0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_2 = arg_609_1:FormatText(StoryNameCfg[640].name)

				arg_609_1.leftNameTxt_.text = var_612_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_3 = arg_609_1:GetWordFromCfg(318041143)
				local var_612_4 = arg_609_1:FormatText(var_612_3.content)

				arg_609_1.text_.text = var_612_4

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041143", "story_v_out_318041.awb") ~= 0 then
					local var_612_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041143", "story_v_out_318041.awb") / 1000

					if var_612_8 + var_612_0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_8 + var_612_0
					end

					if var_612_3.prefab_name ~= "" and arg_609_1.actors_[var_612_3.prefab_name] ~= nil then
						local var_612_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_3.prefab_name].transform, "story_v_out_318041", "318041143", "story_v_out_318041.awb")

						arg_609_1:RecordAudio("318041143", var_612_9)
						arg_609_1:RecordAudio("318041143", var_612_9)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_out_318041", "318041143", "story_v_out_318041.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_out_318041", "318041143", "story_v_out_318041.awb")
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
	Play318041144 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 318041144
		arg_613_1.duration_ = 8.37

		local var_613_0 = {
			zh = 4.466,
			ja = 8.366
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
				arg_613_0:Play318041145(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0
			local var_616_1 = 0.575

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_2 = arg_613_1:FormatText(StoryNameCfg[640].name)

				arg_613_1.leftNameTxt_.text = var_616_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_3 = arg_613_1:GetWordFromCfg(318041144)
				local var_616_4 = arg_613_1:FormatText(var_616_3.content)

				arg_613_1.text_.text = var_616_4

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041144", "story_v_out_318041.awb") ~= 0 then
					local var_616_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041144", "story_v_out_318041.awb") / 1000

					if var_616_8 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_8 + var_616_0
					end

					if var_616_3.prefab_name ~= "" and arg_613_1.actors_[var_616_3.prefab_name] ~= nil then
						local var_616_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_3.prefab_name].transform, "story_v_out_318041", "318041144", "story_v_out_318041.awb")

						arg_613_1:RecordAudio("318041144", var_616_9)
						arg_613_1:RecordAudio("318041144", var_616_9)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_out_318041", "318041144", "story_v_out_318041.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_out_318041", "318041144", "story_v_out_318041.awb")
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
	Play318041145 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 318041145
		arg_617_1.duration_ = 7.77

		local var_617_0 = {
			zh = 3.733,
			ja = 7.766
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
				arg_617_0:Play318041146(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0
			local var_620_1 = 0.425

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				local var_620_2 = arg_617_1:FormatText(StoryNameCfg[640].name)

				arg_617_1.leftNameTxt_.text = var_620_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_3 = arg_617_1:GetWordFromCfg(318041145)
				local var_620_4 = arg_617_1:FormatText(var_620_3.content)

				arg_617_1.text_.text = var_620_4

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041145", "story_v_out_318041.awb") ~= 0 then
					local var_620_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041145", "story_v_out_318041.awb") / 1000

					if var_620_8 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_8 + var_620_0
					end

					if var_620_3.prefab_name ~= "" and arg_617_1.actors_[var_620_3.prefab_name] ~= nil then
						local var_620_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_3.prefab_name].transform, "story_v_out_318041", "318041145", "story_v_out_318041.awb")

						arg_617_1:RecordAudio("318041145", var_620_9)
						arg_617_1:RecordAudio("318041145", var_620_9)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_out_318041", "318041145", "story_v_out_318041.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_out_318041", "318041145", "story_v_out_318041.awb")
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
	Play318041146 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 318041146
		arg_621_1.duration_ = 4.53

		local var_621_0 = {
			zh = 4.533,
			ja = 2.6
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
				arg_621_0:Play318041147(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = arg_621_1.actors_["1050ui_story"]
			local var_624_1 = 0

			if var_624_1 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 and not isNil(var_624_0) and arg_621_1.var_.characterEffect1050ui_story == nil then
				arg_621_1.var_.characterEffect1050ui_story = var_624_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_2 = 0.200000002980232

			if var_624_1 <= arg_621_1.time_ and arg_621_1.time_ < var_624_1 + var_624_2 and not isNil(var_624_0) then
				local var_624_3 = (arg_621_1.time_ - var_624_1) / var_624_2

				if arg_621_1.var_.characterEffect1050ui_story and not isNil(var_624_0) then
					arg_621_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_621_1.time_ >= var_624_1 + var_624_2 and arg_621_1.time_ < var_624_1 + var_624_2 + arg_624_0 and not isNil(var_624_0) and arg_621_1.var_.characterEffect1050ui_story then
				arg_621_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_624_4 = 0

			if var_624_4 < arg_621_1.time_ and arg_621_1.time_ <= var_624_4 + arg_624_0 then
				arg_621_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_624_5 = 0

			if var_624_5 < arg_621_1.time_ and arg_621_1.time_ <= var_624_5 + arg_624_0 then
				arg_621_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_624_6 = arg_621_1.actors_["10066ui_story"]
			local var_624_7 = 0

			if var_624_7 < arg_621_1.time_ and arg_621_1.time_ <= var_624_7 + arg_624_0 and not isNil(var_624_6) and arg_621_1.var_.characterEffect10066ui_story == nil then
				arg_621_1.var_.characterEffect10066ui_story = var_624_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_8 = 0.200000002980232

			if var_624_7 <= arg_621_1.time_ and arg_621_1.time_ < var_624_7 + var_624_8 and not isNil(var_624_6) then
				local var_624_9 = (arg_621_1.time_ - var_624_7) / var_624_8

				if arg_621_1.var_.characterEffect10066ui_story and not isNil(var_624_6) then
					local var_624_10 = Mathf.Lerp(0, 0.5, var_624_9)

					arg_621_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_621_1.var_.characterEffect10066ui_story.fillRatio = var_624_10
				end
			end

			if arg_621_1.time_ >= var_624_7 + var_624_8 and arg_621_1.time_ < var_624_7 + var_624_8 + arg_624_0 and not isNil(var_624_6) and arg_621_1.var_.characterEffect10066ui_story then
				local var_624_11 = 0.5

				arg_621_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_621_1.var_.characterEffect10066ui_story.fillRatio = var_624_11
			end

			local var_624_12 = 0
			local var_624_13 = 0.375

			if var_624_12 < arg_621_1.time_ and arg_621_1.time_ <= var_624_12 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_14 = arg_621_1:FormatText(StoryNameCfg[74].name)

				arg_621_1.leftNameTxt_.text = var_624_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_15 = arg_621_1:GetWordFromCfg(318041146)
				local var_624_16 = arg_621_1:FormatText(var_624_15.content)

				arg_621_1.text_.text = var_624_16

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_17 = 15
				local var_624_18 = utf8.len(var_624_16)
				local var_624_19 = var_624_17 <= 0 and var_624_13 or var_624_13 * (var_624_18 / var_624_17)

				if var_624_19 > 0 and var_624_13 < var_624_19 then
					arg_621_1.talkMaxDuration = var_624_19

					if var_624_19 + var_624_12 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_19 + var_624_12
					end
				end

				arg_621_1.text_.text = var_624_16
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041146", "story_v_out_318041.awb") ~= 0 then
					local var_624_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041146", "story_v_out_318041.awb") / 1000

					if var_624_20 + var_624_12 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_20 + var_624_12
					end

					if var_624_15.prefab_name ~= "" and arg_621_1.actors_[var_624_15.prefab_name] ~= nil then
						local var_624_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_15.prefab_name].transform, "story_v_out_318041", "318041146", "story_v_out_318041.awb")

						arg_621_1:RecordAudio("318041146", var_624_21)
						arg_621_1:RecordAudio("318041146", var_624_21)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_318041", "318041146", "story_v_out_318041.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_318041", "318041146", "story_v_out_318041.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_22 = math.max(var_624_13, arg_621_1.talkMaxDuration)

			if var_624_12 <= arg_621_1.time_ and arg_621_1.time_ < var_624_12 + var_624_22 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_12) / var_624_22

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_12 + var_624_22 and arg_621_1.time_ < var_624_12 + var_624_22 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play318041147 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 318041147
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play318041148(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = arg_625_1.actors_["1050ui_story"]
			local var_628_1 = 0

			if var_628_1 < arg_625_1.time_ and arg_625_1.time_ <= var_628_1 + arg_628_0 and not isNil(var_628_0) and arg_625_1.var_.characterEffect1050ui_story == nil then
				arg_625_1.var_.characterEffect1050ui_story = var_628_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_2 = 0.200000002980232

			if var_628_1 <= arg_625_1.time_ and arg_625_1.time_ < var_628_1 + var_628_2 and not isNil(var_628_0) then
				local var_628_3 = (arg_625_1.time_ - var_628_1) / var_628_2

				if arg_625_1.var_.characterEffect1050ui_story and not isNil(var_628_0) then
					local var_628_4 = Mathf.Lerp(0, 0.5, var_628_3)

					arg_625_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_625_1.var_.characterEffect1050ui_story.fillRatio = var_628_4
				end
			end

			if arg_625_1.time_ >= var_628_1 + var_628_2 and arg_625_1.time_ < var_628_1 + var_628_2 + arg_628_0 and not isNil(var_628_0) and arg_625_1.var_.characterEffect1050ui_story then
				local var_628_5 = 0.5

				arg_625_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_625_1.var_.characterEffect1050ui_story.fillRatio = var_628_5
			end

			local var_628_6 = 0
			local var_628_7 = 0.8

			if var_628_6 < arg_625_1.time_ and arg_625_1.time_ <= var_628_6 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, false)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_8 = arg_625_1:GetWordFromCfg(318041147)
				local var_628_9 = arg_625_1:FormatText(var_628_8.content)

				arg_625_1.text_.text = var_628_9

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_10 = 32
				local var_628_11 = utf8.len(var_628_9)
				local var_628_12 = var_628_10 <= 0 and var_628_7 or var_628_7 * (var_628_11 / var_628_10)

				if var_628_12 > 0 and var_628_7 < var_628_12 then
					arg_625_1.talkMaxDuration = var_628_12

					if var_628_12 + var_628_6 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_12 + var_628_6
					end
				end

				arg_625_1.text_.text = var_628_9
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_13 = math.max(var_628_7, arg_625_1.talkMaxDuration)

			if var_628_6 <= arg_625_1.time_ and arg_625_1.time_ < var_628_6 + var_628_13 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_6) / var_628_13

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_6 + var_628_13 and arg_625_1.time_ < var_628_6 + var_628_13 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play318041148 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 318041148
		arg_629_1.duration_ = 9.63

		local var_629_0 = {
			zh = 3.5,
			ja = 9.633
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
				arg_629_0:Play318041149(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = arg_629_1.actors_["1050ui_story"]
			local var_632_1 = 0

			if var_632_1 < arg_629_1.time_ and arg_629_1.time_ <= var_632_1 + arg_632_0 and not isNil(var_632_0) and arg_629_1.var_.characterEffect1050ui_story == nil then
				arg_629_1.var_.characterEffect1050ui_story = var_632_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_2 = 0.200000002980232

			if var_632_1 <= arg_629_1.time_ and arg_629_1.time_ < var_632_1 + var_632_2 and not isNil(var_632_0) then
				local var_632_3 = (arg_629_1.time_ - var_632_1) / var_632_2

				if arg_629_1.var_.characterEffect1050ui_story and not isNil(var_632_0) then
					arg_629_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_629_1.time_ >= var_632_1 + var_632_2 and arg_629_1.time_ < var_632_1 + var_632_2 + arg_632_0 and not isNil(var_632_0) and arg_629_1.var_.characterEffect1050ui_story then
				arg_629_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_632_4 = 0

			if var_632_4 < arg_629_1.time_ and arg_629_1.time_ <= var_632_4 + arg_632_0 then
				arg_629_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			local var_632_5 = 0

			if var_632_5 < arg_629_1.time_ and arg_629_1.time_ <= var_632_5 + arg_632_0 then
				arg_629_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_632_6 = 0
			local var_632_7 = 0.35

			if var_632_6 < arg_629_1.time_ and arg_629_1.time_ <= var_632_6 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				local var_632_8 = arg_629_1:FormatText(StoryNameCfg[74].name)

				arg_629_1.leftNameTxt_.text = var_632_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_9 = arg_629_1:GetWordFromCfg(318041148)
				local var_632_10 = arg_629_1:FormatText(var_632_9.content)

				arg_629_1.text_.text = var_632_10

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_11 = 14
				local var_632_12 = utf8.len(var_632_10)
				local var_632_13 = var_632_11 <= 0 and var_632_7 or var_632_7 * (var_632_12 / var_632_11)

				if var_632_13 > 0 and var_632_7 < var_632_13 then
					arg_629_1.talkMaxDuration = var_632_13

					if var_632_13 + var_632_6 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_13 + var_632_6
					end
				end

				arg_629_1.text_.text = var_632_10
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041148", "story_v_out_318041.awb") ~= 0 then
					local var_632_14 = manager.audio:GetVoiceLength("story_v_out_318041", "318041148", "story_v_out_318041.awb") / 1000

					if var_632_14 + var_632_6 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_14 + var_632_6
					end

					if var_632_9.prefab_name ~= "" and arg_629_1.actors_[var_632_9.prefab_name] ~= nil then
						local var_632_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_9.prefab_name].transform, "story_v_out_318041", "318041148", "story_v_out_318041.awb")

						arg_629_1:RecordAudio("318041148", var_632_15)
						arg_629_1:RecordAudio("318041148", var_632_15)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_out_318041", "318041148", "story_v_out_318041.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_out_318041", "318041148", "story_v_out_318041.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_16 = math.max(var_632_7, arg_629_1.talkMaxDuration)

			if var_632_6 <= arg_629_1.time_ and arg_629_1.time_ < var_632_6 + var_632_16 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_6) / var_632_16

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_6 + var_632_16 and arg_629_1.time_ < var_632_6 + var_632_16 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play318041149 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 318041149
		arg_633_1.duration_ = 2.6

		local var_633_0 = {
			zh = 2.066,
			ja = 2.6
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
				arg_633_0:Play318041150(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = arg_633_1.actors_["10066ui_story"]
			local var_636_1 = 0

			if var_636_1 < arg_633_1.time_ and arg_633_1.time_ <= var_636_1 + arg_636_0 and not isNil(var_636_0) and arg_633_1.var_.characterEffect10066ui_story == nil then
				arg_633_1.var_.characterEffect10066ui_story = var_636_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_2 = 0.200000002980232

			if var_636_1 <= arg_633_1.time_ and arg_633_1.time_ < var_636_1 + var_636_2 and not isNil(var_636_0) then
				local var_636_3 = (arg_633_1.time_ - var_636_1) / var_636_2

				if arg_633_1.var_.characterEffect10066ui_story and not isNil(var_636_0) then
					arg_633_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= var_636_1 + var_636_2 and arg_633_1.time_ < var_636_1 + var_636_2 + arg_636_0 and not isNil(var_636_0) and arg_633_1.var_.characterEffect10066ui_story then
				arg_633_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_636_4 = 0

			if var_636_4 < arg_633_1.time_ and arg_633_1.time_ <= var_636_4 + arg_636_0 then
				arg_633_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_636_5 = arg_633_1.actors_["1050ui_story"]
			local var_636_6 = 0

			if var_636_6 < arg_633_1.time_ and arg_633_1.time_ <= var_636_6 + arg_636_0 and not isNil(var_636_5) and arg_633_1.var_.characterEffect1050ui_story == nil then
				arg_633_1.var_.characterEffect1050ui_story = var_636_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_7 = 0.200000002980232

			if var_636_6 <= arg_633_1.time_ and arg_633_1.time_ < var_636_6 + var_636_7 and not isNil(var_636_5) then
				local var_636_8 = (arg_633_1.time_ - var_636_6) / var_636_7

				if arg_633_1.var_.characterEffect1050ui_story and not isNil(var_636_5) then
					local var_636_9 = Mathf.Lerp(0, 0.5, var_636_8)

					arg_633_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_633_1.var_.characterEffect1050ui_story.fillRatio = var_636_9
				end
			end

			if arg_633_1.time_ >= var_636_6 + var_636_7 and arg_633_1.time_ < var_636_6 + var_636_7 + arg_636_0 and not isNil(var_636_5) and arg_633_1.var_.characterEffect1050ui_story then
				local var_636_10 = 0.5

				arg_633_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_633_1.var_.characterEffect1050ui_story.fillRatio = var_636_10
			end

			local var_636_11 = 0
			local var_636_12 = 0.2

			if var_636_11 < arg_633_1.time_ and arg_633_1.time_ <= var_636_11 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_13 = arg_633_1:FormatText(StoryNameCfg[640].name)

				arg_633_1.leftNameTxt_.text = var_636_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_14 = arg_633_1:GetWordFromCfg(318041149)
				local var_636_15 = arg_633_1:FormatText(var_636_14.content)

				arg_633_1.text_.text = var_636_15

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_16 = 8
				local var_636_17 = utf8.len(var_636_15)
				local var_636_18 = var_636_16 <= 0 and var_636_12 or var_636_12 * (var_636_17 / var_636_16)

				if var_636_18 > 0 and var_636_12 < var_636_18 then
					arg_633_1.talkMaxDuration = var_636_18

					if var_636_18 + var_636_11 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_18 + var_636_11
					end
				end

				arg_633_1.text_.text = var_636_15
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041149", "story_v_out_318041.awb") ~= 0 then
					local var_636_19 = manager.audio:GetVoiceLength("story_v_out_318041", "318041149", "story_v_out_318041.awb") / 1000

					if var_636_19 + var_636_11 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_19 + var_636_11
					end

					if var_636_14.prefab_name ~= "" and arg_633_1.actors_[var_636_14.prefab_name] ~= nil then
						local var_636_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_14.prefab_name].transform, "story_v_out_318041", "318041149", "story_v_out_318041.awb")

						arg_633_1:RecordAudio("318041149", var_636_20)
						arg_633_1:RecordAudio("318041149", var_636_20)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_out_318041", "318041149", "story_v_out_318041.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_out_318041", "318041149", "story_v_out_318041.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_21 = math.max(var_636_12, arg_633_1.talkMaxDuration)

			if var_636_11 <= arg_633_1.time_ and arg_633_1.time_ < var_636_11 + var_636_21 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_11) / var_636_21

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_11 + var_636_21 and arg_633_1.time_ < var_636_11 + var_636_21 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play318041150 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 318041150
		arg_637_1.duration_ = 1.6

		local var_637_0 = {
			zh = 1.6,
			ja = 1.333
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
				arg_637_0:Play318041151(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = arg_637_1.actors_["1050ui_story"]
			local var_640_1 = 0

			if var_640_1 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 and not isNil(var_640_0) and arg_637_1.var_.characterEffect1050ui_story == nil then
				arg_637_1.var_.characterEffect1050ui_story = var_640_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_2 = 0.200000002980232

			if var_640_1 <= arg_637_1.time_ and arg_637_1.time_ < var_640_1 + var_640_2 and not isNil(var_640_0) then
				local var_640_3 = (arg_637_1.time_ - var_640_1) / var_640_2

				if arg_637_1.var_.characterEffect1050ui_story and not isNil(var_640_0) then
					arg_637_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_637_1.time_ >= var_640_1 + var_640_2 and arg_637_1.time_ < var_640_1 + var_640_2 + arg_640_0 and not isNil(var_640_0) and arg_637_1.var_.characterEffect1050ui_story then
				arg_637_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_640_4 = arg_637_1.actors_["10066ui_story"]
			local var_640_5 = 0

			if var_640_5 < arg_637_1.time_ and arg_637_1.time_ <= var_640_5 + arg_640_0 and not isNil(var_640_4) and arg_637_1.var_.characterEffect10066ui_story == nil then
				arg_637_1.var_.characterEffect10066ui_story = var_640_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_6 = 0.200000002980232

			if var_640_5 <= arg_637_1.time_ and arg_637_1.time_ < var_640_5 + var_640_6 and not isNil(var_640_4) then
				local var_640_7 = (arg_637_1.time_ - var_640_5) / var_640_6

				if arg_637_1.var_.characterEffect10066ui_story and not isNil(var_640_4) then
					local var_640_8 = Mathf.Lerp(0, 0.5, var_640_7)

					arg_637_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_637_1.var_.characterEffect10066ui_story.fillRatio = var_640_8
				end
			end

			if arg_637_1.time_ >= var_640_5 + var_640_6 and arg_637_1.time_ < var_640_5 + var_640_6 + arg_640_0 and not isNil(var_640_4) and arg_637_1.var_.characterEffect10066ui_story then
				local var_640_9 = 0.5

				arg_637_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_637_1.var_.characterEffect10066ui_story.fillRatio = var_640_9
			end

			local var_640_10 = 0
			local var_640_11 = 0.225

			if var_640_10 < arg_637_1.time_ and arg_637_1.time_ <= var_640_10 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				local var_640_12 = arg_637_1:FormatText(StoryNameCfg[74].name)

				arg_637_1.leftNameTxt_.text = var_640_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_13 = arg_637_1:GetWordFromCfg(318041150)
				local var_640_14 = arg_637_1:FormatText(var_640_13.content)

				arg_637_1.text_.text = var_640_14

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_15 = 9
				local var_640_16 = utf8.len(var_640_14)
				local var_640_17 = var_640_15 <= 0 and var_640_11 or var_640_11 * (var_640_16 / var_640_15)

				if var_640_17 > 0 and var_640_11 < var_640_17 then
					arg_637_1.talkMaxDuration = var_640_17

					if var_640_17 + var_640_10 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_17 + var_640_10
					end
				end

				arg_637_1.text_.text = var_640_14
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041150", "story_v_out_318041.awb") ~= 0 then
					local var_640_18 = manager.audio:GetVoiceLength("story_v_out_318041", "318041150", "story_v_out_318041.awb") / 1000

					if var_640_18 + var_640_10 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_18 + var_640_10
					end

					if var_640_13.prefab_name ~= "" and arg_637_1.actors_[var_640_13.prefab_name] ~= nil then
						local var_640_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_13.prefab_name].transform, "story_v_out_318041", "318041150", "story_v_out_318041.awb")

						arg_637_1:RecordAudio("318041150", var_640_19)
						arg_637_1:RecordAudio("318041150", var_640_19)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_out_318041", "318041150", "story_v_out_318041.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_out_318041", "318041150", "story_v_out_318041.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_20 = math.max(var_640_11, arg_637_1.talkMaxDuration)

			if var_640_10 <= arg_637_1.time_ and arg_637_1.time_ < var_640_10 + var_640_20 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_10) / var_640_20

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_10 + var_640_20 and arg_637_1.time_ < var_640_10 + var_640_20 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play318041151 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 318041151
		arg_641_1.duration_ = 14.4

		local var_641_0 = {
			zh = 4.433,
			ja = 14.4
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
				arg_641_0:Play318041152(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = arg_641_1.actors_["10066ui_story"]
			local var_644_1 = 0

			if var_644_1 < arg_641_1.time_ and arg_641_1.time_ <= var_644_1 + arg_644_0 and not isNil(var_644_0) and arg_641_1.var_.characterEffect10066ui_story == nil then
				arg_641_1.var_.characterEffect10066ui_story = var_644_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_2 = 0.200000002980232

			if var_644_1 <= arg_641_1.time_ and arg_641_1.time_ < var_644_1 + var_644_2 and not isNil(var_644_0) then
				local var_644_3 = (arg_641_1.time_ - var_644_1) / var_644_2

				if arg_641_1.var_.characterEffect10066ui_story and not isNil(var_644_0) then
					arg_641_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= var_644_1 + var_644_2 and arg_641_1.time_ < var_644_1 + var_644_2 + arg_644_0 and not isNil(var_644_0) and arg_641_1.var_.characterEffect10066ui_story then
				arg_641_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_644_4 = 0

			if var_644_4 < arg_641_1.time_ and arg_641_1.time_ <= var_644_4 + arg_644_0 then
				arg_641_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_644_5 = 0

			if var_644_5 < arg_641_1.time_ and arg_641_1.time_ <= var_644_5 + arg_644_0 then
				arg_641_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_644_6 = arg_641_1.actors_["1050ui_story"]
			local var_644_7 = 0

			if var_644_7 < arg_641_1.time_ and arg_641_1.time_ <= var_644_7 + arg_644_0 and not isNil(var_644_6) and arg_641_1.var_.characterEffect1050ui_story == nil then
				arg_641_1.var_.characterEffect1050ui_story = var_644_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_8 = 0.200000002980232

			if var_644_7 <= arg_641_1.time_ and arg_641_1.time_ < var_644_7 + var_644_8 and not isNil(var_644_6) then
				local var_644_9 = (arg_641_1.time_ - var_644_7) / var_644_8

				if arg_641_1.var_.characterEffect1050ui_story and not isNil(var_644_6) then
					local var_644_10 = Mathf.Lerp(0, 0.5, var_644_9)

					arg_641_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_641_1.var_.characterEffect1050ui_story.fillRatio = var_644_10
				end
			end

			if arg_641_1.time_ >= var_644_7 + var_644_8 and arg_641_1.time_ < var_644_7 + var_644_8 + arg_644_0 and not isNil(var_644_6) and arg_641_1.var_.characterEffect1050ui_story then
				local var_644_11 = 0.5

				arg_641_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_641_1.var_.characterEffect1050ui_story.fillRatio = var_644_11
			end

			local var_644_12 = 0
			local var_644_13 = 0.5

			if var_644_12 < arg_641_1.time_ and arg_641_1.time_ <= var_644_12 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_14 = arg_641_1:FormatText(StoryNameCfg[640].name)

				arg_641_1.leftNameTxt_.text = var_644_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_15 = arg_641_1:GetWordFromCfg(318041151)
				local var_644_16 = arg_641_1:FormatText(var_644_15.content)

				arg_641_1.text_.text = var_644_16

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_17 = 20
				local var_644_18 = utf8.len(var_644_16)
				local var_644_19 = var_644_17 <= 0 and var_644_13 or var_644_13 * (var_644_18 / var_644_17)

				if var_644_19 > 0 and var_644_13 < var_644_19 then
					arg_641_1.talkMaxDuration = var_644_19

					if var_644_19 + var_644_12 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_19 + var_644_12
					end
				end

				arg_641_1.text_.text = var_644_16
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041151", "story_v_out_318041.awb") ~= 0 then
					local var_644_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041151", "story_v_out_318041.awb") / 1000

					if var_644_20 + var_644_12 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_20 + var_644_12
					end

					if var_644_15.prefab_name ~= "" and arg_641_1.actors_[var_644_15.prefab_name] ~= nil then
						local var_644_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_15.prefab_name].transform, "story_v_out_318041", "318041151", "story_v_out_318041.awb")

						arg_641_1:RecordAudio("318041151", var_644_21)
						arg_641_1:RecordAudio("318041151", var_644_21)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_out_318041", "318041151", "story_v_out_318041.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_out_318041", "318041151", "story_v_out_318041.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_22 = math.max(var_644_13, arg_641_1.talkMaxDuration)

			if var_644_12 <= arg_641_1.time_ and arg_641_1.time_ < var_644_12 + var_644_22 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_12) / var_644_22

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_12 + var_644_22 and arg_641_1.time_ < var_644_12 + var_644_22 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play318041152 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 318041152
		arg_645_1.duration_ = 5.9

		local var_645_0 = {
			zh = 1.633,
			ja = 5.9
		}
		local var_645_1 = manager.audio:GetLocalizationFlag()

		if var_645_0[var_645_1] ~= nil then
			arg_645_1.duration_ = var_645_0[var_645_1]
		end

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play318041153(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = arg_645_1.actors_["1050ui_story"]
			local var_648_1 = 0

			if var_648_1 < arg_645_1.time_ and arg_645_1.time_ <= var_648_1 + arg_648_0 and not isNil(var_648_0) and arg_645_1.var_.characterEffect1050ui_story == nil then
				arg_645_1.var_.characterEffect1050ui_story = var_648_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_2 = 0.200000002980232

			if var_648_1 <= arg_645_1.time_ and arg_645_1.time_ < var_648_1 + var_648_2 and not isNil(var_648_0) then
				local var_648_3 = (arg_645_1.time_ - var_648_1) / var_648_2

				if arg_645_1.var_.characterEffect1050ui_story and not isNil(var_648_0) then
					arg_645_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_645_1.time_ >= var_648_1 + var_648_2 and arg_645_1.time_ < var_648_1 + var_648_2 + arg_648_0 and not isNil(var_648_0) and arg_645_1.var_.characterEffect1050ui_story then
				arg_645_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_648_4 = arg_645_1.actors_["10066ui_story"]
			local var_648_5 = 0

			if var_648_5 < arg_645_1.time_ and arg_645_1.time_ <= var_648_5 + arg_648_0 and not isNil(var_648_4) and arg_645_1.var_.characterEffect10066ui_story == nil then
				arg_645_1.var_.characterEffect10066ui_story = var_648_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_6 = 0.200000002980232

			if var_648_5 <= arg_645_1.time_ and arg_645_1.time_ < var_648_5 + var_648_6 and not isNil(var_648_4) then
				local var_648_7 = (arg_645_1.time_ - var_648_5) / var_648_6

				if arg_645_1.var_.characterEffect10066ui_story and not isNil(var_648_4) then
					local var_648_8 = Mathf.Lerp(0, 0.5, var_648_7)

					arg_645_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_645_1.var_.characterEffect10066ui_story.fillRatio = var_648_8
				end
			end

			if arg_645_1.time_ >= var_648_5 + var_648_6 and arg_645_1.time_ < var_648_5 + var_648_6 + arg_648_0 and not isNil(var_648_4) and arg_645_1.var_.characterEffect10066ui_story then
				local var_648_9 = 0.5

				arg_645_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_645_1.var_.characterEffect10066ui_story.fillRatio = var_648_9
			end

			local var_648_10 = 0
			local var_648_11 = 0.175

			if var_648_10 < arg_645_1.time_ and arg_645_1.time_ <= var_648_10 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				local var_648_12 = arg_645_1:FormatText(StoryNameCfg[74].name)

				arg_645_1.leftNameTxt_.text = var_648_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_13 = arg_645_1:GetWordFromCfg(318041152)
				local var_648_14 = arg_645_1:FormatText(var_648_13.content)

				arg_645_1.text_.text = var_648_14

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_15 = 7
				local var_648_16 = utf8.len(var_648_14)
				local var_648_17 = var_648_15 <= 0 and var_648_11 or var_648_11 * (var_648_16 / var_648_15)

				if var_648_17 > 0 and var_648_11 < var_648_17 then
					arg_645_1.talkMaxDuration = var_648_17

					if var_648_17 + var_648_10 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_17 + var_648_10
					end
				end

				arg_645_1.text_.text = var_648_14
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041152", "story_v_out_318041.awb") ~= 0 then
					local var_648_18 = manager.audio:GetVoiceLength("story_v_out_318041", "318041152", "story_v_out_318041.awb") / 1000

					if var_648_18 + var_648_10 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_18 + var_648_10
					end

					if var_648_13.prefab_name ~= "" and arg_645_1.actors_[var_648_13.prefab_name] ~= nil then
						local var_648_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_645_1.actors_[var_648_13.prefab_name].transform, "story_v_out_318041", "318041152", "story_v_out_318041.awb")

						arg_645_1:RecordAudio("318041152", var_648_19)
						arg_645_1:RecordAudio("318041152", var_648_19)
					else
						arg_645_1:AudioAction("play", "voice", "story_v_out_318041", "318041152", "story_v_out_318041.awb")
					end

					arg_645_1:RecordHistoryTalkVoice("story_v_out_318041", "318041152", "story_v_out_318041.awb")
				end

				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_20 = math.max(var_648_11, arg_645_1.talkMaxDuration)

			if var_648_10 <= arg_645_1.time_ and arg_645_1.time_ < var_648_10 + var_648_20 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_10) / var_648_20

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_10 + var_648_20 and arg_645_1.time_ < var_648_10 + var_648_20 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play318041153 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 318041153
		arg_649_1.duration_ = 10.03

		local var_649_0 = {
			zh = 4.233,
			ja = 10.033
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
				arg_649_0:Play318041154(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = arg_649_1.actors_["10066ui_story"]
			local var_652_1 = 0

			if var_652_1 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect10066ui_story == nil then
				arg_649_1.var_.characterEffect10066ui_story = var_652_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_2 = 0.200000002980232

			if var_652_1 <= arg_649_1.time_ and arg_649_1.time_ < var_652_1 + var_652_2 and not isNil(var_652_0) then
				local var_652_3 = (arg_649_1.time_ - var_652_1) / var_652_2

				if arg_649_1.var_.characterEffect10066ui_story and not isNil(var_652_0) then
					arg_649_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_649_1.time_ >= var_652_1 + var_652_2 and arg_649_1.time_ < var_652_1 + var_652_2 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect10066ui_story then
				arg_649_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_652_4 = 0

			if var_652_4 < arg_649_1.time_ and arg_649_1.time_ <= var_652_4 + arg_652_0 then
				arg_649_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_652_5 = 0

			if var_652_5 < arg_649_1.time_ and arg_649_1.time_ <= var_652_5 + arg_652_0 then
				arg_649_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_652_6 = arg_649_1.actors_["1050ui_story"]
			local var_652_7 = 0

			if var_652_7 < arg_649_1.time_ and arg_649_1.time_ <= var_652_7 + arg_652_0 and not isNil(var_652_6) and arg_649_1.var_.characterEffect1050ui_story == nil then
				arg_649_1.var_.characterEffect1050ui_story = var_652_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_8 = 0.200000002980232

			if var_652_7 <= arg_649_1.time_ and arg_649_1.time_ < var_652_7 + var_652_8 and not isNil(var_652_6) then
				local var_652_9 = (arg_649_1.time_ - var_652_7) / var_652_8

				if arg_649_1.var_.characterEffect1050ui_story and not isNil(var_652_6) then
					local var_652_10 = Mathf.Lerp(0, 0.5, var_652_9)

					arg_649_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_649_1.var_.characterEffect1050ui_story.fillRatio = var_652_10
				end
			end

			if arg_649_1.time_ >= var_652_7 + var_652_8 and arg_649_1.time_ < var_652_7 + var_652_8 + arg_652_0 and not isNil(var_652_6) and arg_649_1.var_.characterEffect1050ui_story then
				local var_652_11 = 0.5

				arg_649_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_649_1.var_.characterEffect1050ui_story.fillRatio = var_652_11
			end

			local var_652_12 = 0
			local var_652_13 = 0.475

			if var_652_12 < arg_649_1.time_ and arg_649_1.time_ <= var_652_12 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_14 = arg_649_1:FormatText(StoryNameCfg[640].name)

				arg_649_1.leftNameTxt_.text = var_652_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_15 = arg_649_1:GetWordFromCfg(318041153)
				local var_652_16 = arg_649_1:FormatText(var_652_15.content)

				arg_649_1.text_.text = var_652_16

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_17 = 19
				local var_652_18 = utf8.len(var_652_16)
				local var_652_19 = var_652_17 <= 0 and var_652_13 or var_652_13 * (var_652_18 / var_652_17)

				if var_652_19 > 0 and var_652_13 < var_652_19 then
					arg_649_1.talkMaxDuration = var_652_19

					if var_652_19 + var_652_12 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_19 + var_652_12
					end
				end

				arg_649_1.text_.text = var_652_16
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041153", "story_v_out_318041.awb") ~= 0 then
					local var_652_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041153", "story_v_out_318041.awb") / 1000

					if var_652_20 + var_652_12 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_20 + var_652_12
					end

					if var_652_15.prefab_name ~= "" and arg_649_1.actors_[var_652_15.prefab_name] ~= nil then
						local var_652_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_15.prefab_name].transform, "story_v_out_318041", "318041153", "story_v_out_318041.awb")

						arg_649_1:RecordAudio("318041153", var_652_21)
						arg_649_1:RecordAudio("318041153", var_652_21)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_out_318041", "318041153", "story_v_out_318041.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_out_318041", "318041153", "story_v_out_318041.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_22 = math.max(var_652_13, arg_649_1.talkMaxDuration)

			if var_652_12 <= arg_649_1.time_ and arg_649_1.time_ < var_652_12 + var_652_22 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_12) / var_652_22

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_12 + var_652_22 and arg_649_1.time_ < var_652_12 + var_652_22 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play318041154 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 318041154
		arg_653_1.duration_ = 9.3

		local var_653_0 = {
			zh = 8.6,
			ja = 9.3
		}
		local var_653_1 = manager.audio:GetLocalizationFlag()

		if var_653_0[var_653_1] ~= nil then
			arg_653_1.duration_ = var_653_0[var_653_1]
		end

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play318041155(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = arg_653_1.actors_["1050ui_story"]
			local var_656_1 = 0

			if var_656_1 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1050ui_story == nil then
				arg_653_1.var_.characterEffect1050ui_story = var_656_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_2 = 0.200000002980232

			if var_656_1 <= arg_653_1.time_ and arg_653_1.time_ < var_656_1 + var_656_2 and not isNil(var_656_0) then
				local var_656_3 = (arg_653_1.time_ - var_656_1) / var_656_2

				if arg_653_1.var_.characterEffect1050ui_story and not isNil(var_656_0) then
					arg_653_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_653_1.time_ >= var_656_1 + var_656_2 and arg_653_1.time_ < var_656_1 + var_656_2 + arg_656_0 and not isNil(var_656_0) and arg_653_1.var_.characterEffect1050ui_story then
				arg_653_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_656_4 = 0

			if var_656_4 < arg_653_1.time_ and arg_653_1.time_ <= var_656_4 + arg_656_0 then
				arg_653_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_2")
			end

			local var_656_5 = 0

			if var_656_5 < arg_653_1.time_ and arg_653_1.time_ <= var_656_5 + arg_656_0 then
				arg_653_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_656_6 = arg_653_1.actors_["10066ui_story"]
			local var_656_7 = 0

			if var_656_7 < arg_653_1.time_ and arg_653_1.time_ <= var_656_7 + arg_656_0 and not isNil(var_656_6) and arg_653_1.var_.characterEffect10066ui_story == nil then
				arg_653_1.var_.characterEffect10066ui_story = var_656_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_8 = 0.200000002980232

			if var_656_7 <= arg_653_1.time_ and arg_653_1.time_ < var_656_7 + var_656_8 and not isNil(var_656_6) then
				local var_656_9 = (arg_653_1.time_ - var_656_7) / var_656_8

				if arg_653_1.var_.characterEffect10066ui_story and not isNil(var_656_6) then
					local var_656_10 = Mathf.Lerp(0, 0.5, var_656_9)

					arg_653_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_653_1.var_.characterEffect10066ui_story.fillRatio = var_656_10
				end
			end

			if arg_653_1.time_ >= var_656_7 + var_656_8 and arg_653_1.time_ < var_656_7 + var_656_8 + arg_656_0 and not isNil(var_656_6) and arg_653_1.var_.characterEffect10066ui_story then
				local var_656_11 = 0.5

				arg_653_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_653_1.var_.characterEffect10066ui_story.fillRatio = var_656_11
			end

			local var_656_12 = 0
			local var_656_13 = 0.875

			if var_656_12 < arg_653_1.time_ and arg_653_1.time_ <= var_656_12 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				local var_656_14 = arg_653_1:FormatText(StoryNameCfg[74].name)

				arg_653_1.leftNameTxt_.text = var_656_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_15 = arg_653_1:GetWordFromCfg(318041154)
				local var_656_16 = arg_653_1:FormatText(var_656_15.content)

				arg_653_1.text_.text = var_656_16

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_17 = 35
				local var_656_18 = utf8.len(var_656_16)
				local var_656_19 = var_656_17 <= 0 and var_656_13 or var_656_13 * (var_656_18 / var_656_17)

				if var_656_19 > 0 and var_656_13 < var_656_19 then
					arg_653_1.talkMaxDuration = var_656_19

					if var_656_19 + var_656_12 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_19 + var_656_12
					end
				end

				arg_653_1.text_.text = var_656_16
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041154", "story_v_out_318041.awb") ~= 0 then
					local var_656_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041154", "story_v_out_318041.awb") / 1000

					if var_656_20 + var_656_12 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_20 + var_656_12
					end

					if var_656_15.prefab_name ~= "" and arg_653_1.actors_[var_656_15.prefab_name] ~= nil then
						local var_656_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_15.prefab_name].transform, "story_v_out_318041", "318041154", "story_v_out_318041.awb")

						arg_653_1:RecordAudio("318041154", var_656_21)
						arg_653_1:RecordAudio("318041154", var_656_21)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_out_318041", "318041154", "story_v_out_318041.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_out_318041", "318041154", "story_v_out_318041.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_22 = math.max(var_656_13, arg_653_1.talkMaxDuration)

			if var_656_12 <= arg_653_1.time_ and arg_653_1.time_ < var_656_12 + var_656_22 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_12) / var_656_22

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_12 + var_656_22 and arg_653_1.time_ < var_656_12 + var_656_22 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play318041155 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 318041155
		arg_657_1.duration_ = 5.6

		local var_657_0 = {
			zh = 5.3,
			ja = 5.6
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
				arg_657_0:Play318041156(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = arg_657_1.actors_["10066ui_story"]
			local var_660_1 = 0

			if var_660_1 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect10066ui_story == nil then
				arg_657_1.var_.characterEffect10066ui_story = var_660_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.200000002980232

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_2 and not isNil(var_660_0) then
				local var_660_3 = (arg_657_1.time_ - var_660_1) / var_660_2

				if arg_657_1.var_.characterEffect10066ui_story and not isNil(var_660_0) then
					arg_657_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= var_660_1 + var_660_2 and arg_657_1.time_ < var_660_1 + var_660_2 + arg_660_0 and not isNil(var_660_0) and arg_657_1.var_.characterEffect10066ui_story then
				arg_657_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_660_4 = 0

			if var_660_4 < arg_657_1.time_ and arg_657_1.time_ <= var_660_4 + arg_660_0 then
				arg_657_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			local var_660_5 = 0

			if var_660_5 < arg_657_1.time_ and arg_657_1.time_ <= var_660_5 + arg_660_0 then
				arg_657_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_660_6 = arg_657_1.actors_["1050ui_story"]
			local var_660_7 = 0

			if var_660_7 < arg_657_1.time_ and arg_657_1.time_ <= var_660_7 + arg_660_0 and not isNil(var_660_6) and arg_657_1.var_.characterEffect1050ui_story == nil then
				arg_657_1.var_.characterEffect1050ui_story = var_660_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_8 = 0.200000002980232

			if var_660_7 <= arg_657_1.time_ and arg_657_1.time_ < var_660_7 + var_660_8 and not isNil(var_660_6) then
				local var_660_9 = (arg_657_1.time_ - var_660_7) / var_660_8

				if arg_657_1.var_.characterEffect1050ui_story and not isNil(var_660_6) then
					local var_660_10 = Mathf.Lerp(0, 0.5, var_660_9)

					arg_657_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_657_1.var_.characterEffect1050ui_story.fillRatio = var_660_10
				end
			end

			if arg_657_1.time_ >= var_660_7 + var_660_8 and arg_657_1.time_ < var_660_7 + var_660_8 + arg_660_0 and not isNil(var_660_6) and arg_657_1.var_.characterEffect1050ui_story then
				local var_660_11 = 0.5

				arg_657_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_657_1.var_.characterEffect1050ui_story.fillRatio = var_660_11
			end

			local var_660_12 = 0
			local var_660_13 = 0.425

			if var_660_12 < arg_657_1.time_ and arg_657_1.time_ <= var_660_12 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				local var_660_14 = arg_657_1:FormatText(StoryNameCfg[640].name)

				arg_657_1.leftNameTxt_.text = var_660_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_15 = arg_657_1:GetWordFromCfg(318041155)
				local var_660_16 = arg_657_1:FormatText(var_660_15.content)

				arg_657_1.text_.text = var_660_16

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_17 = 17
				local var_660_18 = utf8.len(var_660_16)
				local var_660_19 = var_660_17 <= 0 and var_660_13 or var_660_13 * (var_660_18 / var_660_17)

				if var_660_19 > 0 and var_660_13 < var_660_19 then
					arg_657_1.talkMaxDuration = var_660_19

					if var_660_19 + var_660_12 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_19 + var_660_12
					end
				end

				arg_657_1.text_.text = var_660_16
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041155", "story_v_out_318041.awb") ~= 0 then
					local var_660_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041155", "story_v_out_318041.awb") / 1000

					if var_660_20 + var_660_12 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_20 + var_660_12
					end

					if var_660_15.prefab_name ~= "" and arg_657_1.actors_[var_660_15.prefab_name] ~= nil then
						local var_660_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_15.prefab_name].transform, "story_v_out_318041", "318041155", "story_v_out_318041.awb")

						arg_657_1:RecordAudio("318041155", var_660_21)
						arg_657_1:RecordAudio("318041155", var_660_21)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_out_318041", "318041155", "story_v_out_318041.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_out_318041", "318041155", "story_v_out_318041.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_22 = math.max(var_660_13, arg_657_1.talkMaxDuration)

			if var_660_12 <= arg_657_1.time_ and arg_657_1.time_ < var_660_12 + var_660_22 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_12) / var_660_22

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_12 + var_660_22 and arg_657_1.time_ < var_660_12 + var_660_22 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play318041156 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 318041156
		arg_661_1.duration_ = 1.8

		local var_661_0 = {
			zh = 1.8,
			ja = 0.999999999999
		}
		local var_661_1 = manager.audio:GetLocalizationFlag()

		if var_661_0[var_661_1] ~= nil then
			arg_661_1.duration_ = var_661_0[var_661_1]
		end

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play318041157(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = arg_661_1.actors_["1050ui_story"]
			local var_664_1 = 0

			if var_664_1 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 and not isNil(var_664_0) and arg_661_1.var_.characterEffect1050ui_story == nil then
				arg_661_1.var_.characterEffect1050ui_story = var_664_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_2 = 0.200000002980232

			if var_664_1 <= arg_661_1.time_ and arg_661_1.time_ < var_664_1 + var_664_2 and not isNil(var_664_0) then
				local var_664_3 = (arg_661_1.time_ - var_664_1) / var_664_2

				if arg_661_1.var_.characterEffect1050ui_story and not isNil(var_664_0) then
					arg_661_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_661_1.time_ >= var_664_1 + var_664_2 and arg_661_1.time_ < var_664_1 + var_664_2 + arg_664_0 and not isNil(var_664_0) and arg_661_1.var_.characterEffect1050ui_story then
				arg_661_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_664_4 = arg_661_1.actors_["10066ui_story"]
			local var_664_5 = 0

			if var_664_5 < arg_661_1.time_ and arg_661_1.time_ <= var_664_5 + arg_664_0 and not isNil(var_664_4) and arg_661_1.var_.characterEffect10066ui_story == nil then
				arg_661_1.var_.characterEffect10066ui_story = var_664_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_6 = 0.200000002980232

			if var_664_5 <= arg_661_1.time_ and arg_661_1.time_ < var_664_5 + var_664_6 and not isNil(var_664_4) then
				local var_664_7 = (arg_661_1.time_ - var_664_5) / var_664_6

				if arg_661_1.var_.characterEffect10066ui_story and not isNil(var_664_4) then
					local var_664_8 = Mathf.Lerp(0, 0.5, var_664_7)

					arg_661_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_661_1.var_.characterEffect10066ui_story.fillRatio = var_664_8
				end
			end

			if arg_661_1.time_ >= var_664_5 + var_664_6 and arg_661_1.time_ < var_664_5 + var_664_6 + arg_664_0 and not isNil(var_664_4) and arg_661_1.var_.characterEffect10066ui_story then
				local var_664_9 = 0.5

				arg_661_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_661_1.var_.characterEffect10066ui_story.fillRatio = var_664_9
			end

			local var_664_10 = 0
			local var_664_11 = 0.2

			if var_664_10 < arg_661_1.time_ and arg_661_1.time_ <= var_664_10 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				local var_664_12 = arg_661_1:FormatText(StoryNameCfg[74].name)

				arg_661_1.leftNameTxt_.text = var_664_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_13 = arg_661_1:GetWordFromCfg(318041156)
				local var_664_14 = arg_661_1:FormatText(var_664_13.content)

				arg_661_1.text_.text = var_664_14

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_15 = 8
				local var_664_16 = utf8.len(var_664_14)
				local var_664_17 = var_664_15 <= 0 and var_664_11 or var_664_11 * (var_664_16 / var_664_15)

				if var_664_17 > 0 and var_664_11 < var_664_17 then
					arg_661_1.talkMaxDuration = var_664_17

					if var_664_17 + var_664_10 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_17 + var_664_10
					end
				end

				arg_661_1.text_.text = var_664_14
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041156", "story_v_out_318041.awb") ~= 0 then
					local var_664_18 = manager.audio:GetVoiceLength("story_v_out_318041", "318041156", "story_v_out_318041.awb") / 1000

					if var_664_18 + var_664_10 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_18 + var_664_10
					end

					if var_664_13.prefab_name ~= "" and arg_661_1.actors_[var_664_13.prefab_name] ~= nil then
						local var_664_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_661_1.actors_[var_664_13.prefab_name].transform, "story_v_out_318041", "318041156", "story_v_out_318041.awb")

						arg_661_1:RecordAudio("318041156", var_664_19)
						arg_661_1:RecordAudio("318041156", var_664_19)
					else
						arg_661_1:AudioAction("play", "voice", "story_v_out_318041", "318041156", "story_v_out_318041.awb")
					end

					arg_661_1:RecordHistoryTalkVoice("story_v_out_318041", "318041156", "story_v_out_318041.awb")
				end

				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_20 = math.max(var_664_11, arg_661_1.talkMaxDuration)

			if var_664_10 <= arg_661_1.time_ and arg_661_1.time_ < var_664_10 + var_664_20 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_10) / var_664_20

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_10 + var_664_20 and arg_661_1.time_ < var_664_10 + var_664_20 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play318041157 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 318041157
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play318041158(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = arg_665_1.actors_["1050ui_story"]
			local var_668_1 = 0

			if var_668_1 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 and not isNil(var_668_0) and arg_665_1.var_.characterEffect1050ui_story == nil then
				arg_665_1.var_.characterEffect1050ui_story = var_668_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_2 = 0.200000002980232

			if var_668_1 <= arg_665_1.time_ and arg_665_1.time_ < var_668_1 + var_668_2 and not isNil(var_668_0) then
				local var_668_3 = (arg_665_1.time_ - var_668_1) / var_668_2

				if arg_665_1.var_.characterEffect1050ui_story and not isNil(var_668_0) then
					local var_668_4 = Mathf.Lerp(0, 0.5, var_668_3)

					arg_665_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_665_1.var_.characterEffect1050ui_story.fillRatio = var_668_4
				end
			end

			if arg_665_1.time_ >= var_668_1 + var_668_2 and arg_665_1.time_ < var_668_1 + var_668_2 + arg_668_0 and not isNil(var_668_0) and arg_665_1.var_.characterEffect1050ui_story then
				local var_668_5 = 0.5

				arg_665_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_665_1.var_.characterEffect1050ui_story.fillRatio = var_668_5
			end

			local var_668_6 = 0

			if var_668_6 < arg_665_1.time_ and arg_665_1.time_ <= var_668_6 + arg_668_0 then
				arg_665_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_2")
			end

			local var_668_7 = 0
			local var_668_8 = 1.025

			if var_668_7 < arg_665_1.time_ and arg_665_1.time_ <= var_668_7 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, false)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_9 = arg_665_1:GetWordFromCfg(318041157)
				local var_668_10 = arg_665_1:FormatText(var_668_9.content)

				arg_665_1.text_.text = var_668_10

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_11 = 41
				local var_668_12 = utf8.len(var_668_10)
				local var_668_13 = var_668_11 <= 0 and var_668_8 or var_668_8 * (var_668_12 / var_668_11)

				if var_668_13 > 0 and var_668_8 < var_668_13 then
					arg_665_1.talkMaxDuration = var_668_13

					if var_668_13 + var_668_7 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_13 + var_668_7
					end
				end

				arg_665_1.text_.text = var_668_10
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_14 = math.max(var_668_8, arg_665_1.talkMaxDuration)

			if var_668_7 <= arg_665_1.time_ and arg_665_1.time_ < var_668_7 + var_668_14 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_7) / var_668_14

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_7 + var_668_14 and arg_665_1.time_ < var_668_7 + var_668_14 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play318041158 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 318041158
		arg_669_1.duration_ = 6.9

		local var_669_0 = {
			zh = 2.9,
			ja = 6.9
		}
		local var_669_1 = manager.audio:GetLocalizationFlag()

		if var_669_0[var_669_1] ~= nil then
			arg_669_1.duration_ = var_669_0[var_669_1]
		end

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play318041159(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = arg_669_1.actors_["10066ui_story"]
			local var_672_1 = 0

			if var_672_1 < arg_669_1.time_ and arg_669_1.time_ <= var_672_1 + arg_672_0 and not isNil(var_672_0) and arg_669_1.var_.characterEffect10066ui_story == nil then
				arg_669_1.var_.characterEffect10066ui_story = var_672_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_2 = 0.200000002980232

			if var_672_1 <= arg_669_1.time_ and arg_669_1.time_ < var_672_1 + var_672_2 and not isNil(var_672_0) then
				local var_672_3 = (arg_669_1.time_ - var_672_1) / var_672_2

				if arg_669_1.var_.characterEffect10066ui_story and not isNil(var_672_0) then
					arg_669_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_669_1.time_ >= var_672_1 + var_672_2 and arg_669_1.time_ < var_672_1 + var_672_2 + arg_672_0 and not isNil(var_672_0) and arg_669_1.var_.characterEffect10066ui_story then
				arg_669_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_672_4 = 0

			if var_672_4 < arg_669_1.time_ and arg_669_1.time_ <= var_672_4 + arg_672_0 then
				arg_669_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_672_5 = 0
			local var_672_6 = 0.225

			if var_672_5 < arg_669_1.time_ and arg_669_1.time_ <= var_672_5 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_7 = arg_669_1:FormatText(StoryNameCfg[640].name)

				arg_669_1.leftNameTxt_.text = var_672_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_8 = arg_669_1:GetWordFromCfg(318041158)
				local var_672_9 = arg_669_1:FormatText(var_672_8.content)

				arg_669_1.text_.text = var_672_9

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_10 = 9
				local var_672_11 = utf8.len(var_672_9)
				local var_672_12 = var_672_10 <= 0 and var_672_6 or var_672_6 * (var_672_11 / var_672_10)

				if var_672_12 > 0 and var_672_6 < var_672_12 then
					arg_669_1.talkMaxDuration = var_672_12

					if var_672_12 + var_672_5 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_12 + var_672_5
					end
				end

				arg_669_1.text_.text = var_672_9
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041158", "story_v_out_318041.awb") ~= 0 then
					local var_672_13 = manager.audio:GetVoiceLength("story_v_out_318041", "318041158", "story_v_out_318041.awb") / 1000

					if var_672_13 + var_672_5 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_13 + var_672_5
					end

					if var_672_8.prefab_name ~= "" and arg_669_1.actors_[var_672_8.prefab_name] ~= nil then
						local var_672_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_8.prefab_name].transform, "story_v_out_318041", "318041158", "story_v_out_318041.awb")

						arg_669_1:RecordAudio("318041158", var_672_14)
						arg_669_1:RecordAudio("318041158", var_672_14)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_out_318041", "318041158", "story_v_out_318041.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_out_318041", "318041158", "story_v_out_318041.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_15 = math.max(var_672_6, arg_669_1.talkMaxDuration)

			if var_672_5 <= arg_669_1.time_ and arg_669_1.time_ < var_672_5 + var_672_15 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_5) / var_672_15

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_5 + var_672_15 and arg_669_1.time_ < var_672_5 + var_672_15 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play318041159 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 318041159
		arg_673_1.duration_ = 2.77

		local var_673_0 = {
			zh = 2.766,
			ja = 2.066
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
				arg_673_0:Play318041160(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = arg_673_1.actors_["1050ui_story"]
			local var_676_1 = 0

			if var_676_1 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 and not isNil(var_676_0) and arg_673_1.var_.characterEffect1050ui_story == nil then
				arg_673_1.var_.characterEffect1050ui_story = var_676_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_2 = 0.200000002980232

			if var_676_1 <= arg_673_1.time_ and arg_673_1.time_ < var_676_1 + var_676_2 and not isNil(var_676_0) then
				local var_676_3 = (arg_673_1.time_ - var_676_1) / var_676_2

				if arg_673_1.var_.characterEffect1050ui_story and not isNil(var_676_0) then
					arg_673_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_673_1.time_ >= var_676_1 + var_676_2 and arg_673_1.time_ < var_676_1 + var_676_2 + arg_676_0 and not isNil(var_676_0) and arg_673_1.var_.characterEffect1050ui_story then
				arg_673_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_676_4 = 0

			if var_676_4 < arg_673_1.time_ and arg_673_1.time_ <= var_676_4 + arg_676_0 then
				arg_673_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_676_5 = 0

			if var_676_5 < arg_673_1.time_ and arg_673_1.time_ <= var_676_5 + arg_676_0 then
				arg_673_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_676_6 = arg_673_1.actors_["10066ui_story"]
			local var_676_7 = 0

			if var_676_7 < arg_673_1.time_ and arg_673_1.time_ <= var_676_7 + arg_676_0 and not isNil(var_676_6) and arg_673_1.var_.characterEffect10066ui_story == nil then
				arg_673_1.var_.characterEffect10066ui_story = var_676_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_8 = 0.200000002980232

			if var_676_7 <= arg_673_1.time_ and arg_673_1.time_ < var_676_7 + var_676_8 and not isNil(var_676_6) then
				local var_676_9 = (arg_673_1.time_ - var_676_7) / var_676_8

				if arg_673_1.var_.characterEffect10066ui_story and not isNil(var_676_6) then
					local var_676_10 = Mathf.Lerp(0, 0.5, var_676_9)

					arg_673_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_673_1.var_.characterEffect10066ui_story.fillRatio = var_676_10
				end
			end

			if arg_673_1.time_ >= var_676_7 + var_676_8 and arg_673_1.time_ < var_676_7 + var_676_8 + arg_676_0 and not isNil(var_676_6) and arg_673_1.var_.characterEffect10066ui_story then
				local var_676_11 = 0.5

				arg_673_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_673_1.var_.characterEffect10066ui_story.fillRatio = var_676_11
			end

			local var_676_12 = 0
			local var_676_13 = 0.2

			if var_676_12 < arg_673_1.time_ and arg_673_1.time_ <= var_676_12 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				local var_676_14 = arg_673_1:FormatText(StoryNameCfg[74].name)

				arg_673_1.leftNameTxt_.text = var_676_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_15 = arg_673_1:GetWordFromCfg(318041159)
				local var_676_16 = arg_673_1:FormatText(var_676_15.content)

				arg_673_1.text_.text = var_676_16

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_17 = 8
				local var_676_18 = utf8.len(var_676_16)
				local var_676_19 = var_676_17 <= 0 and var_676_13 or var_676_13 * (var_676_18 / var_676_17)

				if var_676_19 > 0 and var_676_13 < var_676_19 then
					arg_673_1.talkMaxDuration = var_676_19

					if var_676_19 + var_676_12 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_19 + var_676_12
					end
				end

				arg_673_1.text_.text = var_676_16
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041159", "story_v_out_318041.awb") ~= 0 then
					local var_676_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041159", "story_v_out_318041.awb") / 1000

					if var_676_20 + var_676_12 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_20 + var_676_12
					end

					if var_676_15.prefab_name ~= "" and arg_673_1.actors_[var_676_15.prefab_name] ~= nil then
						local var_676_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_15.prefab_name].transform, "story_v_out_318041", "318041159", "story_v_out_318041.awb")

						arg_673_1:RecordAudio("318041159", var_676_21)
						arg_673_1:RecordAudio("318041159", var_676_21)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_out_318041", "318041159", "story_v_out_318041.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_out_318041", "318041159", "story_v_out_318041.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_22 = math.max(var_676_13, arg_673_1.talkMaxDuration)

			if var_676_12 <= arg_673_1.time_ and arg_673_1.time_ < var_676_12 + var_676_22 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_12) / var_676_22

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_12 + var_676_22 and arg_673_1.time_ < var_676_12 + var_676_22 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play318041160 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 318041160
		arg_677_1.duration_ = 7.6

		local var_677_0 = {
			zh = 7.6,
			ja = 6.433
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
				arg_677_0:Play318041161(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = arg_677_1.actors_["10066ui_story"]
			local var_680_1 = 0

			if var_680_1 < arg_677_1.time_ and arg_677_1.time_ <= var_680_1 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect10066ui_story == nil then
				arg_677_1.var_.characterEffect10066ui_story = var_680_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_2 = 0.200000002980232

			if var_680_1 <= arg_677_1.time_ and arg_677_1.time_ < var_680_1 + var_680_2 and not isNil(var_680_0) then
				local var_680_3 = (arg_677_1.time_ - var_680_1) / var_680_2

				if arg_677_1.var_.characterEffect10066ui_story and not isNil(var_680_0) then
					arg_677_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_677_1.time_ >= var_680_1 + var_680_2 and arg_677_1.time_ < var_680_1 + var_680_2 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect10066ui_story then
				arg_677_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_680_4 = 0

			if var_680_4 < arg_677_1.time_ and arg_677_1.time_ <= var_680_4 + arg_680_0 then
				arg_677_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			local var_680_5 = 0

			if var_680_5 < arg_677_1.time_ and arg_677_1.time_ <= var_680_5 + arg_680_0 then
				arg_677_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_680_6 = arg_677_1.actors_["1050ui_story"]
			local var_680_7 = 0

			if var_680_7 < arg_677_1.time_ and arg_677_1.time_ <= var_680_7 + arg_680_0 and not isNil(var_680_6) and arg_677_1.var_.characterEffect1050ui_story == nil then
				arg_677_1.var_.characterEffect1050ui_story = var_680_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_8 = 0.200000002980232

			if var_680_7 <= arg_677_1.time_ and arg_677_1.time_ < var_680_7 + var_680_8 and not isNil(var_680_6) then
				local var_680_9 = (arg_677_1.time_ - var_680_7) / var_680_8

				if arg_677_1.var_.characterEffect1050ui_story and not isNil(var_680_6) then
					local var_680_10 = Mathf.Lerp(0, 0.5, var_680_9)

					arg_677_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_677_1.var_.characterEffect1050ui_story.fillRatio = var_680_10
				end
			end

			if arg_677_1.time_ >= var_680_7 + var_680_8 and arg_677_1.time_ < var_680_7 + var_680_8 + arg_680_0 and not isNil(var_680_6) and arg_677_1.var_.characterEffect1050ui_story then
				local var_680_11 = 0.5

				arg_677_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_677_1.var_.characterEffect1050ui_story.fillRatio = var_680_11
			end

			local var_680_12 = 0
			local var_680_13 = 0.65

			if var_680_12 < arg_677_1.time_ and arg_677_1.time_ <= var_680_12 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				local var_680_14 = arg_677_1:FormatText(StoryNameCfg[640].name)

				arg_677_1.leftNameTxt_.text = var_680_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_15 = arg_677_1:GetWordFromCfg(318041160)
				local var_680_16 = arg_677_1:FormatText(var_680_15.content)

				arg_677_1.text_.text = var_680_16

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_17 = 26
				local var_680_18 = utf8.len(var_680_16)
				local var_680_19 = var_680_17 <= 0 and var_680_13 or var_680_13 * (var_680_18 / var_680_17)

				if var_680_19 > 0 and var_680_13 < var_680_19 then
					arg_677_1.talkMaxDuration = var_680_19

					if var_680_19 + var_680_12 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_19 + var_680_12
					end
				end

				arg_677_1.text_.text = var_680_16
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041160", "story_v_out_318041.awb") ~= 0 then
					local var_680_20 = manager.audio:GetVoiceLength("story_v_out_318041", "318041160", "story_v_out_318041.awb") / 1000

					if var_680_20 + var_680_12 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_20 + var_680_12
					end

					if var_680_15.prefab_name ~= "" and arg_677_1.actors_[var_680_15.prefab_name] ~= nil then
						local var_680_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_15.prefab_name].transform, "story_v_out_318041", "318041160", "story_v_out_318041.awb")

						arg_677_1:RecordAudio("318041160", var_680_21)
						arg_677_1:RecordAudio("318041160", var_680_21)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_out_318041", "318041160", "story_v_out_318041.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_out_318041", "318041160", "story_v_out_318041.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_22 = math.max(var_680_13, arg_677_1.talkMaxDuration)

			if var_680_12 <= arg_677_1.time_ and arg_677_1.time_ < var_680_12 + var_680_22 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_12) / var_680_22

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_12 + var_680_22 and arg_677_1.time_ < var_680_12 + var_680_22 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play318041161 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 318041161
		arg_681_1.duration_ = 4.8

		local var_681_0 = {
			zh = 3.1,
			ja = 4.8
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
				arg_681_0:Play318041162(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = arg_681_1.actors_["1050ui_story"]
			local var_684_1 = 0

			if var_684_1 < arg_681_1.time_ and arg_681_1.time_ <= var_684_1 + arg_684_0 and not isNil(var_684_0) and arg_681_1.var_.characterEffect1050ui_story == nil then
				arg_681_1.var_.characterEffect1050ui_story = var_684_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_2 = 0.200000002980232

			if var_684_1 <= arg_681_1.time_ and arg_681_1.time_ < var_684_1 + var_684_2 and not isNil(var_684_0) then
				local var_684_3 = (arg_681_1.time_ - var_684_1) / var_684_2

				if arg_681_1.var_.characterEffect1050ui_story and not isNil(var_684_0) then
					arg_681_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_681_1.time_ >= var_684_1 + var_684_2 and arg_681_1.time_ < var_684_1 + var_684_2 + arg_684_0 and not isNil(var_684_0) and arg_681_1.var_.characterEffect1050ui_story then
				arg_681_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_684_4 = arg_681_1.actors_["10066ui_story"]
			local var_684_5 = 0

			if var_684_5 < arg_681_1.time_ and arg_681_1.time_ <= var_684_5 + arg_684_0 and not isNil(var_684_4) and arg_681_1.var_.characterEffect10066ui_story == nil then
				arg_681_1.var_.characterEffect10066ui_story = var_684_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_6 = 0.200000002980232

			if var_684_5 <= arg_681_1.time_ and arg_681_1.time_ < var_684_5 + var_684_6 and not isNil(var_684_4) then
				local var_684_7 = (arg_681_1.time_ - var_684_5) / var_684_6

				if arg_681_1.var_.characterEffect10066ui_story and not isNil(var_684_4) then
					local var_684_8 = Mathf.Lerp(0, 0.5, var_684_7)

					arg_681_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_681_1.var_.characterEffect10066ui_story.fillRatio = var_684_8
				end
			end

			if arg_681_1.time_ >= var_684_5 + var_684_6 and arg_681_1.time_ < var_684_5 + var_684_6 + arg_684_0 and not isNil(var_684_4) and arg_681_1.var_.characterEffect10066ui_story then
				local var_684_9 = 0.5

				arg_681_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_681_1.var_.characterEffect10066ui_story.fillRatio = var_684_9
			end

			local var_684_10 = 0
			local var_684_11 = 0.5

			if var_684_10 < arg_681_1.time_ and arg_681_1.time_ <= var_684_10 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				local var_684_12 = arg_681_1:FormatText(StoryNameCfg[74].name)

				arg_681_1.leftNameTxt_.text = var_684_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_13 = arg_681_1:GetWordFromCfg(318041161)
				local var_684_14 = arg_681_1:FormatText(var_684_13.content)

				arg_681_1.text_.text = var_684_14

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_15 = 20
				local var_684_16 = utf8.len(var_684_14)
				local var_684_17 = var_684_15 <= 0 and var_684_11 or var_684_11 * (var_684_16 / var_684_15)

				if var_684_17 > 0 and var_684_11 < var_684_17 then
					arg_681_1.talkMaxDuration = var_684_17

					if var_684_17 + var_684_10 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_17 + var_684_10
					end
				end

				arg_681_1.text_.text = var_684_14
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041161", "story_v_out_318041.awb") ~= 0 then
					local var_684_18 = manager.audio:GetVoiceLength("story_v_out_318041", "318041161", "story_v_out_318041.awb") / 1000

					if var_684_18 + var_684_10 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_18 + var_684_10
					end

					if var_684_13.prefab_name ~= "" and arg_681_1.actors_[var_684_13.prefab_name] ~= nil then
						local var_684_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_681_1.actors_[var_684_13.prefab_name].transform, "story_v_out_318041", "318041161", "story_v_out_318041.awb")

						arg_681_1:RecordAudio("318041161", var_684_19)
						arg_681_1:RecordAudio("318041161", var_684_19)
					else
						arg_681_1:AudioAction("play", "voice", "story_v_out_318041", "318041161", "story_v_out_318041.awb")
					end

					arg_681_1:RecordHistoryTalkVoice("story_v_out_318041", "318041161", "story_v_out_318041.awb")
				end

				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_20 = math.max(var_684_11, arg_681_1.talkMaxDuration)

			if var_684_10 <= arg_681_1.time_ and arg_681_1.time_ < var_684_10 + var_684_20 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_10) / var_684_20

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_10 + var_684_20 and arg_681_1.time_ < var_684_10 + var_684_20 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	Play318041162 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 318041162
		arg_685_1.duration_ = 6.8

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play318041163(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = "K13f"

			if arg_685_1.bgs_[var_688_0] == nil then
				local var_688_1 = Object.Instantiate(arg_685_1.paintGo_)

				var_688_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_688_0)
				var_688_1.name = var_688_0
				var_688_1.transform.parent = arg_685_1.stage_.transform
				var_688_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_685_1.bgs_[var_688_0] = var_688_1
			end

			local var_688_2 = 0.983333333333333

			if var_688_2 < arg_685_1.time_ and arg_685_1.time_ <= var_688_2 + arg_688_0 then
				local var_688_3 = manager.ui.mainCamera.transform.localPosition
				local var_688_4 = Vector3.New(0, 0, 10) + Vector3.New(var_688_3.x, var_688_3.y, 0)
				local var_688_5 = arg_685_1.bgs_.K13f

				var_688_5.transform.localPosition = var_688_4
				var_688_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_688_6 = var_688_5:GetComponent("SpriteRenderer")

				if var_688_6 and var_688_6.sprite then
					local var_688_7 = (var_688_5.transform.localPosition - var_688_3).z
					local var_688_8 = manager.ui.mainCameraCom_
					local var_688_9 = 2 * var_688_7 * Mathf.Tan(var_688_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_688_10 = var_688_9 * var_688_8.aspect
					local var_688_11 = var_688_6.sprite.bounds.size.x
					local var_688_12 = var_688_6.sprite.bounds.size.y
					local var_688_13 = var_688_10 / var_688_11
					local var_688_14 = var_688_9 / var_688_12
					local var_688_15 = var_688_14 < var_688_13 and var_688_13 or var_688_14

					var_688_5.transform.localScale = Vector3.New(var_688_15, var_688_15, 0)
				end

				for iter_688_0, iter_688_1 in pairs(arg_685_1.bgs_) do
					if iter_688_0 ~= "K13f" then
						iter_688_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_688_16 = arg_685_1.actors_["1050ui_story"]
			local var_688_17 = 0.983333333333333

			if var_688_17 < arg_685_1.time_ and arg_685_1.time_ <= var_688_17 + arg_688_0 and not isNil(var_688_16) and arg_685_1.var_.characterEffect1050ui_story == nil then
				arg_685_1.var_.characterEffect1050ui_story = var_688_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_18 = 0.0166666666666667

			if var_688_17 <= arg_685_1.time_ and arg_685_1.time_ < var_688_17 + var_688_18 and not isNil(var_688_16) then
				local var_688_19 = (arg_685_1.time_ - var_688_17) / var_688_18

				if arg_685_1.var_.characterEffect1050ui_story and not isNil(var_688_16) then
					local var_688_20 = Mathf.Lerp(0, 0.5, var_688_19)

					arg_685_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_685_1.var_.characterEffect1050ui_story.fillRatio = var_688_20
				end
			end

			if arg_685_1.time_ >= var_688_17 + var_688_18 and arg_685_1.time_ < var_688_17 + var_688_18 + arg_688_0 and not isNil(var_688_16) and arg_685_1.var_.characterEffect1050ui_story then
				local var_688_21 = 0.5

				arg_685_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_685_1.var_.characterEffect1050ui_story.fillRatio = var_688_21
			end

			local var_688_22 = arg_685_1.actors_["10066ui_story"]
			local var_688_23 = 0.983333333333333

			if var_688_23 < arg_685_1.time_ and arg_685_1.time_ <= var_688_23 + arg_688_0 and not isNil(var_688_22) and arg_685_1.var_.characterEffect10066ui_story == nil then
				arg_685_1.var_.characterEffect10066ui_story = var_688_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_24 = 0.0166666666666667

			if var_688_23 <= arg_685_1.time_ and arg_685_1.time_ < var_688_23 + var_688_24 and not isNil(var_688_22) then
				local var_688_25 = (arg_685_1.time_ - var_688_23) / var_688_24

				if arg_685_1.var_.characterEffect10066ui_story and not isNil(var_688_22) then
					local var_688_26 = Mathf.Lerp(0, 0.5, var_688_25)

					arg_685_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_685_1.var_.characterEffect10066ui_story.fillRatio = var_688_26
				end
			end

			if arg_685_1.time_ >= var_688_23 + var_688_24 and arg_685_1.time_ < var_688_23 + var_688_24 + arg_688_0 and not isNil(var_688_22) and arg_685_1.var_.characterEffect10066ui_story then
				local var_688_27 = 0.5

				arg_685_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_685_1.var_.characterEffect10066ui_story.fillRatio = var_688_27
			end

			local var_688_28 = 0

			if var_688_28 < arg_685_1.time_ and arg_685_1.time_ <= var_688_28 + arg_688_0 then
				arg_685_1.mask_.enabled = true
				arg_685_1.mask_.raycastTarget = true

				arg_685_1:SetGaussion(false)
			end

			local var_688_29 = 1

			if var_688_28 <= arg_685_1.time_ and arg_685_1.time_ < var_688_28 + var_688_29 then
				local var_688_30 = (arg_685_1.time_ - var_688_28) / var_688_29
				local var_688_31 = Color.New(0, 0, 0)

				var_688_31.a = Mathf.Lerp(0, 1, var_688_30)
				arg_685_1.mask_.color = var_688_31
			end

			if arg_685_1.time_ >= var_688_28 + var_688_29 and arg_685_1.time_ < var_688_28 + var_688_29 + arg_688_0 then
				local var_688_32 = Color.New(0, 0, 0)

				var_688_32.a = 1
				arg_685_1.mask_.color = var_688_32
			end

			local var_688_33 = 1

			if var_688_33 < arg_685_1.time_ and arg_685_1.time_ <= var_688_33 + arg_688_0 then
				arg_685_1.mask_.enabled = true
				arg_685_1.mask_.raycastTarget = true

				arg_685_1:SetGaussion(false)
			end

			local var_688_34 = 1

			if var_688_33 <= arg_685_1.time_ and arg_685_1.time_ < var_688_33 + var_688_34 then
				local var_688_35 = (arg_685_1.time_ - var_688_33) / var_688_34
				local var_688_36 = Color.New(0, 0, 0)

				var_688_36.a = Mathf.Lerp(1, 0, var_688_35)
				arg_685_1.mask_.color = var_688_36
			end

			if arg_685_1.time_ >= var_688_33 + var_688_34 and arg_685_1.time_ < var_688_33 + var_688_34 + arg_688_0 then
				local var_688_37 = Color.New(0, 0, 0)
				local var_688_38 = 0

				arg_685_1.mask_.enabled = false
				var_688_37.a = var_688_38
				arg_685_1.mask_.color = var_688_37
			end

			local var_688_39 = arg_685_1.actors_["10066ui_story"].transform
			local var_688_40 = 0.966

			if var_688_40 < arg_685_1.time_ and arg_685_1.time_ <= var_688_40 + arg_688_0 then
				arg_685_1.var_.moveOldPos10066ui_story = var_688_39.localPosition
			end

			local var_688_41 = 0.001

			if var_688_40 <= arg_685_1.time_ and arg_685_1.time_ < var_688_40 + var_688_41 then
				local var_688_42 = (arg_685_1.time_ - var_688_40) / var_688_41
				local var_688_43 = Vector3.New(0, 100, 0)

				var_688_39.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos10066ui_story, var_688_43, var_688_42)

				local var_688_44 = manager.ui.mainCamera.transform.position - var_688_39.position

				var_688_39.forward = Vector3.New(var_688_44.x, var_688_44.y, var_688_44.z)

				local var_688_45 = var_688_39.localEulerAngles

				var_688_45.z = 0
				var_688_45.x = 0
				var_688_39.localEulerAngles = var_688_45
			end

			if arg_685_1.time_ >= var_688_40 + var_688_41 and arg_685_1.time_ < var_688_40 + var_688_41 + arg_688_0 then
				var_688_39.localPosition = Vector3.New(0, 100, 0)

				local var_688_46 = manager.ui.mainCamera.transform.position - var_688_39.position

				var_688_39.forward = Vector3.New(var_688_46.x, var_688_46.y, var_688_46.z)

				local var_688_47 = var_688_39.localEulerAngles

				var_688_47.z = 0
				var_688_47.x = 0
				var_688_39.localEulerAngles = var_688_47
			end

			local var_688_48 = arg_685_1.actors_["1050ui_story"].transform
			local var_688_49 = 0.966

			if var_688_49 < arg_685_1.time_ and arg_685_1.time_ <= var_688_49 + arg_688_0 then
				arg_685_1.var_.moveOldPos1050ui_story = var_688_48.localPosition
			end

			local var_688_50 = 0.001

			if var_688_49 <= arg_685_1.time_ and arg_685_1.time_ < var_688_49 + var_688_50 then
				local var_688_51 = (arg_685_1.time_ - var_688_49) / var_688_50
				local var_688_52 = Vector3.New(0, 100, 0)

				var_688_48.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos1050ui_story, var_688_52, var_688_51)

				local var_688_53 = manager.ui.mainCamera.transform.position - var_688_48.position

				var_688_48.forward = Vector3.New(var_688_53.x, var_688_53.y, var_688_53.z)

				local var_688_54 = var_688_48.localEulerAngles

				var_688_54.z = 0
				var_688_54.x = 0
				var_688_48.localEulerAngles = var_688_54
			end

			if arg_685_1.time_ >= var_688_49 + var_688_50 and arg_685_1.time_ < var_688_49 + var_688_50 + arg_688_0 then
				var_688_48.localPosition = Vector3.New(0, 100, 0)

				local var_688_55 = manager.ui.mainCamera.transform.position - var_688_48.position

				var_688_48.forward = Vector3.New(var_688_55.x, var_688_55.y, var_688_55.z)

				local var_688_56 = var_688_48.localEulerAngles

				var_688_56.z = 0
				var_688_56.x = 0
				var_688_48.localEulerAngles = var_688_56
			end

			if arg_685_1.frameCnt_ <= 1 then
				arg_685_1.dialog_:SetActive(false)
			end

			local var_688_57 = 1.8
			local var_688_58 = 0.775

			if var_688_57 < arg_685_1.time_ and arg_685_1.time_ <= var_688_57 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0

				arg_685_1.dialog_:SetActive(true)

				arg_685_1.dialogCg_.alpha = 0

				local var_688_59 = LeanTween.value(arg_685_1.dialog_, 0, 1, 0.3)

				var_688_59:setOnUpdate(LuaHelper.FloatAction(function(arg_689_0)
					arg_685_1.dialogCg_.alpha = arg_689_0
				end))
				var_688_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_685_1.dialog_)
					var_688_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_685_1.duration_ = arg_685_1.duration_ + 0.3

				SetActive(arg_685_1.leftNameGo_, false)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_60 = arg_685_1:GetWordFromCfg(318041162)
				local var_688_61 = arg_685_1:FormatText(var_688_60.content)

				arg_685_1.text_.text = var_688_61

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_62 = 31
				local var_688_63 = utf8.len(var_688_61)
				local var_688_64 = var_688_62 <= 0 and var_688_58 or var_688_58 * (var_688_63 / var_688_62)

				if var_688_64 > 0 and var_688_58 < var_688_64 then
					arg_685_1.talkMaxDuration = var_688_64
					var_688_57 = var_688_57 + 0.3

					if var_688_64 + var_688_57 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_64 + var_688_57
					end
				end

				arg_685_1.text_.text = var_688_61
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_65 = var_688_57 + 0.3
			local var_688_66 = math.max(var_688_58, arg_685_1.talkMaxDuration)

			if var_688_65 <= arg_685_1.time_ and arg_685_1.time_ < var_688_65 + var_688_66 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_65) / var_688_66

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_65 + var_688_66 and arg_685_1.time_ < var_688_65 + var_688_66 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_685_1:InitPlayNodeList()
	end,
	Play318041163 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 318041163
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play318041164(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = 0
			local var_694_1 = 1.4

			if var_694_0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_0 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, false)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_2 = arg_691_1:GetWordFromCfg(318041163)
				local var_694_3 = arg_691_1:FormatText(var_694_2.content)

				arg_691_1.text_.text = var_694_3

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_4 = 56
				local var_694_5 = utf8.len(var_694_3)
				local var_694_6 = var_694_4 <= 0 and var_694_1 or var_694_1 * (var_694_5 / var_694_4)

				if var_694_6 > 0 and var_694_1 < var_694_6 then
					arg_691_1.talkMaxDuration = var_694_6

					if var_694_6 + var_694_0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_6 + var_694_0
					end
				end

				arg_691_1.text_.text = var_694_3
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_7 = math.max(var_694_1, arg_691_1.talkMaxDuration)

			if var_694_0 <= arg_691_1.time_ and arg_691_1.time_ < var_694_0 + var_694_7 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_0) / var_694_7

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_0 + var_694_7 and arg_691_1.time_ < var_694_0 + var_694_7 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play318041164 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 318041164
		arg_695_1.duration_ = 7.93

		local var_695_0 = {
			zh = 4.633,
			ja = 7.933
		}
		local var_695_1 = manager.audio:GetLocalizationFlag()

		if var_695_0[var_695_1] ~= nil then
			arg_695_1.duration_ = var_695_0[var_695_1]
		end

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play318041165(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = arg_695_1.actors_["10066ui_story"]
			local var_698_1 = 0

			if var_698_1 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 and not isNil(var_698_0) and arg_695_1.var_.characterEffect10066ui_story == nil then
				arg_695_1.var_.characterEffect10066ui_story = var_698_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_2 = 0.200000002980232

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_2 and not isNil(var_698_0) then
				local var_698_3 = (arg_695_1.time_ - var_698_1) / var_698_2

				if arg_695_1.var_.characterEffect10066ui_story and not isNil(var_698_0) then
					arg_695_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_695_1.time_ >= var_698_1 + var_698_2 and arg_695_1.time_ < var_698_1 + var_698_2 + arg_698_0 and not isNil(var_698_0) and arg_695_1.var_.characterEffect10066ui_story then
				arg_695_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_698_4 = 0

			if var_698_4 < arg_695_1.time_ and arg_695_1.time_ <= var_698_4 + arg_698_0 then
				arg_695_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			local var_698_5 = 0

			if var_698_5 < arg_695_1.time_ and arg_695_1.time_ <= var_698_5 + arg_698_0 then
				arg_695_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_698_6 = arg_695_1.actors_["10066ui_story"].transform
			local var_698_7 = 0

			if var_698_7 < arg_695_1.time_ and arg_695_1.time_ <= var_698_7 + arg_698_0 then
				arg_695_1.var_.moveOldPos10066ui_story = var_698_6.localPosition
			end

			local var_698_8 = 0.001

			if var_698_7 <= arg_695_1.time_ and arg_695_1.time_ < var_698_7 + var_698_8 then
				local var_698_9 = (arg_695_1.time_ - var_698_7) / var_698_8
				local var_698_10 = Vector3.New(-0.7, -0.99, -5.83)

				var_698_6.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos10066ui_story, var_698_10, var_698_9)

				local var_698_11 = manager.ui.mainCamera.transform.position - var_698_6.position

				var_698_6.forward = Vector3.New(var_698_11.x, var_698_11.y, var_698_11.z)

				local var_698_12 = var_698_6.localEulerAngles

				var_698_12.z = 0
				var_698_12.x = 0
				var_698_6.localEulerAngles = var_698_12
			end

			if arg_695_1.time_ >= var_698_7 + var_698_8 and arg_695_1.time_ < var_698_7 + var_698_8 + arg_698_0 then
				var_698_6.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_698_13 = manager.ui.mainCamera.transform.position - var_698_6.position

				var_698_6.forward = Vector3.New(var_698_13.x, var_698_13.y, var_698_13.z)

				local var_698_14 = var_698_6.localEulerAngles

				var_698_14.z = 0
				var_698_14.x = 0
				var_698_6.localEulerAngles = var_698_14
			end

			local var_698_15 = 0
			local var_698_16 = 0.275

			if var_698_15 < arg_695_1.time_ and arg_695_1.time_ <= var_698_15 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_17 = arg_695_1:FormatText(StoryNameCfg[640].name)

				arg_695_1.leftNameTxt_.text = var_698_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_18 = arg_695_1:GetWordFromCfg(318041164)
				local var_698_19 = arg_695_1:FormatText(var_698_18.content)

				arg_695_1.text_.text = var_698_19

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_20 = 11
				local var_698_21 = utf8.len(var_698_19)
				local var_698_22 = var_698_20 <= 0 and var_698_16 or var_698_16 * (var_698_21 / var_698_20)

				if var_698_22 > 0 and var_698_16 < var_698_22 then
					arg_695_1.talkMaxDuration = var_698_22

					if var_698_22 + var_698_15 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_22 + var_698_15
					end
				end

				arg_695_1.text_.text = var_698_19
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041164", "story_v_out_318041.awb") ~= 0 then
					local var_698_23 = manager.audio:GetVoiceLength("story_v_out_318041", "318041164", "story_v_out_318041.awb") / 1000

					if var_698_23 + var_698_15 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_23 + var_698_15
					end

					if var_698_18.prefab_name ~= "" and arg_695_1.actors_[var_698_18.prefab_name] ~= nil then
						local var_698_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_18.prefab_name].transform, "story_v_out_318041", "318041164", "story_v_out_318041.awb")

						arg_695_1:RecordAudio("318041164", var_698_24)
						arg_695_1:RecordAudio("318041164", var_698_24)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_out_318041", "318041164", "story_v_out_318041.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_out_318041", "318041164", "story_v_out_318041.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_25 = math.max(var_698_16, arg_695_1.talkMaxDuration)

			if var_698_15 <= arg_695_1.time_ and arg_695_1.time_ < var_698_15 + var_698_25 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_15) / var_698_25

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_15 + var_698_25 and arg_695_1.time_ < var_698_15 + var_698_25 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_695_1:InitPlayNodeList()
	end,
	Play318041165 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 318041165
		arg_699_1.duration_ = 2.63

		local var_699_0 = {
			zh = 2.233,
			ja = 2.633
		}
		local var_699_1 = manager.audio:GetLocalizationFlag()

		if var_699_0[var_699_1] ~= nil then
			arg_699_1.duration_ = var_699_0[var_699_1]
		end

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play318041166(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["1050ui_story"]
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 and not isNil(var_702_0) and arg_699_1.var_.characterEffect1050ui_story == nil then
				arg_699_1.var_.characterEffect1050ui_story = var_702_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_2 = 0.200000002980232

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 and not isNil(var_702_0) then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2

				if arg_699_1.var_.characterEffect1050ui_story and not isNil(var_702_0) then
					arg_699_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 and not isNil(var_702_0) and arg_699_1.var_.characterEffect1050ui_story then
				arg_699_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_702_4 = arg_699_1.actors_["10066ui_story"]
			local var_702_5 = 0

			if var_702_5 < arg_699_1.time_ and arg_699_1.time_ <= var_702_5 + arg_702_0 and not isNil(var_702_4) and arg_699_1.var_.characterEffect10066ui_story == nil then
				arg_699_1.var_.characterEffect10066ui_story = var_702_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_6 = 0.200000002980232

			if var_702_5 <= arg_699_1.time_ and arg_699_1.time_ < var_702_5 + var_702_6 and not isNil(var_702_4) then
				local var_702_7 = (arg_699_1.time_ - var_702_5) / var_702_6

				if arg_699_1.var_.characterEffect10066ui_story and not isNil(var_702_4) then
					local var_702_8 = Mathf.Lerp(0, 0.5, var_702_7)

					arg_699_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_699_1.var_.characterEffect10066ui_story.fillRatio = var_702_8
				end
			end

			if arg_699_1.time_ >= var_702_5 + var_702_6 and arg_699_1.time_ < var_702_5 + var_702_6 + arg_702_0 and not isNil(var_702_4) and arg_699_1.var_.characterEffect10066ui_story then
				local var_702_9 = 0.5

				arg_699_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_699_1.var_.characterEffect10066ui_story.fillRatio = var_702_9
			end

			local var_702_10 = arg_699_1.actors_["1050ui_story"].transform
			local var_702_11 = 0

			if var_702_11 < arg_699_1.time_ and arg_699_1.time_ <= var_702_11 + arg_702_0 then
				arg_699_1.var_.moveOldPos1050ui_story = var_702_10.localPosition
			end

			local var_702_12 = 0.001

			if var_702_11 <= arg_699_1.time_ and arg_699_1.time_ < var_702_11 + var_702_12 then
				local var_702_13 = (arg_699_1.time_ - var_702_11) / var_702_12
				local var_702_14 = Vector3.New(0.7, -1, -6.1)

				var_702_10.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos1050ui_story, var_702_14, var_702_13)

				local var_702_15 = manager.ui.mainCamera.transform.position - var_702_10.position

				var_702_10.forward = Vector3.New(var_702_15.x, var_702_15.y, var_702_15.z)

				local var_702_16 = var_702_10.localEulerAngles

				var_702_16.z = 0
				var_702_16.x = 0
				var_702_10.localEulerAngles = var_702_16
			end

			if arg_699_1.time_ >= var_702_11 + var_702_12 and arg_699_1.time_ < var_702_11 + var_702_12 + arg_702_0 then
				var_702_10.localPosition = Vector3.New(0.7, -1, -6.1)

				local var_702_17 = manager.ui.mainCamera.transform.position - var_702_10.position

				var_702_10.forward = Vector3.New(var_702_17.x, var_702_17.y, var_702_17.z)

				local var_702_18 = var_702_10.localEulerAngles

				var_702_18.z = 0
				var_702_18.x = 0
				var_702_10.localEulerAngles = var_702_18
			end

			local var_702_19 = 0

			if var_702_19 < arg_699_1.time_ and arg_699_1.time_ <= var_702_19 + arg_702_0 then
				arg_699_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_702_20 = 0
			local var_702_21 = 0.25

			if var_702_20 < arg_699_1.time_ and arg_699_1.time_ <= var_702_20 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_22 = arg_699_1:FormatText(StoryNameCfg[74].name)

				arg_699_1.leftNameTxt_.text = var_702_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_23 = arg_699_1:GetWordFromCfg(318041165)
				local var_702_24 = arg_699_1:FormatText(var_702_23.content)

				arg_699_1.text_.text = var_702_24

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_25 = 10
				local var_702_26 = utf8.len(var_702_24)
				local var_702_27 = var_702_25 <= 0 and var_702_21 or var_702_21 * (var_702_26 / var_702_25)

				if var_702_27 > 0 and var_702_21 < var_702_27 then
					arg_699_1.talkMaxDuration = var_702_27

					if var_702_27 + var_702_20 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_27 + var_702_20
					end
				end

				arg_699_1.text_.text = var_702_24
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041165", "story_v_out_318041.awb") ~= 0 then
					local var_702_28 = manager.audio:GetVoiceLength("story_v_out_318041", "318041165", "story_v_out_318041.awb") / 1000

					if var_702_28 + var_702_20 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_28 + var_702_20
					end

					if var_702_23.prefab_name ~= "" and arg_699_1.actors_[var_702_23.prefab_name] ~= nil then
						local var_702_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_23.prefab_name].transform, "story_v_out_318041", "318041165", "story_v_out_318041.awb")

						arg_699_1:RecordAudio("318041165", var_702_29)
						arg_699_1:RecordAudio("318041165", var_702_29)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_out_318041", "318041165", "story_v_out_318041.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_out_318041", "318041165", "story_v_out_318041.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_30 = math.max(var_702_21, arg_699_1.talkMaxDuration)

			if var_702_20 <= arg_699_1.time_ and arg_699_1.time_ < var_702_20 + var_702_30 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_20) / var_702_30

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_20 + var_702_30 and arg_699_1.time_ < var_702_20 + var_702_30 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play318041166 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 318041166
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play318041167(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["1050ui_story"]
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 and not isNil(var_706_0) and arg_703_1.var_.characterEffect1050ui_story == nil then
				arg_703_1.var_.characterEffect1050ui_story = var_706_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_2 = 0.200000002980232

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_2 and not isNil(var_706_0) then
				local var_706_3 = (arg_703_1.time_ - var_706_1) / var_706_2

				if arg_703_1.var_.characterEffect1050ui_story and not isNil(var_706_0) then
					local var_706_4 = Mathf.Lerp(0, 0.5, var_706_3)

					arg_703_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_703_1.var_.characterEffect1050ui_story.fillRatio = var_706_4
				end
			end

			if arg_703_1.time_ >= var_706_1 + var_706_2 and arg_703_1.time_ < var_706_1 + var_706_2 + arg_706_0 and not isNil(var_706_0) and arg_703_1.var_.characterEffect1050ui_story then
				local var_706_5 = 0.5

				arg_703_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_703_1.var_.characterEffect1050ui_story.fillRatio = var_706_5
			end

			local var_706_6 = arg_703_1.actors_["1050ui_story"].transform
			local var_706_7 = 0

			if var_706_7 < arg_703_1.time_ and arg_703_1.time_ <= var_706_7 + arg_706_0 then
				arg_703_1.var_.moveOldPos1050ui_story = var_706_6.localPosition
			end

			local var_706_8 = 0.001

			if var_706_7 <= arg_703_1.time_ and arg_703_1.time_ < var_706_7 + var_706_8 then
				local var_706_9 = (arg_703_1.time_ - var_706_7) / var_706_8
				local var_706_10 = Vector3.New(0, 100, 0)

				var_706_6.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos1050ui_story, var_706_10, var_706_9)

				local var_706_11 = manager.ui.mainCamera.transform.position - var_706_6.position

				var_706_6.forward = Vector3.New(var_706_11.x, var_706_11.y, var_706_11.z)

				local var_706_12 = var_706_6.localEulerAngles

				var_706_12.z = 0
				var_706_12.x = 0
				var_706_6.localEulerAngles = var_706_12
			end

			if arg_703_1.time_ >= var_706_7 + var_706_8 and arg_703_1.time_ < var_706_7 + var_706_8 + arg_706_0 then
				var_706_6.localPosition = Vector3.New(0, 100, 0)

				local var_706_13 = manager.ui.mainCamera.transform.position - var_706_6.position

				var_706_6.forward = Vector3.New(var_706_13.x, var_706_13.y, var_706_13.z)

				local var_706_14 = var_706_6.localEulerAngles

				var_706_14.z = 0
				var_706_14.x = 0
				var_706_6.localEulerAngles = var_706_14
			end

			local var_706_15 = arg_703_1.actors_["10066ui_story"].transform
			local var_706_16 = 0

			if var_706_16 < arg_703_1.time_ and arg_703_1.time_ <= var_706_16 + arg_706_0 then
				arg_703_1.var_.moveOldPos10066ui_story = var_706_15.localPosition
			end

			local var_706_17 = 0.001

			if var_706_16 <= arg_703_1.time_ and arg_703_1.time_ < var_706_16 + var_706_17 then
				local var_706_18 = (arg_703_1.time_ - var_706_16) / var_706_17
				local var_706_19 = Vector3.New(0, 100, 0)

				var_706_15.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos10066ui_story, var_706_19, var_706_18)

				local var_706_20 = manager.ui.mainCamera.transform.position - var_706_15.position

				var_706_15.forward = Vector3.New(var_706_20.x, var_706_20.y, var_706_20.z)

				local var_706_21 = var_706_15.localEulerAngles

				var_706_21.z = 0
				var_706_21.x = 0
				var_706_15.localEulerAngles = var_706_21
			end

			if arg_703_1.time_ >= var_706_16 + var_706_17 and arg_703_1.time_ < var_706_16 + var_706_17 + arg_706_0 then
				var_706_15.localPosition = Vector3.New(0, 100, 0)

				local var_706_22 = manager.ui.mainCamera.transform.position - var_706_15.position

				var_706_15.forward = Vector3.New(var_706_22.x, var_706_22.y, var_706_22.z)

				local var_706_23 = var_706_15.localEulerAngles

				var_706_23.z = 0
				var_706_23.x = 0
				var_706_15.localEulerAngles = var_706_23
			end

			local var_706_24 = 0
			local var_706_25 = 0.775

			if var_706_24 < arg_703_1.time_ and arg_703_1.time_ <= var_706_24 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_26 = arg_703_1:GetWordFromCfg(318041166)
				local var_706_27 = arg_703_1:FormatText(var_706_26.content)

				arg_703_1.text_.text = var_706_27

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_28 = 31
				local var_706_29 = utf8.len(var_706_27)
				local var_706_30 = var_706_28 <= 0 and var_706_25 or var_706_25 * (var_706_29 / var_706_28)

				if var_706_30 > 0 and var_706_25 < var_706_30 then
					arg_703_1.talkMaxDuration = var_706_30

					if var_706_30 + var_706_24 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_30 + var_706_24
					end
				end

				arg_703_1.text_.text = var_706_27
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_31 = math.max(var_706_25, arg_703_1.talkMaxDuration)

			if var_706_24 <= arg_703_1.time_ and arg_703_1.time_ < var_706_24 + var_706_31 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_24) / var_706_31

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_24 + var_706_31 and arg_703_1.time_ < var_706_24 + var_706_31 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_703_1:InitPlayNodeList()
	end,
	Play318041167 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 318041167
		arg_707_1.duration_ = 10.57

		local var_707_0 = {
			zh = 8.333,
			ja = 10.566
		}
		local var_707_1 = manager.audio:GetLocalizationFlag()

		if var_707_0[var_707_1] ~= nil then
			arg_707_1.duration_ = var_707_0[var_707_1]
		end

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play318041168(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = "LX0101"

			if arg_707_1.bgs_[var_710_0] == nil then
				local var_710_1 = Object.Instantiate(arg_707_1.paintGo_)

				var_710_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_710_0)
				var_710_1.name = var_710_0
				var_710_1.transform.parent = arg_707_1.stage_.transform
				var_710_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_707_1.bgs_[var_710_0] = var_710_1
			end

			local var_710_2 = 2

			if var_710_2 < arg_707_1.time_ and arg_707_1.time_ <= var_710_2 + arg_710_0 then
				local var_710_3 = manager.ui.mainCamera.transform.localPosition
				local var_710_4 = Vector3.New(0, 0, 10) + Vector3.New(var_710_3.x, var_710_3.y, 0)
				local var_710_5 = arg_707_1.bgs_.LX0101

				var_710_5.transform.localPosition = var_710_4
				var_710_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_710_6 = var_710_5:GetComponent("SpriteRenderer")

				if var_710_6 and var_710_6.sprite then
					local var_710_7 = (var_710_5.transform.localPosition - var_710_3).z
					local var_710_8 = manager.ui.mainCameraCom_
					local var_710_9 = 2 * var_710_7 * Mathf.Tan(var_710_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_710_10 = var_710_9 * var_710_8.aspect
					local var_710_11 = var_710_6.sprite.bounds.size.x
					local var_710_12 = var_710_6.sprite.bounds.size.y
					local var_710_13 = var_710_10 / var_710_11
					local var_710_14 = var_710_9 / var_710_12
					local var_710_15 = var_710_14 < var_710_13 and var_710_13 or var_710_14

					var_710_5.transform.localScale = Vector3.New(var_710_15, var_710_15, 0)
				end

				for iter_710_0, iter_710_1 in pairs(arg_707_1.bgs_) do
					if iter_710_0 ~= "LX0101" then
						iter_710_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_710_16 = 0

			if var_710_16 < arg_707_1.time_ and arg_707_1.time_ <= var_710_16 + arg_710_0 then
				arg_707_1.mask_.enabled = true
				arg_707_1.mask_.raycastTarget = true

				arg_707_1:SetGaussion(false)
			end

			local var_710_17 = 2

			if var_710_16 <= arg_707_1.time_ and arg_707_1.time_ < var_710_16 + var_710_17 then
				local var_710_18 = (arg_707_1.time_ - var_710_16) / var_710_17
				local var_710_19 = Color.New(0, 0, 0)

				var_710_19.a = Mathf.Lerp(0, 1, var_710_18)
				arg_707_1.mask_.color = var_710_19
			end

			if arg_707_1.time_ >= var_710_16 + var_710_17 and arg_707_1.time_ < var_710_16 + var_710_17 + arg_710_0 then
				local var_710_20 = Color.New(0, 0, 0)

				var_710_20.a = 1
				arg_707_1.mask_.color = var_710_20
			end

			local var_710_21 = 2

			if var_710_21 < arg_707_1.time_ and arg_707_1.time_ <= var_710_21 + arg_710_0 then
				arg_707_1.mask_.enabled = true
				arg_707_1.mask_.raycastTarget = true

				arg_707_1:SetGaussion(false)
			end

			local var_710_22 = 2

			if var_710_21 <= arg_707_1.time_ and arg_707_1.time_ < var_710_21 + var_710_22 then
				local var_710_23 = (arg_707_1.time_ - var_710_21) / var_710_22
				local var_710_24 = Color.New(0, 0, 0)

				var_710_24.a = Mathf.Lerp(1, 0, var_710_23)
				arg_707_1.mask_.color = var_710_24
			end

			if arg_707_1.time_ >= var_710_21 + var_710_22 and arg_707_1.time_ < var_710_21 + var_710_22 + arg_710_0 then
				local var_710_25 = Color.New(0, 0, 0)
				local var_710_26 = 0

				arg_707_1.mask_.enabled = false
				var_710_25.a = var_710_26
				arg_707_1.mask_.color = var_710_25
			end

			if arg_707_1.frameCnt_ <= 1 then
				arg_707_1.dialog_:SetActive(false)
			end

			local var_710_27 = 4
			local var_710_28 = 0.325

			if var_710_27 < arg_707_1.time_ and arg_707_1.time_ <= var_710_27 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0

				arg_707_1.dialog_:SetActive(true)

				arg_707_1.dialogCg_.alpha = 0

				local var_710_29 = LeanTween.value(arg_707_1.dialog_, 0, 1, 0.3)

				var_710_29:setOnUpdate(LuaHelper.FloatAction(function(arg_711_0)
					arg_707_1.dialogCg_.alpha = arg_711_0
				end))
				var_710_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_707_1.dialog_)
					var_710_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_707_1.duration_ = arg_707_1.duration_ + 0.3

				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_30 = arg_707_1:FormatText(StoryNameCfg[640].name)

				arg_707_1.leftNameTxt_.text = var_710_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, true)
				arg_707_1.iconController_:SetSelectedState("hero")

				arg_707_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_707_1.callingController_:SetSelectedState("normal")

				arg_707_1.keyicon_.color = Color.New(1, 1, 1)
				arg_707_1.icon_.color = Color.New(1, 1, 1)

				local var_710_31 = arg_707_1:GetWordFromCfg(318041167)
				local var_710_32 = arg_707_1:FormatText(var_710_31.content)

				arg_707_1.text_.text = var_710_32

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_33 = 13
				local var_710_34 = utf8.len(var_710_32)
				local var_710_35 = var_710_33 <= 0 and var_710_28 or var_710_28 * (var_710_34 / var_710_33)

				if var_710_35 > 0 and var_710_28 < var_710_35 then
					arg_707_1.talkMaxDuration = var_710_35
					var_710_27 = var_710_27 + 0.3

					if var_710_35 + var_710_27 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_35 + var_710_27
					end
				end

				arg_707_1.text_.text = var_710_32
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041167", "story_v_out_318041.awb") ~= 0 then
					local var_710_36 = manager.audio:GetVoiceLength("story_v_out_318041", "318041167", "story_v_out_318041.awb") / 1000

					if var_710_36 + var_710_27 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_36 + var_710_27
					end

					if var_710_31.prefab_name ~= "" and arg_707_1.actors_[var_710_31.prefab_name] ~= nil then
						local var_710_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_31.prefab_name].transform, "story_v_out_318041", "318041167", "story_v_out_318041.awb")

						arg_707_1:RecordAudio("318041167", var_710_37)
						arg_707_1:RecordAudio("318041167", var_710_37)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_out_318041", "318041167", "story_v_out_318041.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_out_318041", "318041167", "story_v_out_318041.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_38 = var_710_27 + 0.3
			local var_710_39 = math.max(var_710_28, arg_707_1.talkMaxDuration)

			if var_710_38 <= arg_707_1.time_ and arg_707_1.time_ < var_710_38 + var_710_39 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_38) / var_710_39

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_38 + var_710_39 and arg_707_1.time_ < var_710_38 + var_710_39 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play318041168 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 318041168
		arg_713_1.duration_ = 5.1

		local var_713_0 = {
			zh = 3.3,
			ja = 5.1
		}
		local var_713_1 = manager.audio:GetLocalizationFlag()

		if var_713_0[var_713_1] ~= nil then
			arg_713_1.duration_ = var_713_0[var_713_1]
		end

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
			arg_713_1.auto_ = false
		end

		function arg_713_1.playNext_(arg_715_0)
			arg_713_1.onStoryFinished_()
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0
			local var_716_1 = 0.275

			if var_716_0 < arg_713_1.time_ and arg_713_1.time_ <= var_716_0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				local var_716_2 = arg_713_1:FormatText(StoryNameCfg[74].name)

				arg_713_1.leftNameTxt_.text = var_716_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, true)
				arg_713_1.iconController_:SetSelectedState("hero")

				arg_713_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_713_1.callingController_:SetSelectedState("normal")

				arg_713_1.keyicon_.color = Color.New(1, 1, 1)
				arg_713_1.icon_.color = Color.New(1, 1, 1)

				local var_716_3 = arg_713_1:GetWordFromCfg(318041168)
				local var_716_4 = arg_713_1:FormatText(var_716_3.content)

				arg_713_1.text_.text = var_716_4

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_5 = 11
				local var_716_6 = utf8.len(var_716_4)
				local var_716_7 = var_716_5 <= 0 and var_716_1 or var_716_1 * (var_716_6 / var_716_5)

				if var_716_7 > 0 and var_716_1 < var_716_7 then
					arg_713_1.talkMaxDuration = var_716_7

					if var_716_7 + var_716_0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_7 + var_716_0
					end
				end

				arg_713_1.text_.text = var_716_4
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318041", "318041168", "story_v_out_318041.awb") ~= 0 then
					local var_716_8 = manager.audio:GetVoiceLength("story_v_out_318041", "318041168", "story_v_out_318041.awb") / 1000

					if var_716_8 + var_716_0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_8 + var_716_0
					end

					if var_716_3.prefab_name ~= "" and arg_713_1.actors_[var_716_3.prefab_name] ~= nil then
						local var_716_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_713_1.actors_[var_716_3.prefab_name].transform, "story_v_out_318041", "318041168", "story_v_out_318041.awb")

						arg_713_1:RecordAudio("318041168", var_716_9)
						arg_713_1:RecordAudio("318041168", var_716_9)
					else
						arg_713_1:AudioAction("play", "voice", "story_v_out_318041", "318041168", "story_v_out_318041.awb")
					end

					arg_713_1:RecordHistoryTalkVoice("story_v_out_318041", "318041168", "story_v_out_318041.awb")
				end

				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_10 = math.max(var_716_1, arg_713_1.talkMaxDuration)

			if var_716_0 <= arg_713_1.time_ and arg_713_1.time_ < var_716_0 + var_716_10 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - var_716_0) / var_716_10

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= var_716_0 + var_716_10 and arg_713_1.time_ < var_716_0 + var_716_10 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST69",
		"TextureConfig/Background/ST16",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/LX0102",
		"TextureConfig/Background/LX0102_blur",
		"TextureConfig/Background/K13f",
		"TextureConfig/Background/LX0101"
	},
	voices = {
		"story_v_out_318041.awb"
	}
}
