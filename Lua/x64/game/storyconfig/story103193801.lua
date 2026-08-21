return {
	Play319381001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319381001
		arg_1_1.duration_ = 7.03

		local var_1_0 = {
			zh = 5.666,
			ja = 7.033
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319381002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11l"

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
				local var_4_5 = arg_1_1.bgs_.I11l

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
					if iter_4_0 ~= "I11l" then
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
			local var_4_23 = 0.133333333333333

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

			local var_4_28 = 0.166666666666667
			local var_4_29 = 0.933333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

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
			local var_4_35 = 0.3

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[680].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2019")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(319381001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 12
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381001", "story_v_out_319381.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_319381", "319381001", "story_v_out_319381.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_319381", "319381001", "story_v_out_319381.awb")

						arg_1_1:RecordAudio("319381001", var_4_44)
						arg_1_1:RecordAudio("319381001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319381", "319381001", "story_v_out_319381.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319381", "319381001", "story_v_out_319381.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_34 + 0.3
			local var_4_46 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319381002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319381002
		arg_9_1.duration_ = 5.3

		local var_9_0 = {
			zh = 3.166,
			ja = 5.3
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319381003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1084ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["1084ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_5.localPosition

				local var_12_7 = "1084ui_story"

				arg_9_1:ShowWeapon(arg_9_1.var_[var_12_7 .. "Animator"].transform, false)
			end

			local var_12_8 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_6) / var_12_8
				local var_12_10 = Vector3.New(0, -0.97, -6)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, var_12_10, var_12_9)

				local var_12_11 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_11.x, var_12_11.y, var_12_11.z)

				local var_12_12 = var_12_5.localEulerAngles

				var_12_12.z = 0
				var_12_12.x = 0
				var_12_5.localEulerAngles = var_12_12
			end

			if arg_9_1.time_ >= var_12_6 + var_12_8 and arg_9_1.time_ < var_12_6 + var_12_8 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_12_13 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_13.x, var_12_13.y, var_12_13.z)

				local var_12_14 = var_12_5.localEulerAngles

				var_12_14.z = 0
				var_12_14.x = 0
				var_12_5.localEulerAngles = var_12_14
			end

			local var_12_15 = arg_9_1.actors_["1084ui_story"]
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_17 = 0.200000002980232

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 and not isNil(var_12_15) then
				local var_12_18 = (arg_9_1.time_ - var_12_16) / var_12_17

				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_15) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_21 = 0
			local var_12_22 = 0.35

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_23 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_24 = arg_9_1:GetWordFromCfg(319381002)
				local var_12_25 = arg_9_1:FormatText(var_12_24.content)

				arg_9_1.text_.text = var_12_25

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_26 = 14
				local var_12_27 = utf8.len(var_12_25)
				local var_12_28 = var_12_26 <= 0 and var_12_22 or var_12_22 * (var_12_27 / var_12_26)

				if var_12_28 > 0 and var_12_22 < var_12_28 then
					arg_9_1.talkMaxDuration = var_12_28

					if var_12_28 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_21
					end
				end

				arg_9_1.text_.text = var_12_25
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381002", "story_v_out_319381.awb") ~= 0 then
					local var_12_29 = manager.audio:GetVoiceLength("story_v_out_319381", "319381002", "story_v_out_319381.awb") / 1000

					if var_12_29 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_29 + var_12_21
					end

					if var_12_24.prefab_name ~= "" and arg_9_1.actors_[var_12_24.prefab_name] ~= nil then
						local var_12_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_24.prefab_name].transform, "story_v_out_319381", "319381002", "story_v_out_319381.awb")

						arg_9_1:RecordAudio("319381002", var_12_30)
						arg_9_1:RecordAudio("319381002", var_12_30)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319381", "319381002", "story_v_out_319381.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319381", "319381002", "story_v_out_319381.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_31 = math.max(var_12_22, arg_9_1.talkMaxDuration)

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_31 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_21) / var_12_31

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_21 + var_12_31 and arg_9_1.time_ < var_12_21 + var_12_31 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play319381003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319381003
		arg_13_1.duration_ = 5.03

		local var_13_0 = {
			zh = 3.666,
			ja = 5.033
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
				arg_13_0:Play319381004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1084ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1084ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1084ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1084ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1084ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.3

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[680].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2019")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_9 = arg_13_1:GetWordFromCfg(319381003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 12
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_7 or var_16_7 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_7 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381003", "story_v_out_319381.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_319381", "319381003", "story_v_out_319381.awb") / 1000

					if var_16_14 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_6
					end

					if var_16_9.prefab_name ~= "" and arg_13_1.actors_[var_16_9.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_9.prefab_name].transform, "story_v_out_319381", "319381003", "story_v_out_319381.awb")

						arg_13_1:RecordAudio("319381003", var_16_15)
						arg_13_1:RecordAudio("319381003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319381", "319381003", "story_v_out_319381.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319381", "319381003", "story_v_out_319381.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_16 and arg_13_1.time_ < var_16_6 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319381004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319381004
		arg_17_1.duration_ = 3.17

		local var_17_0 = {
			zh = 2.766,
			ja = 3.166
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
				arg_17_0:Play319381005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1084ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_20_4 = 0
			local var_20_5 = 0.375

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_6 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(319381004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 15
				local var_20_10 = utf8.len(var_20_8)
				local var_20_11 = var_20_9 <= 0 and var_20_5 or var_20_5 * (var_20_10 / var_20_9)

				if var_20_11 > 0 and var_20_5 < var_20_11 then
					arg_17_1.talkMaxDuration = var_20_11

					if var_20_11 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381004", "story_v_out_319381.awb") ~= 0 then
					local var_20_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381004", "story_v_out_319381.awb") / 1000

					if var_20_12 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_4
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_319381", "319381004", "story_v_out_319381.awb")

						arg_17_1:RecordAudio("319381004", var_20_13)
						arg_17_1:RecordAudio("319381004", var_20_13)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319381", "319381004", "story_v_out_319381.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319381", "319381004", "story_v_out_319381.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_14 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_14 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_14

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_14 and arg_17_1.time_ < var_20_4 + var_20_14 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319381005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319381005
		arg_21_1.duration_ = 5.03

		local var_21_0 = {
			zh = 3.666,
			ja = 5.033
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
				arg_21_0:Play319381006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1084ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1084ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1084ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.3

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[680].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2019")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_9 = arg_21_1:GetWordFromCfg(319381005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381005", "story_v_out_319381.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_319381", "319381005", "story_v_out_319381.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_out_319381", "319381005", "story_v_out_319381.awb")

						arg_21_1:RecordAudio("319381005", var_24_15)
						arg_21_1:RecordAudio("319381005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319381", "319381005", "story_v_out_319381.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319381", "319381005", "story_v_out_319381.awb")
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
	Play319381006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319381006
		arg_25_1.duration_ = 4

		local var_25_0 = {
			zh = 2.933,
			ja = 4
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
				arg_25_0:Play319381007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1084ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1084ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, -0.97, -6)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1084ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1084ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_28_14 = 0
			local var_28_15 = 0.225

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_16 = arg_25_1:FormatText(StoryNameCfg[6].name)

				arg_25_1.leftNameTxt_.text = var_28_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_17 = arg_25_1:GetWordFromCfg(319381006)
				local var_28_18 = arg_25_1:FormatText(var_28_17.content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 9
				local var_28_20 = utf8.len(var_28_18)
				local var_28_21 = var_28_19 <= 0 and var_28_15 or var_28_15 * (var_28_20 / var_28_19)

				if var_28_21 > 0 and var_28_15 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_14 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_14
					end
				end

				arg_25_1.text_.text = var_28_18
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381006", "story_v_out_319381.awb") ~= 0 then
					local var_28_22 = manager.audio:GetVoiceLength("story_v_out_319381", "319381006", "story_v_out_319381.awb") / 1000

					if var_28_22 + var_28_14 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_14
					end

					if var_28_17.prefab_name ~= "" and arg_25_1.actors_[var_28_17.prefab_name] ~= nil then
						local var_28_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_17.prefab_name].transform, "story_v_out_319381", "319381006", "story_v_out_319381.awb")

						arg_25_1:RecordAudio("319381006", var_28_23)
						arg_25_1:RecordAudio("319381006", var_28_23)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319381", "319381006", "story_v_out_319381.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319381", "319381006", "story_v_out_319381.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_24 = math.max(var_28_15, arg_25_1.talkMaxDuration)

			if var_28_14 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_24 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_14) / var_28_24

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_14 + var_28_24 and arg_25_1.time_ < var_28_14 + var_28_24 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319381007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319381007
		arg_29_1.duration_ = 5.03

		local var_29_0 = {
			zh = 3.666,
			ja = 5.033
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
				arg_29_0:Play319381008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1084ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1084ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1084ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1084ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1084ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.3

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[680].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2019")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_9 = arg_29_1:GetWordFromCfg(319381007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381007", "story_v_out_319381.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_319381", "319381007", "story_v_out_319381.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_319381", "319381007", "story_v_out_319381.awb")

						arg_29_1:RecordAudio("319381007", var_32_15)
						arg_29_1:RecordAudio("319381007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319381", "319381007", "story_v_out_319381.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319381", "319381007", "story_v_out_319381.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_16 and arg_29_1.time_ < var_32_6 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319381008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319381008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319381009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.05

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(319381008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 2
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319381009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319381009
		arg_37_1.duration_ = 8.3

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play319381010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				local var_40_1 = manager.ui.mainCamera.transform.localPosition
				local var_40_2 = Vector3.New(0, 0, 10) + Vector3.New(var_40_1.x, var_40_1.y, 0)
				local var_40_3 = arg_37_1.bgs_.I11l

				var_40_3.transform.localPosition = var_40_2
				var_40_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_4 = var_40_3:GetComponent("SpriteRenderer")

				if var_40_4 and var_40_4.sprite then
					local var_40_5 = (var_40_3.transform.localPosition - var_40_1).z
					local var_40_6 = manager.ui.mainCameraCom_
					local var_40_7 = 2 * var_40_5 * Mathf.Tan(var_40_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_40_8 = var_40_7 * var_40_6.aspect
					local var_40_9 = var_40_4.sprite.bounds.size.x
					local var_40_10 = var_40_4.sprite.bounds.size.y
					local var_40_11 = var_40_8 / var_40_9
					local var_40_12 = var_40_7 / var_40_10
					local var_40_13 = var_40_12 < var_40_11 and var_40_11 or var_40_12

					var_40_3.transform.localScale = Vector3.New(var_40_13, var_40_13, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "I11l" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_14 = 2

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				local var_40_15 = manager.ui.mainCamera.transform.localPosition
				local var_40_16 = Vector3.New(0, 0, 10) + Vector3.New(var_40_15.x, var_40_15.y, 0)
				local var_40_17 = arg_37_1.bgs_.I11l

				var_40_17.transform.localPosition = var_40_16
				var_40_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_18 = var_40_17:GetComponent("SpriteRenderer")

				if var_40_18 and var_40_18.sprite then
					local var_40_19 = (var_40_17.transform.localPosition - var_40_15).z
					local var_40_20 = manager.ui.mainCameraCom_
					local var_40_21 = 2 * var_40_19 * Mathf.Tan(var_40_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_40_22 = var_40_21 * var_40_20.aspect
					local var_40_23 = var_40_18.sprite.bounds.size.x
					local var_40_24 = var_40_18.sprite.bounds.size.y
					local var_40_25 = var_40_22 / var_40_23
					local var_40_26 = var_40_21 / var_40_24
					local var_40_27 = var_40_26 < var_40_25 and var_40_25 or var_40_26

					var_40_17.transform.localScale = Vector3.New(var_40_27, var_40_27, 0)
				end

				for iter_40_2, iter_40_3 in pairs(arg_37_1.bgs_) do
					if iter_40_2 ~= "I11l" then
						iter_40_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_28 = 0

			if var_40_28 < arg_37_1.time_ and arg_37_1.time_ <= var_40_28 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_29 = 2

			if var_40_28 <= arg_37_1.time_ and arg_37_1.time_ < var_40_28 + var_40_29 then
				local var_40_30 = (arg_37_1.time_ - var_40_28) / var_40_29
				local var_40_31 = Color.New(0, 0, 0)

				var_40_31.a = Mathf.Lerp(0, 1, var_40_30)
				arg_37_1.mask_.color = var_40_31
			end

			if arg_37_1.time_ >= var_40_28 + var_40_29 and arg_37_1.time_ < var_40_28 + var_40_29 + arg_40_0 then
				local var_40_32 = Color.New(0, 0, 0)

				var_40_32.a = 1
				arg_37_1.mask_.color = var_40_32
			end

			local var_40_33 = 2

			if var_40_33 < arg_37_1.time_ and arg_37_1.time_ <= var_40_33 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_34 = 1.3

			if var_40_33 <= arg_37_1.time_ and arg_37_1.time_ < var_40_33 + var_40_34 then
				local var_40_35 = (arg_37_1.time_ - var_40_33) / var_40_34
				local var_40_36 = Color.New(0, 0, 0)

				var_40_36.a = Mathf.Lerp(1, 0, var_40_35)
				arg_37_1.mask_.color = var_40_36
			end

			if arg_37_1.time_ >= var_40_33 + var_40_34 and arg_37_1.time_ < var_40_33 + var_40_34 + arg_40_0 then
				local var_40_37 = Color.New(0, 0, 0)
				local var_40_38 = 0

				arg_37_1.mask_.enabled = false
				var_40_37.a = var_40_38
				arg_37_1.mask_.color = var_40_37
			end

			local var_40_39 = arg_37_1.actors_["1084ui_story"].transform
			local var_40_40 = 2

			if var_40_40 < arg_37_1.time_ and arg_37_1.time_ <= var_40_40 + arg_40_0 then
				arg_37_1.var_.moveOldPos1084ui_story = var_40_39.localPosition

				local var_40_41 = "1084ui_story"

				arg_37_1:ShowWeapon(arg_37_1.var_[var_40_41 .. "Animator"].transform, false)
			end

			local var_40_42 = 0.001

			if var_40_40 <= arg_37_1.time_ and arg_37_1.time_ < var_40_40 + var_40_42 then
				local var_40_43 = (arg_37_1.time_ - var_40_40) / var_40_42
				local var_40_44 = Vector3.New(0, 100, 0)

				var_40_39.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1084ui_story, var_40_44, var_40_43)

				local var_40_45 = manager.ui.mainCamera.transform.position - var_40_39.position

				var_40_39.forward = Vector3.New(var_40_45.x, var_40_45.y, var_40_45.z)

				local var_40_46 = var_40_39.localEulerAngles

				var_40_46.z = 0
				var_40_46.x = 0
				var_40_39.localEulerAngles = var_40_46
			end

			if arg_37_1.time_ >= var_40_40 + var_40_42 and arg_37_1.time_ < var_40_40 + var_40_42 + arg_40_0 then
				var_40_39.localPosition = Vector3.New(0, 100, 0)

				local var_40_47 = manager.ui.mainCamera.transform.position - var_40_39.position

				var_40_39.forward = Vector3.New(var_40_47.x, var_40_47.y, var_40_47.z)

				local var_40_48 = var_40_39.localEulerAngles

				var_40_48.z = 0
				var_40_48.x = 0
				var_40_39.localEulerAngles = var_40_48
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_49 = 3.3
			local var_40_50 = 0.275

			if var_40_49 < arg_37_1.time_ and arg_37_1.time_ <= var_40_49 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_51 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_51:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_52 = arg_37_1:GetWordFromCfg(319381009)
				local var_40_53 = arg_37_1:FormatText(var_40_52.content)

				arg_37_1.text_.text = var_40_53

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_54 = 11
				local var_40_55 = utf8.len(var_40_53)
				local var_40_56 = var_40_54 <= 0 and var_40_50 or var_40_50 * (var_40_55 / var_40_54)

				if var_40_56 > 0 and var_40_50 < var_40_56 then
					arg_37_1.talkMaxDuration = var_40_56
					var_40_49 = var_40_49 + 0.3

					if var_40_56 + var_40_49 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_56 + var_40_49
					end
				end

				arg_37_1.text_.text = var_40_53
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_57 = var_40_49 + 0.3
			local var_40_58 = math.max(var_40_50, arg_37_1.talkMaxDuration)

			if var_40_57 <= arg_37_1.time_ and arg_37_1.time_ < var_40_57 + var_40_58 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_57) / var_40_58

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_57 + var_40_58 and arg_37_1.time_ < var_40_57 + var_40_58 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play319381010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319381010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play319381011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.375

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(319381010)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 15
				local var_46_5 = utf8.len(var_46_3)
				local var_46_6 = var_46_4 <= 0 and var_46_1 or var_46_1 * (var_46_5 / var_46_4)

				if var_46_6 > 0 and var_46_1 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_7 and arg_43_1.time_ < var_46_0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play319381011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319381011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319381012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 1.35

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(319381011)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 54
				local var_50_5 = utf8.len(var_50_3)
				local var_50_6 = var_50_4 <= 0 and var_50_1 or var_50_1 * (var_50_5 / var_50_4)

				if var_50_6 > 0 and var_50_1 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_7 and arg_47_1.time_ < var_50_0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play319381012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319381012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319381013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 1.45

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(319381012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 58
				local var_54_5 = utf8.len(var_54_3)
				local var_54_6 = var_54_4 <= 0 and var_54_1 or var_54_1 * (var_54_5 / var_54_4)

				if var_54_6 > 0 and var_54_1 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_7 and arg_51_1.time_ < var_54_0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play319381013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319381013
		arg_55_1.duration_ = 7.27

		local var_55_0 = {
			zh = 3.3,
			ja = 7.266
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
				arg_55_0:Play319381014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = manager.ui.mainCamera.transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.shakeOldPos = var_58_0.localPosition
			end

			local var_58_2 = 0.6

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / 0.066
				local var_58_4, var_58_5 = math.modf(var_58_3)

				var_58_0.localPosition = Vector3.New(var_58_5 * 0.13, var_58_5 * 0.13, var_58_5 * 0.13) + arg_55_1.var_.shakeOldPos
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = arg_55_1.var_.shakeOldPos
			end

			local var_58_6 = 0

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			local var_58_7 = 0.6

			if arg_55_1.time_ >= var_58_6 + var_58_7 and arg_55_1.time_ < var_58_6 + var_58_7 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end

			local var_58_8 = 0
			local var_58_9 = 0.375

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_10 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_10:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_11 = arg_55_1:FormatText(StoryNameCfg[36].name)

				arg_55_1.leftNameTxt_.text = var_58_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_12 = arg_55_1:GetWordFromCfg(319381013)
				local var_58_13 = arg_55_1:FormatText(var_58_12.content)

				arg_55_1.text_.text = var_58_13

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_14 = 15
				local var_58_15 = utf8.len(var_58_13)
				local var_58_16 = var_58_14 <= 0 and var_58_9 or var_58_9 * (var_58_15 / var_58_14)

				if var_58_16 > 0 and var_58_9 < var_58_16 then
					arg_55_1.talkMaxDuration = var_58_16
					var_58_8 = var_58_8 + 0.3

					if var_58_16 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_16 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_13
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381013", "story_v_out_319381.awb") ~= 0 then
					local var_58_17 = manager.audio:GetVoiceLength("story_v_out_319381", "319381013", "story_v_out_319381.awb") / 1000

					if var_58_17 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_17 + var_58_8
					end

					if var_58_12.prefab_name ~= "" and arg_55_1.actors_[var_58_12.prefab_name] ~= nil then
						local var_58_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_12.prefab_name].transform, "story_v_out_319381", "319381013", "story_v_out_319381.awb")

						arg_55_1:RecordAudio("319381013", var_58_18)
						arg_55_1:RecordAudio("319381013", var_58_18)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319381", "319381013", "story_v_out_319381.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319381", "319381013", "story_v_out_319381.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_19 = var_58_8 + 0.3
			local var_58_20 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_19 <= arg_55_1.time_ and arg_55_1.time_ < var_58_19 + var_58_20 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_19) / var_58_20

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_19 + var_58_20 and arg_55_1.time_ < var_58_19 + var_58_20 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play319381014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319381014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play319381015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.475

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(319381014)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 59
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play319381015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319381015
		arg_65_1.duration_ = 8.83

		local var_65_0 = {
			zh = 2.633,
			ja = 8.833
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
				arg_65_0:Play319381016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.25

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[36].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(319381015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381015", "story_v_out_319381.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_319381", "319381015", "story_v_out_319381.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_319381", "319381015", "story_v_out_319381.awb")

						arg_65_1:RecordAudio("319381015", var_68_9)
						arg_65_1:RecordAudio("319381015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319381", "319381015", "story_v_out_319381.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319381", "319381015", "story_v_out_319381.awb")
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
	Play319381016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319381016
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play319381017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1084ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1084ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_72_6 = arg_69_1.actors_["1084ui_story"].transform
			local var_72_7 = 0

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.var_.moveOldPos1084ui_story = var_72_6.localPosition

				local var_72_8 = "1084ui_story"

				arg_69_1:ShowWeapon(arg_69_1.var_[var_72_8 .. "Animator"].transform, false)
			end

			local var_72_9 = 0.001

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_9 then
				local var_72_10 = (arg_69_1.time_ - var_72_7) / var_72_9
				local var_72_11 = Vector3.New(0, -0.97, -6)

				var_72_6.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1084ui_story, var_72_11, var_72_10)

				local var_72_12 = manager.ui.mainCamera.transform.position - var_72_6.position

				var_72_6.forward = Vector3.New(var_72_12.x, var_72_12.y, var_72_12.z)

				local var_72_13 = var_72_6.localEulerAngles

				var_72_13.z = 0
				var_72_13.x = 0
				var_72_6.localEulerAngles = var_72_13
			end

			if arg_69_1.time_ >= var_72_7 + var_72_9 and arg_69_1.time_ < var_72_7 + var_72_9 + arg_72_0 then
				var_72_6.localPosition = Vector3.New(0, -0.97, -6)

				local var_72_14 = manager.ui.mainCamera.transform.position - var_72_6.position

				var_72_6.forward = Vector3.New(var_72_14.x, var_72_14.y, var_72_14.z)

				local var_72_15 = var_72_6.localEulerAngles

				var_72_15.z = 0
				var_72_15.x = 0
				var_72_6.localEulerAngles = var_72_15
			end

			local var_72_16 = 0
			local var_72_17 = 0.15

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_18 = arg_69_1:FormatText(StoryNameCfg[6].name)

				arg_69_1.leftNameTxt_.text = var_72_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_19 = arg_69_1:GetWordFromCfg(319381016)
				local var_72_20 = arg_69_1:FormatText(var_72_19.content)

				arg_69_1.text_.text = var_72_20

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_21 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381016", "story_v_out_319381.awb") ~= 0 then
					local var_72_24 = manager.audio:GetVoiceLength("story_v_out_319381", "319381016", "story_v_out_319381.awb") / 1000

					if var_72_24 + var_72_16 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_24 + var_72_16
					end

					if var_72_19.prefab_name ~= "" and arg_69_1.actors_[var_72_19.prefab_name] ~= nil then
						local var_72_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_19.prefab_name].transform, "story_v_out_319381", "319381016", "story_v_out_319381.awb")

						arg_69_1:RecordAudio("319381016", var_72_25)
						arg_69_1:RecordAudio("319381016", var_72_25)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319381", "319381016", "story_v_out_319381.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319381", "319381016", "story_v_out_319381.awb")
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
				actorName = "1084ui_story",
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
	Play319381017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319381017
		arg_73_1.duration_ = 9.27

		local var_73_0 = {
			zh = 2.5,
			ja = 9.266
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
				arg_73_0:Play319381018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = "10066ui_story"

			if arg_73_1.actors_[var_76_0] == nil then
				local var_76_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_76_1) then
					local var_76_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_73_1.stage_.transform)

					var_76_2.name = var_76_0
					var_76_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_73_1.actors_[var_76_0] = var_76_2

					local var_76_3 = var_76_2:GetComponentInChildren(typeof(CharacterEffect))

					var_76_3.enabled = true

					local var_76_4 = GameObjectTools.GetOrAddComponent(var_76_2, typeof(DynamicBoneHelper))

					if var_76_4 then
						var_76_4:EnableDynamicBone(false)
					end

					arg_73_1:ShowWeapon(var_76_3.transform, false)

					arg_73_1.var_[var_76_0 .. "Animator"] = var_76_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_73_1.var_[var_76_0 .. "Animator"].applyRootMotion = true
					arg_73_1.var_[var_76_0 .. "LipSync"] = var_76_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_76_5 = arg_73_1.actors_["10066ui_story"].transform
			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.var_.moveOldPos10066ui_story = var_76_5.localPosition
			end

			local var_76_7 = 0.001

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_7 then
				local var_76_8 = (arg_73_1.time_ - var_76_6) / var_76_7
				local var_76_9 = Vector3.New(0.7, -0.99, -5.83)

				var_76_5.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10066ui_story, var_76_9, var_76_8)

				local var_76_10 = manager.ui.mainCamera.transform.position - var_76_5.position

				var_76_5.forward = Vector3.New(var_76_10.x, var_76_10.y, var_76_10.z)

				local var_76_11 = var_76_5.localEulerAngles

				var_76_11.z = 0
				var_76_11.x = 0
				var_76_5.localEulerAngles = var_76_11
			end

			if arg_73_1.time_ >= var_76_6 + var_76_7 and arg_73_1.time_ < var_76_6 + var_76_7 + arg_76_0 then
				var_76_5.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_76_12 = manager.ui.mainCamera.transform.position - var_76_5.position

				var_76_5.forward = Vector3.New(var_76_12.x, var_76_12.y, var_76_12.z)

				local var_76_13 = var_76_5.localEulerAngles

				var_76_13.z = 0
				var_76_13.x = 0
				var_76_5.localEulerAngles = var_76_13
			end

			local var_76_14 = arg_73_1.actors_["10066ui_story"]
			local var_76_15 = 0

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 and not isNil(var_76_14) and arg_73_1.var_.characterEffect10066ui_story == nil then
				arg_73_1.var_.characterEffect10066ui_story = var_76_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_16 = 0.200000002980232

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_16 and not isNil(var_76_14) then
				local var_76_17 = (arg_73_1.time_ - var_76_15) / var_76_16

				if arg_73_1.var_.characterEffect10066ui_story and not isNil(var_76_14) then
					arg_73_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_15 + var_76_16 and arg_73_1.time_ < var_76_15 + var_76_16 + arg_76_0 and not isNil(var_76_14) and arg_73_1.var_.characterEffect10066ui_story then
				arg_73_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_76_18 = 0

			if var_76_18 < arg_73_1.time_ and arg_73_1.time_ <= var_76_18 + arg_76_0 then
				arg_73_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			local var_76_19 = 0

			if var_76_19 < arg_73_1.time_ and arg_73_1.time_ <= var_76_19 + arg_76_0 then
				arg_73_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_20 = arg_73_1.actors_["1084ui_story"].transform
			local var_76_21 = 0

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.var_.moveOldPos1084ui_story = var_76_20.localPosition
			end

			local var_76_22 = 0.001

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_22 then
				local var_76_23 = (arg_73_1.time_ - var_76_21) / var_76_22
				local var_76_24 = Vector3.New(-0.7, -0.97, -6)

				var_76_20.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1084ui_story, var_76_24, var_76_23)

				local var_76_25 = manager.ui.mainCamera.transform.position - var_76_20.position

				var_76_20.forward = Vector3.New(var_76_25.x, var_76_25.y, var_76_25.z)

				local var_76_26 = var_76_20.localEulerAngles

				var_76_26.z = 0
				var_76_26.x = 0
				var_76_20.localEulerAngles = var_76_26
			end

			if arg_73_1.time_ >= var_76_21 + var_76_22 and arg_73_1.time_ < var_76_21 + var_76_22 + arg_76_0 then
				var_76_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_76_27 = manager.ui.mainCamera.transform.position - var_76_20.position

				var_76_20.forward = Vector3.New(var_76_27.x, var_76_27.y, var_76_27.z)

				local var_76_28 = var_76_20.localEulerAngles

				var_76_28.z = 0
				var_76_28.x = 0
				var_76_20.localEulerAngles = var_76_28
			end

			local var_76_29 = arg_73_1.actors_["1084ui_story"]
			local var_76_30 = 0

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 and not isNil(var_76_29) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_31 = 0.200000002980232

			if var_76_30 <= arg_73_1.time_ and arg_73_1.time_ < var_76_30 + var_76_31 and not isNil(var_76_29) then
				local var_76_32 = (arg_73_1.time_ - var_76_30) / var_76_31

				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_29) then
					local var_76_33 = Mathf.Lerp(0, 0.5, var_76_32)

					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_33
				end
			end

			if arg_73_1.time_ >= var_76_30 + var_76_31 and arg_73_1.time_ < var_76_30 + var_76_31 + arg_76_0 and not isNil(var_76_29) and arg_73_1.var_.characterEffect1084ui_story then
				local var_76_34 = 0.5

				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_34
			end

			local var_76_35 = 0
			local var_76_36 = 0.25

			if var_76_35 < arg_73_1.time_ and arg_73_1.time_ <= var_76_35 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_37 = arg_73_1:FormatText(StoryNameCfg[640].name)

				arg_73_1.leftNameTxt_.text = var_76_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_38 = arg_73_1:GetWordFromCfg(319381017)
				local var_76_39 = arg_73_1:FormatText(var_76_38.content)

				arg_73_1.text_.text = var_76_39

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_40 = 10
				local var_76_41 = utf8.len(var_76_39)
				local var_76_42 = var_76_40 <= 0 and var_76_36 or var_76_36 * (var_76_41 / var_76_40)

				if var_76_42 > 0 and var_76_36 < var_76_42 then
					arg_73_1.talkMaxDuration = var_76_42

					if var_76_42 + var_76_35 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_42 + var_76_35
					end
				end

				arg_73_1.text_.text = var_76_39
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381017", "story_v_out_319381.awb") ~= 0 then
					local var_76_43 = manager.audio:GetVoiceLength("story_v_out_319381", "319381017", "story_v_out_319381.awb") / 1000

					if var_76_43 + var_76_35 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_43 + var_76_35
					end

					if var_76_38.prefab_name ~= "" and arg_73_1.actors_[var_76_38.prefab_name] ~= nil then
						local var_76_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_38.prefab_name].transform, "story_v_out_319381", "319381017", "story_v_out_319381.awb")

						arg_73_1:RecordAudio("319381017", var_76_44)
						arg_73_1:RecordAudio("319381017", var_76_44)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319381", "319381017", "story_v_out_319381.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319381", "319381017", "story_v_out_319381.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_45 = math.max(var_76_36, arg_73_1.talkMaxDuration)

			if var_76_35 <= arg_73_1.time_ and arg_73_1.time_ < var_76_35 + var_76_45 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_35) / var_76_45

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_35 + var_76_45 and arg_73_1.time_ < var_76_35 + var_76_45 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
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
	Play319381018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319381018
		arg_77_1.duration_ = 5.77

		local var_77_0 = {
			zh = 3.666,
			ja = 5.766
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
				arg_77_0:Play319381019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10066ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10066ui_story == nil then
				arg_77_1.var_.characterEffect10066ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect10066ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10066ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10066ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10066ui_story.fillRatio = var_80_5
			end

			local var_80_6 = arg_77_1.actors_["1084ui_story"]
			local var_80_7 = 0

			if var_80_7 < arg_77_1.time_ and arg_77_1.time_ <= var_80_7 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect1084ui_story == nil then
				arg_77_1.var_.characterEffect1084ui_story = var_80_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_8 = 0.200000002980232

			if var_80_7 <= arg_77_1.time_ and arg_77_1.time_ < var_80_7 + var_80_8 and not isNil(var_80_6) then
				local var_80_9 = (arg_77_1.time_ - var_80_7) / var_80_8

				if arg_77_1.var_.characterEffect1084ui_story and not isNil(var_80_6) then
					arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_7 + var_80_8 and arg_77_1.time_ < var_80_7 + var_80_8 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect1084ui_story then
				arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_80_10 = 0
			local var_80_11 = 0.5

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_12 = arg_77_1:FormatText(StoryNameCfg[6].name)

				arg_77_1.leftNameTxt_.text = var_80_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:GetWordFromCfg(319381018)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 20
				local var_80_16 = utf8.len(var_80_14)
				local var_80_17 = var_80_15 <= 0 and var_80_11 or var_80_11 * (var_80_16 / var_80_15)

				if var_80_17 > 0 and var_80_11 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381018", "story_v_out_319381.awb") ~= 0 then
					local var_80_18 = manager.audio:GetVoiceLength("story_v_out_319381", "319381018", "story_v_out_319381.awb") / 1000

					if var_80_18 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_10
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_319381", "319381018", "story_v_out_319381.awb")

						arg_77_1:RecordAudio("319381018", var_80_19)
						arg_77_1:RecordAudio("319381018", var_80_19)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319381", "319381018", "story_v_out_319381.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319381", "319381018", "story_v_out_319381.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_20 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_20 and arg_77_1.time_ < var_80_10 + var_80_20 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319381019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319381019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play319381020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1084ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1084ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1084ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 1

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

				local var_84_8 = arg_81_1:GetWordFromCfg(319381019)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 40
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
	Play319381020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319381020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play319381021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 1.525

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(319381020)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 61
				local var_88_5 = utf8.len(var_88_3)
				local var_88_6 = var_88_4 <= 0 and var_88_1 or var_88_1 * (var_88_5 / var_88_4)

				if var_88_6 > 0 and var_88_1 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_7 and arg_85_1.time_ < var_88_0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play319381021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319381021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319381022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.85

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(319381021)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 34
				local var_92_5 = utf8.len(var_92_3)
				local var_92_6 = var_92_4 <= 0 and var_92_1 or var_92_1 * (var_92_5 / var_92_4)

				if var_92_6 > 0 and var_92_1 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_7 and arg_89_1.time_ < var_92_0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319381022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319381022
		arg_93_1.duration_ = 8.2

		local var_93_0 = {
			zh = 8.2,
			ja = 6.533
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
				arg_93_0:Play319381023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10066ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10066ui_story == nil then
				arg_93_1.var_.characterEffect10066ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10066ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10066ui_story then
				arg_93_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action445")
			end

			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_96_6 = 0
			local var_96_7 = 0.65

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[640].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_9 = arg_93_1:GetWordFromCfg(319381022)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 26
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381022", "story_v_out_319381.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_319381", "319381022", "story_v_out_319381.awb") / 1000

					if var_96_14 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_6
					end

					if var_96_9.prefab_name ~= "" and arg_93_1.actors_[var_96_9.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_9.prefab_name].transform, "story_v_out_319381", "319381022", "story_v_out_319381.awb")

						arg_93_1:RecordAudio("319381022", var_96_15)
						arg_93_1:RecordAudio("319381022", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319381", "319381022", "story_v_out_319381.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319381", "319381022", "story_v_out_319381.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_16 and arg_93_1.time_ < var_96_6 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319381023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319381023
		arg_97_1.duration_ = 10.57

		local var_97_0 = {
			zh = 6.3,
			ja = 10.566
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
				arg_97_0:Play319381024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1084ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1084ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(-0.7, -0.97, -6)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1084ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["1084ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect1084ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1084ui_story then
				arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4136")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_100_15 = arg_97_1.actors_["10066ui_story"]
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.characterEffect10066ui_story == nil then
				arg_97_1.var_.characterEffect10066ui_story = var_100_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_17 = 0.200000002980232

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 and not isNil(var_100_15) then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17

				if arg_97_1.var_.characterEffect10066ui_story and not isNil(var_100_15) then
					local var_100_19 = Mathf.Lerp(0, 0.5, var_100_18)

					arg_97_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10066ui_story.fillRatio = var_100_19
				end
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.characterEffect10066ui_story then
				local var_100_20 = 0.5

				arg_97_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10066ui_story.fillRatio = var_100_20
			end

			local var_100_21 = 0
			local var_100_22 = 0.7

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

				local var_100_24 = arg_97_1:GetWordFromCfg(319381023)
				local var_100_25 = arg_97_1:FormatText(var_100_24.content)

				arg_97_1.text_.text = var_100_25

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_26 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381023", "story_v_out_319381.awb") ~= 0 then
					local var_100_29 = manager.audio:GetVoiceLength("story_v_out_319381", "319381023", "story_v_out_319381.awb") / 1000

					if var_100_29 + var_100_21 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_29 + var_100_21
					end

					if var_100_24.prefab_name ~= "" and arg_97_1.actors_[var_100_24.prefab_name] ~= nil then
						local var_100_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_24.prefab_name].transform, "story_v_out_319381", "319381023", "story_v_out_319381.awb")

						arg_97_1:RecordAudio("319381023", var_100_30)
						arg_97_1:RecordAudio("319381023", var_100_30)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319381", "319381023", "story_v_out_319381.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319381", "319381023", "story_v_out_319381.awb")
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
				actorName = "1084ui_story",
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
	Play319381024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319381024
		arg_101_1.duration_ = 9.5

		local var_101_0 = {
			zh = 6.2,
			ja = 9.5
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
				arg_101_0:Play319381025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1084ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1084ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_5
			end

			local var_104_6 = arg_101_1.actors_["10066ui_story"]
			local var_104_7 = 0

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect10066ui_story == nil then
				arg_101_1.var_.characterEffect10066ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_8 = 0.200000002980232

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_8 and not isNil(var_104_6) then
				local var_104_9 = (arg_101_1.time_ - var_104_7) / var_104_8

				if arg_101_1.var_.characterEffect10066ui_story and not isNil(var_104_6) then
					arg_101_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_7 + var_104_8 and arg_101_1.time_ < var_104_7 + var_104_8 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect10066ui_story then
				arg_101_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action453")
			end

			local var_104_11 = 0

			if var_104_11 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_104_12 = 0
			local var_104_13 = 0.6

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_14 = arg_101_1:FormatText(StoryNameCfg[640].name)

				arg_101_1.leftNameTxt_.text = var_104_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_15 = arg_101_1:GetWordFromCfg(319381024)
				local var_104_16 = arg_101_1:FormatText(var_104_15.content)

				arg_101_1.text_.text = var_104_16

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_17 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381024", "story_v_out_319381.awb") ~= 0 then
					local var_104_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381024", "story_v_out_319381.awb") / 1000

					if var_104_20 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_20 + var_104_12
					end

					if var_104_15.prefab_name ~= "" and arg_101_1.actors_[var_104_15.prefab_name] ~= nil then
						local var_104_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_15.prefab_name].transform, "story_v_out_319381", "319381024", "story_v_out_319381.awb")

						arg_101_1:RecordAudio("319381024", var_104_21)
						arg_101_1:RecordAudio("319381024", var_104_21)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319381", "319381024", "story_v_out_319381.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319381", "319381024", "story_v_out_319381.awb")
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
	Play319381025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319381025
		arg_105_1.duration_ = 6.33

		local var_105_0 = {
			zh = 3.4,
			ja = 6.333
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
				arg_105_0:Play319381026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10066ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10066ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0.7, -0.99, -5.83)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10066ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["10066ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10066ui_story == nil then
				arg_105_1.var_.characterEffect10066ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect10066ui_story and not isNil(var_108_9) then
					arg_105_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10066ui_story then
				arg_105_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				arg_105_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_108_14 = 0
			local var_108_15 = 0.35

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_16 = arg_105_1:FormatText(StoryNameCfg[640].name)

				arg_105_1.leftNameTxt_.text = var_108_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_17 = arg_105_1:GetWordFromCfg(319381025)
				local var_108_18 = arg_105_1:FormatText(var_108_17.content)

				arg_105_1.text_.text = var_108_18

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_19 = 14
				local var_108_20 = utf8.len(var_108_18)
				local var_108_21 = var_108_19 <= 0 and var_108_15 or var_108_15 * (var_108_20 / var_108_19)

				if var_108_21 > 0 and var_108_15 < var_108_21 then
					arg_105_1.talkMaxDuration = var_108_21

					if var_108_21 + var_108_14 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_21 + var_108_14
					end
				end

				arg_105_1.text_.text = var_108_18
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381025", "story_v_out_319381.awb") ~= 0 then
					local var_108_22 = manager.audio:GetVoiceLength("story_v_out_319381", "319381025", "story_v_out_319381.awb") / 1000

					if var_108_22 + var_108_14 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_14
					end

					if var_108_17.prefab_name ~= "" and arg_105_1.actors_[var_108_17.prefab_name] ~= nil then
						local var_108_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_17.prefab_name].transform, "story_v_out_319381", "319381025", "story_v_out_319381.awb")

						arg_105_1:RecordAudio("319381025", var_108_23)
						arg_105_1:RecordAudio("319381025", var_108_23)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319381", "319381025", "story_v_out_319381.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319381", "319381025", "story_v_out_319381.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_24 = math.max(var_108_15, arg_105_1.talkMaxDuration)

			if var_108_14 <= arg_105_1.time_ and arg_105_1.time_ < var_108_14 + var_108_24 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_14) / var_108_24

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_14 + var_108_24 and arg_105_1.time_ < var_108_14 + var_108_24 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play319381026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319381026
		arg_109_1.duration_ = 3.23

		local var_109_0 = {
			zh = 1.999999999999,
			ja = 3.233
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
				arg_109_0:Play319381027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10066ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10066ui_story == nil then
				arg_109_1.var_.characterEffect10066ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect10066ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10066ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10066ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10066ui_story.fillRatio = var_112_5
			end

			local var_112_6 = arg_109_1.actors_["1084ui_story"]
			local var_112_7 = 0

			if var_112_7 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = var_112_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_8 = 0.200000002980232

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_8 and not isNil(var_112_6) then
				local var_112_9 = (arg_109_1.time_ - var_112_7) / var_112_8

				if arg_109_1.var_.characterEffect1084ui_story and not isNil(var_112_6) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_7 + var_112_8 and arg_109_1.time_ < var_112_7 + var_112_8 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_112_11 = 0
			local var_112_12 = 0.125

			if var_112_11 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_13 = arg_109_1:FormatText(StoryNameCfg[6].name)

				arg_109_1.leftNameTxt_.text = var_112_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_14 = arg_109_1:GetWordFromCfg(319381026)
				local var_112_15 = arg_109_1:FormatText(var_112_14.content)

				arg_109_1.text_.text = var_112_15

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_16 = 5
				local var_112_17 = utf8.len(var_112_15)
				local var_112_18 = var_112_16 <= 0 and var_112_12 or var_112_12 * (var_112_17 / var_112_16)

				if var_112_18 > 0 and var_112_12 < var_112_18 then
					arg_109_1.talkMaxDuration = var_112_18

					if var_112_18 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_11
					end
				end

				arg_109_1.text_.text = var_112_15
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381026", "story_v_out_319381.awb") ~= 0 then
					local var_112_19 = manager.audio:GetVoiceLength("story_v_out_319381", "319381026", "story_v_out_319381.awb") / 1000

					if var_112_19 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_19 + var_112_11
					end

					if var_112_14.prefab_name ~= "" and arg_109_1.actors_[var_112_14.prefab_name] ~= nil then
						local var_112_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_14.prefab_name].transform, "story_v_out_319381", "319381026", "story_v_out_319381.awb")

						arg_109_1:RecordAudio("319381026", var_112_20)
						arg_109_1:RecordAudio("319381026", var_112_20)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319381", "319381026", "story_v_out_319381.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319381", "319381026", "story_v_out_319381.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_21 = math.max(var_112_12, arg_109_1.talkMaxDuration)

			if var_112_11 <= arg_109_1.time_ and arg_109_1.time_ < var_112_11 + var_112_21 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_11) / var_112_21

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_11 + var_112_21 and arg_109_1.time_ < var_112_11 + var_112_21 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319381027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319381027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play319381028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1084ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1084ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1084ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 0.675

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

				local var_116_8 = arg_113_1:GetWordFromCfg(319381027)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 27
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
	Play319381028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319381028
		arg_117_1.duration_ = 16.07

		local var_117_0 = {
			zh = 5.733,
			ja = 16.066
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
				arg_117_0:Play319381029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10066ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10066ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0.7, -0.99, -5.83)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10066ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["10066ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect10066ui_story == nil then
				arg_117_1.var_.characterEffect10066ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect10066ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect10066ui_story then
				arg_117_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_15 = 0
			local var_120_16 = 0.65

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[640].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(319381028)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 26
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381028", "story_v_out_319381.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_out_319381", "319381028", "story_v_out_319381.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_out_319381", "319381028", "story_v_out_319381.awb")

						arg_117_1:RecordAudio("319381028", var_120_24)
						arg_117_1:RecordAudio("319381028", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319381", "319381028", "story_v_out_319381.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319381", "319381028", "story_v_out_319381.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play319381029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319381029
		arg_121_1.duration_ = 4.67

		local var_121_0 = {
			zh = 2.866,
			ja = 4.666
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
				arg_121_0:Play319381030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1084ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1084ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(-0.7, -0.97, -6)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1084ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1084ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect1084ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect1084ui_story then
				arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_14 = arg_121_1.actors_["10066ui_story"]
			local var_124_15 = 0

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.characterEffect10066ui_story == nil then
				arg_121_1.var_.characterEffect10066ui_story = var_124_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_16 = 0.200000002980232

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_16 and not isNil(var_124_14) then
				local var_124_17 = (arg_121_1.time_ - var_124_15) / var_124_16

				if arg_121_1.var_.characterEffect10066ui_story and not isNil(var_124_14) then
					local var_124_18 = Mathf.Lerp(0, 0.5, var_124_17)

					arg_121_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10066ui_story.fillRatio = var_124_18
				end
			end

			if arg_121_1.time_ >= var_124_15 + var_124_16 and arg_121_1.time_ < var_124_15 + var_124_16 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.characterEffect10066ui_story then
				local var_124_19 = 0.5

				arg_121_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10066ui_story.fillRatio = var_124_19
			end

			local var_124_20 = 0

			if var_124_20 < arg_121_1.time_ and arg_121_1.time_ <= var_124_20 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action463")
			end

			local var_124_21 = 0
			local var_124_22 = 0.15

			if var_124_21 < arg_121_1.time_ and arg_121_1.time_ <= var_124_21 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_23 = arg_121_1:FormatText(StoryNameCfg[6].name)

				arg_121_1.leftNameTxt_.text = var_124_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_24 = arg_121_1:GetWordFromCfg(319381029)
				local var_124_25 = arg_121_1:FormatText(var_124_24.content)

				arg_121_1.text_.text = var_124_25

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_26 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381029", "story_v_out_319381.awb") ~= 0 then
					local var_124_29 = manager.audio:GetVoiceLength("story_v_out_319381", "319381029", "story_v_out_319381.awb") / 1000

					if var_124_29 + var_124_21 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_29 + var_124_21
					end

					if var_124_24.prefab_name ~= "" and arg_121_1.actors_[var_124_24.prefab_name] ~= nil then
						local var_124_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_24.prefab_name].transform, "story_v_out_319381", "319381029", "story_v_out_319381.awb")

						arg_121_1:RecordAudio("319381029", var_124_30)
						arg_121_1:RecordAudio("319381029", var_124_30)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319381", "319381029", "story_v_out_319381.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319381", "319381029", "story_v_out_319381.awb")
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
				actorName = "1084ui_story",
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
	Play319381030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319381030
		arg_125_1.duration_ = 7.33

		local var_125_0 = {
			zh = 4.633,
			ja = 7.333
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
				arg_125_0:Play319381031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1084ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1084ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1084ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1084ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1084ui_story.fillRatio = var_128_5
			end

			local var_128_6 = arg_125_1.actors_["10066ui_story"]
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect10066ui_story == nil then
				arg_125_1.var_.characterEffect10066ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_8 = 0.200000002980232

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 and not isNil(var_128_6) then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8

				if arg_125_1.var_.characterEffect10066ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect10066ui_story then
				arg_125_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_128_11 = 0

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_12 = 0
			local var_128_13 = 0.45

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_14 = arg_125_1:FormatText(StoryNameCfg[640].name)

				arg_125_1.leftNameTxt_.text = var_128_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_15 = arg_125_1:GetWordFromCfg(319381030)
				local var_128_16 = arg_125_1:FormatText(var_128_15.content)

				arg_125_1.text_.text = var_128_16

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381030", "story_v_out_319381.awb") ~= 0 then
					local var_128_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381030", "story_v_out_319381.awb") / 1000

					if var_128_20 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_12
					end

					if var_128_15.prefab_name ~= "" and arg_125_1.actors_[var_128_15.prefab_name] ~= nil then
						local var_128_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_15.prefab_name].transform, "story_v_out_319381", "319381030", "story_v_out_319381.awb")

						arg_125_1:RecordAudio("319381030", var_128_21)
						arg_125_1:RecordAudio("319381030", var_128_21)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319381", "319381030", "story_v_out_319381.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319381", "319381030", "story_v_out_319381.awb")
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
	Play319381031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319381031
		arg_129_1.duration_ = 3.47

		local var_129_0 = {
			zh = 3.466,
			ja = 3.4
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
				arg_129_0:Play319381032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10066ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10066ui_story == nil then
				arg_129_1.var_.characterEffect10066ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect10066ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10066ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10066ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10066ui_story.fillRatio = var_132_5
			end

			local var_132_6 = arg_129_1.actors_["1084ui_story"]
			local var_132_7 = 0

			if var_132_7 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1084ui_story == nil then
				arg_129_1.var_.characterEffect1084ui_story = var_132_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_8 = 0.200000002980232

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_8 and not isNil(var_132_6) then
				local var_132_9 = (arg_129_1.time_ - var_132_7) / var_132_8

				if arg_129_1.var_.characterEffect1084ui_story and not isNil(var_132_6) then
					arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_7 + var_132_8 and arg_129_1.time_ < var_132_7 + var_132_8 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1084ui_story then
				arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_132_11 = 0
			local var_132_12 = 0.2

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_13 = arg_129_1:FormatText(StoryNameCfg[6].name)

				arg_129_1.leftNameTxt_.text = var_132_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_14 = arg_129_1:GetWordFromCfg(319381031)
				local var_132_15 = arg_129_1:FormatText(var_132_14.content)

				arg_129_1.text_.text = var_132_15

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381031", "story_v_out_319381.awb") ~= 0 then
					local var_132_19 = manager.audio:GetVoiceLength("story_v_out_319381", "319381031", "story_v_out_319381.awb") / 1000

					if var_132_19 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_11
					end

					if var_132_14.prefab_name ~= "" and arg_129_1.actors_[var_132_14.prefab_name] ~= nil then
						local var_132_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_14.prefab_name].transform, "story_v_out_319381", "319381031", "story_v_out_319381.awb")

						arg_129_1:RecordAudio("319381031", var_132_20)
						arg_129_1:RecordAudio("319381031", var_132_20)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_319381", "319381031", "story_v_out_319381.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_319381", "319381031", "story_v_out_319381.awb")
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
	Play319381032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319381032
		arg_133_1.duration_ = 7.1

		local var_133_0 = {
			zh = 2.766,
			ja = 7.1
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
				arg_133_0:Play319381033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10066ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10066ui_story == nil then
				arg_133_1.var_.characterEffect10066ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect10066ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10066ui_story then
				arg_133_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["1084ui_story"]
			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = var_136_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.200000002980232

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 and not isNil(var_136_4) then
				local var_136_7 = (arg_133_1.time_ - var_136_5) / var_136_6

				if arg_133_1.var_.characterEffect1084ui_story and not isNil(var_136_4) then
					local var_136_8 = Mathf.Lerp(0, 0.5, var_136_7)

					arg_133_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1084ui_story.fillRatio = var_136_8
				end
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect1084ui_story then
				local var_136_9 = 0.5

				arg_133_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1084ui_story.fillRatio = var_136_9
			end

			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_136_11 = 0

			if var_136_11 < arg_133_1.time_ and arg_133_1.time_ <= var_136_11 + arg_136_0 then
				arg_133_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_12 = 0
			local var_136_13 = 0.225

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_14 = arg_133_1:FormatText(StoryNameCfg[640].name)

				arg_133_1.leftNameTxt_.text = var_136_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_15 = arg_133_1:GetWordFromCfg(319381032)
				local var_136_16 = arg_133_1:FormatText(var_136_15.content)

				arg_133_1.text_.text = var_136_16

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_17 = 9
				local var_136_18 = utf8.len(var_136_16)
				local var_136_19 = var_136_17 <= 0 and var_136_13 or var_136_13 * (var_136_18 / var_136_17)

				if var_136_19 > 0 and var_136_13 < var_136_19 then
					arg_133_1.talkMaxDuration = var_136_19

					if var_136_19 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_19 + var_136_12
					end
				end

				arg_133_1.text_.text = var_136_16
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381032", "story_v_out_319381.awb") ~= 0 then
					local var_136_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381032", "story_v_out_319381.awb") / 1000

					if var_136_20 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_20 + var_136_12
					end

					if var_136_15.prefab_name ~= "" and arg_133_1.actors_[var_136_15.prefab_name] ~= nil then
						local var_136_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_15.prefab_name].transform, "story_v_out_319381", "319381032", "story_v_out_319381.awb")

						arg_133_1:RecordAudio("319381032", var_136_21)
						arg_133_1:RecordAudio("319381032", var_136_21)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319381", "319381032", "story_v_out_319381.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319381", "319381032", "story_v_out_319381.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_22 = math.max(var_136_13, arg_133_1.talkMaxDuration)

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_22 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_12) / var_136_22

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_12 + var_136_22 and arg_133_1.time_ < var_136_12 + var_136_22 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play319381033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319381033
		arg_137_1.duration_ = 5.17

		local var_137_0 = {
			zh = 5.166,
			ja = 4.3
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
				arg_137_0:Play319381034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_1 = 0
			local var_140_2 = 0.5

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_3 = arg_137_1:FormatText(StoryNameCfg[640].name)

				arg_137_1.leftNameTxt_.text = var_140_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(319381033)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 20
				local var_140_7 = utf8.len(var_140_5)
				local var_140_8 = var_140_6 <= 0 and var_140_2 or var_140_2 * (var_140_7 / var_140_6)

				if var_140_8 > 0 and var_140_2 < var_140_8 then
					arg_137_1.talkMaxDuration = var_140_8

					if var_140_8 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381033", "story_v_out_319381.awb") ~= 0 then
					local var_140_9 = manager.audio:GetVoiceLength("story_v_out_319381", "319381033", "story_v_out_319381.awb") / 1000

					if var_140_9 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_1
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_out_319381", "319381033", "story_v_out_319381.awb")

						arg_137_1:RecordAudio("319381033", var_140_10)
						arg_137_1:RecordAudio("319381033", var_140_10)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319381", "319381033", "story_v_out_319381.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319381", "319381033", "story_v_out_319381.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_11 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_11 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_11

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_11 and arg_137_1.time_ < var_140_1 + var_140_11 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play319381034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319381034
		arg_141_1.duration_ = 3.7

		local var_141_0 = {
			zh = 1.999999999999,
			ja = 3.7
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
				arg_141_0:Play319381035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1084ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1084ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_144_6 = arg_141_1.actors_["10066ui_story"]
			local var_144_7 = 0

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect10066ui_story == nil then
				arg_141_1.var_.characterEffect10066ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_8 = 0.200000002980232

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_8 and not isNil(var_144_6) then
				local var_144_9 = (arg_141_1.time_ - var_144_7) / var_144_8

				if arg_141_1.var_.characterEffect10066ui_story and not isNil(var_144_6) then
					local var_144_10 = Mathf.Lerp(0, 0.5, var_144_9)

					arg_141_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10066ui_story.fillRatio = var_144_10
				end
			end

			if arg_141_1.time_ >= var_144_7 + var_144_8 and arg_141_1.time_ < var_144_7 + var_144_8 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect10066ui_story then
				local var_144_11 = 0.5

				arg_141_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10066ui_story.fillRatio = var_144_11
			end

			local var_144_12 = 0
			local var_144_13 = 0.075

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_14 = arg_141_1:FormatText(StoryNameCfg[6].name)

				arg_141_1.leftNameTxt_.text = var_144_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_15 = arg_141_1:GetWordFromCfg(319381034)
				local var_144_16 = arg_141_1:FormatText(var_144_15.content)

				arg_141_1.text_.text = var_144_16

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_17 = 3
				local var_144_18 = utf8.len(var_144_16)
				local var_144_19 = var_144_17 <= 0 and var_144_13 or var_144_13 * (var_144_18 / var_144_17)

				if var_144_19 > 0 and var_144_13 < var_144_19 then
					arg_141_1.talkMaxDuration = var_144_19

					if var_144_19 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_16
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381034", "story_v_out_319381.awb") ~= 0 then
					local var_144_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381034", "story_v_out_319381.awb") / 1000

					if var_144_20 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_12
					end

					if var_144_15.prefab_name ~= "" and arg_141_1.actors_[var_144_15.prefab_name] ~= nil then
						local var_144_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_15.prefab_name].transform, "story_v_out_319381", "319381034", "story_v_out_319381.awb")

						arg_141_1:RecordAudio("319381034", var_144_21)
						arg_141_1:RecordAudio("319381034", var_144_21)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_319381", "319381034", "story_v_out_319381.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_319381", "319381034", "story_v_out_319381.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_22 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_22

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_22 and arg_141_1.time_ < var_144_12 + var_144_22 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play319381035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319381035
		arg_145_1.duration_ = 12.43

		local var_145_0 = {
			zh = 8.4,
			ja = 12.433
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
				arg_145_0:Play319381036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = "I11q"

			if arg_145_1.bgs_[var_148_0] == nil then
				local var_148_1 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_148_0)
				var_148_1.name = var_148_0
				var_148_1.transform.parent = arg_145_1.stage_.transform
				var_148_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_[var_148_0] = var_148_1
			end

			local var_148_2 = 2

			if var_148_2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				local var_148_3 = manager.ui.mainCamera.transform.localPosition
				local var_148_4 = Vector3.New(0, 0, 10) + Vector3.New(var_148_3.x, var_148_3.y, 0)
				local var_148_5 = arg_145_1.bgs_.I11q

				var_148_5.transform.localPosition = var_148_4
				var_148_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_6 = var_148_5:GetComponent("SpriteRenderer")

				if var_148_6 and var_148_6.sprite then
					local var_148_7 = (var_148_5.transform.localPosition - var_148_3).z
					local var_148_8 = manager.ui.mainCameraCom_
					local var_148_9 = 2 * var_148_7 * Mathf.Tan(var_148_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_148_10 = var_148_9 * var_148_8.aspect
					local var_148_11 = var_148_6.sprite.bounds.size.x
					local var_148_12 = var_148_6.sprite.bounds.size.y
					local var_148_13 = var_148_10 / var_148_11
					local var_148_14 = var_148_9 / var_148_12
					local var_148_15 = var_148_14 < var_148_13 and var_148_13 or var_148_14

					var_148_5.transform.localScale = Vector3.New(var_148_15, var_148_15, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "I11q" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_148_27 = arg_145_1.actors_["1084ui_story"].transform
			local var_148_28 = 2

			if var_148_28 < arg_145_1.time_ and arg_145_1.time_ <= var_148_28 + arg_148_0 then
				arg_145_1.var_.moveOldPos1084ui_story = var_148_27.localPosition
			end

			local var_148_29 = 0.001

			if var_148_28 <= arg_145_1.time_ and arg_145_1.time_ < var_148_28 + var_148_29 then
				local var_148_30 = (arg_145_1.time_ - var_148_28) / var_148_29
				local var_148_31 = Vector3.New(0, 100, 0)

				var_148_27.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1084ui_story, var_148_31, var_148_30)

				local var_148_32 = manager.ui.mainCamera.transform.position - var_148_27.position

				var_148_27.forward = Vector3.New(var_148_32.x, var_148_32.y, var_148_32.z)

				local var_148_33 = var_148_27.localEulerAngles

				var_148_33.z = 0
				var_148_33.x = 0
				var_148_27.localEulerAngles = var_148_33
			end

			if arg_145_1.time_ >= var_148_28 + var_148_29 and arg_145_1.time_ < var_148_28 + var_148_29 + arg_148_0 then
				var_148_27.localPosition = Vector3.New(0, 100, 0)

				local var_148_34 = manager.ui.mainCamera.transform.position - var_148_27.position

				var_148_27.forward = Vector3.New(var_148_34.x, var_148_34.y, var_148_34.z)

				local var_148_35 = var_148_27.localEulerAngles

				var_148_35.z = 0
				var_148_35.x = 0
				var_148_27.localEulerAngles = var_148_35
			end

			local var_148_36 = arg_145_1.actors_["1084ui_story"]
			local var_148_37 = 2

			if var_148_37 < arg_145_1.time_ and arg_145_1.time_ <= var_148_37 + arg_148_0 and not isNil(var_148_36) and arg_145_1.var_.characterEffect1084ui_story == nil then
				arg_145_1.var_.characterEffect1084ui_story = var_148_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_38 = 0.200000002980232

			if var_148_37 <= arg_145_1.time_ and arg_145_1.time_ < var_148_37 + var_148_38 and not isNil(var_148_36) then
				local var_148_39 = (arg_145_1.time_ - var_148_37) / var_148_38

				if arg_145_1.var_.characterEffect1084ui_story and not isNil(var_148_36) then
					local var_148_40 = Mathf.Lerp(0, 0.5, var_148_39)

					arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1084ui_story.fillRatio = var_148_40
				end
			end

			if arg_145_1.time_ >= var_148_37 + var_148_38 and arg_145_1.time_ < var_148_37 + var_148_38 + arg_148_0 and not isNil(var_148_36) and arg_145_1.var_.characterEffect1084ui_story then
				local var_148_41 = 0.5

				arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1084ui_story.fillRatio = var_148_41
			end

			local var_148_42 = "1095ui_story"

			if arg_145_1.actors_[var_148_42] == nil then
				local var_148_43 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_148_43) then
					local var_148_44 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_145_1.stage_.transform)

					var_148_44.name = var_148_42
					var_148_44.transform.localPosition = Vector3.New(0, 100, 0)
					arg_145_1.actors_[var_148_42] = var_148_44

					local var_148_45 = var_148_44:GetComponentInChildren(typeof(CharacterEffect))

					var_148_45.enabled = true

					local var_148_46 = GameObjectTools.GetOrAddComponent(var_148_44, typeof(DynamicBoneHelper))

					if var_148_46 then
						var_148_46:EnableDynamicBone(false)
					end

					arg_145_1:ShowWeapon(var_148_45.transform, false)

					arg_145_1.var_[var_148_42 .. "Animator"] = var_148_45.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_145_1.var_[var_148_42 .. "Animator"].applyRootMotion = true
					arg_145_1.var_[var_148_42 .. "LipSync"] = var_148_45.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_148_47 = arg_145_1.actors_["1095ui_story"].transform
			local var_148_48 = 2

			if var_148_48 < arg_145_1.time_ and arg_145_1.time_ <= var_148_48 + arg_148_0 then
				arg_145_1.var_.moveOldPos1095ui_story = var_148_47.localPosition
			end

			local var_148_49 = 0.001

			if var_148_48 <= arg_145_1.time_ and arg_145_1.time_ < var_148_48 + var_148_49 then
				local var_148_50 = (arg_145_1.time_ - var_148_48) / var_148_49
				local var_148_51 = Vector3.New(-0.7, -0.98, -6.1)

				var_148_47.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1095ui_story, var_148_51, var_148_50)

				local var_148_52 = manager.ui.mainCamera.transform.position - var_148_47.position

				var_148_47.forward = Vector3.New(var_148_52.x, var_148_52.y, var_148_52.z)

				local var_148_53 = var_148_47.localEulerAngles

				var_148_53.z = 0
				var_148_53.x = 0
				var_148_47.localEulerAngles = var_148_53
			end

			if arg_145_1.time_ >= var_148_48 + var_148_49 and arg_145_1.time_ < var_148_48 + var_148_49 + arg_148_0 then
				var_148_47.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_148_54 = manager.ui.mainCamera.transform.position - var_148_47.position

				var_148_47.forward = Vector3.New(var_148_54.x, var_148_54.y, var_148_54.z)

				local var_148_55 = var_148_47.localEulerAngles

				var_148_55.z = 0
				var_148_55.x = 0
				var_148_47.localEulerAngles = var_148_55
			end

			local var_148_56 = arg_145_1.actors_["1095ui_story"]
			local var_148_57 = 2

			if var_148_57 < arg_145_1.time_ and arg_145_1.time_ <= var_148_57 + arg_148_0 and not isNil(var_148_56) and arg_145_1.var_.characterEffect1095ui_story == nil then
				arg_145_1.var_.characterEffect1095ui_story = var_148_56:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_58 = 0.200000002980232

			if var_148_57 <= arg_145_1.time_ and arg_145_1.time_ < var_148_57 + var_148_58 and not isNil(var_148_56) then
				local var_148_59 = (arg_145_1.time_ - var_148_57) / var_148_58

				if arg_145_1.var_.characterEffect1095ui_story and not isNil(var_148_56) then
					arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_57 + var_148_58 and arg_145_1.time_ < var_148_57 + var_148_58 + arg_148_0 and not isNil(var_148_56) and arg_145_1.var_.characterEffect1095ui_story then
				arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_148_60 = arg_145_1.actors_["10066ui_story"]
			local var_148_61 = 2

			if var_148_61 < arg_145_1.time_ and arg_145_1.time_ <= var_148_61 + arg_148_0 and not isNil(var_148_60) and arg_145_1.var_.characterEffect10066ui_story == nil then
				arg_145_1.var_.characterEffect10066ui_story = var_148_60:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_62 = 0.200000002980232

			if var_148_61 <= arg_145_1.time_ and arg_145_1.time_ < var_148_61 + var_148_62 and not isNil(var_148_60) then
				local var_148_63 = (arg_145_1.time_ - var_148_61) / var_148_62

				if arg_145_1.var_.characterEffect10066ui_story and not isNil(var_148_60) then
					local var_148_64 = Mathf.Lerp(0, 0.5, var_148_63)

					arg_145_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10066ui_story.fillRatio = var_148_64
				end
			end

			if arg_145_1.time_ >= var_148_61 + var_148_62 and arg_145_1.time_ < var_148_61 + var_148_62 + arg_148_0 and not isNil(var_148_60) and arg_145_1.var_.characterEffect10066ui_story then
				local var_148_65 = 0.5

				arg_145_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10066ui_story.fillRatio = var_148_65
			end

			local var_148_66 = arg_145_1.actors_["10066ui_story"].transform
			local var_148_67 = 2

			if var_148_67 < arg_145_1.time_ and arg_145_1.time_ <= var_148_67 + arg_148_0 then
				arg_145_1.var_.moveOldPos10066ui_story = var_148_66.localPosition
			end

			local var_148_68 = 0.001

			if var_148_67 <= arg_145_1.time_ and arg_145_1.time_ < var_148_67 + var_148_68 then
				local var_148_69 = (arg_145_1.time_ - var_148_67) / var_148_68
				local var_148_70 = Vector3.New(0, 100, 0)

				var_148_66.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10066ui_story, var_148_70, var_148_69)

				local var_148_71 = manager.ui.mainCamera.transform.position - var_148_66.position

				var_148_66.forward = Vector3.New(var_148_71.x, var_148_71.y, var_148_71.z)

				local var_148_72 = var_148_66.localEulerAngles

				var_148_72.z = 0
				var_148_72.x = 0
				var_148_66.localEulerAngles = var_148_72
			end

			if arg_145_1.time_ >= var_148_67 + var_148_68 and arg_145_1.time_ < var_148_67 + var_148_68 + arg_148_0 then
				var_148_66.localPosition = Vector3.New(0, 100, 0)

				local var_148_73 = manager.ui.mainCamera.transform.position - var_148_66.position

				var_148_66.forward = Vector3.New(var_148_73.x, var_148_73.y, var_148_73.z)

				local var_148_74 = var_148_66.localEulerAngles

				var_148_74.z = 0
				var_148_74.x = 0
				var_148_66.localEulerAngles = var_148_74
			end

			local var_148_75 = 2

			if var_148_75 < arg_145_1.time_ and arg_145_1.time_ <= var_148_75 + arg_148_0 then
				arg_145_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_148_76 = 2

			if var_148_76 < arg_145_1.time_ and arg_145_1.time_ <= var_148_76 + arg_148_0 then
				arg_145_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_77 = "10079ui_story"

			if arg_145_1.actors_[var_148_77] == nil then
				local var_148_78 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_148_78) then
					local var_148_79 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_145_1.stage_.transform)

					var_148_79.name = var_148_77
					var_148_79.transform.localPosition = Vector3.New(0, 100, 0)
					arg_145_1.actors_[var_148_77] = var_148_79

					local var_148_80 = var_148_79:GetComponentInChildren(typeof(CharacterEffect))

					var_148_80.enabled = true

					local var_148_81 = GameObjectTools.GetOrAddComponent(var_148_79, typeof(DynamicBoneHelper))

					if var_148_81 then
						var_148_81:EnableDynamicBone(false)
					end

					arg_145_1:ShowWeapon(var_148_80.transform, false)

					arg_145_1.var_[var_148_77 .. "Animator"] = var_148_80.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_145_1.var_[var_148_77 .. "Animator"].applyRootMotion = true
					arg_145_1.var_[var_148_77 .. "LipSync"] = var_148_80.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_148_82 = arg_145_1.actors_["10079ui_story"].transform
			local var_148_83 = 2

			if var_148_83 < arg_145_1.time_ and arg_145_1.time_ <= var_148_83 + arg_148_0 then
				arg_145_1.var_.moveOldPos10079ui_story = var_148_82.localPosition
			end

			local var_148_84 = 0.001

			if var_148_83 <= arg_145_1.time_ and arg_145_1.time_ < var_148_83 + var_148_84 then
				local var_148_85 = (arg_145_1.time_ - var_148_83) / var_148_84
				local var_148_86 = Vector3.New(0.7, -0.95, -6.05)

				var_148_82.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10079ui_story, var_148_86, var_148_85)

				local var_148_87 = manager.ui.mainCamera.transform.position - var_148_82.position

				var_148_82.forward = Vector3.New(var_148_87.x, var_148_87.y, var_148_87.z)

				local var_148_88 = var_148_82.localEulerAngles

				var_148_88.z = 0
				var_148_88.x = 0
				var_148_82.localEulerAngles = var_148_88
			end

			if arg_145_1.time_ >= var_148_83 + var_148_84 and arg_145_1.time_ < var_148_83 + var_148_84 + arg_148_0 then
				var_148_82.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_148_89 = manager.ui.mainCamera.transform.position - var_148_82.position

				var_148_82.forward = Vector3.New(var_148_89.x, var_148_89.y, var_148_89.z)

				local var_148_90 = var_148_82.localEulerAngles

				var_148_90.z = 0
				var_148_90.x = 0
				var_148_82.localEulerAngles = var_148_90
			end

			local var_148_91 = 2

			if var_148_91 < arg_145_1.time_ and arg_145_1.time_ <= var_148_91 + arg_148_0 then
				arg_145_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_148_92 = 2

			if var_148_92 < arg_145_1.time_ and arg_145_1.time_ <= var_148_92 + arg_148_0 then
				arg_145_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_93 = arg_145_1.actors_["10079ui_story"]
			local var_148_94 = 2

			if var_148_94 < arg_145_1.time_ and arg_145_1.time_ <= var_148_94 + arg_148_0 and not isNil(var_148_93) and arg_145_1.var_.characterEffect10079ui_story == nil then
				arg_145_1.var_.characterEffect10079ui_story = var_148_93:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_95 = 0.200000002980232

			if var_148_94 <= arg_145_1.time_ and arg_145_1.time_ < var_148_94 + var_148_95 and not isNil(var_148_93) then
				local var_148_96 = (arg_145_1.time_ - var_148_94) / var_148_95

				if arg_145_1.var_.characterEffect10079ui_story and not isNil(var_148_93) then
					local var_148_97 = Mathf.Lerp(0, 0.5, var_148_96)

					arg_145_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10079ui_story.fillRatio = var_148_97
				end
			end

			if arg_145_1.time_ >= var_148_94 + var_148_95 and arg_145_1.time_ < var_148_94 + var_148_95 + arg_148_0 and not isNil(var_148_93) and arg_145_1.var_.characterEffect10079ui_story then
				local var_148_98 = 0.5

				arg_145_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10079ui_story.fillRatio = var_148_98
			end

			local var_148_99 = 2

			arg_145_1.isInRecall_ = false

			if var_148_99 < arg_145_1.time_ and arg_145_1.time_ <= var_148_99 + arg_148_0 then
				arg_145_1.screenFilterGo_:SetActive(true)

				arg_145_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_148_2, iter_148_3 in pairs(arg_145_1.actors_) do
					local var_148_100 = iter_148_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_148_4, iter_148_5 in ipairs(var_148_100) do
						if iter_148_5.color.r > 0.51 then
							iter_148_5.color = Color.New(1, 1, 1)
						else
							iter_148_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_148_101 = 0.034000001847744

			if var_148_99 <= arg_145_1.time_ and arg_145_1.time_ < var_148_99 + var_148_101 then
				local var_148_102 = (arg_145_1.time_ - var_148_99) / var_148_101

				arg_145_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_148_102)
			end

			if arg_145_1.time_ >= var_148_99 + var_148_101 and arg_145_1.time_ < var_148_99 + var_148_101 + arg_148_0 then
				arg_145_1.screenFilterEffect_.weight = 1
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_103 = 2
			local var_148_104 = 0.7

			if var_148_103 < arg_145_1.time_ and arg_145_1.time_ <= var_148_103 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_105 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_105:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_105:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_105:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_106 = arg_145_1:FormatText(StoryNameCfg[471].name)

				arg_145_1.leftNameTxt_.text = var_148_106

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_107 = arg_145_1:GetWordFromCfg(319381035)
				local var_148_108 = arg_145_1:FormatText(var_148_107.content)

				arg_145_1.text_.text = var_148_108

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_109 = 28
				local var_148_110 = utf8.len(var_148_108)
				local var_148_111 = var_148_109 <= 0 and var_148_104 or var_148_104 * (var_148_110 / var_148_109)

				if var_148_111 > 0 and var_148_104 < var_148_111 then
					arg_145_1.talkMaxDuration = var_148_111
					var_148_103 = var_148_103 + 0.3

					if var_148_111 + var_148_103 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_111 + var_148_103
					end
				end

				arg_145_1.text_.text = var_148_108
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381035", "story_v_out_319381.awb") ~= 0 then
					local var_148_112 = manager.audio:GetVoiceLength("story_v_out_319381", "319381035", "story_v_out_319381.awb") / 1000

					if var_148_112 + var_148_103 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_112 + var_148_103
					end

					if var_148_107.prefab_name ~= "" and arg_145_1.actors_[var_148_107.prefab_name] ~= nil then
						local var_148_113 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_107.prefab_name].transform, "story_v_out_319381", "319381035", "story_v_out_319381.awb")

						arg_145_1:RecordAudio("319381035", var_148_113)
						arg_145_1:RecordAudio("319381035", var_148_113)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319381", "319381035", "story_v_out_319381.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319381", "319381035", "story_v_out_319381.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_114 = var_148_103 + 0.3
			local var_148_115 = math.max(var_148_104, arg_145_1.talkMaxDuration)

			if var_148_114 <= arg_145_1.time_ and arg_145_1.time_ < var_148_114 + var_148_115 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_114) / var_148_115

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_114 + var_148_115 and arg_145_1.time_ < var_148_114 + var_148_115 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play319381036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319381036
		arg_151_1.duration_ = 7.83

		local var_151_0 = {
			zh = 4.533,
			ja = 7.833
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
				arg_151_0:Play319381037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1095ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1095ui_story == nil then
				arg_151_1.var_.characterEffect1095ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1095ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1095ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1095ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1095ui_story.fillRatio = var_154_5
			end

			local var_154_6 = arg_151_1.actors_["10079ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect10079ui_story == nil then
				arg_151_1.var_.characterEffect10079ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.200000002980232

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 and not isNil(var_154_6) then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect10079ui_story and not isNil(var_154_6) then
					local var_154_10 = Mathf.Lerp(0, 0.5, var_154_9)

					arg_151_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10079ui_story.fillRatio = var_154_10
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect10079ui_story then
				local var_154_11 = 0.5

				arg_151_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10079ui_story.fillRatio = var_154_11
			end

			local var_154_12 = 0
			local var_154_13 = 0.6

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_14 = arg_151_1:FormatText(StoryNameCfg[6].name)

				arg_151_1.leftNameTxt_.text = var_154_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_15 = arg_151_1:GetWordFromCfg(319381036)
				local var_154_16 = arg_151_1:FormatText(var_154_15.content)

				arg_151_1.text_.text = var_154_16

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_17 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381036", "story_v_out_319381.awb") ~= 0 then
					local var_154_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381036", "story_v_out_319381.awb") / 1000

					if var_154_20 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_20 + var_154_12
					end

					if var_154_15.prefab_name ~= "" and arg_151_1.actors_[var_154_15.prefab_name] ~= nil then
						local var_154_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_15.prefab_name].transform, "story_v_out_319381", "319381036", "story_v_out_319381.awb")

						arg_151_1:RecordAudio("319381036", var_154_21)
						arg_151_1:RecordAudio("319381036", var_154_21)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319381", "319381036", "story_v_out_319381.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319381", "319381036", "story_v_out_319381.awb")
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
	Play319381037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319381037
		arg_155_1.duration_ = 6.47

		local var_155_0 = {
			zh = 6.46666666666667,
			ja = 6.09966666666667
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
				arg_155_0:Play319381038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 2

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				local var_158_1 = manager.ui.mainCamera.transform.localPosition
				local var_158_2 = Vector3.New(0, 0, 10) + Vector3.New(var_158_1.x, var_158_1.y, 0)
				local var_158_3 = arg_155_1.bgs_.I11l

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
					if iter_158_0 ~= "I11l" then
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

			local var_158_25 = arg_155_1.actors_["1084ui_story"].transform
			local var_158_26 = 3.79999999701977

			if var_158_26 < arg_155_1.time_ and arg_155_1.time_ <= var_158_26 + arg_158_0 then
				arg_155_1.var_.moveOldPos1084ui_story = var_158_25.localPosition
			end

			local var_158_27 = 0.001

			if var_158_26 <= arg_155_1.time_ and arg_155_1.time_ < var_158_26 + var_158_27 then
				local var_158_28 = (arg_155_1.time_ - var_158_26) / var_158_27
				local var_158_29 = Vector3.New(-0.7, -0.97, -6)

				var_158_25.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1084ui_story, var_158_29, var_158_28)

				local var_158_30 = manager.ui.mainCamera.transform.position - var_158_25.position

				var_158_25.forward = Vector3.New(var_158_30.x, var_158_30.y, var_158_30.z)

				local var_158_31 = var_158_25.localEulerAngles

				var_158_31.z = 0
				var_158_31.x = 0
				var_158_25.localEulerAngles = var_158_31
			end

			if arg_155_1.time_ >= var_158_26 + var_158_27 and arg_155_1.time_ < var_158_26 + var_158_27 + arg_158_0 then
				var_158_25.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_158_32 = manager.ui.mainCamera.transform.position - var_158_25.position

				var_158_25.forward = Vector3.New(var_158_32.x, var_158_32.y, var_158_32.z)

				local var_158_33 = var_158_25.localEulerAngles

				var_158_33.z = 0
				var_158_33.x = 0
				var_158_25.localEulerAngles = var_158_33
			end

			local var_158_34 = arg_155_1.actors_["1084ui_story"]
			local var_158_35 = 3.79999999701977

			if var_158_35 < arg_155_1.time_ and arg_155_1.time_ <= var_158_35 + arg_158_0 and not isNil(var_158_34) and arg_155_1.var_.characterEffect1084ui_story == nil then
				arg_155_1.var_.characterEffect1084ui_story = var_158_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_36 = 0.200000002980232

			if var_158_35 <= arg_155_1.time_ and arg_155_1.time_ < var_158_35 + var_158_36 and not isNil(var_158_34) then
				local var_158_37 = (arg_155_1.time_ - var_158_35) / var_158_36

				if arg_155_1.var_.characterEffect1084ui_story and not isNil(var_158_34) then
					arg_155_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_35 + var_158_36 and arg_155_1.time_ < var_158_35 + var_158_36 + arg_158_0 and not isNil(var_158_34) and arg_155_1.var_.characterEffect1084ui_story then
				arg_155_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_158_38 = arg_155_1.actors_["1095ui_story"].transform
			local var_158_39 = 2

			if var_158_39 < arg_155_1.time_ and arg_155_1.time_ <= var_158_39 + arg_158_0 then
				arg_155_1.var_.moveOldPos1095ui_story = var_158_38.localPosition
			end

			local var_158_40 = 0.001

			if var_158_39 <= arg_155_1.time_ and arg_155_1.time_ < var_158_39 + var_158_40 then
				local var_158_41 = (arg_155_1.time_ - var_158_39) / var_158_40
				local var_158_42 = Vector3.New(0, 100, 0)

				var_158_38.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1095ui_story, var_158_42, var_158_41)

				local var_158_43 = manager.ui.mainCamera.transform.position - var_158_38.position

				var_158_38.forward = Vector3.New(var_158_43.x, var_158_43.y, var_158_43.z)

				local var_158_44 = var_158_38.localEulerAngles

				var_158_44.z = 0
				var_158_44.x = 0
				var_158_38.localEulerAngles = var_158_44
			end

			if arg_155_1.time_ >= var_158_39 + var_158_40 and arg_155_1.time_ < var_158_39 + var_158_40 + arg_158_0 then
				var_158_38.localPosition = Vector3.New(0, 100, 0)

				local var_158_45 = manager.ui.mainCamera.transform.position - var_158_38.position

				var_158_38.forward = Vector3.New(var_158_45.x, var_158_45.y, var_158_45.z)

				local var_158_46 = var_158_38.localEulerAngles

				var_158_46.z = 0
				var_158_46.x = 0
				var_158_38.localEulerAngles = var_158_46
			end

			local var_158_47 = arg_155_1.actors_["1095ui_story"]
			local var_158_48 = 3.79999999701977

			if var_158_48 < arg_155_1.time_ and arg_155_1.time_ <= var_158_48 + arg_158_0 and not isNil(var_158_47) and arg_155_1.var_.characterEffect1095ui_story == nil then
				arg_155_1.var_.characterEffect1095ui_story = var_158_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_49 = 0.200000002980232

			if var_158_48 <= arg_155_1.time_ and arg_155_1.time_ < var_158_48 + var_158_49 and not isNil(var_158_47) then
				local var_158_50 = (arg_155_1.time_ - var_158_48) / var_158_49

				if arg_155_1.var_.characterEffect1095ui_story and not isNil(var_158_47) then
					local var_158_51 = Mathf.Lerp(0, 0.5, var_158_50)

					arg_155_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1095ui_story.fillRatio = var_158_51
				end
			end

			if arg_155_1.time_ >= var_158_48 + var_158_49 and arg_155_1.time_ < var_158_48 + var_158_49 + arg_158_0 and not isNil(var_158_47) and arg_155_1.var_.characterEffect1095ui_story then
				local var_158_52 = 0.5

				arg_155_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1095ui_story.fillRatio = var_158_52
			end

			local var_158_53 = arg_155_1.actors_["10066ui_story"]
			local var_158_54 = 3.79999999701977

			if var_158_54 < arg_155_1.time_ and arg_155_1.time_ <= var_158_54 + arg_158_0 and not isNil(var_158_53) and arg_155_1.var_.characterEffect10066ui_story == nil then
				arg_155_1.var_.characterEffect10066ui_story = var_158_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_55 = 0.200000002980232

			if var_158_54 <= arg_155_1.time_ and arg_155_1.time_ < var_158_54 + var_158_55 and not isNil(var_158_53) then
				local var_158_56 = (arg_155_1.time_ - var_158_54) / var_158_55

				if arg_155_1.var_.characterEffect10066ui_story and not isNil(var_158_53) then
					local var_158_57 = Mathf.Lerp(0, 0.5, var_158_56)

					arg_155_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10066ui_story.fillRatio = var_158_57
				end
			end

			if arg_155_1.time_ >= var_158_54 + var_158_55 and arg_155_1.time_ < var_158_54 + var_158_55 + arg_158_0 and not isNil(var_158_53) and arg_155_1.var_.characterEffect10066ui_story then
				local var_158_58 = 0.5

				arg_155_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10066ui_story.fillRatio = var_158_58
			end

			local var_158_59 = arg_155_1.actors_["10066ui_story"].transform
			local var_158_60 = 3.79999999701977

			if var_158_60 < arg_155_1.time_ and arg_155_1.time_ <= var_158_60 + arg_158_0 then
				arg_155_1.var_.moveOldPos10066ui_story = var_158_59.localPosition
			end

			local var_158_61 = 0.001

			if var_158_60 <= arg_155_1.time_ and arg_155_1.time_ < var_158_60 + var_158_61 then
				local var_158_62 = (arg_155_1.time_ - var_158_60) / var_158_61
				local var_158_63 = Vector3.New(0.7, -0.99, -5.83)

				var_158_59.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10066ui_story, var_158_63, var_158_62)

				local var_158_64 = manager.ui.mainCamera.transform.position - var_158_59.position

				var_158_59.forward = Vector3.New(var_158_64.x, var_158_64.y, var_158_64.z)

				local var_158_65 = var_158_59.localEulerAngles

				var_158_65.z = 0
				var_158_65.x = 0
				var_158_59.localEulerAngles = var_158_65
			end

			if arg_155_1.time_ >= var_158_60 + var_158_61 and arg_155_1.time_ < var_158_60 + var_158_61 + arg_158_0 then
				var_158_59.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_158_66 = manager.ui.mainCamera.transform.position - var_158_59.position

				var_158_59.forward = Vector3.New(var_158_66.x, var_158_66.y, var_158_66.z)

				local var_158_67 = var_158_59.localEulerAngles

				var_158_67.z = 0
				var_158_67.x = 0
				var_158_59.localEulerAngles = var_158_67
			end

			local var_158_68 = arg_155_1.actors_["10079ui_story"].transform
			local var_158_69 = 2

			if var_158_69 < arg_155_1.time_ and arg_155_1.time_ <= var_158_69 + arg_158_0 then
				arg_155_1.var_.moveOldPos10079ui_story = var_158_68.localPosition
			end

			local var_158_70 = 0.001

			if var_158_69 <= arg_155_1.time_ and arg_155_1.time_ < var_158_69 + var_158_70 then
				local var_158_71 = (arg_155_1.time_ - var_158_69) / var_158_70
				local var_158_72 = Vector3.New(0, 100, 0)

				var_158_68.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10079ui_story, var_158_72, var_158_71)

				local var_158_73 = manager.ui.mainCamera.transform.position - var_158_68.position

				var_158_68.forward = Vector3.New(var_158_73.x, var_158_73.y, var_158_73.z)

				local var_158_74 = var_158_68.localEulerAngles

				var_158_74.z = 0
				var_158_74.x = 0
				var_158_68.localEulerAngles = var_158_74
			end

			if arg_155_1.time_ >= var_158_69 + var_158_70 and arg_155_1.time_ < var_158_69 + var_158_70 + arg_158_0 then
				var_158_68.localPosition = Vector3.New(0, 100, 0)

				local var_158_75 = manager.ui.mainCamera.transform.position - var_158_68.position

				var_158_68.forward = Vector3.New(var_158_75.x, var_158_75.y, var_158_75.z)

				local var_158_76 = var_158_68.localEulerAngles

				var_158_76.z = 0
				var_158_76.x = 0
				var_158_68.localEulerAngles = var_158_76
			end

			local var_158_77 = arg_155_1.actors_["10079ui_story"]
			local var_158_78 = 3.79999999701977

			if var_158_78 < arg_155_1.time_ and arg_155_1.time_ <= var_158_78 + arg_158_0 and not isNil(var_158_77) and arg_155_1.var_.characterEffect10079ui_story == nil then
				arg_155_1.var_.characterEffect10079ui_story = var_158_77:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_79 = 0.200000002980232

			if var_158_78 <= arg_155_1.time_ and arg_155_1.time_ < var_158_78 + var_158_79 and not isNil(var_158_77) then
				local var_158_80 = (arg_155_1.time_ - var_158_78) / var_158_79

				if arg_155_1.var_.characterEffect10079ui_story and not isNil(var_158_77) then
					local var_158_81 = Mathf.Lerp(0, 0.5, var_158_80)

					arg_155_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10079ui_story.fillRatio = var_158_81
				end
			end

			if arg_155_1.time_ >= var_158_78 + var_158_79 and arg_155_1.time_ < var_158_78 + var_158_79 + arg_158_0 and not isNil(var_158_77) and arg_155_1.var_.characterEffect10079ui_story then
				local var_158_82 = 0.5

				arg_155_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10079ui_story.fillRatio = var_158_82
			end

			local var_158_83 = 3.79999999701977

			if var_158_83 < arg_155_1.time_ and arg_155_1.time_ <= var_158_83 + arg_158_0 then
				arg_155_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_158_84 = 3.79999999701977

			if var_158_84 < arg_155_1.time_ and arg_155_1.time_ <= var_158_84 + arg_158_0 then
				arg_155_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_85 = 2

			arg_155_1.isInRecall_ = false

			if var_158_85 < arg_155_1.time_ and arg_155_1.time_ <= var_158_85 + arg_158_0 then
				arg_155_1.screenFilterGo_:SetActive(false)

				for iter_158_2, iter_158_3 in pairs(arg_155_1.actors_) do
					local var_158_86 = iter_158_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_158_4, iter_158_5 in ipairs(var_158_86) do
						if iter_158_5.color.r > 0.51 then
							iter_158_5.color = Color.New(1, 1, 1)
						else
							iter_158_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_158_87 = 0.0166666666666667

			if var_158_85 <= arg_155_1.time_ and arg_155_1.time_ < var_158_85 + var_158_87 then
				local var_158_88 = (arg_155_1.time_ - var_158_85) / var_158_87

				arg_155_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_158_88)
			end

			if arg_155_1.time_ >= var_158_85 + var_158_87 and arg_155_1.time_ < var_158_85 + var_158_87 + arg_158_0 then
				arg_155_1.screenFilterEffect_.weight = 0
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_89 = 4.16666666666667
			local var_158_90 = 0.225

			if var_158_89 < arg_155_1.time_ and arg_155_1.time_ <= var_158_89 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_91 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_91:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_91:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_91:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_92 = arg_155_1:FormatText(StoryNameCfg[6].name)

				arg_155_1.leftNameTxt_.text = var_158_92

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_93 = arg_155_1:GetWordFromCfg(319381037)
				local var_158_94 = arg_155_1:FormatText(var_158_93.content)

				arg_155_1.text_.text = var_158_94

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_95 = 9
				local var_158_96 = utf8.len(var_158_94)
				local var_158_97 = var_158_95 <= 0 and var_158_90 or var_158_90 * (var_158_96 / var_158_95)

				if var_158_97 > 0 and var_158_90 < var_158_97 then
					arg_155_1.talkMaxDuration = var_158_97
					var_158_89 = var_158_89 + 0.3

					if var_158_97 + var_158_89 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_97 + var_158_89
					end
				end

				arg_155_1.text_.text = var_158_94
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381037", "story_v_out_319381.awb") ~= 0 then
					local var_158_98 = manager.audio:GetVoiceLength("story_v_out_319381", "319381037", "story_v_out_319381.awb") / 1000

					if var_158_98 + var_158_89 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_98 + var_158_89
					end

					if var_158_93.prefab_name ~= "" and arg_155_1.actors_[var_158_93.prefab_name] ~= nil then
						local var_158_99 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_93.prefab_name].transform, "story_v_out_319381", "319381037", "story_v_out_319381.awb")

						arg_155_1:RecordAudio("319381037", var_158_99)
						arg_155_1:RecordAudio("319381037", var_158_99)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319381", "319381037", "story_v_out_319381.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319381", "319381037", "story_v_out_319381.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_100 = var_158_89 + 0.3
			local var_158_101 = math.max(var_158_90, arg_155_1.talkMaxDuration)

			if var_158_100 <= arg_155_1.time_ and arg_155_1.time_ < var_158_100 + var_158_101 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_100) / var_158_101

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_100 + var_158_101 and arg_155_1.time_ < var_158_100 + var_158_101 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319381038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319381038
		arg_161_1.duration_ = 5.73

		local var_161_0 = {
			zh = 5.466,
			ja = 5.733
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
				arg_161_0:Play319381039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10066ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect10066ui_story == nil then
				arg_161_1.var_.characterEffect10066ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect10066ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect10066ui_story then
				arg_161_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_164_4 = arg_161_1.actors_["1084ui_story"]
			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1084ui_story == nil then
				arg_161_1.var_.characterEffect1084ui_story = var_164_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_6 and not isNil(var_164_4) then
				local var_164_7 = (arg_161_1.time_ - var_164_5) / var_164_6

				if arg_161_1.var_.characterEffect1084ui_story and not isNil(var_164_4) then
					local var_164_8 = Mathf.Lerp(0, 0.5, var_164_7)

					arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1084ui_story.fillRatio = var_164_8
				end
			end

			if arg_161_1.time_ >= var_164_5 + var_164_6 and arg_161_1.time_ < var_164_5 + var_164_6 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1084ui_story then
				local var_164_9 = 0.5

				arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1084ui_story.fillRatio = var_164_9
			end

			local var_164_10 = 0
			local var_164_11 = 0.325

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_12 = arg_161_1:FormatText(StoryNameCfg[640].name)

				arg_161_1.leftNameTxt_.text = var_164_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:GetWordFromCfg(319381038)
				local var_164_14 = arg_161_1:FormatText(var_164_13.content)

				arg_161_1.text_.text = var_164_14

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 13
				local var_164_16 = utf8.len(var_164_14)
				local var_164_17 = var_164_15 <= 0 and var_164_11 or var_164_11 * (var_164_16 / var_164_15)

				if var_164_17 > 0 and var_164_11 < var_164_17 then
					arg_161_1.talkMaxDuration = var_164_17

					if var_164_17 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_10
					end
				end

				arg_161_1.text_.text = var_164_14
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381038", "story_v_out_319381.awb") ~= 0 then
					local var_164_18 = manager.audio:GetVoiceLength("story_v_out_319381", "319381038", "story_v_out_319381.awb") / 1000

					if var_164_18 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_18 + var_164_10
					end

					if var_164_13.prefab_name ~= "" and arg_161_1.actors_[var_164_13.prefab_name] ~= nil then
						local var_164_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_13.prefab_name].transform, "story_v_out_319381", "319381038", "story_v_out_319381.awb")

						arg_161_1:RecordAudio("319381038", var_164_19)
						arg_161_1:RecordAudio("319381038", var_164_19)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319381", "319381038", "story_v_out_319381.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319381", "319381038", "story_v_out_319381.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_20 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_20 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_10) / var_164_20

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_10 + var_164_20 and arg_161_1.time_ < var_164_10 + var_164_20 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319381039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319381039
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319381040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10066ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10066ui_story == nil then
				arg_165_1.var_.characterEffect10066ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect10066ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10066ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10066ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10066ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 1.025

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(319381039)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 41
				local var_168_11 = utf8.len(var_168_9)
				local var_168_12 = var_168_10 <= 0 and var_168_7 or var_168_7 * (var_168_11 / var_168_10)

				if var_168_12 > 0 and var_168_7 < var_168_12 then
					arg_165_1.talkMaxDuration = var_168_12

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_13 and arg_165_1.time_ < var_168_6 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319381040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319381040
		arg_169_1.duration_ = 8.97

		local var_169_0 = {
			zh = 4.933,
			ja = 8.966
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
				arg_169_0:Play319381041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10066ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10066ui_story == nil then
				arg_169_1.var_.characterEffect10066ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect10066ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10066ui_story then
				arg_169_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_172_4 = arg_169_1.actors_["1084ui_story"]
			local var_172_5 = 0

			if var_172_5 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1084ui_story == nil then
				arg_169_1.var_.characterEffect1084ui_story = var_172_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_6 = 0.200000002980232

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_6 and not isNil(var_172_4) then
				local var_172_7 = (arg_169_1.time_ - var_172_5) / var_172_6

				if arg_169_1.var_.characterEffect1084ui_story and not isNil(var_172_4) then
					local var_172_8 = Mathf.Lerp(0, 0.5, var_172_7)

					arg_169_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1084ui_story.fillRatio = var_172_8
				end
			end

			if arg_169_1.time_ >= var_172_5 + var_172_6 and arg_169_1.time_ < var_172_5 + var_172_6 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1084ui_story then
				local var_172_9 = 0.5

				arg_169_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1084ui_story.fillRatio = var_172_9
			end

			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_172_11 = 0

			if var_172_11 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				arg_169_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_12 = 0
			local var_172_13 = 0.35

			if var_172_12 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_14 = arg_169_1:FormatText(StoryNameCfg[640].name)

				arg_169_1.leftNameTxt_.text = var_172_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_15 = arg_169_1:GetWordFromCfg(319381040)
				local var_172_16 = arg_169_1:FormatText(var_172_15.content)

				arg_169_1.text_.text = var_172_16

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_17 = 14
				local var_172_18 = utf8.len(var_172_16)
				local var_172_19 = var_172_17 <= 0 and var_172_13 or var_172_13 * (var_172_18 / var_172_17)

				if var_172_19 > 0 and var_172_13 < var_172_19 then
					arg_169_1.talkMaxDuration = var_172_19

					if var_172_19 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_19 + var_172_12
					end
				end

				arg_169_1.text_.text = var_172_16
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381040", "story_v_out_319381.awb") ~= 0 then
					local var_172_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381040", "story_v_out_319381.awb") / 1000

					if var_172_20 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_20 + var_172_12
					end

					if var_172_15.prefab_name ~= "" and arg_169_1.actors_[var_172_15.prefab_name] ~= nil then
						local var_172_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_15.prefab_name].transform, "story_v_out_319381", "319381040", "story_v_out_319381.awb")

						arg_169_1:RecordAudio("319381040", var_172_21)
						arg_169_1:RecordAudio("319381040", var_172_21)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319381", "319381040", "story_v_out_319381.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319381", "319381040", "story_v_out_319381.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_22 = math.max(var_172_13, arg_169_1.talkMaxDuration)

			if var_172_12 <= arg_169_1.time_ and arg_169_1.time_ < var_172_12 + var_172_22 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_12) / var_172_22

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_12 + var_172_22 and arg_169_1.time_ < var_172_12 + var_172_22 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play319381041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319381041
		arg_173_1.duration_ = 5.73

		local var_173_0 = {
			zh = 2.566,
			ja = 5.733
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
				arg_173_0:Play319381042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1084ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1084ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(-0.7, -0.97, -6)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1084ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1084ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1084ui_story == nil then
				arg_173_1.var_.characterEffect1084ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect1084ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1084ui_story then
				arg_173_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_176_13 = arg_173_1.actors_["10066ui_story"]
			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 and not isNil(var_176_13) and arg_173_1.var_.characterEffect10066ui_story == nil then
				arg_173_1.var_.characterEffect10066ui_story = var_176_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_15 = 0.200000002980232

			if var_176_14 <= arg_173_1.time_ and arg_173_1.time_ < var_176_14 + var_176_15 and not isNil(var_176_13) then
				local var_176_16 = (arg_173_1.time_ - var_176_14) / var_176_15

				if arg_173_1.var_.characterEffect10066ui_story and not isNil(var_176_13) then
					local var_176_17 = Mathf.Lerp(0, 0.5, var_176_16)

					arg_173_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10066ui_story.fillRatio = var_176_17
				end
			end

			if arg_173_1.time_ >= var_176_14 + var_176_15 and arg_173_1.time_ < var_176_14 + var_176_15 + arg_176_0 and not isNil(var_176_13) and arg_173_1.var_.characterEffect10066ui_story then
				local var_176_18 = 0.5

				arg_173_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10066ui_story.fillRatio = var_176_18
			end

			local var_176_19 = 0
			local var_176_20 = 0.225

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_21 = arg_173_1:FormatText(StoryNameCfg[6].name)

				arg_173_1.leftNameTxt_.text = var_176_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_22 = arg_173_1:GetWordFromCfg(319381041)
				local var_176_23 = arg_173_1:FormatText(var_176_22.content)

				arg_173_1.text_.text = var_176_23

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_24 = 9
				local var_176_25 = utf8.len(var_176_23)
				local var_176_26 = var_176_24 <= 0 and var_176_20 or var_176_20 * (var_176_25 / var_176_24)

				if var_176_26 > 0 and var_176_20 < var_176_26 then
					arg_173_1.talkMaxDuration = var_176_26

					if var_176_26 + var_176_19 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_26 + var_176_19
					end
				end

				arg_173_1.text_.text = var_176_23
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381041", "story_v_out_319381.awb") ~= 0 then
					local var_176_27 = manager.audio:GetVoiceLength("story_v_out_319381", "319381041", "story_v_out_319381.awb") / 1000

					if var_176_27 + var_176_19 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_27 + var_176_19
					end

					if var_176_22.prefab_name ~= "" and arg_173_1.actors_[var_176_22.prefab_name] ~= nil then
						local var_176_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_22.prefab_name].transform, "story_v_out_319381", "319381041", "story_v_out_319381.awb")

						arg_173_1:RecordAudio("319381041", var_176_28)
						arg_173_1:RecordAudio("319381041", var_176_28)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319381", "319381041", "story_v_out_319381.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319381", "319381041", "story_v_out_319381.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_29 = math.max(var_176_20, arg_173_1.talkMaxDuration)

			if var_176_19 <= arg_173_1.time_ and arg_173_1.time_ < var_176_19 + var_176_29 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_19) / var_176_29

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_19 + var_176_29 and arg_173_1.time_ < var_176_19 + var_176_29 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play319381042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319381042
		arg_177_1.duration_ = 10.77

		local var_177_0 = {
			zh = 4.833,
			ja = 10.766
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
				arg_177_0:Play319381043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10066ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10066ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0.7, -0.99, -5.83)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10066ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["10066ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect10066ui_story == nil then
				arg_177_1.var_.characterEffect10066ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect10066ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect10066ui_story then
				arg_177_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_180_13 = arg_177_1.actors_["1084ui_story"]
			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 and not isNil(var_180_13) and arg_177_1.var_.characterEffect1084ui_story == nil then
				arg_177_1.var_.characterEffect1084ui_story = var_180_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_15 = 0.200000002980232

			if var_180_14 <= arg_177_1.time_ and arg_177_1.time_ < var_180_14 + var_180_15 and not isNil(var_180_13) then
				local var_180_16 = (arg_177_1.time_ - var_180_14) / var_180_15

				if arg_177_1.var_.characterEffect1084ui_story and not isNil(var_180_13) then
					local var_180_17 = Mathf.Lerp(0, 0.5, var_180_16)

					arg_177_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1084ui_story.fillRatio = var_180_17
				end
			end

			if arg_177_1.time_ >= var_180_14 + var_180_15 and arg_177_1.time_ < var_180_14 + var_180_15 + arg_180_0 and not isNil(var_180_13) and arg_177_1.var_.characterEffect1084ui_story then
				local var_180_18 = 0.5

				arg_177_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1084ui_story.fillRatio = var_180_18
			end

			local var_180_19 = 0
			local var_180_20 = 0.525

			if var_180_19 < arg_177_1.time_ and arg_177_1.time_ <= var_180_19 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_21 = arg_177_1:FormatText(StoryNameCfg[640].name)

				arg_177_1.leftNameTxt_.text = var_180_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_22 = arg_177_1:GetWordFromCfg(319381042)
				local var_180_23 = arg_177_1:FormatText(var_180_22.content)

				arg_177_1.text_.text = var_180_23

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_24 = 21
				local var_180_25 = utf8.len(var_180_23)
				local var_180_26 = var_180_24 <= 0 and var_180_20 or var_180_20 * (var_180_25 / var_180_24)

				if var_180_26 > 0 and var_180_20 < var_180_26 then
					arg_177_1.talkMaxDuration = var_180_26

					if var_180_26 + var_180_19 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_26 + var_180_19
					end
				end

				arg_177_1.text_.text = var_180_23
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381042", "story_v_out_319381.awb") ~= 0 then
					local var_180_27 = manager.audio:GetVoiceLength("story_v_out_319381", "319381042", "story_v_out_319381.awb") / 1000

					if var_180_27 + var_180_19 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_27 + var_180_19
					end

					if var_180_22.prefab_name ~= "" and arg_177_1.actors_[var_180_22.prefab_name] ~= nil then
						local var_180_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_22.prefab_name].transform, "story_v_out_319381", "319381042", "story_v_out_319381.awb")

						arg_177_1:RecordAudio("319381042", var_180_28)
						arg_177_1:RecordAudio("319381042", var_180_28)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319381", "319381042", "story_v_out_319381.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319381", "319381042", "story_v_out_319381.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_29 = math.max(var_180_20, arg_177_1.talkMaxDuration)

			if var_180_19 <= arg_177_1.time_ and arg_177_1.time_ < var_180_19 + var_180_29 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_19) / var_180_29

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_19 + var_180_29 and arg_177_1.time_ < var_180_19 + var_180_29 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play319381043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319381043
		arg_181_1.duration_ = 14.07

		local var_181_0 = {
			zh = 7.5,
			ja = 14.066
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
				arg_181_0:Play319381044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_184_2 = 0
			local var_184_3 = 0.775

			if var_184_2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_4 = arg_181_1:FormatText(StoryNameCfg[640].name)

				arg_181_1.leftNameTxt_.text = var_184_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_5 = arg_181_1:GetWordFromCfg(319381043)
				local var_184_6 = arg_181_1:FormatText(var_184_5.content)

				arg_181_1.text_.text = var_184_6

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 31
				local var_184_8 = utf8.len(var_184_6)
				local var_184_9 = var_184_7 <= 0 and var_184_3 or var_184_3 * (var_184_8 / var_184_7)

				if var_184_9 > 0 and var_184_3 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_6
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381043", "story_v_out_319381.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_319381", "319381043", "story_v_out_319381.awb") / 1000

					if var_184_10 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_2
					end

					if var_184_5.prefab_name ~= "" and arg_181_1.actors_[var_184_5.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_5.prefab_name].transform, "story_v_out_319381", "319381043", "story_v_out_319381.awb")

						arg_181_1:RecordAudio("319381043", var_184_11)
						arg_181_1:RecordAudio("319381043", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_319381", "319381043", "story_v_out_319381.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_319381", "319381043", "story_v_out_319381.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_12 and arg_181_1.time_ < var_184_2 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play319381044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319381044
		arg_185_1.duration_ = 7.3

		local var_185_0 = {
			zh = 4.166,
			ja = 7.3
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
				arg_185_0:Play319381045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10066ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect10066ui_story == nil then
				arg_185_1.var_.characterEffect10066ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect10066ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10066ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect10066ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10066ui_story.fillRatio = var_188_5
			end

			local var_188_6 = arg_185_1.actors_["1084ui_story"]
			local var_188_7 = 0

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_8 = 0.200000002980232

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_8 and not isNil(var_188_6) then
				local var_188_9 = (arg_185_1.time_ - var_188_7) / var_188_8

				if arg_185_1.var_.characterEffect1084ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_7 + var_188_8 and arg_185_1.time_ < var_188_7 + var_188_8 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1084ui_story then
				arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_188_11 = 0

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_12 = 0
			local var_188_13 = 0.425

			if var_188_12 < arg_185_1.time_ and arg_185_1.time_ <= var_188_12 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_14 = arg_185_1:FormatText(StoryNameCfg[6].name)

				arg_185_1.leftNameTxt_.text = var_188_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_15 = arg_185_1:GetWordFromCfg(319381044)
				local var_188_16 = arg_185_1:FormatText(var_188_15.content)

				arg_185_1.text_.text = var_188_16

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_17 = 17
				local var_188_18 = utf8.len(var_188_16)
				local var_188_19 = var_188_17 <= 0 and var_188_13 or var_188_13 * (var_188_18 / var_188_17)

				if var_188_19 > 0 and var_188_13 < var_188_19 then
					arg_185_1.talkMaxDuration = var_188_19

					if var_188_19 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_19 + var_188_12
					end
				end

				arg_185_1.text_.text = var_188_16
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381044", "story_v_out_319381.awb") ~= 0 then
					local var_188_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381044", "story_v_out_319381.awb") / 1000

					if var_188_20 + var_188_12 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_20 + var_188_12
					end

					if var_188_15.prefab_name ~= "" and arg_185_1.actors_[var_188_15.prefab_name] ~= nil then
						local var_188_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_15.prefab_name].transform, "story_v_out_319381", "319381044", "story_v_out_319381.awb")

						arg_185_1:RecordAudio("319381044", var_188_21)
						arg_185_1:RecordAudio("319381044", var_188_21)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319381", "319381044", "story_v_out_319381.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319381", "319381044", "story_v_out_319381.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_22 = math.max(var_188_13, arg_185_1.talkMaxDuration)

			if var_188_12 <= arg_185_1.time_ and arg_185_1.time_ < var_188_12 + var_188_22 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_12) / var_188_22

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_12 + var_188_22 and arg_185_1.time_ < var_188_12 + var_188_22 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play319381045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319381045
		arg_189_1.duration_ = 2.27

		local var_189_0 = {
			zh = 1.433,
			ja = 2.266
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
				arg_189_0:Play319381046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10066ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10066ui_story == nil then
				arg_189_1.var_.characterEffect10066ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect10066ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10066ui_story then
				arg_189_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_192_4 = arg_189_1.actors_["1084ui_story"]
			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1084ui_story == nil then
				arg_189_1.var_.characterEffect1084ui_story = var_192_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.200000002980232

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 and not isNil(var_192_4) then
				local var_192_7 = (arg_189_1.time_ - var_192_5) / var_192_6

				if arg_189_1.var_.characterEffect1084ui_story and not isNil(var_192_4) then
					local var_192_8 = Mathf.Lerp(0, 0.5, var_192_7)

					arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1084ui_story.fillRatio = var_192_8
				end
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1084ui_story then
				local var_192_9 = 0.5

				arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1084ui_story.fillRatio = var_192_9
			end

			local var_192_10 = 0
			local var_192_11 = 0.075

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_12 = arg_189_1:FormatText(StoryNameCfg[640].name)

				arg_189_1.leftNameTxt_.text = var_192_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_13 = arg_189_1:GetWordFromCfg(319381045)
				local var_192_14 = arg_189_1:FormatText(var_192_13.content)

				arg_189_1.text_.text = var_192_14

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_15 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381045", "story_v_out_319381.awb") ~= 0 then
					local var_192_18 = manager.audio:GetVoiceLength("story_v_out_319381", "319381045", "story_v_out_319381.awb") / 1000

					if var_192_18 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_18 + var_192_10
					end

					if var_192_13.prefab_name ~= "" and arg_189_1.actors_[var_192_13.prefab_name] ~= nil then
						local var_192_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_13.prefab_name].transform, "story_v_out_319381", "319381045", "story_v_out_319381.awb")

						arg_189_1:RecordAudio("319381045", var_192_19)
						arg_189_1:RecordAudio("319381045", var_192_19)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_319381", "319381045", "story_v_out_319381.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_319381", "319381045", "story_v_out_319381.awb")
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
	Play319381046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319381046
		arg_193_1.duration_ = 3.2

		local var_193_0 = {
			zh = 2.3,
			ja = 3.2
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
				arg_193_0:Play319381047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1084ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1084ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(-0.7, -0.97, -6)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1084ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["10066ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect10066ui_story == nil then
				arg_193_1.var_.characterEffect10066ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect10066ui_story and not isNil(var_196_9) then
					local var_196_13 = Mathf.Lerp(0, 0.5, var_196_12)

					arg_193_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10066ui_story.fillRatio = var_196_13
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect10066ui_story then
				local var_196_14 = 0.5

				arg_193_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10066ui_story.fillRatio = var_196_14
			end

			local var_196_15 = arg_193_1.actors_["1084ui_story"]
			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.characterEffect1084ui_story == nil then
				arg_193_1.var_.characterEffect1084ui_story = var_196_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_17 = 0.200000002980232

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 and not isNil(var_196_15) then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17

				if arg_193_1.var_.characterEffect1084ui_story and not isNil(var_196_15) then
					arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.characterEffect1084ui_story then
				arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_196_19 = 0
			local var_196_20 = 0.225

			if var_196_19 < arg_193_1.time_ and arg_193_1.time_ <= var_196_19 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_21 = arg_193_1:FormatText(StoryNameCfg[6].name)

				arg_193_1.leftNameTxt_.text = var_196_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_22 = arg_193_1:GetWordFromCfg(319381046)
				local var_196_23 = arg_193_1:FormatText(var_196_22.content)

				arg_193_1.text_.text = var_196_23

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_24 = 9
				local var_196_25 = utf8.len(var_196_23)
				local var_196_26 = var_196_24 <= 0 and var_196_20 or var_196_20 * (var_196_25 / var_196_24)

				if var_196_26 > 0 and var_196_20 < var_196_26 then
					arg_193_1.talkMaxDuration = var_196_26

					if var_196_26 + var_196_19 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_26 + var_196_19
					end
				end

				arg_193_1.text_.text = var_196_23
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381046", "story_v_out_319381.awb") ~= 0 then
					local var_196_27 = manager.audio:GetVoiceLength("story_v_out_319381", "319381046", "story_v_out_319381.awb") / 1000

					if var_196_27 + var_196_19 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_27 + var_196_19
					end

					if var_196_22.prefab_name ~= "" and arg_193_1.actors_[var_196_22.prefab_name] ~= nil then
						local var_196_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_22.prefab_name].transform, "story_v_out_319381", "319381046", "story_v_out_319381.awb")

						arg_193_1:RecordAudio("319381046", var_196_28)
						arg_193_1:RecordAudio("319381046", var_196_28)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319381", "319381046", "story_v_out_319381.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319381", "319381046", "story_v_out_319381.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_29 = math.max(var_196_20, arg_193_1.talkMaxDuration)

			if var_196_19 <= arg_193_1.time_ and arg_193_1.time_ < var_196_19 + var_196_29 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_19) / var_196_29

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_19 + var_196_29 and arg_193_1.time_ < var_196_19 + var_196_29 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play319381047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319381047
		arg_197_1.duration_ = 5.23

		local var_197_0 = {
			zh = 2,
			ja = 5.233
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
				arg_197_0:Play319381048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10066ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10066ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0.7, -0.99, -5.83)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10066ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["10066ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect10066ui_story == nil then
				arg_197_1.var_.characterEffect10066ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect10066ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect10066ui_story then
				arg_197_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_200_15 = arg_197_1.actors_["1084ui_story"]
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.characterEffect1084ui_story == nil then
				arg_197_1.var_.characterEffect1084ui_story = var_200_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_17 = 0.200000002980232

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 and not isNil(var_200_15) then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17

				if arg_197_1.var_.characterEffect1084ui_story and not isNil(var_200_15) then
					local var_200_19 = Mathf.Lerp(0, 0.5, var_200_18)

					arg_197_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1084ui_story.fillRatio = var_200_19
				end
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.characterEffect1084ui_story then
				local var_200_20 = 0.5

				arg_197_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1084ui_story.fillRatio = var_200_20
			end

			local var_200_21 = 0
			local var_200_22 = 0.2

			if var_200_21 < arg_197_1.time_ and arg_197_1.time_ <= var_200_21 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_23 = arg_197_1:FormatText(StoryNameCfg[640].name)

				arg_197_1.leftNameTxt_.text = var_200_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_24 = arg_197_1:GetWordFromCfg(319381047)
				local var_200_25 = arg_197_1:FormatText(var_200_24.content)

				arg_197_1.text_.text = var_200_25

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_26 = 8
				local var_200_27 = utf8.len(var_200_25)
				local var_200_28 = var_200_26 <= 0 and var_200_22 or var_200_22 * (var_200_27 / var_200_26)

				if var_200_28 > 0 and var_200_22 < var_200_28 then
					arg_197_1.talkMaxDuration = var_200_28

					if var_200_28 + var_200_21 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_28 + var_200_21
					end
				end

				arg_197_1.text_.text = var_200_25
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381047", "story_v_out_319381.awb") ~= 0 then
					local var_200_29 = manager.audio:GetVoiceLength("story_v_out_319381", "319381047", "story_v_out_319381.awb") / 1000

					if var_200_29 + var_200_21 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_29 + var_200_21
					end

					if var_200_24.prefab_name ~= "" and arg_197_1.actors_[var_200_24.prefab_name] ~= nil then
						local var_200_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_24.prefab_name].transform, "story_v_out_319381", "319381047", "story_v_out_319381.awb")

						arg_197_1:RecordAudio("319381047", var_200_30)
						arg_197_1:RecordAudio("319381047", var_200_30)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_319381", "319381047", "story_v_out_319381.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_319381", "319381047", "story_v_out_319381.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_31 = math.max(var_200_22, arg_197_1.talkMaxDuration)

			if var_200_21 <= arg_197_1.time_ and arg_197_1.time_ < var_200_21 + var_200_31 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_21) / var_200_31

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_21 + var_200_31 and arg_197_1.time_ < var_200_21 + var_200_31 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
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

		arg_197_1:InitPlayNodeList()
	end,
	Play319381048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319381048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play319381049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10066ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect10066ui_story == nil then
				arg_201_1.var_.characterEffect10066ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect10066ui_story and not isNil(var_204_0) then
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10066ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect10066ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10066ui_story.fillRatio = var_204_5
			end

			local var_204_6 = 0
			local var_204_7 = 1.125

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:GetWordFromCfg(319381048)
				local var_204_9 = arg_201_1:FormatText(var_204_8.content)

				arg_201_1.text_.text = var_204_9

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 45
				local var_204_11 = utf8.len(var_204_9)
				local var_204_12 = var_204_10 <= 0 and var_204_7 or var_204_7 * (var_204_11 / var_204_10)

				if var_204_12 > 0 and var_204_7 < var_204_12 then
					arg_201_1.talkMaxDuration = var_204_12

					if var_204_12 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_9
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_13 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_13 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_13

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_13 and arg_201_1.time_ < var_204_6 + var_204_13 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play319381049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319381049
		arg_205_1.duration_ = 14.23

		local var_205_0 = {
			zh = 11.366,
			ja = 14.233
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
				arg_205_0:Play319381050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10066ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect10066ui_story == nil then
				arg_205_1.var_.characterEffect10066ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect10066ui_story and not isNil(var_208_0) then
					arg_205_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect10066ui_story then
				arg_205_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_208_4 = 0
			local var_208_5 = 1.325

			if var_208_4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_6 = arg_205_1:FormatText(StoryNameCfg[640].name)

				arg_205_1.leftNameTxt_.text = var_208_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:GetWordFromCfg(319381049)
				local var_208_8 = arg_205_1:FormatText(var_208_7.content)

				arg_205_1.text_.text = var_208_8

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 53
				local var_208_10 = utf8.len(var_208_8)
				local var_208_11 = var_208_9 <= 0 and var_208_5 or var_208_5 * (var_208_10 / var_208_9)

				if var_208_11 > 0 and var_208_5 < var_208_11 then
					arg_205_1.talkMaxDuration = var_208_11

					if var_208_11 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_8
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381049", "story_v_out_319381.awb") ~= 0 then
					local var_208_12 = manager.audio:GetVoiceLength("story_v_out_319381", "319381049", "story_v_out_319381.awb") / 1000

					if var_208_12 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_4
					end

					if var_208_7.prefab_name ~= "" and arg_205_1.actors_[var_208_7.prefab_name] ~= nil then
						local var_208_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_7.prefab_name].transform, "story_v_out_319381", "319381049", "story_v_out_319381.awb")

						arg_205_1:RecordAudio("319381049", var_208_13)
						arg_205_1:RecordAudio("319381049", var_208_13)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_319381", "319381049", "story_v_out_319381.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_319381", "319381049", "story_v_out_319381.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_14 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_14 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_14

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_14 and arg_205_1.time_ < var_208_4 + var_208_14 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play319381050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319381050
		arg_209_1.duration_ = 16.1

		local var_209_0 = {
			zh = 9.433,
			ja = 16.1
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
				arg_209_0:Play319381051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.075

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[640].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:GetWordFromCfg(319381050)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381050", "story_v_out_319381.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_319381", "319381050", "story_v_out_319381.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_319381", "319381050", "story_v_out_319381.awb")

						arg_209_1:RecordAudio("319381050", var_212_9)
						arg_209_1:RecordAudio("319381050", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_319381", "319381050", "story_v_out_319381.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_319381", "319381050", "story_v_out_319381.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_10 and arg_209_1.time_ < var_212_0 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play319381051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319381051
		arg_213_1.duration_ = 15.33

		local var_213_0 = {
			zh = 7.9,
			ja = 15.333
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
				arg_213_0:Play319381052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1084ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1084ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(-0.7, -0.97, -6)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1084ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 then
				arg_213_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_216_11 = 0
			local var_216_12 = 0.85

			if var_216_11 < arg_213_1.time_ and arg_213_1.time_ <= var_216_11 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_13 = arg_213_1:FormatText(StoryNameCfg[640].name)

				arg_213_1.leftNameTxt_.text = var_216_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_14 = arg_213_1:GetWordFromCfg(319381051)
				local var_216_15 = arg_213_1:FormatText(var_216_14.content)

				arg_213_1.text_.text = var_216_15

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_16 = 34
				local var_216_17 = utf8.len(var_216_15)
				local var_216_18 = var_216_16 <= 0 and var_216_12 or var_216_12 * (var_216_17 / var_216_16)

				if var_216_18 > 0 and var_216_12 < var_216_18 then
					arg_213_1.talkMaxDuration = var_216_18

					if var_216_18 + var_216_11 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_18 + var_216_11
					end
				end

				arg_213_1.text_.text = var_216_15
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381051", "story_v_out_319381.awb") ~= 0 then
					local var_216_19 = manager.audio:GetVoiceLength("story_v_out_319381", "319381051", "story_v_out_319381.awb") / 1000

					if var_216_19 + var_216_11 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_19 + var_216_11
					end

					if var_216_14.prefab_name ~= "" and arg_213_1.actors_[var_216_14.prefab_name] ~= nil then
						local var_216_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_14.prefab_name].transform, "story_v_out_319381", "319381051", "story_v_out_319381.awb")

						arg_213_1:RecordAudio("319381051", var_216_20)
						arg_213_1:RecordAudio("319381051", var_216_20)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_319381", "319381051", "story_v_out_319381.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_319381", "319381051", "story_v_out_319381.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_21 = math.max(var_216_12, arg_213_1.talkMaxDuration)

			if var_216_11 <= arg_213_1.time_ and arg_213_1.time_ < var_216_11 + var_216_21 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_11) / var_216_21

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_11 + var_216_21 and arg_213_1.time_ < var_216_11 + var_216_21 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play319381052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319381052
		arg_217_1.duration_ = 2.57

		local var_217_0 = {
			zh = 2.066,
			ja = 2.566
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
				arg_217_0:Play319381053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10066ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10066ui_story == nil then
				arg_217_1.var_.characterEffect10066ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect10066ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10066ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10066ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10066ui_story.fillRatio = var_220_5
			end

			local var_220_6 = arg_217_1.actors_["1084ui_story"]
			local var_220_7 = 0

			if var_220_7 < arg_217_1.time_ and arg_217_1.time_ <= var_220_7 + arg_220_0 and not isNil(var_220_6) and arg_217_1.var_.characterEffect1084ui_story == nil then
				arg_217_1.var_.characterEffect1084ui_story = var_220_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_8 = 0.200000002980232

			if var_220_7 <= arg_217_1.time_ and arg_217_1.time_ < var_220_7 + var_220_8 and not isNil(var_220_6) then
				local var_220_9 = (arg_217_1.time_ - var_220_7) / var_220_8

				if arg_217_1.var_.characterEffect1084ui_story and not isNil(var_220_6) then
					arg_217_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_7 + var_220_8 and arg_217_1.time_ < var_220_7 + var_220_8 + arg_220_0 and not isNil(var_220_6) and arg_217_1.var_.characterEffect1084ui_story then
				arg_217_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 then
				arg_217_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4124")
			end

			local var_220_11 = 0

			if var_220_11 < arg_217_1.time_ and arg_217_1.time_ <= var_220_11 + arg_220_0 then
				arg_217_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_220_12 = 0
			local var_220_13 = 0.125

			if var_220_12 < arg_217_1.time_ and arg_217_1.time_ <= var_220_12 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_14 = arg_217_1:FormatText(StoryNameCfg[6].name)

				arg_217_1.leftNameTxt_.text = var_220_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_15 = arg_217_1:GetWordFromCfg(319381052)
				local var_220_16 = arg_217_1:FormatText(var_220_15.content)

				arg_217_1.text_.text = var_220_16

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_17 = 5
				local var_220_18 = utf8.len(var_220_16)
				local var_220_19 = var_220_17 <= 0 and var_220_13 or var_220_13 * (var_220_18 / var_220_17)

				if var_220_19 > 0 and var_220_13 < var_220_19 then
					arg_217_1.talkMaxDuration = var_220_19

					if var_220_19 + var_220_12 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_19 + var_220_12
					end
				end

				arg_217_1.text_.text = var_220_16
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381052", "story_v_out_319381.awb") ~= 0 then
					local var_220_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381052", "story_v_out_319381.awb") / 1000

					if var_220_20 + var_220_12 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_20 + var_220_12
					end

					if var_220_15.prefab_name ~= "" and arg_217_1.actors_[var_220_15.prefab_name] ~= nil then
						local var_220_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_15.prefab_name].transform, "story_v_out_319381", "319381052", "story_v_out_319381.awb")

						arg_217_1:RecordAudio("319381052", var_220_21)
						arg_217_1:RecordAudio("319381052", var_220_21)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_319381", "319381052", "story_v_out_319381.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_319381", "319381052", "story_v_out_319381.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_22 = math.max(var_220_13, arg_217_1.talkMaxDuration)

			if var_220_12 <= arg_217_1.time_ and arg_217_1.time_ < var_220_12 + var_220_22 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_12) / var_220_22

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_12 + var_220_22 and arg_217_1.time_ < var_220_12 + var_220_22 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319381053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319381053
		arg_221_1.duration_ = 3.27

		local var_221_0 = {
			zh = 2.566,
			ja = 3.266
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
				arg_221_0:Play319381054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10066ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10066ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0.7, -0.99, -5.83)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10066ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["10066ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect10066ui_story == nil then
				arg_221_1.var_.characterEffect10066ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect10066ui_story and not isNil(var_224_9) then
					arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect10066ui_story then
				arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_224_13 = 0

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_224_15 = arg_221_1.actors_["1084ui_story"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.characterEffect1084ui_story == nil then
				arg_221_1.var_.characterEffect1084ui_story = var_224_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_17 = 0.200000002980232

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 and not isNil(var_224_15) then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17

				if arg_221_1.var_.characterEffect1084ui_story and not isNil(var_224_15) then
					local var_224_19 = Mathf.Lerp(0, 0.5, var_224_18)

					arg_221_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1084ui_story.fillRatio = var_224_19
				end
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.characterEffect1084ui_story then
				local var_224_20 = 0.5

				arg_221_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1084ui_story.fillRatio = var_224_20
			end

			local var_224_21 = 0
			local var_224_22 = 0.15

			if var_224_21 < arg_221_1.time_ and arg_221_1.time_ <= var_224_21 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_23 = arg_221_1:FormatText(StoryNameCfg[640].name)

				arg_221_1.leftNameTxt_.text = var_224_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_24 = arg_221_1:GetWordFromCfg(319381053)
				local var_224_25 = arg_221_1:FormatText(var_224_24.content)

				arg_221_1.text_.text = var_224_25

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_26 = 6
				local var_224_27 = utf8.len(var_224_25)
				local var_224_28 = var_224_26 <= 0 and var_224_22 or var_224_22 * (var_224_27 / var_224_26)

				if var_224_28 > 0 and var_224_22 < var_224_28 then
					arg_221_1.talkMaxDuration = var_224_28

					if var_224_28 + var_224_21 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_28 + var_224_21
					end
				end

				arg_221_1.text_.text = var_224_25
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381053", "story_v_out_319381.awb") ~= 0 then
					local var_224_29 = manager.audio:GetVoiceLength("story_v_out_319381", "319381053", "story_v_out_319381.awb") / 1000

					if var_224_29 + var_224_21 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_29 + var_224_21
					end

					if var_224_24.prefab_name ~= "" and arg_221_1.actors_[var_224_24.prefab_name] ~= nil then
						local var_224_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_24.prefab_name].transform, "story_v_out_319381", "319381053", "story_v_out_319381.awb")

						arg_221_1:RecordAudio("319381053", var_224_30)
						arg_221_1:RecordAudio("319381053", var_224_30)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_319381", "319381053", "story_v_out_319381.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_319381", "319381053", "story_v_out_319381.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_31 = math.max(var_224_22, arg_221_1.talkMaxDuration)

			if var_224_21 <= arg_221_1.time_ and arg_221_1.time_ < var_224_21 + var_224_31 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_21) / var_224_31

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_21 + var_224_31 and arg_221_1.time_ < var_224_21 + var_224_31 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play319381054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319381054
		arg_225_1.duration_ = 7.1

		local var_225_0 = {
			zh = 4.2,
			ja = 7.1
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
				arg_225_0:Play319381055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10066ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect10066ui_story == nil then
				arg_225_1.var_.characterEffect10066ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect10066ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10066ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect10066ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10066ui_story.fillRatio = var_228_5
			end

			local var_228_6 = arg_225_1.actors_["1084ui_story"]
			local var_228_7 = 0

			if var_228_7 < arg_225_1.time_ and arg_225_1.time_ <= var_228_7 + arg_228_0 and not isNil(var_228_6) and arg_225_1.var_.characterEffect1084ui_story == nil then
				arg_225_1.var_.characterEffect1084ui_story = var_228_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_8 = 0.200000002980232

			if var_228_7 <= arg_225_1.time_ and arg_225_1.time_ < var_228_7 + var_228_8 and not isNil(var_228_6) then
				local var_228_9 = (arg_225_1.time_ - var_228_7) / var_228_8

				if arg_225_1.var_.characterEffect1084ui_story and not isNil(var_228_6) then
					arg_225_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_7 + var_228_8 and arg_225_1.time_ < var_228_7 + var_228_8 + arg_228_0 and not isNil(var_228_6) and arg_225_1.var_.characterEffect1084ui_story then
				arg_225_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 then
				arg_225_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_228_11 = 0

			if var_228_11 < arg_225_1.time_ and arg_225_1.time_ <= var_228_11 + arg_228_0 then
				arg_225_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_228_12 = 0
			local var_228_13 = 0.425

			if var_228_12 < arg_225_1.time_ and arg_225_1.time_ <= var_228_12 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_14 = arg_225_1:FormatText(StoryNameCfg[6].name)

				arg_225_1.leftNameTxt_.text = var_228_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_15 = arg_225_1:GetWordFromCfg(319381054)
				local var_228_16 = arg_225_1:FormatText(var_228_15.content)

				arg_225_1.text_.text = var_228_16

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_17 = 17
				local var_228_18 = utf8.len(var_228_16)
				local var_228_19 = var_228_17 <= 0 and var_228_13 or var_228_13 * (var_228_18 / var_228_17)

				if var_228_19 > 0 and var_228_13 < var_228_19 then
					arg_225_1.talkMaxDuration = var_228_19

					if var_228_19 + var_228_12 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_19 + var_228_12
					end
				end

				arg_225_1.text_.text = var_228_16
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381054", "story_v_out_319381.awb") ~= 0 then
					local var_228_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381054", "story_v_out_319381.awb") / 1000

					if var_228_20 + var_228_12 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_20 + var_228_12
					end

					if var_228_15.prefab_name ~= "" and arg_225_1.actors_[var_228_15.prefab_name] ~= nil then
						local var_228_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_15.prefab_name].transform, "story_v_out_319381", "319381054", "story_v_out_319381.awb")

						arg_225_1:RecordAudio("319381054", var_228_21)
						arg_225_1:RecordAudio("319381054", var_228_21)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_319381", "319381054", "story_v_out_319381.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_319381", "319381054", "story_v_out_319381.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_22 = math.max(var_228_13, arg_225_1.talkMaxDuration)

			if var_228_12 <= arg_225_1.time_ and arg_225_1.time_ < var_228_12 + var_228_22 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_12) / var_228_22

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_12 + var_228_22 and arg_225_1.time_ < var_228_12 + var_228_22 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play319381055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319381055
		arg_229_1.duration_ = 5.9

		local var_229_0 = {
			zh = 5.533,
			ja = 5.9
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
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play319381056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_232_1 = 0
			local var_232_2 = 0.55

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_3 = arg_229_1:FormatText(StoryNameCfg[6].name)

				arg_229_1.leftNameTxt_.text = var_232_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(319381055)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_6 = 22
				local var_232_7 = utf8.len(var_232_5)
				local var_232_8 = var_232_6 <= 0 and var_232_2 or var_232_2 * (var_232_7 / var_232_6)

				if var_232_8 > 0 and var_232_2 < var_232_8 then
					arg_229_1.talkMaxDuration = var_232_8

					if var_232_8 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381055", "story_v_out_319381.awb") ~= 0 then
					local var_232_9 = manager.audio:GetVoiceLength("story_v_out_319381", "319381055", "story_v_out_319381.awb") / 1000

					if var_232_9 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_1
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_out_319381", "319381055", "story_v_out_319381.awb")

						arg_229_1:RecordAudio("319381055", var_232_10)
						arg_229_1:RecordAudio("319381055", var_232_10)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319381", "319381055", "story_v_out_319381.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319381", "319381055", "story_v_out_319381.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_11 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_11 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_11

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_11 and arg_229_1.time_ < var_232_1 + var_232_11 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play319381056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 319381056
		arg_233_1.duration_ = 6.63

		local var_233_0 = {
			zh = 4.166,
			ja = 6.633
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
				arg_233_0:Play319381057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10066ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10066ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0.7, -0.99, -5.83)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10066ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["10066ui_story"]
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect10066ui_story == nil then
				arg_233_1.var_.characterEffect10066ui_story = var_236_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_11 = 0.200000002980232

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 and not isNil(var_236_9) then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11

				if arg_233_1.var_.characterEffect10066ui_story and not isNil(var_236_9) then
					arg_233_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect10066ui_story then
				arg_233_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_236_13 = arg_233_1.actors_["1084ui_story"]
			local var_236_14 = 0

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 and not isNil(var_236_13) and arg_233_1.var_.characterEffect1084ui_story == nil then
				arg_233_1.var_.characterEffect1084ui_story = var_236_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_15 = 0.200000002980232

			if var_236_14 <= arg_233_1.time_ and arg_233_1.time_ < var_236_14 + var_236_15 and not isNil(var_236_13) then
				local var_236_16 = (arg_233_1.time_ - var_236_14) / var_236_15

				if arg_233_1.var_.characterEffect1084ui_story and not isNil(var_236_13) then
					local var_236_17 = Mathf.Lerp(0, 0.5, var_236_16)

					arg_233_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1084ui_story.fillRatio = var_236_17
				end
			end

			if arg_233_1.time_ >= var_236_14 + var_236_15 and arg_233_1.time_ < var_236_14 + var_236_15 + arg_236_0 and not isNil(var_236_13) and arg_233_1.var_.characterEffect1084ui_story then
				local var_236_18 = 0.5

				arg_233_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1084ui_story.fillRatio = var_236_18
			end

			local var_236_19 = 0

			if var_236_19 < arg_233_1.time_ and arg_233_1.time_ <= var_236_19 + arg_236_0 then
				arg_233_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_2")
			end

			local var_236_20 = 0

			if var_236_20 < arg_233_1.time_ and arg_233_1.time_ <= var_236_20 + arg_236_0 then
				arg_233_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_236_21 = 0
			local var_236_22 = 0.45

			if var_236_21 < arg_233_1.time_ and arg_233_1.time_ <= var_236_21 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_23 = arg_233_1:FormatText(StoryNameCfg[640].name)

				arg_233_1.leftNameTxt_.text = var_236_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_24 = arg_233_1:GetWordFromCfg(319381056)
				local var_236_25 = arg_233_1:FormatText(var_236_24.content)

				arg_233_1.text_.text = var_236_25

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_26 = 18
				local var_236_27 = utf8.len(var_236_25)
				local var_236_28 = var_236_26 <= 0 and var_236_22 or var_236_22 * (var_236_27 / var_236_26)

				if var_236_28 > 0 and var_236_22 < var_236_28 then
					arg_233_1.talkMaxDuration = var_236_28

					if var_236_28 + var_236_21 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_28 + var_236_21
					end
				end

				arg_233_1.text_.text = var_236_25
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381056", "story_v_out_319381.awb") ~= 0 then
					local var_236_29 = manager.audio:GetVoiceLength("story_v_out_319381", "319381056", "story_v_out_319381.awb") / 1000

					if var_236_29 + var_236_21 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_29 + var_236_21
					end

					if var_236_24.prefab_name ~= "" and arg_233_1.actors_[var_236_24.prefab_name] ~= nil then
						local var_236_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_24.prefab_name].transform, "story_v_out_319381", "319381056", "story_v_out_319381.awb")

						arg_233_1:RecordAudio("319381056", var_236_30)
						arg_233_1:RecordAudio("319381056", var_236_30)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_319381", "319381056", "story_v_out_319381.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_319381", "319381056", "story_v_out_319381.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_31 = math.max(var_236_22, arg_233_1.talkMaxDuration)

			if var_236_21 <= arg_233_1.time_ and arg_233_1.time_ < var_236_21 + var_236_31 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_21) / var_236_31

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_21 + var_236_31 and arg_233_1.time_ < var_236_21 + var_236_31 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play319381057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 319381057
		arg_237_1.duration_ = 11.5

		local var_237_0 = {
			zh = 5.966,
			ja = 11.5
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play319381058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10066ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10066ui_story == nil then
				arg_237_1.var_.characterEffect10066ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect10066ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10066ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect10066ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10066ui_story.fillRatio = var_240_5
			end

			local var_240_6 = arg_237_1.actors_["1084ui_story"]
			local var_240_7 = 0

			if var_240_7 < arg_237_1.time_ and arg_237_1.time_ <= var_240_7 + arg_240_0 and not isNil(var_240_6) and arg_237_1.var_.characterEffect1084ui_story == nil then
				arg_237_1.var_.characterEffect1084ui_story = var_240_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_8 = 0.200000002980232

			if var_240_7 <= arg_237_1.time_ and arg_237_1.time_ < var_240_7 + var_240_8 and not isNil(var_240_6) then
				local var_240_9 = (arg_237_1.time_ - var_240_7) / var_240_8

				if arg_237_1.var_.characterEffect1084ui_story and not isNil(var_240_6) then
					arg_237_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_7 + var_240_8 and arg_237_1.time_ < var_240_7 + var_240_8 + arg_240_0 and not isNil(var_240_6) and arg_237_1.var_.characterEffect1084ui_story then
				arg_237_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_240_10 = 0
			local var_240_11 = 0.6

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_12 = arg_237_1:FormatText(StoryNameCfg[6].name)

				arg_237_1.leftNameTxt_.text = var_240_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_13 = arg_237_1:GetWordFromCfg(319381057)
				local var_240_14 = arg_237_1:FormatText(var_240_13.content)

				arg_237_1.text_.text = var_240_14

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_15 = 24
				local var_240_16 = utf8.len(var_240_14)
				local var_240_17 = var_240_15 <= 0 and var_240_11 or var_240_11 * (var_240_16 / var_240_15)

				if var_240_17 > 0 and var_240_11 < var_240_17 then
					arg_237_1.talkMaxDuration = var_240_17

					if var_240_17 + var_240_10 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_17 + var_240_10
					end
				end

				arg_237_1.text_.text = var_240_14
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381057", "story_v_out_319381.awb") ~= 0 then
					local var_240_18 = manager.audio:GetVoiceLength("story_v_out_319381", "319381057", "story_v_out_319381.awb") / 1000

					if var_240_18 + var_240_10 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_18 + var_240_10
					end

					if var_240_13.prefab_name ~= "" and arg_237_1.actors_[var_240_13.prefab_name] ~= nil then
						local var_240_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_13.prefab_name].transform, "story_v_out_319381", "319381057", "story_v_out_319381.awb")

						arg_237_1:RecordAudio("319381057", var_240_19)
						arg_237_1:RecordAudio("319381057", var_240_19)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_319381", "319381057", "story_v_out_319381.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_319381", "319381057", "story_v_out_319381.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_20 = math.max(var_240_11, arg_237_1.talkMaxDuration)

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_20 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_10) / var_240_20

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_10 + var_240_20 and arg_237_1.time_ < var_240_10 + var_240_20 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play319381058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 319381058
		arg_241_1.duration_ = 12.3

		local var_241_0 = {
			zh = 6.7,
			ja = 12.3
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play319381059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10066ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect10066ui_story == nil then
				arg_241_1.var_.characterEffect10066ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect10066ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect10066ui_story then
				arg_241_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_244_4 = arg_241_1.actors_["1084ui_story"]
			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect1084ui_story == nil then
				arg_241_1.var_.characterEffect1084ui_story = var_244_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_6 = 0.200000002980232

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_6 and not isNil(var_244_4) then
				local var_244_7 = (arg_241_1.time_ - var_244_5) / var_244_6

				if arg_241_1.var_.characterEffect1084ui_story and not isNil(var_244_4) then
					local var_244_8 = Mathf.Lerp(0, 0.5, var_244_7)

					arg_241_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1084ui_story.fillRatio = var_244_8
				end
			end

			if arg_241_1.time_ >= var_244_5 + var_244_6 and arg_241_1.time_ < var_244_5 + var_244_6 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect1084ui_story then
				local var_244_9 = 0.5

				arg_241_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1084ui_story.fillRatio = var_244_9
			end

			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_244_11 = 0
			local var_244_12 = 0.8

			if var_244_11 < arg_241_1.time_ and arg_241_1.time_ <= var_244_11 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_13 = arg_241_1:FormatText(StoryNameCfg[640].name)

				arg_241_1.leftNameTxt_.text = var_244_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_14 = arg_241_1:GetWordFromCfg(319381058)
				local var_244_15 = arg_241_1:FormatText(var_244_14.content)

				arg_241_1.text_.text = var_244_15

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_16 = 32
				local var_244_17 = utf8.len(var_244_15)
				local var_244_18 = var_244_16 <= 0 and var_244_12 or var_244_12 * (var_244_17 / var_244_16)

				if var_244_18 > 0 and var_244_12 < var_244_18 then
					arg_241_1.talkMaxDuration = var_244_18

					if var_244_18 + var_244_11 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_18 + var_244_11
					end
				end

				arg_241_1.text_.text = var_244_15
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381058", "story_v_out_319381.awb") ~= 0 then
					local var_244_19 = manager.audio:GetVoiceLength("story_v_out_319381", "319381058", "story_v_out_319381.awb") / 1000

					if var_244_19 + var_244_11 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_19 + var_244_11
					end

					if var_244_14.prefab_name ~= "" and arg_241_1.actors_[var_244_14.prefab_name] ~= nil then
						local var_244_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_14.prefab_name].transform, "story_v_out_319381", "319381058", "story_v_out_319381.awb")

						arg_241_1:RecordAudio("319381058", var_244_20)
						arg_241_1:RecordAudio("319381058", var_244_20)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_319381", "319381058", "story_v_out_319381.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_319381", "319381058", "story_v_out_319381.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_21 = math.max(var_244_12, arg_241_1.talkMaxDuration)

			if var_244_11 <= arg_241_1.time_ and arg_241_1.time_ < var_244_11 + var_244_21 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_11) / var_244_21

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_11 + var_244_21 and arg_241_1.time_ < var_244_11 + var_244_21 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play319381059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319381059
		arg_245_1.duration_ = 13.17

		local var_245_0 = {
			zh = 8.5,
			ja = 13.166
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play319381060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_248_1 = 0
			local var_248_2 = 1.125

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_3 = arg_245_1:FormatText(StoryNameCfg[640].name)

				arg_245_1.leftNameTxt_.text = var_248_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:GetWordFromCfg(319381059)
				local var_248_5 = arg_245_1:FormatText(var_248_4.content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 45
				local var_248_7 = utf8.len(var_248_5)
				local var_248_8 = var_248_6 <= 0 and var_248_2 or var_248_2 * (var_248_7 / var_248_6)

				if var_248_8 > 0 and var_248_2 < var_248_8 then
					arg_245_1.talkMaxDuration = var_248_8

					if var_248_8 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381059", "story_v_out_319381.awb") ~= 0 then
					local var_248_9 = manager.audio:GetVoiceLength("story_v_out_319381", "319381059", "story_v_out_319381.awb") / 1000

					if var_248_9 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_1
					end

					if var_248_4.prefab_name ~= "" and arg_245_1.actors_[var_248_4.prefab_name] ~= nil then
						local var_248_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_4.prefab_name].transform, "story_v_out_319381", "319381059", "story_v_out_319381.awb")

						arg_245_1:RecordAudio("319381059", var_248_10)
						arg_245_1:RecordAudio("319381059", var_248_10)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_319381", "319381059", "story_v_out_319381.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_319381", "319381059", "story_v_out_319381.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_11 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_11 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_11

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_11 and arg_245_1.time_ < var_248_1 + var_248_11 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play319381060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 319381060
		arg_249_1.duration_ = 4.57

		local var_249_0 = {
			zh = 3.4,
			ja = 4.566
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play319381061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10066ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect10066ui_story == nil then
				arg_249_1.var_.characterEffect10066ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect10066ui_story and not isNil(var_252_0) then
					local var_252_4 = Mathf.Lerp(0, 0.5, var_252_3)

					arg_249_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10066ui_story.fillRatio = var_252_4
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect10066ui_story then
				local var_252_5 = 0.5

				arg_249_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10066ui_story.fillRatio = var_252_5
			end

			local var_252_6 = arg_249_1.actors_["1084ui_story"]
			local var_252_7 = 0

			if var_252_7 < arg_249_1.time_ and arg_249_1.time_ <= var_252_7 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect1084ui_story == nil then
				arg_249_1.var_.characterEffect1084ui_story = var_252_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_8 = 0.200000002980232

			if var_252_7 <= arg_249_1.time_ and arg_249_1.time_ < var_252_7 + var_252_8 and not isNil(var_252_6) then
				local var_252_9 = (arg_249_1.time_ - var_252_7) / var_252_8

				if arg_249_1.var_.characterEffect1084ui_story and not isNil(var_252_6) then
					arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_7 + var_252_8 and arg_249_1.time_ < var_252_7 + var_252_8 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect1084ui_story then
				arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_252_11 = 0

			if var_252_11 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_252_12 = 0
			local var_252_13 = 0.325

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_14 = arg_249_1:FormatText(StoryNameCfg[6].name)

				arg_249_1.leftNameTxt_.text = var_252_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_15 = arg_249_1:GetWordFromCfg(319381060)
				local var_252_16 = arg_249_1:FormatText(var_252_15.content)

				arg_249_1.text_.text = var_252_16

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_17 = 13
				local var_252_18 = utf8.len(var_252_16)
				local var_252_19 = var_252_17 <= 0 and var_252_13 or var_252_13 * (var_252_18 / var_252_17)

				if var_252_19 > 0 and var_252_13 < var_252_19 then
					arg_249_1.talkMaxDuration = var_252_19

					if var_252_19 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_19 + var_252_12
					end
				end

				arg_249_1.text_.text = var_252_16
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381060", "story_v_out_319381.awb") ~= 0 then
					local var_252_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381060", "story_v_out_319381.awb") / 1000

					if var_252_20 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_20 + var_252_12
					end

					if var_252_15.prefab_name ~= "" and arg_249_1.actors_[var_252_15.prefab_name] ~= nil then
						local var_252_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_15.prefab_name].transform, "story_v_out_319381", "319381060", "story_v_out_319381.awb")

						arg_249_1:RecordAudio("319381060", var_252_21)
						arg_249_1:RecordAudio("319381060", var_252_21)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_319381", "319381060", "story_v_out_319381.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_319381", "319381060", "story_v_out_319381.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_22 = math.max(var_252_13, arg_249_1.talkMaxDuration)

			if var_252_12 <= arg_249_1.time_ and arg_249_1.time_ < var_252_12 + var_252_22 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_12) / var_252_22

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_12 + var_252_22 and arg_249_1.time_ < var_252_12 + var_252_22 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play319381061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 319381061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play319381062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1084ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1084ui_story == nil then
				arg_253_1.var_.characterEffect1084ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1084ui_story and not isNil(var_256_0) then
					local var_256_4 = Mathf.Lerp(0, 0.5, var_256_3)

					arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1084ui_story.fillRatio = var_256_4
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1084ui_story then
				local var_256_5 = 0.5

				arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1084ui_story.fillRatio = var_256_5
			end

			local var_256_6 = 0
			local var_256_7 = 1.275

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_8 = arg_253_1:GetWordFromCfg(319381061)
				local var_256_9 = arg_253_1:FormatText(var_256_8.content)

				arg_253_1.text_.text = var_256_9

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_10 = 51
				local var_256_11 = utf8.len(var_256_9)
				local var_256_12 = var_256_10 <= 0 and var_256_7 or var_256_7 * (var_256_11 / var_256_10)

				if var_256_12 > 0 and var_256_7 < var_256_12 then
					arg_253_1.talkMaxDuration = var_256_12

					if var_256_12 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_9
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_13 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_13 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_13

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_13 and arg_253_1.time_ < var_256_6 + var_256_13 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play319381062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319381062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play319381063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.95

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_2 = arg_257_1:GetWordFromCfg(319381062)
				local var_260_3 = arg_257_1:FormatText(var_260_2.content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 38
				local var_260_5 = utf8.len(var_260_3)
				local var_260_6 = var_260_4 <= 0 and var_260_1 or var_260_1 * (var_260_5 / var_260_4)

				if var_260_6 > 0 and var_260_1 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_7 and arg_257_1.time_ < var_260_0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319381063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319381063
		arg_261_1.duration_ = 9.57

		local var_261_0 = {
			zh = 6.73400000184774,
			ja = 9.56700000184775
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
				arg_261_0:Play319381064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1084ui_story"].transform
			local var_264_1 = 3.7

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1084ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0, -0.97, -6)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1084ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["1084ui_story"]
			local var_264_10 = 3.7

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1084ui_story == nil then
				arg_261_1.var_.characterEffect1084ui_story = var_264_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_11 = 0.200000002980232

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_11 and not isNil(var_264_9) then
				local var_264_12 = (arg_261_1.time_ - var_264_10) / var_264_11

				if arg_261_1.var_.characterEffect1084ui_story and not isNil(var_264_9) then
					arg_261_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_10 + var_264_11 and arg_261_1.time_ < var_264_10 + var_264_11 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1084ui_story then
				arg_261_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_264_13 = 2

			if var_264_13 < arg_261_1.time_ and arg_261_1.time_ <= var_264_13 + arg_264_0 then
				local var_264_14 = manager.ui.mainCamera.transform.localPosition
				local var_264_15 = Vector3.New(0, 0, 10) + Vector3.New(var_264_14.x, var_264_14.y, 0)
				local var_264_16 = arg_261_1.bgs_.I11l

				var_264_16.transform.localPosition = var_264_15
				var_264_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_17 = var_264_16:GetComponent("SpriteRenderer")

				if var_264_17 and var_264_17.sprite then
					local var_264_18 = (var_264_16.transform.localPosition - var_264_14).z
					local var_264_19 = manager.ui.mainCameraCom_
					local var_264_20 = 2 * var_264_18 * Mathf.Tan(var_264_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_264_21 = var_264_20 * var_264_19.aspect
					local var_264_22 = var_264_17.sprite.bounds.size.x
					local var_264_23 = var_264_17.sprite.bounds.size.y
					local var_264_24 = var_264_21 / var_264_22
					local var_264_25 = var_264_20 / var_264_23
					local var_264_26 = var_264_25 < var_264_24 and var_264_24 or var_264_25

					var_264_16.transform.localScale = Vector3.New(var_264_26, var_264_26, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "I11l" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_27 = 0

			if var_264_27 < arg_261_1.time_ and arg_261_1.time_ <= var_264_27 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_28 = 2

			if var_264_27 <= arg_261_1.time_ and arg_261_1.time_ < var_264_27 + var_264_28 then
				local var_264_29 = (arg_261_1.time_ - var_264_27) / var_264_28
				local var_264_30 = Color.New(0, 0, 0)

				var_264_30.a = Mathf.Lerp(0, 1, var_264_29)
				arg_261_1.mask_.color = var_264_30
			end

			if arg_261_1.time_ >= var_264_27 + var_264_28 and arg_261_1.time_ < var_264_27 + var_264_28 + arg_264_0 then
				local var_264_31 = Color.New(0, 0, 0)

				var_264_31.a = 1
				arg_261_1.mask_.color = var_264_31
			end

			local var_264_32 = 2

			if var_264_32 < arg_261_1.time_ and arg_261_1.time_ <= var_264_32 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_33 = 2

			if var_264_32 <= arg_261_1.time_ and arg_261_1.time_ < var_264_32 + var_264_33 then
				local var_264_34 = (arg_261_1.time_ - var_264_32) / var_264_33
				local var_264_35 = Color.New(0, 0, 0)

				var_264_35.a = Mathf.Lerp(1, 0, var_264_34)
				arg_261_1.mask_.color = var_264_35
			end

			if arg_261_1.time_ >= var_264_32 + var_264_33 and arg_261_1.time_ < var_264_32 + var_264_33 + arg_264_0 then
				local var_264_36 = Color.New(0, 0, 0)
				local var_264_37 = 0

				arg_261_1.mask_.enabled = false
				var_264_36.a = var_264_37
				arg_261_1.mask_.color = var_264_36
			end

			local var_264_38 = arg_261_1.actors_["1084ui_story"].transform
			local var_264_39 = 2

			if var_264_39 < arg_261_1.time_ and arg_261_1.time_ <= var_264_39 + arg_264_0 then
				arg_261_1.var_.moveOldPos1084ui_story = var_264_38.localPosition
			end

			local var_264_40 = 0.001

			if var_264_39 <= arg_261_1.time_ and arg_261_1.time_ < var_264_39 + var_264_40 then
				local var_264_41 = (arg_261_1.time_ - var_264_39) / var_264_40
				local var_264_42 = Vector3.New(0, 100, 0)

				var_264_38.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1084ui_story, var_264_42, var_264_41)

				local var_264_43 = manager.ui.mainCamera.transform.position - var_264_38.position

				var_264_38.forward = Vector3.New(var_264_43.x, var_264_43.y, var_264_43.z)

				local var_264_44 = var_264_38.localEulerAngles

				var_264_44.z = 0
				var_264_44.x = 0
				var_264_38.localEulerAngles = var_264_44
			end

			if arg_261_1.time_ >= var_264_39 + var_264_40 and arg_261_1.time_ < var_264_39 + var_264_40 + arg_264_0 then
				var_264_38.localPosition = Vector3.New(0, 100, 0)

				local var_264_45 = manager.ui.mainCamera.transform.position - var_264_38.position

				var_264_38.forward = Vector3.New(var_264_45.x, var_264_45.y, var_264_45.z)

				local var_264_46 = var_264_38.localEulerAngles

				var_264_46.z = 0
				var_264_46.x = 0
				var_264_38.localEulerAngles = var_264_46
			end

			local var_264_47 = arg_261_1.actors_["10066ui_story"].transform
			local var_264_48 = 2

			if var_264_48 < arg_261_1.time_ and arg_261_1.time_ <= var_264_48 + arg_264_0 then
				arg_261_1.var_.moveOldPos10066ui_story = var_264_47.localPosition
			end

			local var_264_49 = 0.001

			if var_264_48 <= arg_261_1.time_ and arg_261_1.time_ < var_264_48 + var_264_49 then
				local var_264_50 = (arg_261_1.time_ - var_264_48) / var_264_49
				local var_264_51 = Vector3.New(0, 100, 0)

				var_264_47.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10066ui_story, var_264_51, var_264_50)

				local var_264_52 = manager.ui.mainCamera.transform.position - var_264_47.position

				var_264_47.forward = Vector3.New(var_264_52.x, var_264_52.y, var_264_52.z)

				local var_264_53 = var_264_47.localEulerAngles

				var_264_53.z = 0
				var_264_53.x = 0
				var_264_47.localEulerAngles = var_264_53
			end

			if arg_261_1.time_ >= var_264_48 + var_264_49 and arg_261_1.time_ < var_264_48 + var_264_49 + arg_264_0 then
				var_264_47.localPosition = Vector3.New(0, 100, 0)

				local var_264_54 = manager.ui.mainCamera.transform.position - var_264_47.position

				var_264_47.forward = Vector3.New(var_264_54.x, var_264_54.y, var_264_54.z)

				local var_264_55 = var_264_47.localEulerAngles

				var_264_55.z = 0
				var_264_55.x = 0
				var_264_47.localEulerAngles = var_264_55
			end

			local var_264_56 = 3.7

			if var_264_56 < arg_261_1.time_ and arg_261_1.time_ <= var_264_56 + arg_264_0 then
				arg_261_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_264_57 = 3.7

			if var_264_57 < arg_261_1.time_ and arg_261_1.time_ <= var_264_57 + arg_264_0 then
				arg_261_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_58 = 3.73400000184774
			local var_264_59 = 0.35

			if var_264_58 < arg_261_1.time_ and arg_261_1.time_ <= var_264_58 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_60 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_60:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_61 = arg_261_1:FormatText(StoryNameCfg[6].name)

				arg_261_1.leftNameTxt_.text = var_264_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_62 = arg_261_1:GetWordFromCfg(319381063)
				local var_264_63 = arg_261_1:FormatText(var_264_62.content)

				arg_261_1.text_.text = var_264_63

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_64 = 14
				local var_264_65 = utf8.len(var_264_63)
				local var_264_66 = var_264_64 <= 0 and var_264_59 or var_264_59 * (var_264_65 / var_264_64)

				if var_264_66 > 0 and var_264_59 < var_264_66 then
					arg_261_1.talkMaxDuration = var_264_66
					var_264_58 = var_264_58 + 0.3

					if var_264_66 + var_264_58 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_66 + var_264_58
					end
				end

				arg_261_1.text_.text = var_264_63
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381063", "story_v_out_319381.awb") ~= 0 then
					local var_264_67 = manager.audio:GetVoiceLength("story_v_out_319381", "319381063", "story_v_out_319381.awb") / 1000

					if var_264_67 + var_264_58 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_67 + var_264_58
					end

					if var_264_62.prefab_name ~= "" and arg_261_1.actors_[var_264_62.prefab_name] ~= nil then
						local var_264_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_62.prefab_name].transform, "story_v_out_319381", "319381063", "story_v_out_319381.awb")

						arg_261_1:RecordAudio("319381063", var_264_68)
						arg_261_1:RecordAudio("319381063", var_264_68)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_319381", "319381063", "story_v_out_319381.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_319381", "319381063", "story_v_out_319381.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_69 = var_264_58 + 0.3
			local var_264_70 = math.max(var_264_59, arg_261_1.talkMaxDuration)

			if var_264_69 <= arg_261_1.time_ and arg_261_1.time_ < var_264_69 + var_264_70 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_69) / var_264_70

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_69 + var_264_70 and arg_261_1.time_ < var_264_69 + var_264_70 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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

		arg_261_1:InitPlayNodeList()
	end,
	Play319381064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 319381064
		arg_267_1.duration_ = 3.07

		local var_267_0 = {
			zh = 2.066,
			ja = 3.066
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play319381065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1084ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1084ui_story == nil then
				arg_267_1.var_.characterEffect1084ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect1084ui_story and not isNil(var_270_0) then
					local var_270_4 = Mathf.Lerp(0, 0.5, var_270_3)

					arg_267_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1084ui_story.fillRatio = var_270_4
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.characterEffect1084ui_story then
				local var_270_5 = 0.5

				arg_267_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1084ui_story.fillRatio = var_270_5
			end

			local var_270_6 = arg_267_1.actors_["10066ui_story"]
			local var_270_7 = 0

			if var_270_7 < arg_267_1.time_ and arg_267_1.time_ <= var_270_7 + arg_270_0 and not isNil(var_270_6) and arg_267_1.var_.characterEffect10066ui_story == nil then
				arg_267_1.var_.characterEffect10066ui_story = var_270_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_8 = 0.200000002980232

			if var_270_7 <= arg_267_1.time_ and arg_267_1.time_ < var_270_7 + var_270_8 and not isNil(var_270_6) then
				local var_270_9 = (arg_267_1.time_ - var_270_7) / var_270_8

				if arg_267_1.var_.characterEffect10066ui_story and not isNil(var_270_6) then
					arg_267_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_7 + var_270_8 and arg_267_1.time_ < var_270_7 + var_270_8 + arg_270_0 and not isNil(var_270_6) and arg_267_1.var_.characterEffect10066ui_story then
				arg_267_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_270_10 = arg_267_1.actors_["1084ui_story"].transform
			local var_270_11 = 0

			if var_270_11 < arg_267_1.time_ and arg_267_1.time_ <= var_270_11 + arg_270_0 then
				arg_267_1.var_.moveOldPos1084ui_story = var_270_10.localPosition
			end

			local var_270_12 = 0.001

			if var_270_11 <= arg_267_1.time_ and arg_267_1.time_ < var_270_11 + var_270_12 then
				local var_270_13 = (arg_267_1.time_ - var_270_11) / var_270_12
				local var_270_14 = Vector3.New(-0.7, -0.97, -6)

				var_270_10.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1084ui_story, var_270_14, var_270_13)

				local var_270_15 = manager.ui.mainCamera.transform.position - var_270_10.position

				var_270_10.forward = Vector3.New(var_270_15.x, var_270_15.y, var_270_15.z)

				local var_270_16 = var_270_10.localEulerAngles

				var_270_16.z = 0
				var_270_16.x = 0
				var_270_10.localEulerAngles = var_270_16
			end

			if arg_267_1.time_ >= var_270_11 + var_270_12 and arg_267_1.time_ < var_270_11 + var_270_12 + arg_270_0 then
				var_270_10.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_270_17 = manager.ui.mainCamera.transform.position - var_270_10.position

				var_270_10.forward = Vector3.New(var_270_17.x, var_270_17.y, var_270_17.z)

				local var_270_18 = var_270_10.localEulerAngles

				var_270_18.z = 0
				var_270_18.x = 0
				var_270_10.localEulerAngles = var_270_18
			end

			local var_270_19 = arg_267_1.actors_["10066ui_story"].transform
			local var_270_20 = 0

			if var_270_20 < arg_267_1.time_ and arg_267_1.time_ <= var_270_20 + arg_270_0 then
				arg_267_1.var_.moveOldPos10066ui_story = var_270_19.localPosition
			end

			local var_270_21 = 0.001

			if var_270_20 <= arg_267_1.time_ and arg_267_1.time_ < var_270_20 + var_270_21 then
				local var_270_22 = (arg_267_1.time_ - var_270_20) / var_270_21
				local var_270_23 = Vector3.New(0.7, -0.99, -5.83)

				var_270_19.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10066ui_story, var_270_23, var_270_22)

				local var_270_24 = manager.ui.mainCamera.transform.position - var_270_19.position

				var_270_19.forward = Vector3.New(var_270_24.x, var_270_24.y, var_270_24.z)

				local var_270_25 = var_270_19.localEulerAngles

				var_270_25.z = 0
				var_270_25.x = 0
				var_270_19.localEulerAngles = var_270_25
			end

			if arg_267_1.time_ >= var_270_20 + var_270_21 and arg_267_1.time_ < var_270_20 + var_270_21 + arg_270_0 then
				var_270_19.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_270_26 = manager.ui.mainCamera.transform.position - var_270_19.position

				var_270_19.forward = Vector3.New(var_270_26.x, var_270_26.y, var_270_26.z)

				local var_270_27 = var_270_19.localEulerAngles

				var_270_27.z = 0
				var_270_27.x = 0
				var_270_19.localEulerAngles = var_270_27
			end

			local var_270_28 = 0
			local var_270_29 = 0.175

			if var_270_28 < arg_267_1.time_ and arg_267_1.time_ <= var_270_28 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_30 = arg_267_1:FormatText(StoryNameCfg[640].name)

				arg_267_1.leftNameTxt_.text = var_270_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_31 = arg_267_1:GetWordFromCfg(319381064)
				local var_270_32 = arg_267_1:FormatText(var_270_31.content)

				arg_267_1.text_.text = var_270_32

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_33 = 7
				local var_270_34 = utf8.len(var_270_32)
				local var_270_35 = var_270_33 <= 0 and var_270_29 or var_270_29 * (var_270_34 / var_270_33)

				if var_270_35 > 0 and var_270_29 < var_270_35 then
					arg_267_1.talkMaxDuration = var_270_35

					if var_270_35 + var_270_28 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_35 + var_270_28
					end
				end

				arg_267_1.text_.text = var_270_32
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381064", "story_v_out_319381.awb") ~= 0 then
					local var_270_36 = manager.audio:GetVoiceLength("story_v_out_319381", "319381064", "story_v_out_319381.awb") / 1000

					if var_270_36 + var_270_28 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_36 + var_270_28
					end

					if var_270_31.prefab_name ~= "" and arg_267_1.actors_[var_270_31.prefab_name] ~= nil then
						local var_270_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_31.prefab_name].transform, "story_v_out_319381", "319381064", "story_v_out_319381.awb")

						arg_267_1:RecordAudio("319381064", var_270_37)
						arg_267_1:RecordAudio("319381064", var_270_37)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_319381", "319381064", "story_v_out_319381.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_319381", "319381064", "story_v_out_319381.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_38 = math.max(var_270_29, arg_267_1.talkMaxDuration)

			if var_270_28 <= arg_267_1.time_ and arg_267_1.time_ < var_270_28 + var_270_38 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_28) / var_270_38

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_28 + var_270_38 and arg_267_1.time_ < var_270_28 + var_270_38 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_267_1:InitPlayNodeList()
	end,
	Play319381065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 319381065
		arg_271_1.duration_ = 6.9

		local var_271_0 = {
			zh = 4.466,
			ja = 6.9
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play319381066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1084ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1084ui_story == nil then
				arg_271_1.var_.characterEffect1084ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1084ui_story and not isNil(var_274_0) then
					arg_271_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1084ui_story then
				arg_271_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_274_4 = arg_271_1.actors_["10066ui_story"]
			local var_274_5 = 0

			if var_274_5 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect10066ui_story == nil then
				arg_271_1.var_.characterEffect10066ui_story = var_274_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_6 = 0.200000002980232

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_6 and not isNil(var_274_4) then
				local var_274_7 = (arg_271_1.time_ - var_274_5) / var_274_6

				if arg_271_1.var_.characterEffect10066ui_story and not isNil(var_274_4) then
					local var_274_8 = Mathf.Lerp(0, 0.5, var_274_7)

					arg_271_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10066ui_story.fillRatio = var_274_8
				end
			end

			if arg_271_1.time_ >= var_274_5 + var_274_6 and arg_271_1.time_ < var_274_5 + var_274_6 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect10066ui_story then
				local var_274_9 = 0.5

				arg_271_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10066ui_story.fillRatio = var_274_9
			end

			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 then
				arg_271_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_274_11 = 0

			if var_274_11 < arg_271_1.time_ and arg_271_1.time_ <= var_274_11 + arg_274_0 then
				arg_271_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_12 = 0
			local var_274_13 = 0.525

			if var_274_12 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_14 = arg_271_1:FormatText(StoryNameCfg[6].name)

				arg_271_1.leftNameTxt_.text = var_274_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_15 = arg_271_1:GetWordFromCfg(319381065)
				local var_274_16 = arg_271_1:FormatText(var_274_15.content)

				arg_271_1.text_.text = var_274_16

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_17 = 21
				local var_274_18 = utf8.len(var_274_16)
				local var_274_19 = var_274_17 <= 0 and var_274_13 or var_274_13 * (var_274_18 / var_274_17)

				if var_274_19 > 0 and var_274_13 < var_274_19 then
					arg_271_1.talkMaxDuration = var_274_19

					if var_274_19 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_19 + var_274_12
					end
				end

				arg_271_1.text_.text = var_274_16
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381065", "story_v_out_319381.awb") ~= 0 then
					local var_274_20 = manager.audio:GetVoiceLength("story_v_out_319381", "319381065", "story_v_out_319381.awb") / 1000

					if var_274_20 + var_274_12 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_20 + var_274_12
					end

					if var_274_15.prefab_name ~= "" and arg_271_1.actors_[var_274_15.prefab_name] ~= nil then
						local var_274_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_15.prefab_name].transform, "story_v_out_319381", "319381065", "story_v_out_319381.awb")

						arg_271_1:RecordAudio("319381065", var_274_21)
						arg_271_1:RecordAudio("319381065", var_274_21)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_319381", "319381065", "story_v_out_319381.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_319381", "319381065", "story_v_out_319381.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_22 = math.max(var_274_13, arg_271_1.talkMaxDuration)

			if var_274_12 <= arg_271_1.time_ and arg_271_1.time_ < var_274_12 + var_274_22 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_12) / var_274_22

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_12 + var_274_22 and arg_271_1.time_ < var_274_12 + var_274_22 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play319381066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 319381066
		arg_275_1.duration_ = 11.03

		local var_275_0 = {
			zh = 6.266,
			ja = 11.033
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play319381067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10066ui_story"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos10066ui_story = var_278_0.localPosition
			end

			local var_278_2 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2
				local var_278_4 = Vector3.New(0.7, -0.99, -5.83)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10066ui_story, var_278_4, var_278_3)

				local var_278_5 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_5.x, var_278_5.y, var_278_5.z)

				local var_278_6 = var_278_0.localEulerAngles

				var_278_6.z = 0
				var_278_6.x = 0
				var_278_0.localEulerAngles = var_278_6
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_278_7 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_7.x, var_278_7.y, var_278_7.z)

				local var_278_8 = var_278_0.localEulerAngles

				var_278_8.z = 0
				var_278_8.x = 0
				var_278_0.localEulerAngles = var_278_8
			end

			local var_278_9 = arg_275_1.actors_["10066ui_story"]
			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect10066ui_story == nil then
				arg_275_1.var_.characterEffect10066ui_story = var_278_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_11 = 0.200000002980232

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_11 and not isNil(var_278_9) then
				local var_278_12 = (arg_275_1.time_ - var_278_10) / var_278_11

				if arg_275_1.var_.characterEffect10066ui_story and not isNil(var_278_9) then
					arg_275_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_10 + var_278_11 and arg_275_1.time_ < var_278_10 + var_278_11 + arg_278_0 and not isNil(var_278_9) and arg_275_1.var_.characterEffect10066ui_story then
				arg_275_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_278_13 = 0

			if var_278_13 < arg_275_1.time_ and arg_275_1.time_ <= var_278_13 + arg_278_0 then
				arg_275_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_278_14 = 0

			if var_278_14 < arg_275_1.time_ and arg_275_1.time_ <= var_278_14 + arg_278_0 then
				arg_275_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_278_15 = arg_275_1.actors_["1084ui_story"]
			local var_278_16 = 0

			if var_278_16 < arg_275_1.time_ and arg_275_1.time_ <= var_278_16 + arg_278_0 and not isNil(var_278_15) and arg_275_1.var_.characterEffect1084ui_story == nil then
				arg_275_1.var_.characterEffect1084ui_story = var_278_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_17 = 0.200000002980232

			if var_278_16 <= arg_275_1.time_ and arg_275_1.time_ < var_278_16 + var_278_17 and not isNil(var_278_15) then
				local var_278_18 = (arg_275_1.time_ - var_278_16) / var_278_17

				if arg_275_1.var_.characterEffect1084ui_story and not isNil(var_278_15) then
					local var_278_19 = Mathf.Lerp(0, 0.5, var_278_18)

					arg_275_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1084ui_story.fillRatio = var_278_19
				end
			end

			if arg_275_1.time_ >= var_278_16 + var_278_17 and arg_275_1.time_ < var_278_16 + var_278_17 + arg_278_0 and not isNil(var_278_15) and arg_275_1.var_.characterEffect1084ui_story then
				local var_278_20 = 0.5

				arg_275_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1084ui_story.fillRatio = var_278_20
			end

			local var_278_21 = 0
			local var_278_22 = 0.575

			if var_278_21 < arg_275_1.time_ and arg_275_1.time_ <= var_278_21 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_23 = arg_275_1:FormatText(StoryNameCfg[640].name)

				arg_275_1.leftNameTxt_.text = var_278_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_24 = arg_275_1:GetWordFromCfg(319381066)
				local var_278_25 = arg_275_1:FormatText(var_278_24.content)

				arg_275_1.text_.text = var_278_25

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_26 = 23
				local var_278_27 = utf8.len(var_278_25)
				local var_278_28 = var_278_26 <= 0 and var_278_22 or var_278_22 * (var_278_27 / var_278_26)

				if var_278_28 > 0 and var_278_22 < var_278_28 then
					arg_275_1.talkMaxDuration = var_278_28

					if var_278_28 + var_278_21 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_28 + var_278_21
					end
				end

				arg_275_1.text_.text = var_278_25
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381066", "story_v_out_319381.awb") ~= 0 then
					local var_278_29 = manager.audio:GetVoiceLength("story_v_out_319381", "319381066", "story_v_out_319381.awb") / 1000

					if var_278_29 + var_278_21 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_29 + var_278_21
					end

					if var_278_24.prefab_name ~= "" and arg_275_1.actors_[var_278_24.prefab_name] ~= nil then
						local var_278_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_24.prefab_name].transform, "story_v_out_319381", "319381066", "story_v_out_319381.awb")

						arg_275_1:RecordAudio("319381066", var_278_30)
						arg_275_1:RecordAudio("319381066", var_278_30)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_319381", "319381066", "story_v_out_319381.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_319381", "319381066", "story_v_out_319381.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_31 = math.max(var_278_22, arg_275_1.talkMaxDuration)

			if var_278_21 <= arg_275_1.time_ and arg_275_1.time_ < var_278_21 + var_278_31 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_21) / var_278_31

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_21 + var_278_31 and arg_275_1.time_ < var_278_21 + var_278_31 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play319381067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 319381067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play319381068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1084ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1084ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, 100, 0)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1084ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, 100, 0)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["10066ui_story"].transform
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 then
				arg_279_1.var_.moveOldPos10066ui_story = var_282_9.localPosition
			end

			local var_282_11 = 0.001

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11
				local var_282_13 = Vector3.New(0, 100, 0)

				var_282_9.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10066ui_story, var_282_13, var_282_12)

				local var_282_14 = manager.ui.mainCamera.transform.position - var_282_9.position

				var_282_9.forward = Vector3.New(var_282_14.x, var_282_14.y, var_282_14.z)

				local var_282_15 = var_282_9.localEulerAngles

				var_282_15.z = 0
				var_282_15.x = 0
				var_282_9.localEulerAngles = var_282_15
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 then
				var_282_9.localPosition = Vector3.New(0, 100, 0)

				local var_282_16 = manager.ui.mainCamera.transform.position - var_282_9.position

				var_282_9.forward = Vector3.New(var_282_16.x, var_282_16.y, var_282_16.z)

				local var_282_17 = var_282_9.localEulerAngles

				var_282_17.z = 0
				var_282_17.x = 0
				var_282_9.localEulerAngles = var_282_17
			end

			local var_282_18 = 0
			local var_282_19 = 0.675

			if var_282_18 < arg_279_1.time_ and arg_279_1.time_ <= var_282_18 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_20 = arg_279_1:GetWordFromCfg(319381067)
				local var_282_21 = arg_279_1:FormatText(var_282_20.content)

				arg_279_1.text_.text = var_282_21

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_22 = 27
				local var_282_23 = utf8.len(var_282_21)
				local var_282_24 = var_282_22 <= 0 and var_282_19 or var_282_19 * (var_282_23 / var_282_22)

				if var_282_24 > 0 and var_282_19 < var_282_24 then
					arg_279_1.talkMaxDuration = var_282_24

					if var_282_24 + var_282_18 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_24 + var_282_18
					end
				end

				arg_279_1.text_.text = var_282_21
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_25 = math.max(var_282_19, arg_279_1.talkMaxDuration)

			if var_282_18 <= arg_279_1.time_ and arg_279_1.time_ < var_282_18 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_18) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_18 + var_282_25 and arg_279_1.time_ < var_282_18 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_279_1:InitPlayNodeList()
	end,
	Play319381068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 319381068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play319381069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.85

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_2 = arg_283_1:GetWordFromCfg(319381068)
				local var_286_3 = arg_283_1:FormatText(var_286_2.content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_4 = 34
				local var_286_5 = utf8.len(var_286_3)
				local var_286_6 = var_286_4 <= 0 and var_286_1 or var_286_1 * (var_286_5 / var_286_4)

				if var_286_6 > 0 and var_286_1 < var_286_6 then
					arg_283_1.talkMaxDuration = var_286_6

					if var_286_6 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_6 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_7 and arg_283_1.time_ < var_286_0 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play319381069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 319381069
		arg_287_1.duration_ = 6.8

		local var_287_0 = {
			zh = 5.4,
			ja = 6.8
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
				arg_287_0:Play319381070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10066ui_story"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect10066ui_story == nil then
				arg_287_1.var_.characterEffect10066ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.characterEffect10066ui_story and not isNil(var_290_0) then
					arg_287_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect10066ui_story then
				arg_287_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_290_4 = arg_287_1.actors_["1084ui_story"].transform
			local var_290_5 = 0

			if var_290_5 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1.var_.moveOldPos1084ui_story = var_290_4.localPosition
			end

			local var_290_6 = 0.001

			if var_290_5 <= arg_287_1.time_ and arg_287_1.time_ < var_290_5 + var_290_6 then
				local var_290_7 = (arg_287_1.time_ - var_290_5) / var_290_6
				local var_290_8 = Vector3.New(0, 100, 0)

				var_290_4.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1084ui_story, var_290_8, var_290_7)

				local var_290_9 = manager.ui.mainCamera.transform.position - var_290_4.position

				var_290_4.forward = Vector3.New(var_290_9.x, var_290_9.y, var_290_9.z)

				local var_290_10 = var_290_4.localEulerAngles

				var_290_10.z = 0
				var_290_10.x = 0
				var_290_4.localEulerAngles = var_290_10
			end

			if arg_287_1.time_ >= var_290_5 + var_290_6 and arg_287_1.time_ < var_290_5 + var_290_6 + arg_290_0 then
				var_290_4.localPosition = Vector3.New(0, 100, 0)

				local var_290_11 = manager.ui.mainCamera.transform.position - var_290_4.position

				var_290_4.forward = Vector3.New(var_290_11.x, var_290_11.y, var_290_11.z)

				local var_290_12 = var_290_4.localEulerAngles

				var_290_12.z = 0
				var_290_12.x = 0
				var_290_4.localEulerAngles = var_290_12
			end

			local var_290_13 = arg_287_1.actors_["10066ui_story"].transform
			local var_290_14 = 0

			if var_290_14 < arg_287_1.time_ and arg_287_1.time_ <= var_290_14 + arg_290_0 then
				arg_287_1.var_.moveOldPos10066ui_story = var_290_13.localPosition
			end

			local var_290_15 = 0.001

			if var_290_14 <= arg_287_1.time_ and arg_287_1.time_ < var_290_14 + var_290_15 then
				local var_290_16 = (arg_287_1.time_ - var_290_14) / var_290_15
				local var_290_17 = Vector3.New(0, -0.99, -5.83)

				var_290_13.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10066ui_story, var_290_17, var_290_16)

				local var_290_18 = manager.ui.mainCamera.transform.position - var_290_13.position

				var_290_13.forward = Vector3.New(var_290_18.x, var_290_18.y, var_290_18.z)

				local var_290_19 = var_290_13.localEulerAngles

				var_290_19.z = 0
				var_290_19.x = 0
				var_290_13.localEulerAngles = var_290_19
			end

			if arg_287_1.time_ >= var_290_14 + var_290_15 and arg_287_1.time_ < var_290_14 + var_290_15 + arg_290_0 then
				var_290_13.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_290_20 = manager.ui.mainCamera.transform.position - var_290_13.position

				var_290_13.forward = Vector3.New(var_290_20.x, var_290_20.y, var_290_20.z)

				local var_290_21 = var_290_13.localEulerAngles

				var_290_21.z = 0
				var_290_21.x = 0
				var_290_13.localEulerAngles = var_290_21
			end

			local var_290_22 = 0

			if var_290_22 < arg_287_1.time_ and arg_287_1.time_ <= var_290_22 + arg_290_0 then
				arg_287_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_290_23 = 0
			local var_290_24 = 0.6

			if var_290_23 < arg_287_1.time_ and arg_287_1.time_ <= var_290_23 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_25 = arg_287_1:FormatText(StoryNameCfg[640].name)

				arg_287_1.leftNameTxt_.text = var_290_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_26 = arg_287_1:GetWordFromCfg(319381069)
				local var_290_27 = arg_287_1:FormatText(var_290_26.content)

				arg_287_1.text_.text = var_290_27

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_28 = 24
				local var_290_29 = utf8.len(var_290_27)
				local var_290_30 = var_290_28 <= 0 and var_290_24 or var_290_24 * (var_290_29 / var_290_28)

				if var_290_30 > 0 and var_290_24 < var_290_30 then
					arg_287_1.talkMaxDuration = var_290_30

					if var_290_30 + var_290_23 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_30 + var_290_23
					end
				end

				arg_287_1.text_.text = var_290_27
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381069", "story_v_out_319381.awb") ~= 0 then
					local var_290_31 = manager.audio:GetVoiceLength("story_v_out_319381", "319381069", "story_v_out_319381.awb") / 1000

					if var_290_31 + var_290_23 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_31 + var_290_23
					end

					if var_290_26.prefab_name ~= "" and arg_287_1.actors_[var_290_26.prefab_name] ~= nil then
						local var_290_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_26.prefab_name].transform, "story_v_out_319381", "319381069", "story_v_out_319381.awb")

						arg_287_1:RecordAudio("319381069", var_290_32)
						arg_287_1:RecordAudio("319381069", var_290_32)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_319381", "319381069", "story_v_out_319381.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_319381", "319381069", "story_v_out_319381.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_33 = math.max(var_290_24, arg_287_1.talkMaxDuration)

			if var_290_23 <= arg_287_1.time_ and arg_287_1.time_ < var_290_23 + var_290_33 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_23) / var_290_33

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_23 + var_290_33 and arg_287_1.time_ < var_290_23 + var_290_33 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_287_1:InitPlayNodeList()
	end,
	Play319381070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 319381070
		arg_291_1.duration_ = 2

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play319381071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1084ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1084ui_story == nil then
				arg_291_1.var_.characterEffect1084ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1084ui_story and not isNil(var_294_0) then
					arg_291_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1084ui_story then
				arg_291_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_294_4 = arg_291_1.actors_["10066ui_story"]
			local var_294_5 = 0

			if var_294_5 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 and not isNil(var_294_4) and arg_291_1.var_.characterEffect10066ui_story == nil then
				arg_291_1.var_.characterEffect10066ui_story = var_294_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_6 = 0.200000002980232

			if var_294_5 <= arg_291_1.time_ and arg_291_1.time_ < var_294_5 + var_294_6 and not isNil(var_294_4) then
				local var_294_7 = (arg_291_1.time_ - var_294_5) / var_294_6

				if arg_291_1.var_.characterEffect10066ui_story and not isNil(var_294_4) then
					local var_294_8 = Mathf.Lerp(0, 0.5, var_294_7)

					arg_291_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10066ui_story.fillRatio = var_294_8
				end
			end

			if arg_291_1.time_ >= var_294_5 + var_294_6 and arg_291_1.time_ < var_294_5 + var_294_6 + arg_294_0 and not isNil(var_294_4) and arg_291_1.var_.characterEffect10066ui_story then
				local var_294_9 = 0.5

				arg_291_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10066ui_story.fillRatio = var_294_9
			end

			local var_294_10 = arg_291_1.actors_["1084ui_story"].transform
			local var_294_11 = 0

			if var_294_11 < arg_291_1.time_ and arg_291_1.time_ <= var_294_11 + arg_294_0 then
				arg_291_1.var_.moveOldPos1084ui_story = var_294_10.localPosition
			end

			local var_294_12 = 0.001

			if var_294_11 <= arg_291_1.time_ and arg_291_1.time_ < var_294_11 + var_294_12 then
				local var_294_13 = (arg_291_1.time_ - var_294_11) / var_294_12
				local var_294_14 = Vector3.New(-0.7, -0.97, -6)

				var_294_10.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1084ui_story, var_294_14, var_294_13)

				local var_294_15 = manager.ui.mainCamera.transform.position - var_294_10.position

				var_294_10.forward = Vector3.New(var_294_15.x, var_294_15.y, var_294_15.z)

				local var_294_16 = var_294_10.localEulerAngles

				var_294_16.z = 0
				var_294_16.x = 0
				var_294_10.localEulerAngles = var_294_16
			end

			if arg_291_1.time_ >= var_294_11 + var_294_12 and arg_291_1.time_ < var_294_11 + var_294_12 + arg_294_0 then
				var_294_10.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_294_17 = manager.ui.mainCamera.transform.position - var_294_10.position

				var_294_10.forward = Vector3.New(var_294_17.x, var_294_17.y, var_294_17.z)

				local var_294_18 = var_294_10.localEulerAngles

				var_294_18.z = 0
				var_294_18.x = 0
				var_294_10.localEulerAngles = var_294_18
			end

			local var_294_19 = arg_291_1.actors_["10066ui_story"].transform
			local var_294_20 = 0

			if var_294_20 < arg_291_1.time_ and arg_291_1.time_ <= var_294_20 + arg_294_0 then
				arg_291_1.var_.moveOldPos10066ui_story = var_294_19.localPosition
			end

			local var_294_21 = 0.001

			if var_294_20 <= arg_291_1.time_ and arg_291_1.time_ < var_294_20 + var_294_21 then
				local var_294_22 = (arg_291_1.time_ - var_294_20) / var_294_21
				local var_294_23 = Vector3.New(0.7, -0.99, -5.83)

				var_294_19.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10066ui_story, var_294_23, var_294_22)

				local var_294_24 = manager.ui.mainCamera.transform.position - var_294_19.position

				var_294_19.forward = Vector3.New(var_294_24.x, var_294_24.y, var_294_24.z)

				local var_294_25 = var_294_19.localEulerAngles

				var_294_25.z = 0
				var_294_25.x = 0
				var_294_19.localEulerAngles = var_294_25
			end

			if arg_291_1.time_ >= var_294_20 + var_294_21 and arg_291_1.time_ < var_294_20 + var_294_21 + arg_294_0 then
				var_294_19.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_294_26 = manager.ui.mainCamera.transform.position - var_294_19.position

				var_294_19.forward = Vector3.New(var_294_26.x, var_294_26.y, var_294_26.z)

				local var_294_27 = var_294_19.localEulerAngles

				var_294_27.z = 0
				var_294_27.x = 0
				var_294_19.localEulerAngles = var_294_27
			end

			local var_294_28 = 0

			if var_294_28 < arg_291_1.time_ and arg_291_1.time_ <= var_294_28 + arg_294_0 then
				arg_291_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_294_29 = 0

			if var_294_29 < arg_291_1.time_ and arg_291_1.time_ <= var_294_29 + arg_294_0 then
				arg_291_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_294_30 = 0
			local var_294_31 = 0.175

			if var_294_30 < arg_291_1.time_ and arg_291_1.time_ <= var_294_30 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_32 = arg_291_1:FormatText(StoryNameCfg[6].name)

				arg_291_1.leftNameTxt_.text = var_294_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_33 = arg_291_1:GetWordFromCfg(319381070)
				local var_294_34 = arg_291_1:FormatText(var_294_33.content)

				arg_291_1.text_.text = var_294_34

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_35 = 7
				local var_294_36 = utf8.len(var_294_34)
				local var_294_37 = var_294_35 <= 0 and var_294_31 or var_294_31 * (var_294_36 / var_294_35)

				if var_294_37 > 0 and var_294_31 < var_294_37 then
					arg_291_1.talkMaxDuration = var_294_37

					if var_294_37 + var_294_30 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_37 + var_294_30
					end
				end

				arg_291_1.text_.text = var_294_34
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319381", "319381070", "story_v_out_319381.awb") ~= 0 then
					local var_294_38 = manager.audio:GetVoiceLength("story_v_out_319381", "319381070", "story_v_out_319381.awb") / 1000

					if var_294_38 + var_294_30 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_38 + var_294_30
					end

					if var_294_33.prefab_name ~= "" and arg_291_1.actors_[var_294_33.prefab_name] ~= nil then
						local var_294_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_33.prefab_name].transform, "story_v_out_319381", "319381070", "story_v_out_319381.awb")

						arg_291_1:RecordAudio("319381070", var_294_39)
						arg_291_1:RecordAudio("319381070", var_294_39)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_319381", "319381070", "story_v_out_319381.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_319381", "319381070", "story_v_out_319381.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_40 = math.max(var_294_31, arg_291_1.talkMaxDuration)

			if var_294_30 <= arg_291_1.time_ and arg_291_1.time_ < var_294_30 + var_294_40 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_30) / var_294_40

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_30 + var_294_40 and arg_291_1.time_ < var_294_30 + var_294_40 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_291_1:InitPlayNodeList()
	end,
	Play319381071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319381071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play319381072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1084ui_story"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect1084ui_story == nil then
				arg_295_1.var_.characterEffect1084ui_story = var_298_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.characterEffect1084ui_story and not isNil(var_298_0) then
					local var_298_4 = Mathf.Lerp(0, 0.5, var_298_3)

					arg_295_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1084ui_story.fillRatio = var_298_4
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect1084ui_story then
				local var_298_5 = 0.5

				arg_295_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1084ui_story.fillRatio = var_298_5
			end

			local var_298_6 = 0
			local var_298_7 = 1.125

			if var_298_6 < arg_295_1.time_ and arg_295_1.time_ <= var_298_6 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_8 = arg_295_1:GetWordFromCfg(319381071)
				local var_298_9 = arg_295_1:FormatText(var_298_8.content)

				arg_295_1.text_.text = var_298_9

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_10 = 45
				local var_298_11 = utf8.len(var_298_9)
				local var_298_12 = var_298_10 <= 0 and var_298_7 or var_298_7 * (var_298_11 / var_298_10)

				if var_298_12 > 0 and var_298_7 < var_298_12 then
					arg_295_1.talkMaxDuration = var_298_12

					if var_298_12 + var_298_6 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_12 + var_298_6
					end
				end

				arg_295_1.text_.text = var_298_9
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_13 = math.max(var_298_7, arg_295_1.talkMaxDuration)

			if var_298_6 <= arg_295_1.time_ and arg_295_1.time_ < var_298_6 + var_298_13 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_6) / var_298_13

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_6 + var_298_13 and arg_295_1.time_ < var_298_6 + var_298_13 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play319381072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 319381072
		arg_299_1.duration_ = 5.8

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play319381073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = "STblack"

			if arg_299_1.bgs_[var_302_0] == nil then
				local var_302_1 = Object.Instantiate(arg_299_1.paintGo_)

				var_302_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_302_0)
				var_302_1.name = var_302_0
				var_302_1.transform.parent = arg_299_1.stage_.transform
				var_302_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.bgs_[var_302_0] = var_302_1
			end

			local var_302_2 = 0

			if var_302_2 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				local var_302_3 = manager.ui.mainCamera.transform.localPosition
				local var_302_4 = Vector3.New(0, 0, 10) + Vector3.New(var_302_3.x, var_302_3.y, 0)
				local var_302_5 = arg_299_1.bgs_.STblack

				var_302_5.transform.localPosition = var_302_4
				var_302_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_6 = var_302_5:GetComponent("SpriteRenderer")

				if var_302_6 and var_302_6.sprite then
					local var_302_7 = (var_302_5.transform.localPosition - var_302_3).z
					local var_302_8 = manager.ui.mainCameraCom_
					local var_302_9 = 2 * var_302_7 * Mathf.Tan(var_302_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_302_10 = var_302_9 * var_302_8.aspect
					local var_302_11 = var_302_6.sprite.bounds.size.x
					local var_302_12 = var_302_6.sprite.bounds.size.y
					local var_302_13 = var_302_10 / var_302_11
					local var_302_14 = var_302_9 / var_302_12
					local var_302_15 = var_302_14 < var_302_13 and var_302_13 or var_302_14

					var_302_5.transform.localScale = Vector3.New(var_302_15, var_302_15, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "STblack" then
						iter_302_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_302_16 = 0

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 then
				local var_302_17 = arg_299_1.fswbg_.transform:Find("textbox/adapt/content") or arg_299_1.fswbg_.transform:Find("textbox/content")
				local var_302_18 = arg_299_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_302_19 = var_302_17:GetComponent("Text")
				local var_302_20 = var_302_17:GetComponent("RectTransform")

				var_302_19.alignment = UnityEngine.TextAnchor.LowerCenter
				var_302_20.offsetMin = Vector2.New(0, 0)
				var_302_20.offsetMax = Vector2.New(0, 0)
			end

			local var_302_21 = 0

			if var_302_21 < arg_299_1.time_ and arg_299_1.time_ <= var_302_21 + arg_302_0 then
				arg_299_1.fswbg_:SetActive(true)
				arg_299_1.dialog_:SetActive(false)

				arg_299_1.fswtw_.percent = 0

				local var_302_22 = arg_299_1:GetWordFromCfg(319381072)
				local var_302_23 = arg_299_1:FormatText(var_302_22.content)

				arg_299_1.fswt_.text = var_302_23

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.fswt_)

				arg_299_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_299_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_299_1.fswtw_:SetDirty()

				arg_299_1.typewritterCharCountI18N = 0

				SetActive(arg_299_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_299_1:ShowNextGo(false)
			end

			local var_302_24 = 0.8

			if var_302_24 < arg_299_1.time_ and arg_299_1.time_ <= var_302_24 + arg_302_0 then
				arg_299_1.var_.oldValueTypewriter = arg_299_1.fswtw_.percent

				SetActive(arg_299_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_299_1:ShowNextGo(false)
			end

			local var_302_25 = 19
			local var_302_26 = 1.26666666666667
			local var_302_27 = arg_299_1:GetWordFromCfg(319381072)
			local var_302_28 = arg_299_1:FormatText(var_302_27.content)
			local var_302_29, var_302_30 = arg_299_1:GetPercentByPara(var_302_28, 1)

			if var_302_24 < arg_299_1.time_ and arg_299_1.time_ <= var_302_24 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				local var_302_31 = var_302_25 <= 0 and var_302_26 or var_302_26 * ((var_302_30 - arg_299_1.typewritterCharCountI18N) / var_302_25)

				if var_302_31 > 0 and var_302_26 < var_302_31 then
					arg_299_1.talkMaxDuration = var_302_31

					if var_302_31 + var_302_24 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_31 + var_302_24
					end
				end
			end

			local var_302_32 = 1.26666666666667
			local var_302_33 = math.max(var_302_32, arg_299_1.talkMaxDuration)

			if var_302_24 <= arg_299_1.time_ and arg_299_1.time_ < var_302_24 + var_302_33 then
				local var_302_34 = (arg_299_1.time_ - var_302_24) / var_302_33

				arg_299_1.fswtw_.percent = Mathf.Lerp(arg_299_1.var_.oldValueTypewriter, var_302_29, var_302_34)
				arg_299_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_299_1.fswtw_:SetDirty()
			end

			if arg_299_1.time_ >= var_302_24 + var_302_33 and arg_299_1.time_ < var_302_24 + var_302_33 + arg_302_0 then
				arg_299_1.fswtw_.percent = var_302_29

				arg_299_1.fswtw_:SetDirty()
				arg_299_1:ShowNextGo(true)

				arg_299_1.typewritterCharCountI18N = var_302_30
			end

			local var_302_35 = 0

			if var_302_35 < arg_299_1.time_ and arg_299_1.time_ <= var_302_35 + arg_302_0 then
				arg_299_1.cswbg_:SetActive(true)

				local var_302_36 = arg_299_1.cswt_:GetComponent("RectTransform")

				arg_299_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_302_36.offsetMin = Vector2.New(410, 330)
				var_302_36.offsetMax = Vector2.New(-400, -175)

				local var_302_37 = arg_299_1:GetWordFromCfg(419016)
				local var_302_38 = arg_299_1:FormatText(var_302_37.content)

				arg_299_1.cswt_.text = var_302_38

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.cswt_)

				arg_299_1.cswt_.fontSize = 180
				arg_299_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_299_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_299_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_302_39 = arg_299_1.actors_["1084ui_story"].transform
			local var_302_40 = 0

			if var_302_40 < arg_299_1.time_ and arg_299_1.time_ <= var_302_40 + arg_302_0 then
				arg_299_1.var_.moveOldPos1084ui_story = var_302_39.localPosition
			end

			local var_302_41 = 0.001

			if var_302_40 <= arg_299_1.time_ and arg_299_1.time_ < var_302_40 + var_302_41 then
				local var_302_42 = (arg_299_1.time_ - var_302_40) / var_302_41
				local var_302_43 = Vector3.New(0, 100, 0)

				var_302_39.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1084ui_story, var_302_43, var_302_42)

				local var_302_44 = manager.ui.mainCamera.transform.position - var_302_39.position

				var_302_39.forward = Vector3.New(var_302_44.x, var_302_44.y, var_302_44.z)

				local var_302_45 = var_302_39.localEulerAngles

				var_302_45.z = 0
				var_302_45.x = 0
				var_302_39.localEulerAngles = var_302_45
			end

			if arg_299_1.time_ >= var_302_40 + var_302_41 and arg_299_1.time_ < var_302_40 + var_302_41 + arg_302_0 then
				var_302_39.localPosition = Vector3.New(0, 100, 0)

				local var_302_46 = manager.ui.mainCamera.transform.position - var_302_39.position

				var_302_39.forward = Vector3.New(var_302_46.x, var_302_46.y, var_302_46.z)

				local var_302_47 = var_302_39.localEulerAngles

				var_302_47.z = 0
				var_302_47.x = 0
				var_302_39.localEulerAngles = var_302_47
			end

			local var_302_48 = arg_299_1.actors_["10066ui_story"].transform
			local var_302_49 = 0

			if var_302_49 < arg_299_1.time_ and arg_299_1.time_ <= var_302_49 + arg_302_0 then
				arg_299_1.var_.moveOldPos10066ui_story = var_302_48.localPosition
			end

			local var_302_50 = 0.001

			if var_302_49 <= arg_299_1.time_ and arg_299_1.time_ < var_302_49 + var_302_50 then
				local var_302_51 = (arg_299_1.time_ - var_302_49) / var_302_50
				local var_302_52 = Vector3.New(0, 100, 0)

				var_302_48.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10066ui_story, var_302_52, var_302_51)

				local var_302_53 = manager.ui.mainCamera.transform.position - var_302_48.position

				var_302_48.forward = Vector3.New(var_302_53.x, var_302_53.y, var_302_53.z)

				local var_302_54 = var_302_48.localEulerAngles

				var_302_54.z = 0
				var_302_54.x = 0
				var_302_48.localEulerAngles = var_302_54
			end

			if arg_299_1.time_ >= var_302_49 + var_302_50 and arg_299_1.time_ < var_302_49 + var_302_50 + arg_302_0 then
				var_302_48.localPosition = Vector3.New(0, 100, 0)

				local var_302_55 = manager.ui.mainCamera.transform.position - var_302_48.position

				var_302_48.forward = Vector3.New(var_302_55.x, var_302_55.y, var_302_55.z)

				local var_302_56 = var_302_48.localEulerAngles

				var_302_56.z = 0
				var_302_56.x = 0
				var_302_48.localEulerAngles = var_302_56
			end

			local var_302_57 = 0.8
			local var_302_58 = 5
			local var_302_59 = manager.audio:GetVoiceLength("story_v_out_319381", "319381072", "story_v_out_319381.awb") / 1000

			if var_302_59 > 0 and var_302_58 < var_302_59 and var_302_59 + var_302_57 > arg_299_1.duration_ then
				local var_302_60 = var_302_59

				arg_299_1.duration_ = var_302_59 + var_302_57
			end

			if var_302_57 < arg_299_1.time_ and arg_299_1.time_ <= var_302_57 + arg_302_0 then
				local var_302_61 = "play"
				local var_302_62 = "voice"

				arg_299_1:AudioAction(var_302_61, var_302_62, "story_v_out_319381", "319381072", "story_v_out_319381.awb")
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_299_1:InitPlayNodeList()
	end,
	Play319381073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 319381073
		arg_303_1.duration_ = 1.93

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play319381074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.fswbg_:SetActive(true)
				arg_303_1.dialog_:SetActive(false)

				arg_303_1.fswtw_.percent = 0

				local var_306_1 = arg_303_1:GetWordFromCfg(319381073)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.fswt_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.fswt_)

				arg_303_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_303_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_303_1.fswtw_:SetDirty()

				arg_303_1.typewritterCharCountI18N = 0

				SetActive(arg_303_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_303_1:ShowNextGo(false)
			end

			local var_306_3 = 0.133333333333333

			if var_306_3 < arg_303_1.time_ and arg_303_1.time_ <= var_306_3 + arg_306_0 then
				arg_303_1.var_.oldValueTypewriter = arg_303_1.fswtw_.percent

				SetActive(arg_303_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_303_1:ShowNextGo(false)
			end

			local var_306_4 = 5
			local var_306_5 = 0.333333333333333
			local var_306_6 = arg_303_1:GetWordFromCfg(319381073)
			local var_306_7 = arg_303_1:FormatText(var_306_6.content)
			local var_306_8, var_306_9 = arg_303_1:GetPercentByPara(var_306_7, 1)

			if var_306_3 < arg_303_1.time_ and arg_303_1.time_ <= var_306_3 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0

				local var_306_10 = var_306_4 <= 0 and var_306_5 or var_306_5 * ((var_306_9 - arg_303_1.typewritterCharCountI18N) / var_306_4)

				if var_306_10 > 0 and var_306_5 < var_306_10 then
					arg_303_1.talkMaxDuration = var_306_10

					if var_306_10 + var_306_3 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_10 + var_306_3
					end
				end
			end

			local var_306_11 = 0.333333333333333
			local var_306_12 = math.max(var_306_11, arg_303_1.talkMaxDuration)

			if var_306_3 <= arg_303_1.time_ and arg_303_1.time_ < var_306_3 + var_306_12 then
				local var_306_13 = (arg_303_1.time_ - var_306_3) / var_306_12

				arg_303_1.fswtw_.percent = Mathf.Lerp(arg_303_1.var_.oldValueTypewriter, var_306_8, var_306_13)
				arg_303_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_303_1.fswtw_:SetDirty()
			end

			if arg_303_1.time_ >= var_306_3 + var_306_12 and arg_303_1.time_ < var_306_3 + var_306_12 + arg_306_0 then
				arg_303_1.fswtw_.percent = var_306_8

				arg_303_1.fswtw_:SetDirty()
				arg_303_1:ShowNextGo(true)

				arg_303_1.typewritterCharCountI18N = var_306_9
			end

			local var_306_14 = 0.133333333333333
			local var_306_15 = 1.8
			local var_306_16 = manager.audio:GetVoiceLength("story_v_out_319381", "319381073", "story_v_out_319381.awb") / 1000

			if var_306_16 > 0 and var_306_15 < var_306_16 and var_306_16 + var_306_14 > arg_303_1.duration_ then
				local var_306_17 = var_306_16

				arg_303_1.duration_ = var_306_16 + var_306_14
			end

			if var_306_14 < arg_303_1.time_ and arg_303_1.time_ <= var_306_14 + arg_306_0 then
				local var_306_18 = "play"
				local var_306_19 = "voice"

				arg_303_1:AudioAction(var_306_18, var_306_19, "story_v_out_319381", "319381073", "story_v_out_319381.awb")
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play319381074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 319381074
		arg_307_1.duration_ = 7.47

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play319381075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.fswbg_:SetActive(true)
				arg_307_1.dialog_:SetActive(false)

				arg_307_1.fswtw_.percent = 0

				local var_310_1 = arg_307_1:GetWordFromCfg(319381074)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.fswt_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.fswt_)

				arg_307_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_307_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_307_1.fswtw_:SetDirty()

				arg_307_1.typewritterCharCountI18N = 0

				SetActive(arg_307_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_307_1:ShowNextGo(false)
			end

			local var_310_3 = 0.133333333333333

			if var_310_3 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 then
				arg_307_1.var_.oldValueTypewriter = arg_307_1.fswtw_.percent

				SetActive(arg_307_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_307_1:ShowNextGo(false)
			end

			local var_310_4 = 29
			local var_310_5 = 1.93333333333333
			local var_310_6 = arg_307_1:GetWordFromCfg(319381074)
			local var_310_7 = arg_307_1:FormatText(var_310_6.content)
			local var_310_8, var_310_9 = arg_307_1:GetPercentByPara(var_310_7, 1)

			if var_310_3 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				local var_310_10 = var_310_4 <= 0 and var_310_5 or var_310_5 * ((var_310_9 - arg_307_1.typewritterCharCountI18N) / var_310_4)

				if var_310_10 > 0 and var_310_5 < var_310_10 then
					arg_307_1.talkMaxDuration = var_310_10

					if var_310_10 + var_310_3 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_3
					end
				end
			end

			local var_310_11 = 1.93333333333333
			local var_310_12 = math.max(var_310_11, arg_307_1.talkMaxDuration)

			if var_310_3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_3 + var_310_12 then
				local var_310_13 = (arg_307_1.time_ - var_310_3) / var_310_12

				arg_307_1.fswtw_.percent = Mathf.Lerp(arg_307_1.var_.oldValueTypewriter, var_310_8, var_310_13)
				arg_307_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_307_1.fswtw_:SetDirty()
			end

			if arg_307_1.time_ >= var_310_3 + var_310_12 and arg_307_1.time_ < var_310_3 + var_310_12 + arg_310_0 then
				arg_307_1.fswtw_.percent = var_310_8

				arg_307_1.fswtw_:SetDirty()
				arg_307_1:ShowNextGo(true)

				arg_307_1.typewritterCharCountI18N = var_310_9
			end

			local var_310_14 = 0.133333333333333
			local var_310_15 = 7.333
			local var_310_16 = manager.audio:GetVoiceLength("story_v_out_319381", "319381074", "story_v_out_319381.awb") / 1000

			if var_310_16 > 0 and var_310_15 < var_310_16 and var_310_16 + var_310_14 > arg_307_1.duration_ then
				local var_310_17 = var_310_16

				arg_307_1.duration_ = var_310_16 + var_310_14
			end

			if var_310_14 < arg_307_1.time_ and arg_307_1.time_ <= var_310_14 + arg_310_0 then
				local var_310_18 = "play"
				local var_310_19 = "voice"

				arg_307_1:AudioAction(var_310_18, var_310_19, "story_v_out_319381", "319381074", "story_v_out_319381.awb")
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play319381075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319381075
		arg_311_1.duration_ = 2.23

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
			arg_311_1.auto_ = false
		end

		function arg_311_1.playNext_(arg_313_0)
			arg_311_1.onStoryFinished_()
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.fswbg_:SetActive(true)
				arg_311_1.dialog_:SetActive(false)

				arg_311_1.fswtw_.percent = 0

				local var_314_1 = arg_311_1:GetWordFromCfg(319381075)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.fswt_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.fswt_)

				arg_311_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_311_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_311_1.fswtw_:SetDirty()

				arg_311_1.typewritterCharCountI18N = 0

				SetActive(arg_311_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_311_1:ShowNextGo(false)
			end

			local var_314_3 = 0.133333333333333

			if var_314_3 < arg_311_1.time_ and arg_311_1.time_ <= var_314_3 + arg_314_0 then
				arg_311_1.var_.oldValueTypewriter = arg_311_1.fswtw_.percent

				SetActive(arg_311_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_311_1:ShowNextGo(false)
			end

			local var_314_4 = 13
			local var_314_5 = 0.866666666666667
			local var_314_6 = arg_311_1:GetWordFromCfg(319381075)
			local var_314_7 = arg_311_1:FormatText(var_314_6.content)
			local var_314_8, var_314_9 = arg_311_1:GetPercentByPara(var_314_7, 1)

			if var_314_3 < arg_311_1.time_ and arg_311_1.time_ <= var_314_3 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				local var_314_10 = var_314_4 <= 0 and var_314_5 or var_314_5 * ((var_314_9 - arg_311_1.typewritterCharCountI18N) / var_314_4)

				if var_314_10 > 0 and var_314_5 < var_314_10 then
					arg_311_1.talkMaxDuration = var_314_10

					if var_314_10 + var_314_3 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_3
					end
				end
			end

			local var_314_11 = 0.866666666666667
			local var_314_12 = math.max(var_314_11, arg_311_1.talkMaxDuration)

			if var_314_3 <= arg_311_1.time_ and arg_311_1.time_ < var_314_3 + var_314_12 then
				local var_314_13 = (arg_311_1.time_ - var_314_3) / var_314_12

				arg_311_1.fswtw_.percent = Mathf.Lerp(arg_311_1.var_.oldValueTypewriter, var_314_8, var_314_13)
				arg_311_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_311_1.fswtw_:SetDirty()
			end

			if arg_311_1.time_ >= var_314_3 + var_314_12 and arg_311_1.time_ < var_314_3 + var_314_12 + arg_314_0 then
				arg_311_1.fswtw_.percent = var_314_8

				arg_311_1.fswtw_:SetDirty()
				arg_311_1:ShowNextGo(true)

				arg_311_1.typewritterCharCountI18N = var_314_9
			end

			local var_314_14 = 0.133333333333333
			local var_314_15 = 2.1
			local var_314_16 = manager.audio:GetVoiceLength("story_v_out_319381", "319381075", "story_v_out_319381.awb") / 1000

			if var_314_16 > 0 and var_314_15 < var_314_16 and var_314_16 + var_314_14 > arg_311_1.duration_ then
				local var_314_17 = var_314_16

				arg_311_1.duration_ = var_314_16 + var_314_14
			end

			if var_314_14 < arg_311_1.time_ and arg_311_1.time_ <= var_314_14 + arg_314_0 then
				local var_314_18 = "play"
				local var_314_19 = "voice"

				arg_311_1:AudioAction(var_314_18, var_314_19, "story_v_out_319381", "319381075", "story_v_out_319381.awb")
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11l",
		"TextureConfig/Background/I11q",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319381.awb"
	}
}
