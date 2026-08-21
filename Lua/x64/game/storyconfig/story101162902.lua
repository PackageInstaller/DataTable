return {
	Play116292001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116292001
		arg_1_1.duration_ = 4.83

		local var_1_0 = {
			zh = 4.833,
			ja = 4.466
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
				arg_1_0:Play116292002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B13c"

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
				local var_4_5 = arg_1_1.bgs_.B13c

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
					if iter_4_0 ~= "B13c" then
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
			local var_4_23 = 0.15

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

			local var_4_28 = 0.266666666666667
			local var_4_29 = 0.733333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

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

			local var_4_34 = 2
			local var_4_35 = 0.35

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_36 = arg_1_1:FormatText(StoryNameCfg[8].name)

				arg_1_1.leftNameTxt_.text = var_4_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_37 = arg_1_1:GetWordFromCfg(116292001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 14
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292001", "story_v_out_116292.awb") ~= 0 then
					local var_4_42 = manager.audio:GetVoiceLength("story_v_out_116292", "116292001", "story_v_out_116292.awb") / 1000

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end

					if var_4_37.prefab_name ~= "" and arg_1_1.actors_[var_4_37.prefab_name] ~= nil then
						local var_4_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_37.prefab_name].transform, "story_v_out_116292", "116292001", "story_v_out_116292.awb")

						arg_1_1:RecordAudio("116292001", var_4_43)
						arg_1_1:RecordAudio("116292001", var_4_43)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116292", "116292001", "story_v_out_116292.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116292", "116292001", "story_v_out_116292.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_44 and arg_1_1.time_ < var_4_34 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116292002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 116292002
		arg_7_1.duration_ = 2

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play116292003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "1059ui_story"

			if arg_7_1.actors_[var_10_0] == nil then
				local var_10_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_10_1) then
					local var_10_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_7_1.stage_.transform)

					var_10_2.name = var_10_0
					var_10_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_0] = var_10_2

					local var_10_3 = var_10_2:GetComponentInChildren(typeof(CharacterEffect))

					var_10_3.enabled = true

					local var_10_4 = GameObjectTools.GetOrAddComponent(var_10_2, typeof(DynamicBoneHelper))

					if var_10_4 then
						var_10_4:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_3.transform, false)

					arg_7_1.var_[var_10_0 .. "Animator"] = var_10_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_0 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_0 .. "LipSync"] = var_10_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_5 = arg_7_1.actors_["1059ui_story"]
			local var_10_6 = 0

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1059ui_story == nil then
				arg_7_1.var_.characterEffect1059ui_story = var_10_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_7 = 0.2

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_7 and not isNil(var_10_5) then
				local var_10_8 = (arg_7_1.time_ - var_10_6) / var_10_7

				if arg_7_1.var_.characterEffect1059ui_story and not isNil(var_10_5) then
					arg_7_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_6 + var_10_7 and arg_7_1.time_ < var_10_6 + var_10_7 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1059ui_story then
				arg_7_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_10_9 = "1148ui_story"

			if arg_7_1.actors_[var_10_9] == nil then
				local var_10_10 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_10_10) then
					local var_10_11 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_7_1.stage_.transform)

					var_10_11.name = var_10_9
					var_10_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_9] = var_10_11

					local var_10_12 = var_10_11:GetComponentInChildren(typeof(CharacterEffect))

					var_10_12.enabled = true

					local var_10_13 = GameObjectTools.GetOrAddComponent(var_10_11, typeof(DynamicBoneHelper))

					if var_10_13 then
						var_10_13:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_12.transform, false)

					arg_7_1.var_[var_10_9 .. "Animator"] = var_10_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_9 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_9 .. "LipSync"] = var_10_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_14 = arg_7_1.actors_["1148ui_story"]
			local var_10_15 = 0

			if var_10_15 < arg_7_1.time_ and arg_7_1.time_ <= var_10_15 + arg_10_0 and not isNil(var_10_14) and arg_7_1.var_.characterEffect1148ui_story == nil then
				arg_7_1.var_.characterEffect1148ui_story = var_10_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_16 = 0.2

			if var_10_15 <= arg_7_1.time_ and arg_7_1.time_ < var_10_15 + var_10_16 and not isNil(var_10_14) then
				local var_10_17 = (arg_7_1.time_ - var_10_15) / var_10_16

				if arg_7_1.var_.characterEffect1148ui_story and not isNil(var_10_14) then
					local var_10_18 = Mathf.Lerp(0, 0.5, var_10_17)

					arg_7_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1148ui_story.fillRatio = var_10_18
				end
			end

			if arg_7_1.time_ >= var_10_15 + var_10_16 and arg_7_1.time_ < var_10_15 + var_10_16 + arg_10_0 and not isNil(var_10_14) and arg_7_1.var_.characterEffect1148ui_story then
				local var_10_19 = 0.5

				arg_7_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1148ui_story.fillRatio = var_10_19
			end

			local var_10_20 = arg_7_1.actors_["1059ui_story"].transform
			local var_10_21 = 0

			if var_10_21 < arg_7_1.time_ and arg_7_1.time_ <= var_10_21 + arg_10_0 then
				arg_7_1.var_.moveOldPos1059ui_story = var_10_20.localPosition
			end

			local var_10_22 = 0.001

			if var_10_21 <= arg_7_1.time_ and arg_7_1.time_ < var_10_21 + var_10_22 then
				local var_10_23 = (arg_7_1.time_ - var_10_21) / var_10_22
				local var_10_24 = Vector3.New(0, -1.05, -6)

				var_10_20.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1059ui_story, var_10_24, var_10_23)

				local var_10_25 = manager.ui.mainCamera.transform.position - var_10_20.position

				var_10_20.forward = Vector3.New(var_10_25.x, var_10_25.y, var_10_25.z)

				local var_10_26 = var_10_20.localEulerAngles

				var_10_26.z = 0
				var_10_26.x = 0
				var_10_20.localEulerAngles = var_10_26
			end

			if arg_7_1.time_ >= var_10_21 + var_10_22 and arg_7_1.time_ < var_10_21 + var_10_22 + arg_10_0 then
				var_10_20.localPosition = Vector3.New(0, -1.05, -6)

				local var_10_27 = manager.ui.mainCamera.transform.position - var_10_20.position

				var_10_20.forward = Vector3.New(var_10_27.x, var_10_27.y, var_10_27.z)

				local var_10_28 = var_10_20.localEulerAngles

				var_10_28.z = 0
				var_10_28.x = 0
				var_10_20.localEulerAngles = var_10_28
			end

			local var_10_29 = 0

			if var_10_29 < arg_7_1.time_ and arg_7_1.time_ <= var_10_29 + arg_10_0 then
				arg_7_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_10_30 = 0

			if var_10_30 < arg_7_1.time_ and arg_7_1.time_ <= var_10_30 + arg_10_0 then
				arg_7_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_10_31 = 0
			local var_10_32 = 0.125

			if var_10_31 < arg_7_1.time_ and arg_7_1.time_ <= var_10_31 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_33 = arg_7_1:FormatText(StoryNameCfg[28].name)

				arg_7_1.leftNameTxt_.text = var_10_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_34 = arg_7_1:GetWordFromCfg(116292002)
				local var_10_35 = arg_7_1:FormatText(var_10_34.content)

				arg_7_1.text_.text = var_10_35

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_36 = 5
				local var_10_37 = utf8.len(var_10_35)
				local var_10_38 = var_10_36 <= 0 and var_10_32 or var_10_32 * (var_10_37 / var_10_36)

				if var_10_38 > 0 and var_10_32 < var_10_38 then
					arg_7_1.talkMaxDuration = var_10_38

					if var_10_38 + var_10_31 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_38 + var_10_31
					end
				end

				arg_7_1.text_.text = var_10_35
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292002", "story_v_out_116292.awb") ~= 0 then
					local var_10_39 = manager.audio:GetVoiceLength("story_v_out_116292", "116292002", "story_v_out_116292.awb") / 1000

					if var_10_39 + var_10_31 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_39 + var_10_31
					end

					if var_10_34.prefab_name ~= "" and arg_7_1.actors_[var_10_34.prefab_name] ~= nil then
						local var_10_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_34.prefab_name].transform, "story_v_out_116292", "116292002", "story_v_out_116292.awb")

						arg_7_1:RecordAudio("116292002", var_10_40)
						arg_7_1:RecordAudio("116292002", var_10_40)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_116292", "116292002", "story_v_out_116292.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_116292", "116292002", "story_v_out_116292.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_41 = math.max(var_10_32, arg_7_1.talkMaxDuration)

			if var_10_31 <= arg_7_1.time_ and arg_7_1.time_ < var_10_31 + var_10_41 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_31) / var_10_41

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_31 + var_10_41 and arg_7_1.time_ < var_10_31 + var_10_41 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play116292003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 116292003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play116292004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = arg_11_1.actors_["1148ui_story"].transform
			local var_14_1 = 0

			if var_14_1 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.var_.moveOldPos1148ui_story = var_14_0.localPosition
			end

			local var_14_2 = 0.001

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_2 then
				local var_14_3 = (arg_11_1.time_ - var_14_1) / var_14_2
				local var_14_4 = Vector3.New(0, 100, 0)

				var_14_0.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1148ui_story, var_14_4, var_14_3)

				local var_14_5 = manager.ui.mainCamera.transform.position - var_14_0.position

				var_14_0.forward = Vector3.New(var_14_5.x, var_14_5.y, var_14_5.z)

				local var_14_6 = var_14_0.localEulerAngles

				var_14_6.z = 0
				var_14_6.x = 0
				var_14_0.localEulerAngles = var_14_6
			end

			if arg_11_1.time_ >= var_14_1 + var_14_2 and arg_11_1.time_ < var_14_1 + var_14_2 + arg_14_0 then
				var_14_0.localPosition = Vector3.New(0, 100, 0)

				local var_14_7 = manager.ui.mainCamera.transform.position - var_14_0.position

				var_14_0.forward = Vector3.New(var_14_7.x, var_14_7.y, var_14_7.z)

				local var_14_8 = var_14_0.localEulerAngles

				var_14_8.z = 0
				var_14_8.x = 0
				var_14_0.localEulerAngles = var_14_8
			end

			local var_14_9 = arg_11_1.actors_["1059ui_story"].transform
			local var_14_10 = 0

			if var_14_10 < arg_11_1.time_ and arg_11_1.time_ <= var_14_10 + arg_14_0 then
				arg_11_1.var_.moveOldPos1059ui_story = var_14_9.localPosition
			end

			local var_14_11 = 0.001

			if var_14_10 <= arg_11_1.time_ and arg_11_1.time_ < var_14_10 + var_14_11 then
				local var_14_12 = (arg_11_1.time_ - var_14_10) / var_14_11
				local var_14_13 = Vector3.New(0, 100, 0)

				var_14_9.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1059ui_story, var_14_13, var_14_12)

				local var_14_14 = manager.ui.mainCamera.transform.position - var_14_9.position

				var_14_9.forward = Vector3.New(var_14_14.x, var_14_14.y, var_14_14.z)

				local var_14_15 = var_14_9.localEulerAngles

				var_14_15.z = 0
				var_14_15.x = 0
				var_14_9.localEulerAngles = var_14_15
			end

			if arg_11_1.time_ >= var_14_10 + var_14_11 and arg_11_1.time_ < var_14_10 + var_14_11 + arg_14_0 then
				var_14_9.localPosition = Vector3.New(0, 100, 0)

				local var_14_16 = manager.ui.mainCamera.transform.position - var_14_9.position

				var_14_9.forward = Vector3.New(var_14_16.x, var_14_16.y, var_14_16.z)

				local var_14_17 = var_14_9.localEulerAngles

				var_14_17.z = 0
				var_14_17.x = 0
				var_14_9.localEulerAngles = var_14_17
			end

			local var_14_18 = 0
			local var_14_19 = 1.375

			if var_14_18 < arg_11_1.time_ and arg_11_1.time_ <= var_14_18 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_20 = arg_11_1:GetWordFromCfg(116292003)
				local var_14_21 = arg_11_1:FormatText(var_14_20.content)

				arg_11_1.text_.text = var_14_21

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_22 = 55
				local var_14_23 = utf8.len(var_14_21)
				local var_14_24 = var_14_22 <= 0 and var_14_19 or var_14_19 * (var_14_23 / var_14_22)

				if var_14_24 > 0 and var_14_19 < var_14_24 then
					arg_11_1.talkMaxDuration = var_14_24

					if var_14_24 + var_14_18 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_24 + var_14_18
					end
				end

				arg_11_1.text_.text = var_14_21
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_25 = math.max(var_14_19, arg_11_1.talkMaxDuration)

			if var_14_18 <= arg_11_1.time_ and arg_11_1.time_ < var_14_18 + var_14_25 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_18) / var_14_25

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_18 + var_14_25 and arg_11_1.time_ < var_14_18 + var_14_25 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play116292004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 116292004
		arg_15_1.duration_ = 4.73

		local var_15_0 = {
			zh = 4.733,
			ja = 4.266
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play116292005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.55

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[28].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_3 = arg_15_1:GetWordFromCfg(116292004)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 22
				local var_18_6 = utf8.len(var_18_4)
				local var_18_7 = var_18_5 <= 0 and var_18_1 or var_18_1 * (var_18_6 / var_18_5)

				if var_18_7 > 0 and var_18_1 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292004", "story_v_out_116292.awb") ~= 0 then
					local var_18_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292004", "story_v_out_116292.awb") / 1000

					if var_18_8 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_0
					end

					if var_18_3.prefab_name ~= "" and arg_15_1.actors_[var_18_3.prefab_name] ~= nil then
						local var_18_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_3.prefab_name].transform, "story_v_out_116292", "116292004", "story_v_out_116292.awb")

						arg_15_1:RecordAudio("116292004", var_18_9)
						arg_15_1:RecordAudio("116292004", var_18_9)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_116292", "116292004", "story_v_out_116292.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_116292", "116292004", "story_v_out_116292.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_10 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_10 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_10

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_10 and arg_15_1.time_ < var_18_0 + var_18_10 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play116292005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 116292005
		arg_19_1.duration_ = 7

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play116292006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1059ui_story"].transform
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.var_.moveOldPos1059ui_story = var_22_0.localPosition
			end

			local var_22_2 = 0.001

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2
				local var_22_4 = Vector3.New(0, 100, 0)

				var_22_0.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1059ui_story, var_22_4, var_22_3)

				local var_22_5 = manager.ui.mainCamera.transform.position - var_22_0.position

				var_22_0.forward = Vector3.New(var_22_5.x, var_22_5.y, var_22_5.z)

				local var_22_6 = var_22_0.localEulerAngles

				var_22_6.z = 0
				var_22_6.x = 0
				var_22_0.localEulerAngles = var_22_6
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 then
				var_22_0.localPosition = Vector3.New(0, 100, 0)

				local var_22_7 = manager.ui.mainCamera.transform.position - var_22_0.position

				var_22_0.forward = Vector3.New(var_22_7.x, var_22_7.y, var_22_7.z)

				local var_22_8 = var_22_0.localEulerAngles

				var_22_8.z = 0
				var_22_8.x = 0
				var_22_0.localEulerAngles = var_22_8
			end

			local var_22_9 = 0
			local var_22_10 = 1

			if var_22_9 < arg_19_1.time_ and arg_19_1.time_ <= var_22_9 + arg_22_0 then
				local var_22_11 = "play"
				local var_22_12 = "effect"

				arg_19_1:AudioAction(var_22_11, var_22_12, "se_story_16", "se_story_16_archery", "")
			end

			local var_22_13 = 0

			if var_22_13 < arg_19_1.time_ and arg_19_1.time_ <= var_22_13 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_14 = 2

			if var_22_13 <= arg_19_1.time_ and arg_19_1.time_ < var_22_13 + var_22_14 then
				local var_22_15 = (arg_19_1.time_ - var_22_13) / var_22_14
				local var_22_16 = Color.New(1, 1, 1)

				var_22_16.a = Mathf.Lerp(1, 0, var_22_15)
				arg_19_1.mask_.color = var_22_16
			end

			if arg_19_1.time_ >= var_22_13 + var_22_14 and arg_19_1.time_ < var_22_13 + var_22_14 + arg_22_0 then
				local var_22_17 = Color.New(1, 1, 1)
				local var_22_18 = 0

				arg_19_1.mask_.enabled = false
				var_22_17.a = var_22_18
				arg_19_1.mask_.color = var_22_17
			end

			local var_22_19 = manager.ui.mainCamera.transform
			local var_22_20 = 1

			if var_22_20 < arg_19_1.time_ and arg_19_1.time_ <= var_22_20 + arg_22_0 then
				arg_19_1.var_.shakeOldPos = var_22_19.localPosition
			end

			local var_22_21 = 1

			if var_22_20 <= arg_19_1.time_ and arg_19_1.time_ < var_22_20 + var_22_21 then
				local var_22_22 = (arg_19_1.time_ - var_22_20) / 0.066
				local var_22_23, var_22_24 = math.modf(var_22_22)

				var_22_19.localPosition = Vector3.New(var_22_24 * 0.13, var_22_24 * 0.13, var_22_24 * 0.13) + arg_19_1.var_.shakeOldPos
			end

			if arg_19_1.time_ >= var_22_20 + var_22_21 and arg_19_1.time_ < var_22_20 + var_22_21 + arg_22_0 then
				var_22_19.localPosition = arg_19_1.var_.shakeOldPos
			end

			if arg_19_1.frameCnt_ <= 1 then
				arg_19_1.dialog_:SetActive(false)
			end

			local var_22_25 = 1.999999999999
			local var_22_26 = 1.65

			if var_22_25 < arg_19_1.time_ and arg_19_1.time_ <= var_22_25 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				arg_19_1.dialog_:SetActive(true)

				arg_19_1.dialogCg_.alpha = 0

				local var_22_27 = LeanTween.value(arg_19_1.dialog_, 0, 1, 0.3)

				var_22_27:setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
					arg_19_1.dialogCg_.alpha = arg_23_0
				end))
				var_22_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_19_1.dialog_)
					var_22_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_19_1.duration_ = arg_19_1.duration_ + 0.3

				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_28 = arg_19_1:GetWordFromCfg(116292005)
				local var_22_29 = arg_19_1:FormatText(var_22_28.content)

				arg_19_1.text_.text = var_22_29

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_30 = 66
				local var_22_31 = utf8.len(var_22_29)
				local var_22_32 = var_22_30 <= 0 and var_22_26 or var_22_26 * (var_22_31 / var_22_30)

				if var_22_32 > 0 and var_22_26 < var_22_32 then
					arg_19_1.talkMaxDuration = var_22_32
					var_22_25 = var_22_25 + 0.3

					if var_22_32 + var_22_25 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_32 + var_22_25
					end
				end

				arg_19_1.text_.text = var_22_29
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_33 = var_22_25 + 0.3
			local var_22_34 = math.max(var_22_26, arg_19_1.talkMaxDuration)

			if var_22_33 <= arg_19_1.time_ and arg_19_1.time_ < var_22_33 + var_22_34 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_33) / var_22_34

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_33 + var_22_34 and arg_19_1.time_ < var_22_33 + var_22_34 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play116292006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116292006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116292007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.1

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:GetWordFromCfg(116292006)
				local var_28_3 = arg_25_1:FormatText(var_28_2.content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 4
				local var_28_5 = utf8.len(var_28_3)
				local var_28_6 = var_28_4 <= 0 and var_28_1 or var_28_1 * (var_28_5 / var_28_4)

				if var_28_6 > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_7 and arg_25_1.time_ < var_28_0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play116292007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116292007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play116292008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(116292007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 40
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play116292008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116292008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play116292009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.05

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_2

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

				local var_36_3 = arg_33_1:GetWordFromCfg(116292008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 2
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play116292009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116292009
		arg_37_1.duration_ = 5.17

		local var_37_0 = {
			zh = 3.266,
			ja = 5.166
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
				arg_37_0:Play116292010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "1184ui_story"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_37_1.stage_.transform)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentInChildren(typeof(CharacterEffect))

					var_40_3.enabled = true

					local var_40_4 = GameObjectTools.GetOrAddComponent(var_40_2, typeof(DynamicBoneHelper))

					if var_40_4 then
						var_40_4:EnableDynamicBone(false)
					end

					arg_37_1:ShowWeapon(var_40_3.transform, false)

					arg_37_1.var_[var_40_0 .. "Animator"] = var_40_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_37_1.var_[var_40_0 .. "Animator"].applyRootMotion = true
					arg_37_1.var_[var_40_0 .. "LipSync"] = var_40_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_40_5 = arg_37_1.actors_["1184ui_story"].transform
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.var_.moveOldPos1184ui_story = var_40_5.localPosition
			end

			local var_40_7 = 0.001

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7
				local var_40_9 = Vector3.New(-0.7, -0.97, -6)

				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1184ui_story, var_40_9, var_40_8)

				local var_40_10 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_10.x, var_40_10.y, var_40_10.z)

				local var_40_11 = var_40_5.localEulerAngles

				var_40_11.z = 0
				var_40_11.x = 0
				var_40_5.localEulerAngles = var_40_11
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_40_12 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_12.x, var_40_12.y, var_40_12.z)

				local var_40_13 = var_40_5.localEulerAngles

				var_40_13.z = 0
				var_40_13.x = 0
				var_40_5.localEulerAngles = var_40_13
			end

			local var_40_14 = arg_37_1.actors_["1059ui_story"].transform
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.var_.moveOldPos1059ui_story = var_40_14.localPosition
			end

			local var_40_16 = 0.001

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16
				local var_40_18 = Vector3.New(0.7, -1.05, -6)

				var_40_14.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1059ui_story, var_40_18, var_40_17)

				local var_40_19 = manager.ui.mainCamera.transform.position - var_40_14.position

				var_40_14.forward = Vector3.New(var_40_19.x, var_40_19.y, var_40_19.z)

				local var_40_20 = var_40_14.localEulerAngles

				var_40_20.z = 0
				var_40_20.x = 0
				var_40_14.localEulerAngles = var_40_20
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 then
				var_40_14.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_40_21 = manager.ui.mainCamera.transform.position - var_40_14.position

				var_40_14.forward = Vector3.New(var_40_21.x, var_40_21.y, var_40_21.z)

				local var_40_22 = var_40_14.localEulerAngles

				var_40_22.z = 0
				var_40_22.x = 0
				var_40_14.localEulerAngles = var_40_22
			end

			local var_40_23 = arg_37_1.actors_["1059ui_story"]
			local var_40_24 = 0

			if var_40_24 < arg_37_1.time_ and arg_37_1.time_ <= var_40_24 + arg_40_0 and not isNil(var_40_23) and arg_37_1.var_.characterEffect1059ui_story == nil then
				arg_37_1.var_.characterEffect1059ui_story = var_40_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_25 = 0.034

			if var_40_24 <= arg_37_1.time_ and arg_37_1.time_ < var_40_24 + var_40_25 and not isNil(var_40_23) then
				local var_40_26 = (arg_37_1.time_ - var_40_24) / var_40_25

				if arg_37_1.var_.characterEffect1059ui_story and not isNil(var_40_23) then
					local var_40_27 = Mathf.Lerp(0, 0.5, var_40_26)

					arg_37_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1059ui_story.fillRatio = var_40_27
				end
			end

			if arg_37_1.time_ >= var_40_24 + var_40_25 and arg_37_1.time_ < var_40_24 + var_40_25 + arg_40_0 and not isNil(var_40_23) and arg_37_1.var_.characterEffect1059ui_story then
				local var_40_28 = 0.5

				arg_37_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1059ui_story.fillRatio = var_40_28
			end

			local var_40_29 = arg_37_1.actors_["1184ui_story"]
			local var_40_30 = 0

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 and not isNil(var_40_29) and arg_37_1.var_.characterEffect1184ui_story == nil then
				arg_37_1.var_.characterEffect1184ui_story = var_40_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_31 = 0.2

			if var_40_30 <= arg_37_1.time_ and arg_37_1.time_ < var_40_30 + var_40_31 and not isNil(var_40_29) then
				local var_40_32 = (arg_37_1.time_ - var_40_30) / var_40_31

				if arg_37_1.var_.characterEffect1184ui_story and not isNil(var_40_29) then
					arg_37_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_30 + var_40_31 and arg_37_1.time_ < var_40_30 + var_40_31 + arg_40_0 and not isNil(var_40_29) and arg_37_1.var_.characterEffect1184ui_story then
				arg_37_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_40_33 = 0

			if var_40_33 < arg_37_1.time_ and arg_37_1.time_ <= var_40_33 + arg_40_0 then
				arg_37_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_40_34 = 0

			if var_40_34 < arg_37_1.time_ and arg_37_1.time_ <= var_40_34 + arg_40_0 then
				arg_37_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_40_35 = 0

			if var_40_35 < arg_37_1.time_ and arg_37_1.time_ <= var_40_35 + arg_40_0 then
				arg_37_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_40_36 = 0
			local var_40_37 = 0.375

			if var_40_36 < arg_37_1.time_ and arg_37_1.time_ <= var_40_36 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_38 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_39 = arg_37_1:GetWordFromCfg(116292009)
				local var_40_40 = arg_37_1:FormatText(var_40_39.content)

				arg_37_1.text_.text = var_40_40

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_41 = 15
				local var_40_42 = utf8.len(var_40_40)
				local var_40_43 = var_40_41 <= 0 and var_40_37 or var_40_37 * (var_40_42 / var_40_41)

				if var_40_43 > 0 and var_40_37 < var_40_43 then
					arg_37_1.talkMaxDuration = var_40_43

					if var_40_43 + var_40_36 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_43 + var_40_36
					end
				end

				arg_37_1.text_.text = var_40_40
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292009", "story_v_out_116292.awb") ~= 0 then
					local var_40_44 = manager.audio:GetVoiceLength("story_v_out_116292", "116292009", "story_v_out_116292.awb") / 1000

					if var_40_44 + var_40_36 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_44 + var_40_36
					end

					if var_40_39.prefab_name ~= "" and arg_37_1.actors_[var_40_39.prefab_name] ~= nil then
						local var_40_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_39.prefab_name].transform, "story_v_out_116292", "116292009", "story_v_out_116292.awb")

						arg_37_1:RecordAudio("116292009", var_40_45)
						arg_37_1:RecordAudio("116292009", var_40_45)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_116292", "116292009", "story_v_out_116292.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_116292", "116292009", "story_v_out_116292.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_46 = math.max(var_40_37, arg_37_1.talkMaxDuration)

			if var_40_36 <= arg_37_1.time_ and arg_37_1.time_ < var_40_36 + var_40_46 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_36) / var_40_46

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_36 + var_40_46 and arg_37_1.time_ < var_40_36 + var_40_46 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play116292010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116292010
		arg_41_1.duration_ = 3.07

		local var_41_0 = {
			zh = 2.433333333332,
			ja = 3.066
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
				arg_41_0:Play116292011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1059ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1059ui_story == nil then
				arg_41_1.var_.characterEffect1059ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1059ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1059ui_story then
				arg_41_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1184ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1184ui_story == nil then
				arg_41_1.var_.characterEffect1184ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.2

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect1184ui_story and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1184ui_story.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1184ui_story then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1184ui_story.fillRatio = var_44_9
			end

			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			local var_44_11 = 0

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_44_12 = 0
			local var_44_13 = 0.2

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[28].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(116292010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292010", "story_v_out_116292.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_116292", "116292010", "story_v_out_116292.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_116292", "116292010", "story_v_out_116292.awb")

						arg_41_1:RecordAudio("116292010", var_44_21)
						arg_41_1:RecordAudio("116292010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_116292", "116292010", "story_v_out_116292.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_116292", "116292010", "story_v_out_116292.awb")
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
	Play116292011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116292011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play116292012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1184ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1184ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1184ui_story, var_48_4, var_48_3)

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

			local var_48_9 = arg_45_1.actors_["1059ui_story"].transform
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.var_.moveOldPos1059ui_story = var_48_9.localPosition
			end

			local var_48_11 = 0.001

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11
				local var_48_13 = Vector3.New(0, 100, 0)

				var_48_9.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1059ui_story, var_48_13, var_48_12)

				local var_48_14 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_14.x, var_48_14.y, var_48_14.z)

				local var_48_15 = var_48_9.localEulerAngles

				var_48_15.z = 0
				var_48_15.x = 0
				var_48_9.localEulerAngles = var_48_15
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 then
				var_48_9.localPosition = Vector3.New(0, 100, 0)

				local var_48_16 = manager.ui.mainCamera.transform.position - var_48_9.position

				var_48_9.forward = Vector3.New(var_48_16.x, var_48_16.y, var_48_16.z)

				local var_48_17 = var_48_9.localEulerAngles

				var_48_17.z = 0
				var_48_17.x = 0
				var_48_9.localEulerAngles = var_48_17
			end

			local var_48_18 = 0
			local var_48_19 = 0.65

			if var_48_18 < arg_45_1.time_ and arg_45_1.time_ <= var_48_18 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_20 = arg_45_1:GetWordFromCfg(116292011)
				local var_48_21 = arg_45_1:FormatText(var_48_20.content)

				arg_45_1.text_.text = var_48_21

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_22 = 26
				local var_48_23 = utf8.len(var_48_21)
				local var_48_24 = var_48_22 <= 0 and var_48_19 or var_48_19 * (var_48_23 / var_48_22)

				if var_48_24 > 0 and var_48_19 < var_48_24 then
					arg_45_1.talkMaxDuration = var_48_24

					if var_48_24 + var_48_18 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_18
					end
				end

				arg_45_1.text_.text = var_48_21
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_19, arg_45_1.talkMaxDuration)

			if var_48_18 <= arg_45_1.time_ and arg_45_1.time_ < var_48_18 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_18) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_18 + var_48_25 and arg_45_1.time_ < var_48_18 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play116292012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116292012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play116292013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.225

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(116292012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 49
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play116292013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116292013
		arg_53_1.duration_ = 3.43

		local var_53_0 = {
			zh = 3.433,
			ja = 0.999999999999
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
				arg_53_0:Play116292014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1184ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1184ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1184ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, 100, 0)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["1059ui_story"].transform
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.var_.moveOldPos1059ui_story = var_56_9.localPosition
			end

			local var_56_11 = 0.001

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11
				local var_56_13 = Vector3.New(0, 100, 0)

				var_56_9.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1059ui_story, var_56_13, var_56_12)

				local var_56_14 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_14.x, var_56_14.y, var_56_14.z)

				local var_56_15 = var_56_9.localEulerAngles

				var_56_15.z = 0
				var_56_15.x = 0
				var_56_9.localEulerAngles = var_56_15
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 then
				var_56_9.localPosition = Vector3.New(0, 100, 0)

				local var_56_16 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_16.x, var_56_16.y, var_56_16.z)

				local var_56_17 = var_56_9.localEulerAngles

				var_56_17.z = 0
				var_56_17.x = 0
				var_56_9.localEulerAngles = var_56_17
			end

			local var_56_18 = manager.ui.mainCamera.transform
			local var_56_19 = 0

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_18.localPosition
			end

			local var_56_20 = 0.6

			if var_56_19 <= arg_53_1.time_ and arg_53_1.time_ < var_56_19 + var_56_20 then
				local var_56_21 = (arg_53_1.time_ - var_56_19) / 0.066
				local var_56_22, var_56_23 = math.modf(var_56_21)

				var_56_18.localPosition = Vector3.New(var_56_23 * 0.13, var_56_23 * 0.13, var_56_23 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= var_56_19 + var_56_20 and arg_53_1.time_ < var_56_19 + var_56_20 + arg_56_0 then
				var_56_18.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_24 = 0

			if var_56_24 < arg_53_1.time_ and arg_53_1.time_ <= var_56_24 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_25 = 0.6

			if arg_53_1.time_ >= var_56_24 + var_56_25 and arg_53_1.time_ < var_56_24 + var_56_25 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_26 = 0
			local var_56_27 = 0.375

			if var_56_26 < arg_53_1.time_ and arg_53_1.time_ <= var_56_26 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_28 = arg_53_1:FormatText(StoryNameCfg[8].name)

				arg_53_1.leftNameTxt_.text = var_56_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_29 = arg_53_1:GetWordFromCfg(116292013)
				local var_56_30 = arg_53_1:FormatText(var_56_29.content)

				arg_53_1.text_.text = var_56_30

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_31 = 15
				local var_56_32 = utf8.len(var_56_30)
				local var_56_33 = var_56_31 <= 0 and var_56_27 or var_56_27 * (var_56_32 / var_56_31)

				if var_56_33 > 0 and var_56_27 < var_56_33 then
					arg_53_1.talkMaxDuration = var_56_33

					if var_56_33 + var_56_26 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_33 + var_56_26
					end
				end

				arg_53_1.text_.text = var_56_30
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292013", "story_v_out_116292.awb") ~= 0 then
					local var_56_34 = manager.audio:GetVoiceLength("story_v_out_116292", "116292013", "story_v_out_116292.awb") / 1000

					if var_56_34 + var_56_26 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_34 + var_56_26
					end

					if var_56_29.prefab_name ~= "" and arg_53_1.actors_[var_56_29.prefab_name] ~= nil then
						local var_56_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_29.prefab_name].transform, "story_v_out_116292", "116292013", "story_v_out_116292.awb")

						arg_53_1:RecordAudio("116292013", var_56_35)
						arg_53_1:RecordAudio("116292013", var_56_35)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_116292", "116292013", "story_v_out_116292.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_116292", "116292013", "story_v_out_116292.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_36 = math.max(var_56_27, arg_53_1.talkMaxDuration)

			if var_56_26 <= arg_53_1.time_ and arg_53_1.time_ < var_56_26 + var_56_36 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_26) / var_56_36

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_26 + var_56_36 and arg_53_1.time_ < var_56_26 + var_56_36 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play116292014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116292014
		arg_57_1.duration_ = 2

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play116292015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1184ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1184ui_story == nil then
				arg_57_1.var_.characterEffect1184ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1184ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1184ui_story then
				arg_57_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_60_4 = arg_57_1.actors_["1148ui_story"]
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1148ui_story == nil then
				arg_57_1.var_.characterEffect1148ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_6 = 0.2

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 and not isNil(var_60_4) then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6

				if arg_57_1.var_.characterEffect1148ui_story and not isNil(var_60_4) then
					local var_60_8 = Mathf.Lerp(0, 0.5, var_60_7)

					arg_57_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1148ui_story.fillRatio = var_60_8
				end
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1148ui_story then
				local var_60_9 = 0.5

				arg_57_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1148ui_story.fillRatio = var_60_9
			end

			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_60_11 = 0

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_60_12 = arg_57_1.actors_["1184ui_story"].transform
			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1.var_.moveOldPos1184ui_story = var_60_12.localPosition

				local var_60_14 = "1184ui_story"

				arg_57_1:ShowWeapon(arg_57_1.var_[var_60_14 .. "Animator"].transform, true)
			end

			local var_60_15 = 0.001

			if var_60_13 <= arg_57_1.time_ and arg_57_1.time_ < var_60_13 + var_60_15 then
				local var_60_16 = (arg_57_1.time_ - var_60_13) / var_60_15
				local var_60_17 = Vector3.New(0, -0.97, -6)

				var_60_12.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1184ui_story, var_60_17, var_60_16)

				local var_60_18 = manager.ui.mainCamera.transform.position - var_60_12.position

				var_60_12.forward = Vector3.New(var_60_18.x, var_60_18.y, var_60_18.z)

				local var_60_19 = var_60_12.localEulerAngles

				var_60_19.z = 0
				var_60_19.x = 0
				var_60_12.localEulerAngles = var_60_19
			end

			if arg_57_1.time_ >= var_60_13 + var_60_15 and arg_57_1.time_ < var_60_13 + var_60_15 + arg_60_0 then
				var_60_12.localPosition = Vector3.New(0, -0.97, -6)

				local var_60_20 = manager.ui.mainCamera.transform.position - var_60_12.position

				var_60_12.forward = Vector3.New(var_60_20.x, var_60_20.y, var_60_20.z)

				local var_60_21 = var_60_12.localEulerAngles

				var_60_21.z = 0
				var_60_21.x = 0
				var_60_12.localEulerAngles = var_60_21
			end

			local var_60_22 = 0
			local var_60_23 = 0.175

			if var_60_22 < arg_57_1.time_ and arg_57_1.time_ <= var_60_22 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_24 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_25 = arg_57_1:GetWordFromCfg(116292014)
				local var_60_26 = arg_57_1:FormatText(var_60_25.content)

				arg_57_1.text_.text = var_60_26

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_27 = 7
				local var_60_28 = utf8.len(var_60_26)
				local var_60_29 = var_60_27 <= 0 and var_60_23 or var_60_23 * (var_60_28 / var_60_27)

				if var_60_29 > 0 and var_60_23 < var_60_29 then
					arg_57_1.talkMaxDuration = var_60_29

					if var_60_29 + var_60_22 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_29 + var_60_22
					end
				end

				arg_57_1.text_.text = var_60_26
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292014", "story_v_out_116292.awb") ~= 0 then
					local var_60_30 = manager.audio:GetVoiceLength("story_v_out_116292", "116292014", "story_v_out_116292.awb") / 1000

					if var_60_30 + var_60_22 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_30 + var_60_22
					end

					if var_60_25.prefab_name ~= "" and arg_57_1.actors_[var_60_25.prefab_name] ~= nil then
						local var_60_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_25.prefab_name].transform, "story_v_out_116292", "116292014", "story_v_out_116292.awb")

						arg_57_1:RecordAudio("116292014", var_60_31)
						arg_57_1:RecordAudio("116292014", var_60_31)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116292", "116292014", "story_v_out_116292.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116292", "116292014", "story_v_out_116292.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_32 = math.max(var_60_23, arg_57_1.talkMaxDuration)

			if var_60_22 <= arg_57_1.time_ and arg_57_1.time_ < var_60_22 + var_60_32 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_22) / var_60_32

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_22 + var_60_32 and arg_57_1.time_ < var_60_22 + var_60_32 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play116292015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116292015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play116292016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1148ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1148ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, 100, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1148ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, 100, 0)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1184ui_story"].transform
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1.var_.moveOldPos1184ui_story = var_64_9.localPosition
			end

			local var_64_11 = 0.001

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11
				local var_64_13 = Vector3.New(0, 100, 0)

				var_64_9.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1184ui_story, var_64_13, var_64_12)

				local var_64_14 = manager.ui.mainCamera.transform.position - var_64_9.position

				var_64_9.forward = Vector3.New(var_64_14.x, var_64_14.y, var_64_14.z)

				local var_64_15 = var_64_9.localEulerAngles

				var_64_15.z = 0
				var_64_15.x = 0
				var_64_9.localEulerAngles = var_64_15
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 then
				var_64_9.localPosition = Vector3.New(0, 100, 0)

				local var_64_16 = manager.ui.mainCamera.transform.position - var_64_9.position

				var_64_9.forward = Vector3.New(var_64_16.x, var_64_16.y, var_64_16.z)

				local var_64_17 = var_64_9.localEulerAngles

				var_64_17.z = 0
				var_64_17.x = 0
				var_64_9.localEulerAngles = var_64_17
			end

			local var_64_18 = 0
			local var_64_19 = 0.85

			if var_64_18 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_20 = arg_61_1:GetWordFromCfg(116292015)
				local var_64_21 = arg_61_1:FormatText(var_64_20.content)

				arg_61_1.text_.text = var_64_21

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_22 = 34
				local var_64_23 = utf8.len(var_64_21)
				local var_64_24 = var_64_22 <= 0 and var_64_19 or var_64_19 * (var_64_23 / var_64_22)

				if var_64_24 > 0 and var_64_19 < var_64_24 then
					arg_61_1.talkMaxDuration = var_64_24

					if var_64_24 + var_64_18 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_18
					end
				end

				arg_61_1.text_.text = var_64_21
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_19, arg_61_1.talkMaxDuration)

			if var_64_18 <= arg_61_1.time_ and arg_61_1.time_ < var_64_18 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_18) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_18 + var_64_25 and arg_61_1.time_ < var_64_18 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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

		arg_61_1:InitPlayNodeList()
	end,
	Play116292016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116292016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play116292017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = manager.ui.mainCamera.transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.shakeOldPos = var_68_0.localPosition
			end

			local var_68_2 = 1

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / 0.099
				local var_68_4, var_68_5 = math.modf(var_68_3)

				var_68_0.localPosition = Vector3.New(var_68_5 * 0.13, var_68_5 * 0.13, var_68_5 * 0.13) + arg_65_1.var_.shakeOldPos
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = arg_65_1.var_.shakeOldPos
			end

			local var_68_6 = 0
			local var_68_7 = 1

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				local var_68_8 = "play"
				local var_68_9 = "effect"

				arg_65_1:AudioAction(var_68_8, var_68_9, "se_story_16", "se_story_16_blast", "")
			end

			local var_68_10 = 0
			local var_68_11 = 0.95

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_12 = arg_65_1:GetWordFromCfg(116292016)
				local var_68_13 = arg_65_1:FormatText(var_68_12.content)

				arg_65_1.text_.text = var_68_13

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_14 = 38
				local var_68_15 = utf8.len(var_68_13)
				local var_68_16 = var_68_14 <= 0 and var_68_11 or var_68_11 * (var_68_15 / var_68_14)

				if var_68_16 > 0 and var_68_11 < var_68_16 then
					arg_65_1.talkMaxDuration = var_68_16

					if var_68_16 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_10
					end
				end

				arg_65_1.text_.text = var_68_13
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_17 = math.max(var_68_11, arg_65_1.talkMaxDuration)

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_17 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_10) / var_68_17

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_10 + var_68_17 and arg_65_1.time_ < var_68_10 + var_68_17 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play116292017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116292017
		arg_69_1.duration_ = 11.68

		local var_69_0 = {
			zh = 6.083,
			ja = 11.683
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
				arg_69_0:Play116292018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "STblack"

			if arg_69_1.bgs_[var_72_0] == nil then
				local var_72_1 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_0)
				var_72_1.name = var_72_0
				var_72_1.transform.parent = arg_69_1.stage_.transform
				var_72_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_0] = var_72_1
			end

			local var_72_2 = 2

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				local var_72_3 = manager.ui.mainCamera.transform.localPosition
				local var_72_4 = Vector3.New(0, 0, 10) + Vector3.New(var_72_3.x, var_72_3.y, 0)
				local var_72_5 = arg_69_1.bgs_.STblack

				var_72_5.transform.localPosition = var_72_4
				var_72_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_6 = var_72_5:GetComponent("SpriteRenderer")

				if var_72_6 and var_72_6.sprite then
					local var_72_7 = (var_72_5.transform.localPosition - var_72_3).z
					local var_72_8 = manager.ui.mainCameraCom_
					local var_72_9 = 2 * var_72_7 * Mathf.Tan(var_72_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_10 = var_72_9 * var_72_8.aspect
					local var_72_11 = var_72_6.sprite.bounds.size.x
					local var_72_12 = var_72_6.sprite.bounds.size.y
					local var_72_13 = var_72_10 / var_72_11
					local var_72_14 = var_72_9 / var_72_12
					local var_72_15 = var_72_14 < var_72_13 and var_72_13 or var_72_14

					var_72_5.transform.localScale = Vector3.New(var_72_15, var_72_15, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "STblack" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_17 = 2

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17
				local var_72_19 = Color.New(0, 0, 0)

				var_72_19.a = Mathf.Lerp(0, 1, var_72_18)
				arg_69_1.mask_.color = var_72_19
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 then
				local var_72_20 = Color.New(0, 0, 0)

				var_72_20.a = 1
				arg_69_1.mask_.color = var_72_20
			end

			local var_72_21 = 2

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_22 = 2

			if var_72_21 <= arg_69_1.time_ and arg_69_1.time_ < var_72_21 + var_72_22 then
				local var_72_23 = (arg_69_1.time_ - var_72_21) / var_72_22
				local var_72_24 = Color.New(0, 0, 0)

				var_72_24.a = Mathf.Lerp(1, 0, var_72_23)
				arg_69_1.mask_.color = var_72_24
			end

			if arg_69_1.time_ >= var_72_21 + var_72_22 and arg_69_1.time_ < var_72_21 + var_72_22 + arg_72_0 then
				local var_72_25 = Color.New(0, 0, 0)
				local var_72_26 = 0

				arg_69_1.mask_.enabled = false
				var_72_25.a = var_72_26
				arg_69_1.mask_.color = var_72_25
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_27 = 3.85
			local var_72_28 = 0.15

			if var_72_27 < arg_69_1.time_ and arg_69_1.time_ <= var_72_27 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_29 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_29:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_30 = arg_69_1:FormatText(StoryNameCfg[8].name)

				arg_69_1.leftNameTxt_.text = var_72_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_31 = arg_69_1:GetWordFromCfg(116292017)
				local var_72_32 = arg_69_1:FormatText(var_72_31.content)

				arg_69_1.text_.text = var_72_32

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_33 = 6
				local var_72_34 = utf8.len(var_72_32)
				local var_72_35 = var_72_33 <= 0 and var_72_28 or var_72_28 * (var_72_34 / var_72_33)

				if var_72_35 > 0 and var_72_28 < var_72_35 then
					arg_69_1.talkMaxDuration = var_72_35
					var_72_27 = var_72_27 + 0.3

					if var_72_35 + var_72_27 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_35 + var_72_27
					end
				end

				arg_69_1.text_.text = var_72_32
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292017", "story_v_out_116292.awb") ~= 0 then
					local var_72_36 = manager.audio:GetVoiceLength("story_v_out_116292", "116292017", "story_v_out_116292.awb") / 1000

					if var_72_36 + var_72_27 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_36 + var_72_27
					end

					if var_72_31.prefab_name ~= "" and arg_69_1.actors_[var_72_31.prefab_name] ~= nil then
						local var_72_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_31.prefab_name].transform, "story_v_out_116292", "116292017", "story_v_out_116292.awb")

						arg_69_1:RecordAudio("116292017", var_72_37)
						arg_69_1:RecordAudio("116292017", var_72_37)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_116292", "116292017", "story_v_out_116292.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_116292", "116292017", "story_v_out_116292.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_38 = var_72_27 + 0.3
			local var_72_39 = math.max(var_72_28, arg_69_1.talkMaxDuration)

			if var_72_38 <= arg_69_1.time_ and arg_69_1.time_ < var_72_38 + var_72_39 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_38) / var_72_39

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_38 + var_72_39 and arg_69_1.time_ < var_72_38 + var_72_39 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play116292018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116292018
		arg_75_1.duration_ = 12.17

		local var_75_0 = {
			zh = 10.733,
			ja = 12.166
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
				arg_75_0:Play116292019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "SK0204"

			if arg_75_1.bgs_[var_78_0] == nil then
				local var_78_1 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_78_0)
				var_78_1.name = var_78_0
				var_78_1.transform.parent = arg_75_1.stage_.transform
				var_78_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_[var_78_0] = var_78_1
			end

			local var_78_2 = 0

			if var_78_2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				local var_78_3 = manager.ui.mainCamera.transform.localPosition
				local var_78_4 = Vector3.New(0, 0, 10) + Vector3.New(var_78_3.x, var_78_3.y, 0)
				local var_78_5 = arg_75_1.bgs_.SK0204

				var_78_5.transform.localPosition = var_78_4
				var_78_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_6 = var_78_5:GetComponent("SpriteRenderer")

				if var_78_6 and var_78_6.sprite then
					local var_78_7 = (var_78_5.transform.localPosition - var_78_3).z
					local var_78_8 = manager.ui.mainCameraCom_
					local var_78_9 = 2 * var_78_7 * Mathf.Tan(var_78_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_78_10 = var_78_9 * var_78_8.aspect
					local var_78_11 = var_78_6.sprite.bounds.size.x
					local var_78_12 = var_78_6.sprite.bounds.size.y
					local var_78_13 = var_78_10 / var_78_11
					local var_78_14 = var_78_9 / var_78_12
					local var_78_15 = var_78_14 < var_78_13 and var_78_13 or var_78_14

					var_78_5.transform.localScale = Vector3.New(var_78_15, var_78_15, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "SK0204" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_16 = 0

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_17 = 5

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_17 then
				local var_78_18 = (arg_75_1.time_ - var_78_16) / var_78_17
				local var_78_19 = Color.New(0, 0, 0)

				var_78_19.a = Mathf.Lerp(1, 0, var_78_18)
				arg_75_1.mask_.color = var_78_19
			end

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 then
				local var_78_20 = Color.New(0, 0, 0)
				local var_78_21 = 0

				arg_75_1.mask_.enabled = false
				var_78_20.a = var_78_21
				arg_75_1.mask_.color = var_78_20
			end

			local var_78_22 = arg_75_1.bgs_.SK0204.transform
			local var_78_23 = 0

			if var_78_23 < arg_75_1.time_ and arg_75_1.time_ <= var_78_23 + arg_78_0 then
				arg_75_1.var_.moveOldPosSK0204 = var_78_22.localPosition
			end

			local var_78_24 = 0.1

			if var_78_23 <= arg_75_1.time_ and arg_75_1.time_ < var_78_23 + var_78_24 then
				local var_78_25 = (arg_75_1.time_ - var_78_23) / var_78_24
				local var_78_26 = Vector3.New(-4.08, 3.87, 0.99)

				var_78_22.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPosSK0204, var_78_26, var_78_25)
			end

			if arg_75_1.time_ >= var_78_23 + var_78_24 and arg_75_1.time_ < var_78_23 + var_78_24 + arg_78_0 then
				var_78_22.localPosition = Vector3.New(-4.08, 3.87, 0.99)
			end

			local var_78_27 = arg_75_1.bgs_.SK0204.transform
			local var_78_28 = 0.1

			if var_78_28 < arg_75_1.time_ and arg_75_1.time_ <= var_78_28 + arg_78_0 then
				arg_75_1.var_.moveOldPosSK0204 = var_78_27.localPosition
			end

			local var_78_29 = 4.9

			if var_78_28 <= arg_75_1.time_ and arg_75_1.time_ < var_78_28 + var_78_29 then
				local var_78_30 = (arg_75_1.time_ - var_78_28) / var_78_29
				local var_78_31 = Vector3.New(0, 1, 10)

				var_78_27.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPosSK0204, var_78_31, var_78_30)
			end

			if arg_75_1.time_ >= var_78_28 + var_78_29 and arg_75_1.time_ < var_78_28 + var_78_29 + arg_78_0 then
				var_78_27.localPosition = Vector3.New(0, 1, 10)
			end

			local var_78_32 = 0

			if var_78_32 < arg_75_1.time_ and arg_75_1.time_ <= var_78_32 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			local var_78_33 = 5

			if arg_75_1.time_ >= var_78_32 + var_78_33 and arg_75_1.time_ < var_78_32 + var_78_33 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_34 = 5
			local var_78_35 = 0.45

			if var_78_34 < arg_75_1.time_ and arg_75_1.time_ <= var_78_34 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_36 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_36:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_37 = arg_75_1:FormatText(StoryNameCfg[327].name)

				arg_75_1.leftNameTxt_.text = var_78_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_38 = arg_75_1:GetWordFromCfg(116292018)
				local var_78_39 = arg_75_1:FormatText(var_78_38.content)

				arg_75_1.text_.text = var_78_39

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_40 = 18
				local var_78_41 = utf8.len(var_78_39)
				local var_78_42 = var_78_40 <= 0 and var_78_35 or var_78_35 * (var_78_41 / var_78_40)

				if var_78_42 > 0 and var_78_35 < var_78_42 then
					arg_75_1.talkMaxDuration = var_78_42
					var_78_34 = var_78_34 + 0.3

					if var_78_42 + var_78_34 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_42 + var_78_34
					end
				end

				arg_75_1.text_.text = var_78_39
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292018", "story_v_out_116292.awb") ~= 0 then
					local var_78_43 = manager.audio:GetVoiceLength("story_v_out_116292", "116292018", "story_v_out_116292.awb") / 1000

					if var_78_43 + var_78_34 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_43 + var_78_34
					end

					if var_78_38.prefab_name ~= "" and arg_75_1.actors_[var_78_38.prefab_name] ~= nil then
						local var_78_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_38.prefab_name].transform, "story_v_out_116292", "116292018", "story_v_out_116292.awb")

						arg_75_1:RecordAudio("116292018", var_78_44)
						arg_75_1:RecordAudio("116292018", var_78_44)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_116292", "116292018", "story_v_out_116292.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_116292", "116292018", "story_v_out_116292.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_45 = var_78_34 + 0.3
			local var_78_46 = math.max(var_78_35, arg_75_1.talkMaxDuration)

			if var_78_45 <= arg_75_1.time_ and arg_75_1.time_ < var_78_45 + var_78_46 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_45) / var_78_46

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_45 + var_78_46 and arg_75_1.time_ < var_78_45 + var_78_46 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.9,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play116292019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116292019
		arg_81_1.duration_ = 2.4

		local var_81_0 = {
			zh = 1.9,
			ja = 2.4
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
				arg_81_0:Play116292020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.175

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[8].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(116292019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 7
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292019", "story_v_out_116292.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292019", "story_v_out_116292.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_116292", "116292019", "story_v_out_116292.awb")

						arg_81_1:RecordAudio("116292019", var_84_9)
						arg_81_1:RecordAudio("116292019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_116292", "116292019", "story_v_out_116292.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_116292", "116292019", "story_v_out_116292.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play116292020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116292020
		arg_85_1.duration_ = 5.8

		local var_85_0 = {
			zh = 5.8,
			ja = 4.9
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
				arg_85_0:Play116292021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.85

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[332].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(116292020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292020", "story_v_out_116292.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292020", "story_v_out_116292.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_116292", "116292020", "story_v_out_116292.awb")

						arg_85_1:RecordAudio("116292020", var_88_9)
						arg_85_1:RecordAudio("116292020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_116292", "116292020", "story_v_out_116292.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_116292", "116292020", "story_v_out_116292.awb")
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
	Play116292021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116292021
		arg_89_1.duration_ = 10.63

		local var_89_0 = {
			zh = 8.166,
			ja = 10.633
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
				arg_89_0:Play116292022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.075

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[327].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(116292021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292021", "story_v_out_116292.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292021", "story_v_out_116292.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_116292", "116292021", "story_v_out_116292.awb")

						arg_89_1:RecordAudio("116292021", var_92_9)
						arg_89_1:RecordAudio("116292021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_116292", "116292021", "story_v_out_116292.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_116292", "116292021", "story_v_out_116292.awb")
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
	Play116292022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 116292022
		arg_93_1.duration_ = 7.3

		local var_93_0 = {
			zh = 7.3,
			ja = 3.6
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
				arg_93_0:Play116292023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.525

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[332].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(116292022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292022", "story_v_out_116292.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292022", "story_v_out_116292.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_116292", "116292022", "story_v_out_116292.awb")

						arg_93_1:RecordAudio("116292022", var_96_9)
						arg_93_1:RecordAudio("116292022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_116292", "116292022", "story_v_out_116292.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_116292", "116292022", "story_v_out_116292.awb")
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
	Play116292023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 116292023
		arg_97_1.duration_ = 12.67

		local var_97_0 = {
			zh = 12.666,
			ja = 6.766
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
				arg_97_0:Play116292024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.15

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[327].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(116292023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292023", "story_v_out_116292.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292023", "story_v_out_116292.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_116292", "116292023", "story_v_out_116292.awb")

						arg_97_1:RecordAudio("116292023", var_100_9)
						arg_97_1:RecordAudio("116292023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_116292", "116292023", "story_v_out_116292.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_116292", "116292023", "story_v_out_116292.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play116292024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 116292024
		arg_101_1.duration_ = 5.63

		local var_101_0 = {
			zh = 5.6,
			ja = 5.633
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
				arg_101_0:Play116292025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.7

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[28].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(116292024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 28
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292024", "story_v_out_116292.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292024", "story_v_out_116292.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_116292", "116292024", "story_v_out_116292.awb")

						arg_101_1:RecordAudio("116292024", var_104_9)
						arg_101_1:RecordAudio("116292024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_116292", "116292024", "story_v_out_116292.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_116292", "116292024", "story_v_out_116292.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play116292025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116292025
		arg_105_1.duration_ = 3.7

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play116292026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.175

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[327].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(116292025)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292025", "story_v_out_116292.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292025", "story_v_out_116292.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_116292", "116292025", "story_v_out_116292.awb")

						arg_105_1:RecordAudio("116292025", var_108_9)
						arg_105_1:RecordAudio("116292025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_116292", "116292025", "story_v_out_116292.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_116292", "116292025", "story_v_out_116292.awb")
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
	Play116292026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116292026
		arg_109_1.duration_ = 9.76

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play116292027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				local var_112_1 = manager.ui.mainCamera.transform.localPosition
				local var_112_2 = Vector3.New(0, 0, 10) + Vector3.New(var_112_1.x, var_112_1.y, 0)
				local var_112_3 = arg_109_1.bgs_.STblack

				var_112_3.transform.localPosition = var_112_2
				var_112_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_4 = var_112_3:GetComponent("SpriteRenderer")

				if var_112_4 and var_112_4.sprite then
					local var_112_5 = (var_112_3.transform.localPosition - var_112_1).z
					local var_112_6 = manager.ui.mainCameraCom_
					local var_112_7 = 2 * var_112_5 * Mathf.Tan(var_112_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_112_8 = var_112_7 * var_112_6.aspect
					local var_112_9 = var_112_4.sprite.bounds.size.x
					local var_112_10 = var_112_4.sprite.bounds.size.y
					local var_112_11 = var_112_8 / var_112_9
					local var_112_12 = var_112_7 / var_112_10
					local var_112_13 = var_112_12 < var_112_11 and var_112_11 or var_112_12

					var_112_3.transform.localScale = Vector3.New(var_112_13, var_112_13, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "STblack" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = false

				arg_109_1:SetGaussion(false)
			end

			local var_112_15 = 1

			if var_112_14 <= arg_109_1.time_ and arg_109_1.time_ < var_112_14 + var_112_15 then
				local var_112_16 = (arg_109_1.time_ - var_112_14) / var_112_15
				local var_112_17 = Color.New(0, 0, 0)

				var_112_17.a = Mathf.Lerp(0, 1, var_112_16)
				arg_109_1.mask_.color = var_112_17
			end

			if arg_109_1.time_ >= var_112_14 + var_112_15 and arg_109_1.time_ < var_112_14 + var_112_15 + arg_112_0 then
				local var_112_18 = Color.New(0, 0, 0)

				var_112_18.a = 1
				arg_109_1.mask_.color = var_112_18
			end

			local var_112_19 = 1

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = false

				arg_109_1:SetGaussion(false)
			end

			local var_112_20 = 1.5

			if var_112_19 <= arg_109_1.time_ and arg_109_1.time_ < var_112_19 + var_112_20 then
				local var_112_21 = (arg_109_1.time_ - var_112_19) / var_112_20
				local var_112_22 = Color.New(0, 0, 0)

				var_112_22.a = Mathf.Lerp(1, 0, var_112_21)
				arg_109_1.mask_.color = var_112_22
			end

			if arg_109_1.time_ >= var_112_19 + var_112_20 and arg_109_1.time_ < var_112_19 + var_112_20 + arg_112_0 then
				local var_112_23 = Color.New(0, 0, 0)
				local var_112_24 = 0

				arg_109_1.mask_.enabled = false
				var_112_23.a = var_112_24
				arg_109_1.mask_.color = var_112_23
			end

			local var_112_25 = 2.5
			local var_112_26 = 7.264
			local var_112_27 = manager.audio:GetVoiceLength("story_v_out_116292", "116292026", "story_v_out_116292.awb") / 1000

			if var_112_27 > 0 and var_112_26 < var_112_27 and var_112_27 + var_112_25 > arg_109_1.duration_ then
				local var_112_28 = var_112_27

				arg_109_1.duration_ = var_112_27 + var_112_25
			end

			if var_112_25 < arg_109_1.time_ and arg_109_1.time_ <= var_112_25 + arg_112_0 then
				local var_112_29 = "play"
				local var_112_30 = "voice"

				arg_109_1:AudioAction(var_112_29, var_112_30, "story_v_out_116292", "116292026", "story_v_out_116292.awb")
			end

			local var_112_31 = 1

			if var_112_31 < arg_109_1.time_ and arg_109_1.time_ <= var_112_31 + arg_112_0 then
				arg_109_1.fswbg_:SetActive(true)
				arg_109_1.dialog_:SetActive(false)

				arg_109_1.fswtw_.percent = 0

				local var_112_32 = arg_109_1:GetWordFromCfg(116292026)
				local var_112_33 = arg_109_1:FormatText(var_112_32.content)

				arg_109_1.fswt_.text = var_112_33

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.fswt_)

				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_109_1.fswtw_:SetDirty()

				arg_109_1.typewritterCharCountI18N = 0

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_34 = 2.5

			if var_112_34 < arg_109_1.time_ and arg_109_1.time_ <= var_112_34 + arg_112_0 then
				arg_109_1.var_.oldValueTypewriter = arg_109_1.fswtw_.percent

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_35 = 42
			local var_112_36 = 2.8
			local var_112_37 = arg_109_1:GetWordFromCfg(116292026)
			local var_112_38 = arg_109_1:FormatText(var_112_37.content)
			local var_112_39, var_112_40 = arg_109_1:GetPercentByPara(var_112_38, 1)

			if var_112_34 < arg_109_1.time_ and arg_109_1.time_ <= var_112_34 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				local var_112_41 = var_112_35 <= 0 and var_112_36 or var_112_36 * ((var_112_40 - arg_109_1.typewritterCharCountI18N) / var_112_35)

				if var_112_41 > 0 and var_112_36 < var_112_41 then
					arg_109_1.talkMaxDuration = var_112_41

					if var_112_41 + var_112_34 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_41 + var_112_34
					end
				end
			end

			local var_112_42 = 2.8
			local var_112_43 = math.max(var_112_42, arg_109_1.talkMaxDuration)

			if var_112_34 <= arg_109_1.time_ and arg_109_1.time_ < var_112_34 + var_112_43 then
				local var_112_44 = (arg_109_1.time_ - var_112_34) / var_112_43

				arg_109_1.fswtw_.percent = Mathf.Lerp(arg_109_1.var_.oldValueTypewriter, var_112_39, var_112_44)
				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_109_1.fswtw_:SetDirty()
			end

			if arg_109_1.time_ >= var_112_34 + var_112_43 and arg_109_1.time_ < var_112_34 + var_112_43 + arg_112_0 then
				arg_109_1.fswtw_.percent = var_112_39

				arg_109_1.fswtw_:SetDirty()
				arg_109_1:ShowNextGo(true)

				arg_109_1.typewritterCharCountI18N = var_112_40
			end

			local var_112_45 = 0

			if var_112_45 < arg_109_1.time_ and arg_109_1.time_ <= var_112_45 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			local var_112_46 = 5.3

			if arg_109_1.time_ >= var_112_45 + var_112_46 and arg_109_1.time_ < var_112_45 + var_112_46 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play116292027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 116292027
		arg_113_1.duration_ = 1

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play116292028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.var_.oldValueTypewriter = arg_113_1.fswtw_.percent

				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_1 = 0
			local var_116_2 = -0.533333333333333
			local var_116_3 = arg_113_1:GetWordFromCfg(116292026)
			local var_116_4 = arg_113_1:FormatText(var_116_3.content)
			local var_116_5, var_116_6 = arg_113_1:GetPercentByPara(var_116_4, 1)

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				local var_116_7 = var_116_1 <= 0 and var_116_2 or var_116_2 * ((var_116_6 - arg_113_1.typewritterCharCountI18N) / var_116_1)

				if var_116_7 > 0 and var_116_2 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end
			end

			local var_116_8 = -0.533333333333333
			local var_116_9 = math.max(var_116_8, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_9 then
				local var_116_10 = (arg_113_1.time_ - var_116_0) / var_116_9

				arg_113_1.fswtw_.percent = Mathf.Lerp(arg_113_1.var_.oldValueTypewriter, var_116_5, var_116_10)
				arg_113_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_113_1.fswtw_:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_9 and arg_113_1.time_ < var_116_0 + var_116_9 + arg_116_0 then
				arg_113_1.fswtw_.percent = var_116_5

				arg_113_1.fswtw_:SetDirty()
				arg_113_1:ShowNextGo(true)

				arg_113_1.typewritterCharCountI18N = var_116_6
			end

			local var_116_11 = 0

			if var_116_11 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 then
				arg_113_1.var_.oldValueTypewriter = arg_113_1.fswtw_.percent

				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_12 = 57
			local var_116_13 = 1
			local var_116_14 = arg_113_1:GetWordFromCfg(116292026)
			local var_116_15 = arg_113_1:FormatText(var_116_14.content)
			local var_116_16, var_116_17 = arg_113_1:GetPercentByPara(var_116_15, 2)

			if var_116_11 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				local var_116_18 = var_116_12 <= 0 and var_116_13 or var_116_13 * ((var_116_17 - arg_113_1.typewritterCharCountI18N) / var_116_12)

				if var_116_18 > 0 and var_116_13 < var_116_18 then
					arg_113_1.talkMaxDuration = var_116_18

					if var_116_18 + var_116_11 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_11
					end
				end
			end

			local var_116_19 = 1
			local var_116_20 = math.max(var_116_19, arg_113_1.talkMaxDuration)

			if var_116_11 <= arg_113_1.time_ and arg_113_1.time_ < var_116_11 + var_116_20 then
				local var_116_21 = (arg_113_1.time_ - var_116_11) / var_116_20

				arg_113_1.fswtw_.percent = Mathf.Lerp(arg_113_1.var_.oldValueTypewriter, var_116_16, var_116_21)
				arg_113_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_113_1.fswtw_:SetDirty()
			end

			if arg_113_1.time_ >= var_116_11 + var_116_20 and arg_113_1.time_ < var_116_11 + var_116_20 + arg_116_0 then
				arg_113_1.fswtw_.percent = var_116_16

				arg_113_1.fswtw_:SetDirty()
				arg_113_1:ShowNextGo(true)

				arg_113_1.typewritterCharCountI18N = var_116_17
			end

			local var_116_22 = 0
			local var_116_23 = 0.711
			local var_116_24 = manager.audio:GetVoiceLength("story_v_out_116292", "116292027", "story_v_out_116292.awb") / 1000

			if var_116_24 > 0 and var_116_23 < var_116_24 and var_116_24 + var_116_22 > arg_113_1.duration_ then
				local var_116_25 = var_116_24

				arg_113_1.duration_ = var_116_24 + var_116_22
			end

			if var_116_22 < arg_113_1.time_ and arg_113_1.time_ <= var_116_22 + arg_116_0 then
				local var_116_26 = "play"
				local var_116_27 = "voice"

				arg_113_1:AudioAction(var_116_26, var_116_27, "story_v_out_116292", "116292027", "story_v_out_116292.awb")
			end

			local var_116_28 = 0

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			local var_116_29 = 1

			if arg_113_1.time_ >= var_116_28 + var_116_29 and arg_113_1.time_ < var_116_28 + var_116_29 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play116292028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 116292028
		arg_117_1.duration_ = 7.42

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play116292029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.var_.oldValueTypewriter = arg_117_1.fswtw_.percent

				SetActive(arg_117_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_117_1:ShowNextGo(false)
			end

			local var_120_1 = 46
			local var_120_2 = 3.06666666666667
			local var_120_3 = arg_117_1:GetWordFromCfg(116292026)
			local var_120_4 = arg_117_1:FormatText(var_120_3.content)
			local var_120_5, var_120_6 = arg_117_1:GetPercentByPara(var_120_4, 3)

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				local var_120_7 = var_120_1 <= 0 and var_120_2 or var_120_2 * ((var_120_6 - arg_117_1.typewritterCharCountI18N) / var_120_1)

				if var_120_7 > 0 and var_120_2 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end
			end

			local var_120_8 = 3.06666666666667
			local var_120_9 = math.max(var_120_8, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_9 then
				local var_120_10 = (arg_117_1.time_ - var_120_0) / var_120_9

				arg_117_1.fswtw_.percent = Mathf.Lerp(arg_117_1.var_.oldValueTypewriter, var_120_5, var_120_10)
				arg_117_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_117_1.fswtw_:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_9 and arg_117_1.time_ < var_120_0 + var_120_9 + arg_120_0 then
				arg_117_1.fswtw_.percent = var_120_5

				arg_117_1.fswtw_:SetDirty()
				arg_117_1:ShowNextGo(true)

				arg_117_1.typewritterCharCountI18N = var_120_6
			end

			local var_120_11 = 0
			local var_120_12 = 7.417
			local var_120_13 = manager.audio:GetVoiceLength("story_v_out_116292", "116292028", "story_v_out_116292.awb") / 1000

			if var_120_13 > 0 and var_120_12 < var_120_13 and var_120_13 + var_120_11 > arg_117_1.duration_ then
				local var_120_14 = var_120_13

				arg_117_1.duration_ = var_120_13 + var_120_11
			end

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				local var_120_15 = "play"
				local var_120_16 = "voice"

				arg_117_1:AudioAction(var_120_15, var_120_16, "story_v_out_116292", "116292028", "story_v_out_116292.awb")
			end

			local var_120_17 = 0

			if var_120_17 < arg_117_1.time_ and arg_117_1.time_ <= var_120_17 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			local var_120_18 = 3.06666666666667

			if arg_117_1.time_ >= var_120_17 + var_120_18 and arg_117_1.time_ < var_120_17 + var_120_18 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play116292029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 116292029
		arg_121_1.duration_ = 7.8

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play116292030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.var_.oldValueTypewriter = arg_121_1.fswtw_.percent

				SetActive(arg_121_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_121_1:ShowNextGo(false)
			end

			local var_124_1 = 0
			local var_124_2 = -0.866666666666667
			local var_124_3 = arg_121_1:GetWordFromCfg(116292026)
			local var_124_4 = arg_121_1:FormatText(var_124_3.content)
			local var_124_5, var_124_6 = arg_121_1:GetPercentByPara(var_124_4, 3)

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				local var_124_7 = var_124_1 <= 0 and var_124_2 or var_124_2 * ((var_124_6 - arg_121_1.typewritterCharCountI18N) / var_124_1)

				if var_124_7 > 0 and var_124_2 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end
			end

			local var_124_8 = -0.866666666666667
			local var_124_9 = math.max(var_124_8, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_9 then
				local var_124_10 = (arg_121_1.time_ - var_124_0) / var_124_9

				arg_121_1.fswtw_.percent = Mathf.Lerp(arg_121_1.var_.oldValueTypewriter, var_124_5, var_124_10)
				arg_121_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_121_1.fswtw_:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_9 and arg_121_1.time_ < var_124_0 + var_124_9 + arg_124_0 then
				arg_121_1.fswtw_.percent = var_124_5

				arg_121_1.fswtw_:SetDirty()
				arg_121_1:ShowNextGo(true)

				arg_121_1.typewritterCharCountI18N = var_124_6
			end

			local var_124_11 = 0

			if var_124_11 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1.var_.oldValueTypewriter = arg_121_1.fswtw_.percent

				SetActive(arg_121_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_121_1:ShowNextGo(false)
			end

			local var_124_12 = 45
			local var_124_13 = 3
			local var_124_14 = arg_121_1:GetWordFromCfg(116292026)
			local var_124_15 = arg_121_1:FormatText(var_124_14.content)
			local var_124_16, var_124_17 = arg_121_1:GetPercentByPara(var_124_15, 4)

			if var_124_11 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				local var_124_18 = var_124_12 <= 0 and var_124_13 or var_124_13 * ((var_124_17 - arg_121_1.typewritterCharCountI18N) / var_124_12)

				if var_124_18 > 0 and var_124_13 < var_124_18 then
					arg_121_1.talkMaxDuration = var_124_18

					if var_124_18 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_18 + var_124_11
					end
				end
			end

			local var_124_19 = 3
			local var_124_20 = math.max(var_124_19, arg_121_1.talkMaxDuration)

			if var_124_11 <= arg_121_1.time_ and arg_121_1.time_ < var_124_11 + var_124_20 then
				local var_124_21 = (arg_121_1.time_ - var_124_11) / var_124_20

				arg_121_1.fswtw_.percent = Mathf.Lerp(arg_121_1.var_.oldValueTypewriter, var_124_16, var_124_21)
				arg_121_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_121_1.fswtw_:SetDirty()
			end

			if arg_121_1.time_ >= var_124_11 + var_124_20 and arg_121_1.time_ < var_124_11 + var_124_20 + arg_124_0 then
				arg_121_1.fswtw_.percent = var_124_16

				arg_121_1.fswtw_:SetDirty()
				arg_121_1:ShowNextGo(true)

				arg_121_1.typewritterCharCountI18N = var_124_17
			end

			local var_124_22 = 0
			local var_124_23 = 7.802
			local var_124_24 = manager.audio:GetVoiceLength("story_v_out_116292", "116292029", "story_v_out_116292.awb") / 1000

			if var_124_24 > 0 and var_124_23 < var_124_24 and var_124_24 + var_124_22 > arg_121_1.duration_ then
				local var_124_25 = var_124_24

				arg_121_1.duration_ = var_124_24 + var_124_22
			end

			if var_124_22 < arg_121_1.time_ and arg_121_1.time_ <= var_124_22 + arg_124_0 then
				local var_124_26 = "play"
				local var_124_27 = "voice"

				arg_121_1:AudioAction(var_124_26, var_124_27, "story_v_out_116292", "116292029", "story_v_out_116292.awb")
			end

			local var_124_28 = 0

			if var_124_28 < arg_121_1.time_ and arg_121_1.time_ <= var_124_28 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			local var_124_29 = 3.06666666666667

			if arg_121_1.time_ >= var_124_28 + var_124_29 and arg_121_1.time_ < var_124_28 + var_124_29 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play116292030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 116292030
		arg_125_1.duration_ = 3.73

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play116292031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.var_.oldValueTypewriter = arg_125_1.fswtw_.percent

				SetActive(arg_125_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_125_1:ShowNextGo(false)
			end

			local var_128_1 = 0
			local var_128_2 = -2.6
			local var_128_3 = arg_125_1:GetWordFromCfg(116292026)
			local var_128_4 = arg_125_1:FormatText(var_128_3.content)
			local var_128_5, var_128_6 = arg_125_1:GetPercentByPara(var_128_4, 3)

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				local var_128_7 = var_128_1 <= 0 and var_128_2 or var_128_2 * ((var_128_6 - arg_125_1.typewritterCharCountI18N) / var_128_1)

				if var_128_7 > 0 and var_128_2 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end
			end

			local var_128_8 = -2.6
			local var_128_9 = math.max(var_128_8, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_9 then
				local var_128_10 = (arg_125_1.time_ - var_128_0) / var_128_9

				arg_125_1.fswtw_.percent = Mathf.Lerp(arg_125_1.var_.oldValueTypewriter, var_128_5, var_128_10)
				arg_125_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_125_1.fswtw_:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_9 and arg_125_1.time_ < var_128_0 + var_128_9 + arg_128_0 then
				arg_125_1.fswtw_.percent = var_128_5

				arg_125_1.fswtw_:SetDirty()
				arg_125_1:ShowNextGo(true)

				arg_125_1.typewritterCharCountI18N = var_128_6
			end

			local var_128_11 = 0

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1.var_.oldValueTypewriter = arg_125_1.fswtw_.percent

				SetActive(arg_125_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_125_1:ShowNextGo(false)
			end

			local var_128_12 = 29
			local var_128_13 = 1.93333333333333
			local var_128_14 = arg_125_1:GetWordFromCfg(116292026)
			local var_128_15 = arg_125_1:FormatText(var_128_14.content)
			local var_128_16, var_128_17 = arg_125_1:GetPercentByPara(var_128_15, 5)

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				local var_128_18 = var_128_12 <= 0 and var_128_13 or var_128_13 * ((var_128_17 - arg_125_1.typewritterCharCountI18N) / var_128_12)

				if var_128_18 > 0 and var_128_13 < var_128_18 then
					arg_125_1.talkMaxDuration = var_128_18

					if var_128_18 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_11
					end
				end
			end

			local var_128_19 = 1.93333333333333
			local var_128_20 = math.max(var_128_19, arg_125_1.talkMaxDuration)

			if var_128_11 <= arg_125_1.time_ and arg_125_1.time_ < var_128_11 + var_128_20 then
				local var_128_21 = (arg_125_1.time_ - var_128_11) / var_128_20

				arg_125_1.fswtw_.percent = Mathf.Lerp(arg_125_1.var_.oldValueTypewriter, var_128_16, var_128_21)
				arg_125_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_125_1.fswtw_:SetDirty()
			end

			if arg_125_1.time_ >= var_128_11 + var_128_20 and arg_125_1.time_ < var_128_11 + var_128_20 + arg_128_0 then
				arg_125_1.fswtw_.percent = var_128_16

				arg_125_1.fswtw_:SetDirty()
				arg_125_1:ShowNextGo(true)

				arg_125_1.typewritterCharCountI18N = var_128_17
			end

			local var_128_22 = 0
			local var_128_23 = 3.729
			local var_128_24 = manager.audio:GetVoiceLength("story_v_out_116292", "116292030", "story_v_out_116292.awb") / 1000

			if var_128_24 > 0 and var_128_23 < var_128_24 and var_128_24 + var_128_22 > arg_125_1.duration_ then
				local var_128_25 = var_128_24

				arg_125_1.duration_ = var_128_24 + var_128_22
			end

			if var_128_22 < arg_125_1.time_ and arg_125_1.time_ <= var_128_22 + arg_128_0 then
				local var_128_26 = "play"
				local var_128_27 = "voice"

				arg_125_1:AudioAction(var_128_26, var_128_27, "story_v_out_116292", "116292030", "story_v_out_116292.awb")
			end

			local var_128_28 = 0

			if var_128_28 < arg_125_1.time_ and arg_125_1.time_ <= var_128_28 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			local var_128_29 = 1.93333333333333

			if arg_125_1.time_ >= var_128_28 + var_128_29 and arg_125_1.time_ < var_128_28 + var_128_29 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play116292031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 116292031
		arg_129_1.duration_ = 2.59

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play116292032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.var_.oldValueTypewriter = arg_129_1.fswtw_.percent

				SetActive(arg_129_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_129_1:ShowNextGo(false)
			end

			local var_132_1 = 0
			local var_132_2 = -3.93333333333333
			local var_132_3 = arg_129_1:GetWordFromCfg(116292026)
			local var_132_4 = arg_129_1:FormatText(var_132_3.content)
			local var_132_5, var_132_6 = arg_129_1:GetPercentByPara(var_132_4, 3)

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				local var_132_7 = var_132_1 <= 0 and var_132_2 or var_132_2 * ((var_132_6 - arg_129_1.typewritterCharCountI18N) / var_132_1)

				if var_132_7 > 0 and var_132_2 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end
			end

			local var_132_8 = -3.93333333333333
			local var_132_9 = math.max(var_132_8, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_9 then
				local var_132_10 = (arg_129_1.time_ - var_132_0) / var_132_9

				arg_129_1.fswtw_.percent = Mathf.Lerp(arg_129_1.var_.oldValueTypewriter, var_132_5, var_132_10)
				arg_129_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_129_1.fswtw_:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_9 and arg_129_1.time_ < var_132_0 + var_132_9 + arg_132_0 then
				arg_129_1.fswtw_.percent = var_132_5

				arg_129_1.fswtw_:SetDirty()
				arg_129_1:ShowNextGo(true)

				arg_129_1.typewritterCharCountI18N = var_132_6
			end

			local var_132_11 = 0

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.var_.oldValueTypewriter = arg_129_1.fswtw_.percent

				SetActive(arg_129_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_129_1:ShowNextGo(false)
			end

			local var_132_12 = 15
			local var_132_13 = 1
			local var_132_14 = arg_129_1:GetWordFromCfg(116292026)
			local var_132_15 = arg_129_1:FormatText(var_132_14.content)
			local var_132_16, var_132_17 = arg_129_1:GetPercentByPara(var_132_15, 6)

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				local var_132_18 = var_132_12 <= 0 and var_132_13 or var_132_13 * ((var_132_17 - arg_129_1.typewritterCharCountI18N) / var_132_12)

				if var_132_18 > 0 and var_132_13 < var_132_18 then
					arg_129_1.talkMaxDuration = var_132_18

					if var_132_18 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_18 + var_132_11
					end
				end
			end

			local var_132_19 = 1
			local var_132_20 = math.max(var_132_19, arg_129_1.talkMaxDuration)

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_20 then
				local var_132_21 = (arg_129_1.time_ - var_132_11) / var_132_20

				arg_129_1.fswtw_.percent = Mathf.Lerp(arg_129_1.var_.oldValueTypewriter, var_132_16, var_132_21)
				arg_129_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_129_1.fswtw_:SetDirty()
			end

			if arg_129_1.time_ >= var_132_11 + var_132_20 and arg_129_1.time_ < var_132_11 + var_132_20 + arg_132_0 then
				arg_129_1.fswtw_.percent = var_132_16

				arg_129_1.fswtw_:SetDirty()
				arg_129_1:ShowNextGo(true)

				arg_129_1.typewritterCharCountI18N = var_132_17
			end

			local var_132_22 = 0
			local var_132_23 = 2.586
			local var_132_24 = manager.audio:GetVoiceLength("story_v_out_116292", "116292031", "story_v_out_116292.awb") / 1000

			if var_132_24 > 0 and var_132_23 < var_132_24 and var_132_24 + var_132_22 > arg_129_1.duration_ then
				local var_132_25 = var_132_24

				arg_129_1.duration_ = var_132_24 + var_132_22
			end

			if var_132_22 < arg_129_1.time_ and arg_129_1.time_ <= var_132_22 + arg_132_0 then
				local var_132_26 = "play"
				local var_132_27 = "voice"

				arg_129_1:AudioAction(var_132_26, var_132_27, "story_v_out_116292", "116292031", "story_v_out_116292.awb")
			end

			local var_132_28 = 0

			if var_132_28 < arg_129_1.time_ and arg_129_1.time_ <= var_132_28 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			local var_132_29 = 1

			if arg_129_1.time_ >= var_132_28 + var_132_29 and arg_129_1.time_ < var_132_28 + var_132_29 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play116292032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 116292032
		arg_133_1.duration_ = 4.96

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play116292033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.var_.oldValueTypewriter = arg_133_1.fswtw_.percent

				SetActive(arg_133_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_133_1:ShowNextGo(false)
			end

			local var_136_1 = 0
			local var_136_2 = -3.46666666666667
			local var_136_3 = arg_133_1:GetWordFromCfg(116292026)
			local var_136_4 = arg_133_1:FormatText(var_136_3.content)
			local var_136_5, var_136_6 = arg_133_1:GetPercentByPara(var_136_4, 4)

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				local var_136_7 = var_136_1 <= 0 and var_136_2 or var_136_2 * ((var_136_6 - arg_133_1.typewritterCharCountI18N) / var_136_1)

				if var_136_7 > 0 and var_136_2 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end
			end

			local var_136_8 = -3.46666666666667
			local var_136_9 = math.max(var_136_8, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_9 then
				local var_136_10 = (arg_133_1.time_ - var_136_0) / var_136_9

				arg_133_1.fswtw_.percent = Mathf.Lerp(arg_133_1.var_.oldValueTypewriter, var_136_5, var_136_10)
				arg_133_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_133_1.fswtw_:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_9 and arg_133_1.time_ < var_136_0 + var_136_9 + arg_136_0 then
				arg_133_1.fswtw_.percent = var_136_5

				arg_133_1.fswtw_:SetDirty()
				arg_133_1:ShowNextGo(true)

				arg_133_1.typewritterCharCountI18N = var_136_6
			end

			local var_136_11 = 0

			if var_136_11 < arg_133_1.time_ and arg_133_1.time_ <= var_136_11 + arg_136_0 then
				arg_133_1.fswbg_:SetActive(true)
				arg_133_1.dialog_:SetActive(false)

				arg_133_1.fswtw_.percent = 0

				local var_136_12 = arg_133_1:GetWordFromCfg(116292032)
				local var_136_13 = arg_133_1:FormatText(var_136_12.content)

				arg_133_1.fswt_.text = var_136_13

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.fswt_)

				arg_133_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_133_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_133_1.fswtw_:SetDirty()

				arg_133_1.typewritterCharCountI18N = 0

				SetActive(arg_133_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_133_1:ShowNextGo(false)
			end

			local var_136_14 = 0.0166666666666667

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1.var_.oldValueTypewriter = arg_133_1.fswtw_.percent

				SetActive(arg_133_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_133_1:ShowNextGo(false)
			end

			local var_136_15 = 34
			local var_136_16 = 2.26666666666667
			local var_136_17 = arg_133_1:GetWordFromCfg(116292032)
			local var_136_18 = arg_133_1:FormatText(var_136_17.content)
			local var_136_19, var_136_20 = arg_133_1:GetPercentByPara(var_136_18, 1)

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				local var_136_21 = var_136_15 <= 0 and var_136_16 or var_136_16 * ((var_136_20 - arg_133_1.typewritterCharCountI18N) / var_136_15)

				if var_136_21 > 0 and var_136_16 < var_136_21 then
					arg_133_1.talkMaxDuration = var_136_21

					if var_136_21 + var_136_14 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_21 + var_136_14
					end
				end
			end

			local var_136_22 = 2.26666666666667
			local var_136_23 = math.max(var_136_22, arg_133_1.talkMaxDuration)

			if var_136_14 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_23 then
				local var_136_24 = (arg_133_1.time_ - var_136_14) / var_136_23

				arg_133_1.fswtw_.percent = Mathf.Lerp(arg_133_1.var_.oldValueTypewriter, var_136_19, var_136_24)
				arg_133_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_133_1.fswtw_:SetDirty()
			end

			if arg_133_1.time_ >= var_136_14 + var_136_23 and arg_133_1.time_ < var_136_14 + var_136_23 + arg_136_0 then
				arg_133_1.fswtw_.percent = var_136_19

				arg_133_1.fswtw_:SetDirty()
				arg_133_1:ShowNextGo(true)

				arg_133_1.typewritterCharCountI18N = var_136_20
			end

			local var_136_25 = 0
			local var_136_26 = 4.957
			local var_136_27 = manager.audio:GetVoiceLength("story_v_out_116292", "116292032", "story_v_out_116292.awb") / 1000

			if var_136_27 > 0 and var_136_26 < var_136_27 and var_136_27 + var_136_25 > arg_133_1.duration_ then
				local var_136_28 = var_136_27

				arg_133_1.duration_ = var_136_27 + var_136_25
			end

			if var_136_25 < arg_133_1.time_ and arg_133_1.time_ <= var_136_25 + arg_136_0 then
				local var_136_29 = "play"
				local var_136_30 = "voice"

				arg_133_1:AudioAction(var_136_29, var_136_30, "story_v_out_116292", "116292032", "story_v_out_116292.awb")
			end

			local var_136_31 = 0

			if var_136_31 < arg_133_1.time_ and arg_133_1.time_ <= var_136_31 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			local var_136_32 = 2.28333333333333

			if arg_133_1.time_ >= var_136_31 + var_136_32 and arg_133_1.time_ < var_136_31 + var_136_32 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play116292033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 116292033
		arg_137_1.duration_ = 3.35

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play116292034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.var_.oldValueTypewriter = arg_137_1.fswtw_.percent

				SetActive(arg_137_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_137_1:ShowNextGo(false)
			end

			local var_140_1 = 25
			local var_140_2 = 1.66666666666667
			local var_140_3 = arg_137_1:GetWordFromCfg(116292032)
			local var_140_4 = arg_137_1:FormatText(var_140_3.content)
			local var_140_5, var_140_6 = arg_137_1:GetPercentByPara(var_140_4, 2)

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				local var_140_7 = var_140_1 <= 0 and var_140_2 or var_140_2 * ((var_140_6 - arg_137_1.typewritterCharCountI18N) / var_140_1)

				if var_140_7 > 0 and var_140_2 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end
			end

			local var_140_8 = 1.66666666666667
			local var_140_9 = math.max(var_140_8, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_9 then
				local var_140_10 = (arg_137_1.time_ - var_140_0) / var_140_9

				arg_137_1.fswtw_.percent = Mathf.Lerp(arg_137_1.var_.oldValueTypewriter, var_140_5, var_140_10)
				arg_137_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_137_1.fswtw_:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_9 and arg_137_1.time_ < var_140_0 + var_140_9 + arg_140_0 then
				arg_137_1.fswtw_.percent = var_140_5

				arg_137_1.fswtw_:SetDirty()
				arg_137_1:ShowNextGo(true)

				arg_137_1.typewritterCharCountI18N = var_140_6
			end

			local var_140_11 = 0
			local var_140_12 = 3.346
			local var_140_13 = manager.audio:GetVoiceLength("story_v_out_116292", "116292033", "story_v_out_116292.awb") / 1000

			if var_140_13 > 0 and var_140_12 < var_140_13 and var_140_13 + var_140_11 > arg_137_1.duration_ then
				local var_140_14 = var_140_13

				arg_137_1.duration_ = var_140_13 + var_140_11
			end

			if var_140_11 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				local var_140_15 = "play"
				local var_140_16 = "voice"

				arg_137_1:AudioAction(var_140_15, var_140_16, "story_v_out_116292", "116292033", "story_v_out_116292.awb")
			end

			local var_140_17 = 0

			if var_140_17 < arg_137_1.time_ and arg_137_1.time_ <= var_140_17 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			local var_140_18 = 1.66666666666667

			if arg_137_1.time_ >= var_140_17 + var_140_18 and arg_137_1.time_ < var_140_17 + var_140_18 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play116292034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 116292034
		arg_141_1.duration_ = 6.67

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play116292035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.var_.oldValueTypewriter = arg_141_1.fswtw_.percent

				SetActive(arg_141_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_141_1:ShowNextGo(false)
			end

			local var_144_1 = 40
			local var_144_2 = 2.66666666666667
			local var_144_3 = arg_141_1:GetWordFromCfg(116292032)
			local var_144_4 = arg_141_1:FormatText(var_144_3.content)
			local var_144_5, var_144_6 = arg_141_1:GetPercentByPara(var_144_4, 3)

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				local var_144_7 = var_144_1 <= 0 and var_144_2 or var_144_2 * ((var_144_6 - arg_141_1.typewritterCharCountI18N) / var_144_1)

				if var_144_7 > 0 and var_144_2 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end
			end

			local var_144_8 = 2.66666666666667
			local var_144_9 = math.max(var_144_8, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_9 then
				local var_144_10 = (arg_141_1.time_ - var_144_0) / var_144_9

				arg_141_1.fswtw_.percent = Mathf.Lerp(arg_141_1.var_.oldValueTypewriter, var_144_5, var_144_10)
				arg_141_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_141_1.fswtw_:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_9 and arg_141_1.time_ < var_144_0 + var_144_9 + arg_144_0 then
				arg_141_1.fswtw_.percent = var_144_5

				arg_141_1.fswtw_:SetDirty()
				arg_141_1:ShowNextGo(true)

				arg_141_1.typewritterCharCountI18N = var_144_6
			end

			local var_144_11 = 0
			local var_144_12 = 6.671
			local var_144_13 = manager.audio:GetVoiceLength("story_v_out_116292", "116292034", "story_v_out_116292.awb") / 1000

			if var_144_13 > 0 and var_144_12 < var_144_13 and var_144_13 + var_144_11 > arg_141_1.duration_ then
				local var_144_14 = var_144_13

				arg_141_1.duration_ = var_144_13 + var_144_11
			end

			if var_144_11 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				local var_144_15 = "play"
				local var_144_16 = "voice"

				arg_141_1:AudioAction(var_144_15, var_144_16, "story_v_out_116292", "116292034", "story_v_out_116292.awb")
			end

			local var_144_17 = 0

			if var_144_17 < arg_141_1.time_ and arg_141_1.time_ <= var_144_17 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_18 = 2.66666666666667

			if arg_141_1.time_ >= var_144_17 + var_144_18 and arg_141_1.time_ < var_144_17 + var_144_18 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play116292035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 116292035
		arg_145_1.duration_ = 6.09

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play116292036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.var_.oldValueTypewriter = arg_145_1.fswtw_.percent

				SetActive(arg_145_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_145_1:ShowNextGo(false)
			end

			local var_148_1 = 28
			local var_148_2 = 1.86666666666667
			local var_148_3 = arg_145_1:GetWordFromCfg(116292032)
			local var_148_4 = arg_145_1:FormatText(var_148_3.content)
			local var_148_5, var_148_6 = arg_145_1:GetPercentByPara(var_148_4, 4)

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				local var_148_7 = var_148_1 <= 0 and var_148_2 or var_148_2 * ((var_148_6 - arg_145_1.typewritterCharCountI18N) / var_148_1)

				if var_148_7 > 0 and var_148_2 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end
			end

			local var_148_8 = 1.86666666666667
			local var_148_9 = math.max(var_148_8, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_9 then
				local var_148_10 = (arg_145_1.time_ - var_148_0) / var_148_9

				arg_145_1.fswtw_.percent = Mathf.Lerp(arg_145_1.var_.oldValueTypewriter, var_148_5, var_148_10)
				arg_145_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_145_1.fswtw_:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_9 and arg_145_1.time_ < var_148_0 + var_148_9 + arg_148_0 then
				arg_145_1.fswtw_.percent = var_148_5

				arg_145_1.fswtw_:SetDirty()
				arg_145_1:ShowNextGo(true)

				arg_145_1.typewritterCharCountI18N = var_148_6
			end

			local var_148_11 = 0
			local var_148_12 = 6.092
			local var_148_13 = manager.audio:GetVoiceLength("story_v_out_116292", "116292035", "story_v_out_116292.awb") / 1000

			if var_148_13 > 0 and var_148_12 < var_148_13 and var_148_13 + var_148_11 > arg_145_1.duration_ then
				local var_148_14 = var_148_13

				arg_145_1.duration_ = var_148_13 + var_148_11
			end

			if var_148_11 < arg_145_1.time_ and arg_145_1.time_ <= var_148_11 + arg_148_0 then
				local var_148_15 = "play"
				local var_148_16 = "voice"

				arg_145_1:AudioAction(var_148_15, var_148_16, "story_v_out_116292", "116292035", "story_v_out_116292.awb")
			end

			local var_148_17 = 0

			if var_148_17 < arg_145_1.time_ and arg_145_1.time_ <= var_148_17 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			local var_148_18 = 1.86666666666667

			if arg_145_1.time_ >= var_148_17 + var_148_18 and arg_145_1.time_ < var_148_17 + var_148_18 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play116292036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 116292036
		arg_149_1.duration_ = 5.68

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play116292037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.var_.oldValueTypewriter = arg_149_1.fswtw_.percent

				SetActive(arg_149_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_149_1:ShowNextGo(false)
			end

			local var_152_1 = 37
			local var_152_2 = 2.46666666666667
			local var_152_3 = arg_149_1:GetWordFromCfg(116292032)
			local var_152_4 = arg_149_1:FormatText(var_152_3.content)
			local var_152_5, var_152_6 = arg_149_1:GetPercentByPara(var_152_4, 5)

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				local var_152_7 = var_152_1 <= 0 and var_152_2 or var_152_2 * ((var_152_6 - arg_149_1.typewritterCharCountI18N) / var_152_1)

				if var_152_7 > 0 and var_152_2 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end
			end

			local var_152_8 = 2.46666666666667
			local var_152_9 = math.max(var_152_8, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_9 then
				local var_152_10 = (arg_149_1.time_ - var_152_0) / var_152_9

				arg_149_1.fswtw_.percent = Mathf.Lerp(arg_149_1.var_.oldValueTypewriter, var_152_5, var_152_10)
				arg_149_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_149_1.fswtw_:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_9 and arg_149_1.time_ < var_152_0 + var_152_9 + arg_152_0 then
				arg_149_1.fswtw_.percent = var_152_5

				arg_149_1.fswtw_:SetDirty()
				arg_149_1:ShowNextGo(true)

				arg_149_1.typewritterCharCountI18N = var_152_6
			end

			local var_152_11 = 0
			local var_152_12 = 5.681
			local var_152_13 = manager.audio:GetVoiceLength("story_v_out_116292", "116292036", "story_v_out_116292.awb") / 1000

			if var_152_13 > 0 and var_152_12 < var_152_13 and var_152_13 + var_152_11 > arg_149_1.duration_ then
				local var_152_14 = var_152_13

				arg_149_1.duration_ = var_152_13 + var_152_11
			end

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				local var_152_15 = "play"
				local var_152_16 = "voice"

				arg_149_1:AudioAction(var_152_15, var_152_16, "story_v_out_116292", "116292036", "story_v_out_116292.awb")
			end

			local var_152_17 = 0

			if var_152_17 < arg_149_1.time_ and arg_149_1.time_ <= var_152_17 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			local var_152_18 = 2.46666666666667

			if arg_149_1.time_ >= var_152_17 + var_152_18 and arg_149_1.time_ < var_152_17 + var_152_18 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play116292037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 116292037
		arg_153_1.duration_ = 4.06

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play116292038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.var_.oldValueTypewriter = arg_153_1.fswtw_.percent

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_1 = 25
			local var_156_2 = 1.66666666666667
			local var_156_3 = arg_153_1:GetWordFromCfg(116292032)
			local var_156_4 = arg_153_1:FormatText(var_156_3.content)
			local var_156_5, var_156_6 = arg_153_1:GetPercentByPara(var_156_4, 6)

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				local var_156_7 = var_156_1 <= 0 and var_156_2 or var_156_2 * ((var_156_6 - arg_153_1.typewritterCharCountI18N) / var_156_1)

				if var_156_7 > 0 and var_156_2 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end
			end

			local var_156_8 = 1.66666666666667
			local var_156_9 = math.max(var_156_8, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_9 then
				local var_156_10 = (arg_153_1.time_ - var_156_0) / var_156_9

				arg_153_1.fswtw_.percent = Mathf.Lerp(arg_153_1.var_.oldValueTypewriter, var_156_5, var_156_10)
				arg_153_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_153_1.fswtw_:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_9 and arg_153_1.time_ < var_156_0 + var_156_9 + arg_156_0 then
				arg_153_1.fswtw_.percent = var_156_5

				arg_153_1.fswtw_:SetDirty()
				arg_153_1:ShowNextGo(true)

				arg_153_1.typewritterCharCountI18N = var_156_6
			end

			local var_156_11 = 0
			local var_156_12 = 4.06
			local var_156_13 = manager.audio:GetVoiceLength("story_v_out_116292", "116292037", "story_v_out_116292.awb") / 1000

			if var_156_13 > 0 and var_156_12 < var_156_13 and var_156_13 + var_156_11 > arg_153_1.duration_ then
				local var_156_14 = var_156_13

				arg_153_1.duration_ = var_156_13 + var_156_11
			end

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				local var_156_15 = "play"
				local var_156_16 = "voice"

				arg_153_1:AudioAction(var_156_15, var_156_16, "story_v_out_116292", "116292037", "story_v_out_116292.awb")
			end

			local var_156_17 = 0

			if var_156_17 < arg_153_1.time_ and arg_153_1.time_ <= var_156_17 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			local var_156_18 = 1.66666666666667

			if arg_153_1.time_ >= var_156_17 + var_156_18 and arg_153_1.time_ < var_156_17 + var_156_18 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play116292038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 116292038
		arg_157_1.duration_ = 3.55

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play116292039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.fswbg_:SetActive(true)
				arg_157_1.dialog_:SetActive(false)

				arg_157_1.fswtw_.percent = 0

				local var_160_1 = arg_157_1:GetWordFromCfg(116292038)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.fswt_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.fswt_)

				arg_157_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_157_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_157_1.fswtw_:SetDirty()

				arg_157_1.typewritterCharCountI18N = 0

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_3 = 0.0166666666666667

			if var_160_3 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 then
				arg_157_1.var_.oldValueTypewriter = arg_157_1.fswtw_.percent

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_4 = 21
			local var_160_5 = 1.4
			local var_160_6 = arg_157_1:GetWordFromCfg(116292038)
			local var_160_7 = arg_157_1:FormatText(var_160_6.content)
			local var_160_8, var_160_9 = arg_157_1:GetPercentByPara(var_160_7, 1)

			if var_160_3 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				local var_160_10 = var_160_4 <= 0 and var_160_5 or var_160_5 * ((var_160_9 - arg_157_1.typewritterCharCountI18N) / var_160_4)

				if var_160_10 > 0 and var_160_5 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_3 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_3
					end
				end
			end

			local var_160_11 = 1.4
			local var_160_12 = math.max(var_160_11, arg_157_1.talkMaxDuration)

			if var_160_3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_3 + var_160_12 then
				local var_160_13 = (arg_157_1.time_ - var_160_3) / var_160_12

				arg_157_1.fswtw_.percent = Mathf.Lerp(arg_157_1.var_.oldValueTypewriter, var_160_8, var_160_13)
				arg_157_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_157_1.fswtw_:SetDirty()
			end

			if arg_157_1.time_ >= var_160_3 + var_160_12 and arg_157_1.time_ < var_160_3 + var_160_12 + arg_160_0 then
				arg_157_1.fswtw_.percent = var_160_8

				arg_157_1.fswtw_:SetDirty()
				arg_157_1:ShowNextGo(true)

				arg_157_1.typewritterCharCountI18N = var_160_9
			end

			local var_160_14 = 0
			local var_160_15 = 3.554
			local var_160_16 = manager.audio:GetVoiceLength("story_v_out_116292", "116292038", "story_v_out_116292.awb") / 1000

			if var_160_16 > 0 and var_160_15 < var_160_16 and var_160_16 + var_160_14 > arg_157_1.duration_ then
				local var_160_17 = var_160_16

				arg_157_1.duration_ = var_160_16 + var_160_14
			end

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 then
				local var_160_18 = "play"
				local var_160_19 = "voice"

				arg_157_1:AudioAction(var_160_18, var_160_19, "story_v_out_116292", "116292038", "story_v_out_116292.awb")
			end

			local var_160_20 = 0

			if var_160_20 < arg_157_1.time_ and arg_157_1.time_ <= var_160_20 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			local var_160_21 = 3.554

			if arg_157_1.time_ >= var_160_20 + var_160_21 and arg_157_1.time_ < var_160_20 + var_160_21 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play116292039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116292039
		arg_161_1.duration_ = 2.77

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play116292040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.var_.oldValueTypewriter = arg_161_1.fswtw_.percent

				SetActive(arg_161_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_161_1:ShowNextGo(false)
			end

			local var_164_1 = 19
			local var_164_2 = 1.26666666666667
			local var_164_3 = arg_161_1:GetWordFromCfg(116292038)
			local var_164_4 = arg_161_1:FormatText(var_164_3.content)
			local var_164_5, var_164_6 = arg_161_1:GetPercentByPara(var_164_4, 2)

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				local var_164_7 = var_164_1 <= 0 and var_164_2 or var_164_2 * ((var_164_6 - arg_161_1.typewritterCharCountI18N) / var_164_1)

				if var_164_7 > 0 and var_164_2 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end
			end

			local var_164_8 = 1.26666666666667
			local var_164_9 = math.max(var_164_8, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_9 then
				local var_164_10 = (arg_161_1.time_ - var_164_0) / var_164_9

				arg_161_1.fswtw_.percent = Mathf.Lerp(arg_161_1.var_.oldValueTypewriter, var_164_5, var_164_10)
				arg_161_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_161_1.fswtw_:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_9 and arg_161_1.time_ < var_164_0 + var_164_9 + arg_164_0 then
				arg_161_1.fswtw_.percent = var_164_5

				arg_161_1.fswtw_:SetDirty()
				arg_161_1:ShowNextGo(true)

				arg_161_1.typewritterCharCountI18N = var_164_6
			end

			local var_164_11 = 0
			local var_164_12 = 2.767
			local var_164_13 = manager.audio:GetVoiceLength("story_v_out_116292", "116292039", "story_v_out_116292.awb") / 1000

			if var_164_13 > 0 and var_164_12 < var_164_13 and var_164_13 + var_164_11 > arg_161_1.duration_ then
				local var_164_14 = var_164_13

				arg_161_1.duration_ = var_164_13 + var_164_11
			end

			if var_164_11 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				local var_164_15 = "play"
				local var_164_16 = "voice"

				arg_161_1:AudioAction(var_164_15, var_164_16, "story_v_out_116292", "116292039", "story_v_out_116292.awb")
			end

			local var_164_17 = 0

			if var_164_17 < arg_161_1.time_ and arg_161_1.time_ <= var_164_17 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			local var_164_18 = 1.26666666666667

			if arg_161_1.time_ >= var_164_17 + var_164_18 and arg_161_1.time_ < var_164_17 + var_164_18 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play116292040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116292040
		arg_165_1.duration_ = 2.1

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116292041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.var_.oldValueTypewriter = arg_165_1.fswtw_.percent

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_1 = 18
			local var_168_2 = 1.2
			local var_168_3 = arg_165_1:GetWordFromCfg(116292038)
			local var_168_4 = arg_165_1:FormatText(var_168_3.content)
			local var_168_5, var_168_6 = arg_165_1:GetPercentByPara(var_168_4, 3)

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				local var_168_7 = var_168_1 <= 0 and var_168_2 or var_168_2 * ((var_168_6 - arg_165_1.typewritterCharCountI18N) / var_168_1)

				if var_168_7 > 0 and var_168_2 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end
			end

			local var_168_8 = 1.2
			local var_168_9 = math.max(var_168_8, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_9 then
				local var_168_10 = (arg_165_1.time_ - var_168_0) / var_168_9

				arg_165_1.fswtw_.percent = Mathf.Lerp(arg_165_1.var_.oldValueTypewriter, var_168_5, var_168_10)
				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_165_1.fswtw_:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_9 and arg_165_1.time_ < var_168_0 + var_168_9 + arg_168_0 then
				arg_165_1.fswtw_.percent = var_168_5

				arg_165_1.fswtw_:SetDirty()
				arg_165_1:ShowNextGo(true)

				arg_165_1.typewritterCharCountI18N = var_168_6
			end

			local var_168_11 = 0
			local var_168_12 = 2.102
			local var_168_13 = manager.audio:GetVoiceLength("story_v_out_116292", "116292040", "story_v_out_116292.awb") / 1000

			if var_168_13 > 0 and var_168_12 < var_168_13 and var_168_13 + var_168_11 > arg_165_1.duration_ then
				local var_168_14 = var_168_13

				arg_165_1.duration_ = var_168_13 + var_168_11
			end

			if var_168_11 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				local var_168_15 = "play"
				local var_168_16 = "voice"

				arg_165_1:AudioAction(var_168_15, var_168_16, "story_v_out_116292", "116292040", "story_v_out_116292.awb")
			end

			local var_168_17 = 0

			if var_168_17 < arg_165_1.time_ and arg_165_1.time_ <= var_168_17 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			local var_168_18 = 1.2

			if arg_165_1.time_ >= var_168_17 + var_168_18 and arg_165_1.time_ < var_168_17 + var_168_18 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play116292041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116292041
		arg_169_1.duration_ = 2.94

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116292042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.var_.oldValueTypewriter = arg_169_1.fswtw_.percent

				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_1 = 21
			local var_172_2 = 1.4
			local var_172_3 = arg_169_1:GetWordFromCfg(116292038)
			local var_172_4 = arg_169_1:FormatText(var_172_3.content)
			local var_172_5, var_172_6 = arg_169_1:GetPercentByPara(var_172_4, 4)

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				local var_172_7 = var_172_1 <= 0 and var_172_2 or var_172_2 * ((var_172_6 - arg_169_1.typewritterCharCountI18N) / var_172_1)

				if var_172_7 > 0 and var_172_2 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end
			end

			local var_172_8 = 1.4
			local var_172_9 = math.max(var_172_8, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_9 then
				local var_172_10 = (arg_169_1.time_ - var_172_0) / var_172_9

				arg_169_1.fswtw_.percent = Mathf.Lerp(arg_169_1.var_.oldValueTypewriter, var_172_5, var_172_10)
				arg_169_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_169_1.fswtw_:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_9 and arg_169_1.time_ < var_172_0 + var_172_9 + arg_172_0 then
				arg_169_1.fswtw_.percent = var_172_5

				arg_169_1.fswtw_:SetDirty()
				arg_169_1:ShowNextGo(true)

				arg_169_1.typewritterCharCountI18N = var_172_6
			end

			local var_172_11 = 0
			local var_172_12 = 1

			if var_172_11 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				local var_172_13 = "play"
				local var_172_14 = "effect"

				arg_169_1:AudioAction(var_172_13, var_172_14, "se_story_6", "se_story_6_blast", "")
			end

			local var_172_15 = 0
			local var_172_16 = 2.936
			local var_172_17 = manager.audio:GetVoiceLength("story_v_out_116292", "116292041", "story_v_out_116292.awb") / 1000

			if var_172_17 > 0 and var_172_16 < var_172_17 and var_172_17 + var_172_15 > arg_169_1.duration_ then
				local var_172_18 = var_172_17

				arg_169_1.duration_ = var_172_17 + var_172_15
			end

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				local var_172_19 = "play"
				local var_172_20 = "voice"

				arg_169_1:AudioAction(var_172_19, var_172_20, "story_v_out_116292", "116292041", "story_v_out_116292.awb")
			end

			local var_172_21 = 0

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			local var_172_22 = 1.4

			if arg_169_1.time_ >= var_172_21 + var_172_22 and arg_169_1.time_ < var_172_21 + var_172_22 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play116292042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116292042
		arg_173_1.duration_ = 1.84

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play116292043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.var_.oldValueTypewriter = arg_173_1.fswtw_.percent

				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_173_1:ShowNextGo(false)
			end

			local var_176_1 = 18
			local var_176_2 = 1.2
			local var_176_3 = arg_173_1:GetWordFromCfg(116292038)
			local var_176_4 = arg_173_1:FormatText(var_176_3.content)
			local var_176_5, var_176_6 = arg_173_1:GetPercentByPara(var_176_4, 5)

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				local var_176_7 = var_176_1 <= 0 and var_176_2 or var_176_2 * ((var_176_6 - arg_173_1.typewritterCharCountI18N) / var_176_1)

				if var_176_7 > 0 and var_176_2 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end
			end

			local var_176_8 = 1.2
			local var_176_9 = math.max(var_176_8, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_9 then
				local var_176_10 = (arg_173_1.time_ - var_176_0) / var_176_9

				arg_173_1.fswtw_.percent = Mathf.Lerp(arg_173_1.var_.oldValueTypewriter, var_176_5, var_176_10)
				arg_173_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_173_1.fswtw_:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_9 and arg_173_1.time_ < var_176_0 + var_176_9 + arg_176_0 then
				arg_173_1.fswtw_.percent = var_176_5

				arg_173_1.fswtw_:SetDirty()
				arg_173_1:ShowNextGo(true)

				arg_173_1.typewritterCharCountI18N = var_176_6
			end

			local var_176_11 = 0
			local var_176_12 = 1.844
			local var_176_13 = manager.audio:GetVoiceLength("story_v_out_116292", "116292042", "story_v_out_116292.awb") / 1000

			if var_176_13 > 0 and var_176_12 < var_176_13 and var_176_13 + var_176_11 > arg_173_1.duration_ then
				local var_176_14 = var_176_13

				arg_173_1.duration_ = var_176_13 + var_176_11
			end

			if var_176_11 < arg_173_1.time_ and arg_173_1.time_ <= var_176_11 + arg_176_0 then
				local var_176_15 = "play"
				local var_176_16 = "voice"

				arg_173_1:AudioAction(var_176_15, var_176_16, "story_v_out_116292", "116292042", "story_v_out_116292.awb")
			end

			local var_176_17 = 0

			if var_176_17 < arg_173_1.time_ and arg_173_1.time_ <= var_176_17 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			local var_176_18 = 1.2

			if arg_173_1.time_ >= var_176_17 + var_176_18 and arg_173_1.time_ < var_176_17 + var_176_18 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play116292043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116292043
		arg_177_1.duration_ = 8.13

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play116292044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				local var_180_1 = manager.ui.mainCamera.transform.localPosition
				local var_180_2 = Vector3.New(0, 0, 10) + Vector3.New(var_180_1.x, var_180_1.y, 0)
				local var_180_3 = arg_177_1.bgs_.STblack

				var_180_3.transform.localPosition = var_180_2
				var_180_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_180_4 = var_180_3:GetComponent("SpriteRenderer")

				if var_180_4 and var_180_4.sprite then
					local var_180_5 = (var_180_3.transform.localPosition - var_180_1).z
					local var_180_6 = manager.ui.mainCameraCom_
					local var_180_7 = 2 * var_180_5 * Mathf.Tan(var_180_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_180_8 = var_180_7 * var_180_6.aspect
					local var_180_9 = var_180_4.sprite.bounds.size.x
					local var_180_10 = var_180_4.sprite.bounds.size.y
					local var_180_11 = var_180_8 / var_180_9
					local var_180_12 = var_180_7 / var_180_10
					local var_180_13 = var_180_12 < var_180_11 and var_180_11 or var_180_12

					var_180_3.transform.localScale = Vector3.New(var_180_13, var_180_13, 0)
				end

				for iter_180_0, iter_180_1 in pairs(arg_177_1.bgs_) do
					if iter_180_0 ~= "STblack" then
						iter_180_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_180_14 = 1.983333

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1.fswbg_:SetActive(false)
				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_15 = 2
			local var_180_16 = 3.464
			local var_180_17 = manager.audio:GetVoiceLength("story_v_out_116292", "116292043", "story_v_out_116292.awb") / 1000

			if var_180_17 > 0 and var_180_16 < var_180_17 and var_180_17 + var_180_15 > arg_177_1.duration_ then
				local var_180_18 = var_180_17

				arg_177_1.duration_ = var_180_17 + var_180_15
			end

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				local var_180_19 = "play"
				local var_180_20 = "voice"

				arg_177_1:AudioAction(var_180_19, var_180_20, "story_v_out_116292", "116292043", "story_v_out_116292.awb")
			end

			local var_180_21 = 0

			if var_180_21 < arg_177_1.time_ and arg_177_1.time_ <= var_180_21 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_22 = 2

			if var_180_21 <= arg_177_1.time_ and arg_177_1.time_ < var_180_21 + var_180_22 then
				local var_180_23 = (arg_177_1.time_ - var_180_21) / var_180_22
				local var_180_24 = Color.New(0, 0, 0)

				var_180_24.a = Mathf.Lerp(0, 1, var_180_23)
				arg_177_1.mask_.color = var_180_24
			end

			if arg_177_1.time_ >= var_180_21 + var_180_22 and arg_177_1.time_ < var_180_21 + var_180_22 + arg_180_0 then
				local var_180_25 = Color.New(0, 0, 0)

				var_180_25.a = 1
				arg_177_1.mask_.color = var_180_25
			end

			local var_180_26 = 2

			if var_180_26 < arg_177_1.time_ and arg_177_1.time_ <= var_180_26 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_27 = 2

			if var_180_26 <= arg_177_1.time_ and arg_177_1.time_ < var_180_26 + var_180_27 then
				local var_180_28 = (arg_177_1.time_ - var_180_26) / var_180_27
				local var_180_29 = Color.New(0, 0, 0)

				var_180_29.a = Mathf.Lerp(1, 0, var_180_28)
				arg_177_1.mask_.color = var_180_29
			end

			if arg_177_1.time_ >= var_180_26 + var_180_27 and arg_177_1.time_ < var_180_26 + var_180_27 + arg_180_0 then
				local var_180_30 = Color.New(0, 0, 0)
				local var_180_31 = 0

				arg_177_1.mask_.enabled = false
				var_180_30.a = var_180_31
				arg_177_1.mask_.color = var_180_30
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_32 = 1.983333
			local var_180_33 = 0.15

			if var_180_32 < arg_177_1.time_ and arg_177_1.time_ <= var_180_32 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_34 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_34:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_35 = arg_177_1:FormatText(StoryNameCfg[8].name)

				arg_177_1.leftNameTxt_.text = var_180_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_36 = arg_177_1:GetWordFromCfg(116292043)
				local var_180_37 = arg_177_1:FormatText(var_180_36.content)

				arg_177_1.text_.text = var_180_37

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_38 = 6
				local var_180_39 = utf8.len(var_180_37)
				local var_180_40 = var_180_38 <= 0 and var_180_33 or var_180_33 * (var_180_39 / var_180_38)

				if var_180_40 > 0 and var_180_33 < var_180_40 then
					arg_177_1.talkMaxDuration = var_180_40
					var_180_32 = var_180_32 + 0.3

					if var_180_40 + var_180_32 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_40 + var_180_32
					end
				end

				arg_177_1.text_.text = var_180_37
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292043", "story_v_out_116292.awb") ~= 0 then
					local var_180_41 = manager.audio:GetVoiceLength("story_v_out_116292", "116292043", "story_v_out_116292.awb") / 1000

					if var_180_41 + var_180_32 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_41 + var_180_32
					end

					if var_180_36.prefab_name ~= "" and arg_177_1.actors_[var_180_36.prefab_name] ~= nil then
						local var_180_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_36.prefab_name].transform, "story_v_out_116292", "116292043", "story_v_out_116292.awb")

						arg_177_1:RecordAudio("116292043", var_180_42)
						arg_177_1:RecordAudio("116292043", var_180_42)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_116292", "116292043", "story_v_out_116292.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_116292", "116292043", "story_v_out_116292.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_43 = var_180_32 + 0.3
			local var_180_44 = math.max(var_180_33, arg_177_1.talkMaxDuration)

			if var_180_43 <= arg_177_1.time_ and arg_177_1.time_ < var_180_43 + var_180_44 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_43) / var_180_44

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_43 + var_180_44 and arg_177_1.time_ < var_180_43 + var_180_44 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play116292044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 116292044
		arg_183_1.duration_ = 6.83

		local var_183_0 = {
			zh = 5.733,
			ja = 6.833
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
				arg_183_0:Play116292045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = "SK0204a"

			if arg_183_1.bgs_[var_186_0] == nil then
				local var_186_1 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_186_0)
				var_186_1.name = var_186_0
				var_186_1.transform.parent = arg_183_1.stage_.transform
				var_186_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_[var_186_0] = var_186_1
			end

			local var_186_2 = 0

			if var_186_2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				local var_186_3 = manager.ui.mainCamera.transform.localPosition
				local var_186_4 = Vector3.New(0, 0, 10) + Vector3.New(var_186_3.x, var_186_3.y, 0)
				local var_186_5 = arg_183_1.bgs_.SK0204a

				var_186_5.transform.localPosition = var_186_4
				var_186_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_6 = var_186_5:GetComponent("SpriteRenderer")

				if var_186_6 and var_186_6.sprite then
					local var_186_7 = (var_186_5.transform.localPosition - var_186_3).z
					local var_186_8 = manager.ui.mainCameraCom_
					local var_186_9 = 2 * var_186_7 * Mathf.Tan(var_186_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_186_10 = var_186_9 * var_186_8.aspect
					local var_186_11 = var_186_6.sprite.bounds.size.x
					local var_186_12 = var_186_6.sprite.bounds.size.y
					local var_186_13 = var_186_10 / var_186_11
					local var_186_14 = var_186_9 / var_186_12
					local var_186_15 = var_186_14 < var_186_13 and var_186_13 or var_186_14

					var_186_5.transform.localScale = Vector3.New(var_186_15, var_186_15, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "SK0204a" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_16 = 0

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_17 = 3

			if var_186_16 <= arg_183_1.time_ and arg_183_1.time_ < var_186_16 + var_186_17 then
				local var_186_18 = (arg_183_1.time_ - var_186_16) / var_186_17
				local var_186_19 = Color.New(0, 0, 0)

				var_186_19.a = Mathf.Lerp(1, 0, var_186_18)
				arg_183_1.mask_.color = var_186_19
			end

			if arg_183_1.time_ >= var_186_16 + var_186_17 and arg_183_1.time_ < var_186_16 + var_186_17 + arg_186_0 then
				local var_186_20 = Color.New(0, 0, 0)
				local var_186_21 = 0

				arg_183_1.mask_.enabled = false
				var_186_20.a = var_186_21
				arg_183_1.mask_.color = var_186_20
			end

			local var_186_22 = 0

			arg_183_1.isInRecall_ = false

			if var_186_22 < arg_183_1.time_ and arg_183_1.time_ <= var_186_22 + arg_186_0 then
				arg_183_1.screenFilterGo_:SetActive(true)

				arg_183_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_186_2, iter_186_3 in pairs(arg_183_1.actors_) do
					local var_186_23 = iter_186_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_186_4, iter_186_5 in ipairs(var_186_23) do
						if iter_186_5.color.r > 0.51 then
							iter_186_5.color = Color.New(1, 1, 1)
						else
							iter_186_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_186_24 = 0.0166666666666667

			if var_186_22 <= arg_183_1.time_ and arg_183_1.time_ < var_186_22 + var_186_24 then
				local var_186_25 = (arg_183_1.time_ - var_186_22) / var_186_24

				arg_183_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_186_25)
			end

			if arg_183_1.time_ >= var_186_22 + var_186_24 and arg_183_1.time_ < var_186_22 + var_186_24 + arg_186_0 then
				arg_183_1.screenFilterEffect_.weight = 1
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_26 = 3
			local var_186_27 = 0.2

			if var_186_26 < arg_183_1.time_ and arg_183_1.time_ <= var_186_26 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_28 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_28:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_29 = arg_183_1:FormatText(StoryNameCfg[8].name)

				arg_183_1.leftNameTxt_.text = var_186_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_30 = arg_183_1:GetWordFromCfg(116292044)
				local var_186_31 = arg_183_1:FormatText(var_186_30.content)

				arg_183_1.text_.text = var_186_31

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_32 = 8
				local var_186_33 = utf8.len(var_186_31)
				local var_186_34 = var_186_32 <= 0 and var_186_27 or var_186_27 * (var_186_33 / var_186_32)

				if var_186_34 > 0 and var_186_27 < var_186_34 then
					arg_183_1.talkMaxDuration = var_186_34
					var_186_26 = var_186_26 + 0.3

					if var_186_34 + var_186_26 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_34 + var_186_26
					end
				end

				arg_183_1.text_.text = var_186_31
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292044", "story_v_out_116292.awb") ~= 0 then
					local var_186_35 = manager.audio:GetVoiceLength("story_v_out_116292", "116292044", "story_v_out_116292.awb") / 1000

					if var_186_35 + var_186_26 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_35 + var_186_26
					end

					if var_186_30.prefab_name ~= "" and arg_183_1.actors_[var_186_30.prefab_name] ~= nil then
						local var_186_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_30.prefab_name].transform, "story_v_out_116292", "116292044", "story_v_out_116292.awb")

						arg_183_1:RecordAudio("116292044", var_186_36)
						arg_183_1:RecordAudio("116292044", var_186_36)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_116292", "116292044", "story_v_out_116292.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_116292", "116292044", "story_v_out_116292.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_37 = var_186_26 + 0.3
			local var_186_38 = math.max(var_186_27, arg_183_1.talkMaxDuration)

			if var_186_37 <= arg_183_1.time_ and arg_183_1.time_ < var_186_37 + var_186_38 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_37) / var_186_38

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_37 + var_186_38 and arg_183_1.time_ < var_186_37 + var_186_38 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play116292045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 116292045
		arg_189_1.duration_ = 7.7

		local var_189_0 = {
			zh = 7.7,
			ja = 6.966
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
				arg_189_0:Play116292046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.75

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[327].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(116292045)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 30
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292045", "story_v_out_116292.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292045", "story_v_out_116292.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_116292", "116292045", "story_v_out_116292.awb")

						arg_189_1:RecordAudio("116292045", var_192_9)
						arg_189_1:RecordAudio("116292045", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_116292", "116292045", "story_v_out_116292.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_116292", "116292045", "story_v_out_116292.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play116292046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116292046
		arg_193_1.duration_ = 6

		local var_193_0 = {
			zh = 6,
			ja = 2.966
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
				arg_193_0:Play116292047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.45

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[8].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(116292046)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292046", "story_v_out_116292.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292046", "story_v_out_116292.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_116292", "116292046", "story_v_out_116292.awb")

						arg_193_1:RecordAudio("116292046", var_196_9)
						arg_193_1:RecordAudio("116292046", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_116292", "116292046", "story_v_out_116292.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_116292", "116292046", "story_v_out_116292.awb")
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
	Play116292047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116292047
		arg_197_1.duration_ = 12.63

		local var_197_0 = {
			zh = 8.8,
			ja = 12.633
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
				arg_197_0:Play116292048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.925

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[327].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(116292047)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 37
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292047", "story_v_out_116292.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292047", "story_v_out_116292.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_116292", "116292047", "story_v_out_116292.awb")

						arg_197_1:RecordAudio("116292047", var_200_9)
						arg_197_1:RecordAudio("116292047", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_116292", "116292047", "story_v_out_116292.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_116292", "116292047", "story_v_out_116292.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116292048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 116292048
		arg_201_1.duration_ = 3.4

		local var_201_0 = {
			zh = 2.7,
			ja = 3.4
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
				arg_201_0:Play116292049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.225

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[8].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(116292048)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292048", "story_v_out_116292.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292048", "story_v_out_116292.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_116292", "116292048", "story_v_out_116292.awb")

						arg_201_1:RecordAudio("116292048", var_204_9)
						arg_201_1:RecordAudio("116292048", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_116292", "116292048", "story_v_out_116292.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_116292", "116292048", "story_v_out_116292.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play116292049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 116292049
		arg_205_1.duration_ = 10.63

		local var_205_0 = {
			zh = 10.633,
			ja = 4.4
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
				arg_205_0:Play116292050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[327].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(116292049)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292049", "story_v_out_116292.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292049", "story_v_out_116292.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_116292", "116292049", "story_v_out_116292.awb")

						arg_205_1:RecordAudio("116292049", var_208_9)
						arg_205_1:RecordAudio("116292049", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_116292", "116292049", "story_v_out_116292.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_116292", "116292049", "story_v_out_116292.awb")
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
	Play116292050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 116292050
		arg_209_1.duration_ = 4.7

		local var_209_0 = {
			zh = 2.8,
			ja = 4.7
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
				arg_209_0:Play116292051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.325

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[28].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(116292050)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292050", "story_v_out_116292.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292050", "story_v_out_116292.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_116292", "116292050", "story_v_out_116292.awb")

						arg_209_1:RecordAudio("116292050", var_212_9)
						arg_209_1:RecordAudio("116292050", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_116292", "116292050", "story_v_out_116292.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_116292", "116292050", "story_v_out_116292.awb")
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
	Play116292051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 116292051
		arg_213_1.duration_ = 5.23

		local var_213_0 = {
			zh = 5.233,
			ja = 2.133
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
				arg_213_0:Play116292052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.4

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[327].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(116292051)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 16
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292051", "story_v_out_116292.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292051", "story_v_out_116292.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_116292", "116292051", "story_v_out_116292.awb")

						arg_213_1:RecordAudio("116292051", var_216_9)
						arg_213_1:RecordAudio("116292051", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_116292", "116292051", "story_v_out_116292.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_116292", "116292051", "story_v_out_116292.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_10 and arg_213_1.time_ < var_216_0 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play116292052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 116292052
		arg_217_1.duration_ = 3.6

		local var_217_0 = {
			zh = 3.6,
			ja = 2.466
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
				arg_217_0:Play116292053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.175

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[8].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:GetWordFromCfg(116292052)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 7
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292052", "story_v_out_116292.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292052", "story_v_out_116292.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_116292", "116292052", "story_v_out_116292.awb")

						arg_217_1:RecordAudio("116292052", var_220_9)
						arg_217_1:RecordAudio("116292052", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_116292", "116292052", "story_v_out_116292.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_116292", "116292052", "story_v_out_116292.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_10 and arg_217_1.time_ < var_220_0 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play116292053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 116292053
		arg_221_1.duration_ = 13.47

		local var_221_0 = {
			zh = 13.466,
			ja = 10.6
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
				arg_221_0:Play116292054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 2

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				local var_224_1 = manager.ui.mainCamera.transform.localPosition
				local var_224_2 = Vector3.New(0, 0, 10) + Vector3.New(var_224_1.x, var_224_1.y, 0)
				local var_224_3 = arg_221_1.bgs_.B13c

				var_224_3.transform.localPosition = var_224_2
				var_224_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_4 = var_224_3:GetComponent("SpriteRenderer")

				if var_224_4 and var_224_4.sprite then
					local var_224_5 = (var_224_3.transform.localPosition - var_224_1).z
					local var_224_6 = manager.ui.mainCameraCom_
					local var_224_7 = 2 * var_224_5 * Mathf.Tan(var_224_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_224_8 = var_224_7 * var_224_6.aspect
					local var_224_9 = var_224_4.sprite.bounds.size.x
					local var_224_10 = var_224_4.sprite.bounds.size.y
					local var_224_11 = var_224_8 / var_224_9
					local var_224_12 = var_224_7 / var_224_10
					local var_224_13 = var_224_12 < var_224_11 and var_224_11 or var_224_12

					var_224_3.transform.localScale = Vector3.New(var_224_13, var_224_13, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "B13c" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_15 = 2

			if var_224_14 <= arg_221_1.time_ and arg_221_1.time_ < var_224_14 + var_224_15 then
				local var_224_16 = (arg_221_1.time_ - var_224_14) / var_224_15
				local var_224_17 = Color.New(0, 0, 0)

				var_224_17.a = Mathf.Lerp(0, 1, var_224_16)
				arg_221_1.mask_.color = var_224_17
			end

			if arg_221_1.time_ >= var_224_14 + var_224_15 and arg_221_1.time_ < var_224_14 + var_224_15 + arg_224_0 then
				local var_224_18 = Color.New(0, 0, 0)

				var_224_18.a = 1
				arg_221_1.mask_.color = var_224_18
			end

			local var_224_19 = 2

			if var_224_19 < arg_221_1.time_ and arg_221_1.time_ <= var_224_19 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_20 = 2

			if var_224_19 <= arg_221_1.time_ and arg_221_1.time_ < var_224_19 + var_224_20 then
				local var_224_21 = (arg_221_1.time_ - var_224_19) / var_224_20
				local var_224_22 = Color.New(0, 0, 0)

				var_224_22.a = Mathf.Lerp(1, 0, var_224_21)
				arg_221_1.mask_.color = var_224_22
			end

			if arg_221_1.time_ >= var_224_19 + var_224_20 and arg_221_1.time_ < var_224_19 + var_224_20 + arg_224_0 then
				local var_224_23 = Color.New(0, 0, 0)
				local var_224_24 = 0

				arg_221_1.mask_.enabled = false
				var_224_23.a = var_224_24
				arg_221_1.mask_.color = var_224_23
			end

			local var_224_25 = 1.98333333333333

			arg_221_1.isInRecall_ = false

			if var_224_25 < arg_221_1.time_ and arg_221_1.time_ <= var_224_25 + arg_224_0 then
				arg_221_1.screenFilterGo_:SetActive(false)

				for iter_224_2, iter_224_3 in pairs(arg_221_1.actors_) do
					local var_224_26 = iter_224_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_224_4, iter_224_5 in ipairs(var_224_26) do
						if iter_224_5.color.r > 0.51 then
							iter_224_5.color = Color.New(1, 1, 1)
						else
							iter_224_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_224_27 = 0.0166666666666667

			if var_224_25 <= arg_221_1.time_ and arg_221_1.time_ < var_224_25 + var_224_27 then
				local var_224_28 = (arg_221_1.time_ - var_224_25) / var_224_27

				arg_221_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_224_28)
			end

			if arg_221_1.time_ >= var_224_25 + var_224_27 and arg_221_1.time_ < var_224_25 + var_224_27 + arg_224_0 then
				arg_221_1.screenFilterEffect_.weight = 0
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_29 = 4
			local var_224_30 = 1.175

			if var_224_29 < arg_221_1.time_ and arg_221_1.time_ <= var_224_29 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_31 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_31:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_32 = arg_221_1:FormatText(StoryNameCfg[28].name)

				arg_221_1.leftNameTxt_.text = var_224_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_33 = arg_221_1:GetWordFromCfg(116292053)
				local var_224_34 = arg_221_1:FormatText(var_224_33.content)

				arg_221_1.text_.text = var_224_34

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_35 = 47
				local var_224_36 = utf8.len(var_224_34)
				local var_224_37 = var_224_35 <= 0 and var_224_30 or var_224_30 * (var_224_36 / var_224_35)

				if var_224_37 > 0 and var_224_30 < var_224_37 then
					arg_221_1.talkMaxDuration = var_224_37
					var_224_29 = var_224_29 + 0.3

					if var_224_37 + var_224_29 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_37 + var_224_29
					end
				end

				arg_221_1.text_.text = var_224_34
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292053", "story_v_out_116292.awb") ~= 0 then
					local var_224_38 = manager.audio:GetVoiceLength("story_v_out_116292", "116292053", "story_v_out_116292.awb") / 1000

					if var_224_38 + var_224_29 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_38 + var_224_29
					end

					if var_224_33.prefab_name ~= "" and arg_221_1.actors_[var_224_33.prefab_name] ~= nil then
						local var_224_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_33.prefab_name].transform, "story_v_out_116292", "116292053", "story_v_out_116292.awb")

						arg_221_1:RecordAudio("116292053", var_224_39)
						arg_221_1:RecordAudio("116292053", var_224_39)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_116292", "116292053", "story_v_out_116292.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_116292", "116292053", "story_v_out_116292.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_40 = var_224_29 + 0.3
			local var_224_41 = math.max(var_224_30, arg_221_1.talkMaxDuration)

			if var_224_40 <= arg_221_1.time_ and arg_221_1.time_ < var_224_40 + var_224_41 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_40) / var_224_41

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_40 + var_224_41 and arg_221_1.time_ < var_224_40 + var_224_41 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play116292054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 116292054
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play116292055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 1

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(116292054)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 40
				local var_230_5 = utf8.len(var_230_3)
				local var_230_6 = var_230_4 <= 0 and var_230_1 or var_230_1 * (var_230_5 / var_230_4)

				if var_230_6 > 0 and var_230_1 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_7 and arg_227_1.time_ < var_230_0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play116292055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 116292055
		arg_231_1.duration_ = 7.2

		local var_231_0 = {
			zh = 7.2,
			ja = 6.766
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
				arg_231_0:Play116292056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1059ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1059ui_story == nil then
				arg_231_1.var_.characterEffect1059ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1059ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1059ui_story then
				arg_231_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_234_4 = 0

			if var_234_4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_234_5 = arg_231_1.actors_["1059ui_story"].transform
			local var_234_6 = 0

			if var_234_6 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.var_.moveOldPos1059ui_story = var_234_5.localPosition
			end

			local var_234_7 = 0.001

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_7 then
				local var_234_8 = (arg_231_1.time_ - var_234_6) / var_234_7
				local var_234_9 = Vector3.New(0, -1.05, -6)

				var_234_5.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1059ui_story, var_234_9, var_234_8)

				local var_234_10 = manager.ui.mainCamera.transform.position - var_234_5.position

				var_234_5.forward = Vector3.New(var_234_10.x, var_234_10.y, var_234_10.z)

				local var_234_11 = var_234_5.localEulerAngles

				var_234_11.z = 0
				var_234_11.x = 0
				var_234_5.localEulerAngles = var_234_11
			end

			if arg_231_1.time_ >= var_234_6 + var_234_7 and arg_231_1.time_ < var_234_6 + var_234_7 + arg_234_0 then
				var_234_5.localPosition = Vector3.New(0, -1.05, -6)

				local var_234_12 = manager.ui.mainCamera.transform.position - var_234_5.position

				var_234_5.forward = Vector3.New(var_234_12.x, var_234_12.y, var_234_12.z)

				local var_234_13 = var_234_5.localEulerAngles

				var_234_13.z = 0
				var_234_13.x = 0
				var_234_5.localEulerAngles = var_234_13
			end

			local var_234_14 = 0

			if var_234_14 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 then
				arg_231_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			local var_234_15 = 0
			local var_234_16 = 0.825

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_17 = arg_231_1:FormatText(StoryNameCfg[28].name)

				arg_231_1.leftNameTxt_.text = var_234_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_18 = arg_231_1:GetWordFromCfg(116292055)
				local var_234_19 = arg_231_1:FormatText(var_234_18.content)

				arg_231_1.text_.text = var_234_19

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_20 = 33
				local var_234_21 = utf8.len(var_234_19)
				local var_234_22 = var_234_20 <= 0 and var_234_16 or var_234_16 * (var_234_21 / var_234_20)

				if var_234_22 > 0 and var_234_16 < var_234_22 then
					arg_231_1.talkMaxDuration = var_234_22

					if var_234_22 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_22 + var_234_15
					end
				end

				arg_231_1.text_.text = var_234_19
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292055", "story_v_out_116292.awb") ~= 0 then
					local var_234_23 = manager.audio:GetVoiceLength("story_v_out_116292", "116292055", "story_v_out_116292.awb") / 1000

					if var_234_23 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_23 + var_234_15
					end

					if var_234_18.prefab_name ~= "" and arg_231_1.actors_[var_234_18.prefab_name] ~= nil then
						local var_234_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_18.prefab_name].transform, "story_v_out_116292", "116292055", "story_v_out_116292.awb")

						arg_231_1:RecordAudio("116292055", var_234_24)
						arg_231_1:RecordAudio("116292055", var_234_24)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_116292", "116292055", "story_v_out_116292.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_116292", "116292055", "story_v_out_116292.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_25 = math.max(var_234_16, arg_231_1.talkMaxDuration)

			if var_234_15 <= arg_231_1.time_ and arg_231_1.time_ < var_234_15 + var_234_25 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_15) / var_234_25

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_15 + var_234_25 and arg_231_1.time_ < var_234_15 + var_234_25 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play116292056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 116292056
		arg_235_1.duration_ = 6.6

		local var_235_0 = {
			zh = 6.6,
			ja = 3.566
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
				arg_235_0:Play116292057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_238_1 = 0
			local var_238_2 = 0.825

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_3 = arg_235_1:FormatText(StoryNameCfg[28].name)

				arg_235_1.leftNameTxt_.text = var_238_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_4 = arg_235_1:GetWordFromCfg(116292056)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_6 = 33
				local var_238_7 = utf8.len(var_238_5)
				local var_238_8 = var_238_6 <= 0 and var_238_2 or var_238_2 * (var_238_7 / var_238_6)

				if var_238_8 > 0 and var_238_2 < var_238_8 then
					arg_235_1.talkMaxDuration = var_238_8

					if var_238_8 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292056", "story_v_out_116292.awb") ~= 0 then
					local var_238_9 = manager.audio:GetVoiceLength("story_v_out_116292", "116292056", "story_v_out_116292.awb") / 1000

					if var_238_9 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_1
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_116292", "116292056", "story_v_out_116292.awb")

						arg_235_1:RecordAudio("116292056", var_238_10)
						arg_235_1:RecordAudio("116292056", var_238_10)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_116292", "116292056", "story_v_out_116292.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_116292", "116292056", "story_v_out_116292.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_11 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_11 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_11

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_11 and arg_235_1.time_ < var_238_1 + var_238_11 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play116292057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 116292057
		arg_239_1.duration_ = 7.7

		local var_239_0 = {
			zh = 7.666,
			ja = 7.7
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
				arg_239_0:Play116292058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_2")
			end

			local var_242_2 = 0
			local var_242_3 = 0.975

			if var_242_2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_4 = arg_239_1:FormatText(StoryNameCfg[28].name)

				arg_239_1.leftNameTxt_.text = var_242_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_5 = arg_239_1:GetWordFromCfg(116292057)
				local var_242_6 = arg_239_1:FormatText(var_242_5.content)

				arg_239_1.text_.text = var_242_6

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_7 = 39
				local var_242_8 = utf8.len(var_242_6)
				local var_242_9 = var_242_7 <= 0 and var_242_3 or var_242_3 * (var_242_8 / var_242_7)

				if var_242_9 > 0 and var_242_3 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_6
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292057", "story_v_out_116292.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_116292", "116292057", "story_v_out_116292.awb") / 1000

					if var_242_10 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_2
					end

					if var_242_5.prefab_name ~= "" and arg_239_1.actors_[var_242_5.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_5.prefab_name].transform, "story_v_out_116292", "116292057", "story_v_out_116292.awb")

						arg_239_1:RecordAudio("116292057", var_242_11)
						arg_239_1:RecordAudio("116292057", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_116292", "116292057", "story_v_out_116292.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_116292", "116292057", "story_v_out_116292.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_12 and arg_239_1.time_ < var_242_2 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play116292058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 116292058
		arg_243_1.duration_ = 1.7

		local var_243_0 = {
			zh = 1.7,
			ja = 1.1
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
				arg_243_0:Play116292059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1059ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1059ui_story == nil then
				arg_243_1.var_.characterEffect1059ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect1059ui_story and not isNil(var_246_0) then
					local var_246_4 = Mathf.Lerp(0, 0.5, var_246_3)

					arg_243_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1059ui_story.fillRatio = var_246_4
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1059ui_story then
				local var_246_5 = 0.5

				arg_243_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1059ui_story.fillRatio = var_246_5
			end

			local var_246_6 = 0
			local var_246_7 = 0.15

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_8 = arg_243_1:FormatText(StoryNameCfg[327].name)

				arg_243_1.leftNameTxt_.text = var_246_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_9 = arg_243_1:GetWordFromCfg(116292058)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 6
				local var_246_12 = utf8.len(var_246_10)
				local var_246_13 = var_246_11 <= 0 and var_246_7 or var_246_7 * (var_246_12 / var_246_11)

				if var_246_13 > 0 and var_246_7 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292058", "story_v_out_116292.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_116292", "116292058", "story_v_out_116292.awb") / 1000

					if var_246_14 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_6
					end

					if var_246_9.prefab_name ~= "" and arg_243_1.actors_[var_246_9.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_9.prefab_name].transform, "story_v_out_116292", "116292058", "story_v_out_116292.awb")

						arg_243_1:RecordAudio("116292058", var_246_15)
						arg_243_1:RecordAudio("116292058", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_116292", "116292058", "story_v_out_116292.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_116292", "116292058", "story_v_out_116292.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_16 and arg_243_1.time_ < var_246_6 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play116292059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 116292059
		arg_247_1.duration_ = 13.43

		local var_247_0 = {
			zh = 12.1,
			ja = 13.433
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
				arg_247_0:Play116292060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1059ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1059ui_story == nil then
				arg_247_1.var_.characterEffect1059ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1059ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1059ui_story then
				arg_247_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_250_4 = 0

			if var_250_4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_250_5 = 0
			local var_250_6 = 1.3

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_7 = arg_247_1:FormatText(StoryNameCfg[28].name)

				arg_247_1.leftNameTxt_.text = var_250_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_8 = arg_247_1:GetWordFromCfg(116292059)
				local var_250_9 = arg_247_1:FormatText(var_250_8.content)

				arg_247_1.text_.text = var_250_9

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_10 = 52
				local var_250_11 = utf8.len(var_250_9)
				local var_250_12 = var_250_10 <= 0 and var_250_6 or var_250_6 * (var_250_11 / var_250_10)

				if var_250_12 > 0 and var_250_6 < var_250_12 then
					arg_247_1.talkMaxDuration = var_250_12

					if var_250_12 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_12 + var_250_5
					end
				end

				arg_247_1.text_.text = var_250_9
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292059", "story_v_out_116292.awb") ~= 0 then
					local var_250_13 = manager.audio:GetVoiceLength("story_v_out_116292", "116292059", "story_v_out_116292.awb") / 1000

					if var_250_13 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_5
					end

					if var_250_8.prefab_name ~= "" and arg_247_1.actors_[var_250_8.prefab_name] ~= nil then
						local var_250_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_8.prefab_name].transform, "story_v_out_116292", "116292059", "story_v_out_116292.awb")

						arg_247_1:RecordAudio("116292059", var_250_14)
						arg_247_1:RecordAudio("116292059", var_250_14)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_116292", "116292059", "story_v_out_116292.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_116292", "116292059", "story_v_out_116292.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_15 = math.max(var_250_6, arg_247_1.talkMaxDuration)

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_15 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_5) / var_250_15

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_5 + var_250_15 and arg_247_1.time_ < var_250_5 + var_250_15 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play116292060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 116292060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play116292061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1059ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1059ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(0, 100, 0)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1059ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, 100, 0)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = 0
			local var_254_10 = 1

			if var_254_9 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 then
				local var_254_11 = "play"
				local var_254_12 = "effect"

				arg_251_1:AudioAction(var_254_11, var_254_12, "se_story_16", "se_story_16_arch", "")
			end

			local var_254_13 = 0
			local var_254_14 = 0.5

			if var_254_13 < arg_251_1.time_ and arg_251_1.time_ <= var_254_13 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_15 = arg_251_1:GetWordFromCfg(116292060)
				local var_254_16 = arg_251_1:FormatText(var_254_15.content)

				arg_251_1.text_.text = var_254_16

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_17 = 20
				local var_254_18 = utf8.len(var_254_16)
				local var_254_19 = var_254_17 <= 0 and var_254_14 or var_254_14 * (var_254_18 / var_254_17)

				if var_254_19 > 0 and var_254_14 < var_254_19 then
					arg_251_1.talkMaxDuration = var_254_19

					if var_254_19 + var_254_13 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_19 + var_254_13
					end
				end

				arg_251_1.text_.text = var_254_16
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_20 = math.max(var_254_14, arg_251_1.talkMaxDuration)

			if var_254_13 <= arg_251_1.time_ and arg_251_1.time_ < var_254_13 + var_254_20 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_13) / var_254_20

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_13 + var_254_20 and arg_251_1.time_ < var_254_13 + var_254_20 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play116292061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 116292061
		arg_255_1.duration_ = 6.3

		local var_255_0 = {
			zh = 4.266,
			ja = 6.3
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play116292062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.4

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[28].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(116292061)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 16
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292061", "story_v_out_116292.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292061", "story_v_out_116292.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_116292", "116292061", "story_v_out_116292.awb")

						arg_255_1:RecordAudio("116292061", var_258_9)
						arg_255_1:RecordAudio("116292061", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_116292", "116292061", "story_v_out_116292.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_116292", "116292061", "story_v_out_116292.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play116292062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 116292062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play116292063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 1.125

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

				local var_262_2 = arg_259_1:GetWordFromCfg(116292062)
				local var_262_3 = arg_259_1:FormatText(var_262_2.content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 45
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
	Play116292063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 116292063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play116292064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.7

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

				local var_266_2 = arg_263_1:GetWordFromCfg(116292063)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 28
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
	Play116292064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 116292064
		arg_267_1.duration_ = 6.63

		local var_267_0 = {
			zh = 4.466,
			ja = 6.633
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
				arg_267_0:Play116292065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.3

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[327].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:GetWordFromCfg(116292064)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292064", "story_v_out_116292.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292064", "story_v_out_116292.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_116292", "116292064", "story_v_out_116292.awb")

						arg_267_1:RecordAudio("116292064", var_270_9)
						arg_267_1:RecordAudio("116292064", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_116292", "116292064", "story_v_out_116292.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_116292", "116292064", "story_v_out_116292.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play116292065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 116292065
		arg_271_1.duration_ = 5.57

		local var_271_0 = {
			zh = 5.566,
			ja = 4.033
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
				arg_271_0:Play116292066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1059ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1059ui_story == nil then
				arg_271_1.var_.characterEffect1059ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1059ui_story and not isNil(var_274_0) then
					arg_271_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1059ui_story then
				arg_271_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_274_4 = 0

			if var_274_4 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			local var_274_5 = 0

			if var_274_5 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_274_6 = arg_271_1.actors_["1059ui_story"].transform
			local var_274_7 = 0

			if var_274_7 < arg_271_1.time_ and arg_271_1.time_ <= var_274_7 + arg_274_0 then
				arg_271_1.var_.moveOldPos1059ui_story = var_274_6.localPosition
			end

			local var_274_8 = 0.001

			if var_274_7 <= arg_271_1.time_ and arg_271_1.time_ < var_274_7 + var_274_8 then
				local var_274_9 = (arg_271_1.time_ - var_274_7) / var_274_8
				local var_274_10 = Vector3.New(0, -1.05, -6)

				var_274_6.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1059ui_story, var_274_10, var_274_9)

				local var_274_11 = manager.ui.mainCamera.transform.position - var_274_6.position

				var_274_6.forward = Vector3.New(var_274_11.x, var_274_11.y, var_274_11.z)

				local var_274_12 = var_274_6.localEulerAngles

				var_274_12.z = 0
				var_274_12.x = 0
				var_274_6.localEulerAngles = var_274_12
			end

			if arg_271_1.time_ >= var_274_7 + var_274_8 and arg_271_1.time_ < var_274_7 + var_274_8 + arg_274_0 then
				var_274_6.localPosition = Vector3.New(0, -1.05, -6)

				local var_274_13 = manager.ui.mainCamera.transform.position - var_274_6.position

				var_274_6.forward = Vector3.New(var_274_13.x, var_274_13.y, var_274_13.z)

				local var_274_14 = var_274_6.localEulerAngles

				var_274_14.z = 0
				var_274_14.x = 0
				var_274_6.localEulerAngles = var_274_14
			end

			local var_274_15 = 0
			local var_274_16 = 0.55

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_17 = arg_271_1:FormatText(StoryNameCfg[28].name)

				arg_271_1.leftNameTxt_.text = var_274_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:GetWordFromCfg(116292065)
				local var_274_19 = arg_271_1:FormatText(var_274_18.content)

				arg_271_1.text_.text = var_274_19

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 22
				local var_274_21 = utf8.len(var_274_19)
				local var_274_22 = var_274_20 <= 0 and var_274_16 or var_274_16 * (var_274_21 / var_274_20)

				if var_274_22 > 0 and var_274_16 < var_274_22 then
					arg_271_1.talkMaxDuration = var_274_22

					if var_274_22 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_22 + var_274_15
					end
				end

				arg_271_1.text_.text = var_274_19
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292065", "story_v_out_116292.awb") ~= 0 then
					local var_274_23 = manager.audio:GetVoiceLength("story_v_out_116292", "116292065", "story_v_out_116292.awb") / 1000

					if var_274_23 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_15
					end

					if var_274_18.prefab_name ~= "" and arg_271_1.actors_[var_274_18.prefab_name] ~= nil then
						local var_274_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_18.prefab_name].transform, "story_v_out_116292", "116292065", "story_v_out_116292.awb")

						arg_271_1:RecordAudio("116292065", var_274_24)
						arg_271_1:RecordAudio("116292065", var_274_24)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_116292", "116292065", "story_v_out_116292.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_116292", "116292065", "story_v_out_116292.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_25 = math.max(var_274_16, arg_271_1.talkMaxDuration)

			if var_274_15 <= arg_271_1.time_ and arg_271_1.time_ < var_274_15 + var_274_25 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_15) / var_274_25

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_15 + var_274_25 and arg_271_1.time_ < var_274_15 + var_274_25 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play116292066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 116292066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play116292067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1059ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1059ui_story == nil then
				arg_275_1.var_.characterEffect1059ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect1059ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1059ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1059ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1059ui_story.fillRatio = var_278_5
			end

			local var_278_6 = 0
			local var_278_7 = 0.2

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

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_9 = arg_275_1:GetWordFromCfg(116292066)
				local var_278_10 = arg_275_1:FormatText(var_278_9.content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 8
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
	Play116292067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 116292067
		arg_279_1.duration_ = 2.8

		local var_279_0 = {
			zh = 2.8,
			ja = 2.433333333332
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
				arg_279_0:Play116292068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1059ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1059ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, 100, 0)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1059ui_story, var_282_4, var_282_3)

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

			local var_282_9 = "10025ui_story"

			if arg_279_1.actors_[var_282_9] == nil then
				local var_282_10 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_282_10) then
					local var_282_11 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_279_1.stage_.transform)

					var_282_11.name = var_282_9
					var_282_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_279_1.actors_[var_282_9] = var_282_11

					local var_282_12 = var_282_11:GetComponentInChildren(typeof(CharacterEffect))

					var_282_12.enabled = true

					local var_282_13 = GameObjectTools.GetOrAddComponent(var_282_11, typeof(DynamicBoneHelper))

					if var_282_13 then
						var_282_13:EnableDynamicBone(false)
					end

					arg_279_1:ShowWeapon(var_282_12.transform, false)

					arg_279_1.var_[var_282_9 .. "Animator"] = var_282_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_279_1.var_[var_282_9 .. "Animator"].applyRootMotion = true
					arg_279_1.var_[var_282_9 .. "LipSync"] = var_282_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_282_14 = arg_279_1.actors_["10025ui_story"].transform
			local var_282_15 = 0

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.var_.moveOldPos10025ui_story = var_282_14.localPosition
			end

			local var_282_16 = 0.001

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_16 then
				local var_282_17 = (arg_279_1.time_ - var_282_15) / var_282_16
				local var_282_18 = Vector3.New(0, -1.1, -5.9)

				var_282_14.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10025ui_story, var_282_18, var_282_17)

				local var_282_19 = manager.ui.mainCamera.transform.position - var_282_14.position

				var_282_14.forward = Vector3.New(var_282_19.x, var_282_19.y, var_282_19.z)

				local var_282_20 = var_282_14.localEulerAngles

				var_282_20.z = 0
				var_282_20.x = 0
				var_282_14.localEulerAngles = var_282_20
			end

			if arg_279_1.time_ >= var_282_15 + var_282_16 and arg_279_1.time_ < var_282_15 + var_282_16 + arg_282_0 then
				var_282_14.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_282_21 = manager.ui.mainCamera.transform.position - var_282_14.position

				var_282_14.forward = Vector3.New(var_282_21.x, var_282_21.y, var_282_21.z)

				local var_282_22 = var_282_14.localEulerAngles

				var_282_22.z = 0
				var_282_22.x = 0
				var_282_14.localEulerAngles = var_282_22
			end

			local var_282_23 = arg_279_1.actors_["10025ui_story"]
			local var_282_24 = 0

			if var_282_24 < arg_279_1.time_ and arg_279_1.time_ <= var_282_24 + arg_282_0 and not isNil(var_282_23) and arg_279_1.var_.characterEffect10025ui_story == nil then
				arg_279_1.var_.characterEffect10025ui_story = var_282_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_25 = 0.2

			if var_282_24 <= arg_279_1.time_ and arg_279_1.time_ < var_282_24 + var_282_25 and not isNil(var_282_23) then
				local var_282_26 = (arg_279_1.time_ - var_282_24) / var_282_25

				if arg_279_1.var_.characterEffect10025ui_story and not isNil(var_282_23) then
					arg_279_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_24 + var_282_25 and arg_279_1.time_ < var_282_24 + var_282_25 + arg_282_0 and not isNil(var_282_23) and arg_279_1.var_.characterEffect10025ui_story then
				arg_279_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_282_27 = 0

			if var_282_27 < arg_279_1.time_ and arg_279_1.time_ <= var_282_27 + arg_282_0 then
				arg_279_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_282_28 = 0

			if var_282_28 < arg_279_1.time_ and arg_279_1.time_ <= var_282_28 + arg_282_0 then
				arg_279_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_282_29 = 0
			local var_282_30 = 0.175

			if var_282_29 < arg_279_1.time_ and arg_279_1.time_ <= var_282_29 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_31 = arg_279_1:FormatText(StoryNameCfg[328].name)

				arg_279_1.leftNameTxt_.text = var_282_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_32 = arg_279_1:GetWordFromCfg(116292067)
				local var_282_33 = arg_279_1:FormatText(var_282_32.content)

				arg_279_1.text_.text = var_282_33

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_34 = 7
				local var_282_35 = utf8.len(var_282_33)
				local var_282_36 = var_282_34 <= 0 and var_282_30 or var_282_30 * (var_282_35 / var_282_34)

				if var_282_36 > 0 and var_282_30 < var_282_36 then
					arg_279_1.talkMaxDuration = var_282_36

					if var_282_36 + var_282_29 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_36 + var_282_29
					end
				end

				arg_279_1.text_.text = var_282_33
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292067", "story_v_out_116292.awb") ~= 0 then
					local var_282_37 = manager.audio:GetVoiceLength("story_v_out_116292", "116292067", "story_v_out_116292.awb") / 1000

					if var_282_37 + var_282_29 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_37 + var_282_29
					end

					if var_282_32.prefab_name ~= "" and arg_279_1.actors_[var_282_32.prefab_name] ~= nil then
						local var_282_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_32.prefab_name].transform, "story_v_out_116292", "116292067", "story_v_out_116292.awb")

						arg_279_1:RecordAudio("116292067", var_282_38)
						arg_279_1:RecordAudio("116292067", var_282_38)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_116292", "116292067", "story_v_out_116292.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_116292", "116292067", "story_v_out_116292.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_39 = math.max(var_282_30, arg_279_1.talkMaxDuration)

			if var_282_29 <= arg_279_1.time_ and arg_279_1.time_ < var_282_29 + var_282_39 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_29) / var_282_39

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_29 + var_282_39 and arg_279_1.time_ < var_282_29 + var_282_39 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
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
	Play116292068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 116292068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play116292069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10025ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos10025ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0, 100, 0)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10025ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, 100, 0)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = 0
			local var_286_10 = 1.025

			if var_286_9 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_11 = arg_283_1:GetWordFromCfg(116292068)
				local var_286_12 = arg_283_1:FormatText(var_286_11.content)

				arg_283_1.text_.text = var_286_12

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 41
				local var_286_14 = utf8.len(var_286_12)
				local var_286_15 = var_286_13 <= 0 and var_286_10 or var_286_10 * (var_286_14 / var_286_13)

				if var_286_15 > 0 and var_286_10 < var_286_15 then
					arg_283_1.talkMaxDuration = var_286_15

					if var_286_15 + var_286_9 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_9
					end
				end

				arg_283_1.text_.text = var_286_12
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_10, arg_283_1.talkMaxDuration)

			if var_286_9 <= arg_283_1.time_ and arg_283_1.time_ < var_286_9 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_9) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_9 + var_286_16 and arg_283_1.time_ < var_286_9 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play116292069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 116292069
		arg_287_1.duration_ = 8.3

		local var_287_0 = {
			zh = 6.2,
			ja = 8.3
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
				arg_287_0:Play116292070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 0.35

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_2 = arg_287_1:FormatText(StoryNameCfg[327].name)

				arg_287_1.leftNameTxt_.text = var_290_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:GetWordFromCfg(116292069)
				local var_290_4 = arg_287_1:FormatText(var_290_3.content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 14
				local var_290_6 = utf8.len(var_290_4)
				local var_290_7 = var_290_5 <= 0 and var_290_1 or var_290_1 * (var_290_6 / var_290_5)

				if var_290_7 > 0 and var_290_1 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292069", "story_v_out_116292.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_116292", "116292069", "story_v_out_116292.awb") / 1000

					if var_290_8 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_0
					end

					if var_290_3.prefab_name ~= "" and arg_287_1.actors_[var_290_3.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_3.prefab_name].transform, "story_v_out_116292", "116292069", "story_v_out_116292.awb")

						arg_287_1:RecordAudio("116292069", var_290_9)
						arg_287_1:RecordAudio("116292069", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_116292", "116292069", "story_v_out_116292.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_116292", "116292069", "story_v_out_116292.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_10 and arg_287_1.time_ < var_290_0 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play116292070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 116292070
		arg_291_1.duration_ = 4.57

		local var_291_0 = {
			zh = 4.5,
			ja = 4.566
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
				arg_291_0:Play116292071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1184ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos1184ui_story = var_294_0.localPosition

				local var_294_2 = "1184ui_story"

				arg_291_1:ShowWeapon(arg_291_1.var_[var_294_2 .. "Animator"].transform, false)
			end

			local var_294_3 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_3 then
				local var_294_4 = (arg_291_1.time_ - var_294_1) / var_294_3
				local var_294_5 = Vector3.New(0, -0.97, -6)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1184ui_story, var_294_5, var_294_4)

				local var_294_6 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_6.x, var_294_6.y, var_294_6.z)

				local var_294_7 = var_294_0.localEulerAngles

				var_294_7.z = 0
				var_294_7.x = 0
				var_294_0.localEulerAngles = var_294_7
			end

			if arg_291_1.time_ >= var_294_1 + var_294_3 and arg_291_1.time_ < var_294_1 + var_294_3 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_294_8 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_8.x, var_294_8.y, var_294_8.z)

				local var_294_9 = var_294_0.localEulerAngles

				var_294_9.z = 0
				var_294_9.x = 0
				var_294_0.localEulerAngles = var_294_9
			end

			local var_294_10 = "1028ui_story"

			if arg_291_1.actors_[var_294_10] == nil then
				local var_294_11 = Asset.Load("Char/" .. "1028ui_story")

				if not isNil(var_294_11) then
					local var_294_12 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_291_1.stage_.transform)

					var_294_12.name = var_294_10
					var_294_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_291_1.actors_[var_294_10] = var_294_12

					local var_294_13 = var_294_12:GetComponentInChildren(typeof(CharacterEffect))

					var_294_13.enabled = true

					local var_294_14 = GameObjectTools.GetOrAddComponent(var_294_12, typeof(DynamicBoneHelper))

					if var_294_14 then
						var_294_14:EnableDynamicBone(false)
					end

					arg_291_1:ShowWeapon(var_294_13.transform, false)

					arg_291_1.var_[var_294_10 .. "Animator"] = var_294_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_291_1.var_[var_294_10 .. "Animator"].applyRootMotion = true
					arg_291_1.var_[var_294_10 .. "LipSync"] = var_294_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_294_15 = arg_291_1.actors_["1028ui_story"]
			local var_294_16 = 0

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 and not isNil(var_294_15) and arg_291_1.var_.characterEffect1028ui_story == nil then
				arg_291_1.var_.characterEffect1028ui_story = var_294_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_17 = 0.2

			if var_294_16 <= arg_291_1.time_ and arg_291_1.time_ < var_294_16 + var_294_17 and not isNil(var_294_15) then
				local var_294_18 = (arg_291_1.time_ - var_294_16) / var_294_17

				if arg_291_1.var_.characterEffect1028ui_story and not isNil(var_294_15) then
					local var_294_19 = Mathf.Lerp(0, 0.5, var_294_18)

					arg_291_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1028ui_story.fillRatio = var_294_19
				end
			end

			if arg_291_1.time_ >= var_294_16 + var_294_17 and arg_291_1.time_ < var_294_16 + var_294_17 + arg_294_0 and not isNil(var_294_15) and arg_291_1.var_.characterEffect1028ui_story then
				local var_294_20 = 0.5

				arg_291_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1028ui_story.fillRatio = var_294_20
			end

			local var_294_21 = arg_291_1.actors_["1184ui_story"]
			local var_294_22 = 0

			if var_294_22 < arg_291_1.time_ and arg_291_1.time_ <= var_294_22 + arg_294_0 and not isNil(var_294_21) and arg_291_1.var_.characterEffect1184ui_story == nil then
				arg_291_1.var_.characterEffect1184ui_story = var_294_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_23 = 0.2

			if var_294_22 <= arg_291_1.time_ and arg_291_1.time_ < var_294_22 + var_294_23 and not isNil(var_294_21) then
				local var_294_24 = (arg_291_1.time_ - var_294_22) / var_294_23

				if arg_291_1.var_.characterEffect1184ui_story and not isNil(var_294_21) then
					arg_291_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_22 + var_294_23 and arg_291_1.time_ < var_294_22 + var_294_23 + arg_294_0 and not isNil(var_294_21) and arg_291_1.var_.characterEffect1184ui_story then
				arg_291_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_294_25 = 0

			if var_294_25 < arg_291_1.time_ and arg_291_1.time_ <= var_294_25 + arg_294_0 then
				arg_291_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_294_26 = 0

			if var_294_26 < arg_291_1.time_ and arg_291_1.time_ <= var_294_26 + arg_294_0 then
				arg_291_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_294_27 = 0
			local var_294_28 = 0.3

			if var_294_27 < arg_291_1.time_ and arg_291_1.time_ <= var_294_27 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_29 = arg_291_1:FormatText(StoryNameCfg[6].name)

				arg_291_1.leftNameTxt_.text = var_294_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_30 = arg_291_1:GetWordFromCfg(116292070)
				local var_294_31 = arg_291_1:FormatText(var_294_30.content)

				arg_291_1.text_.text = var_294_31

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_32 = 12
				local var_294_33 = utf8.len(var_294_31)
				local var_294_34 = var_294_32 <= 0 and var_294_28 or var_294_28 * (var_294_33 / var_294_32)

				if var_294_34 > 0 and var_294_28 < var_294_34 then
					arg_291_1.talkMaxDuration = var_294_34

					if var_294_34 + var_294_27 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_34 + var_294_27
					end
				end

				arg_291_1.text_.text = var_294_31
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292070", "story_v_out_116292.awb") ~= 0 then
					local var_294_35 = manager.audio:GetVoiceLength("story_v_out_116292", "116292070", "story_v_out_116292.awb") / 1000

					if var_294_35 + var_294_27 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_35 + var_294_27
					end

					if var_294_30.prefab_name ~= "" and arg_291_1.actors_[var_294_30.prefab_name] ~= nil then
						local var_294_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_30.prefab_name].transform, "story_v_out_116292", "116292070", "story_v_out_116292.awb")

						arg_291_1:RecordAudio("116292070", var_294_36)
						arg_291_1:RecordAudio("116292070", var_294_36)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_116292", "116292070", "story_v_out_116292.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_116292", "116292070", "story_v_out_116292.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_37 = math.max(var_294_28, arg_291_1.talkMaxDuration)

			if var_294_27 <= arg_291_1.time_ and arg_291_1.time_ < var_294_27 + var_294_37 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_27) / var_294_37

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_27 + var_294_37 and arg_291_1.time_ < var_294_27 + var_294_37 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play116292071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 116292071
		arg_295_1.duration_ = 13.57

		local var_295_0 = {
			zh = 8.133,
			ja = 13.566
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
				arg_295_0:Play116292072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1028ui_story"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect1028ui_story == nil then
				arg_295_1.var_.characterEffect1028ui_story = var_298_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.characterEffect1028ui_story and not isNil(var_298_0) then
					arg_295_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect1028ui_story then
				arg_295_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_298_4 = arg_295_1.actors_["1184ui_story"]
			local var_298_5 = 0

			if var_298_5 < arg_295_1.time_ and arg_295_1.time_ <= var_298_5 + arg_298_0 and not isNil(var_298_4) and arg_295_1.var_.characterEffect1184ui_story == nil then
				arg_295_1.var_.characterEffect1184ui_story = var_298_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_6 = 0.2

			if var_298_5 <= arg_295_1.time_ and arg_295_1.time_ < var_298_5 + var_298_6 and not isNil(var_298_4) then
				local var_298_7 = (arg_295_1.time_ - var_298_5) / var_298_6

				if arg_295_1.var_.characterEffect1184ui_story and not isNil(var_298_4) then
					local var_298_8 = Mathf.Lerp(0, 0.5, var_298_7)

					arg_295_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1184ui_story.fillRatio = var_298_8
				end
			end

			if arg_295_1.time_ >= var_298_5 + var_298_6 and arg_295_1.time_ < var_298_5 + var_298_6 + arg_298_0 and not isNil(var_298_4) and arg_295_1.var_.characterEffect1184ui_story then
				local var_298_9 = 0.5

				arg_295_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1184ui_story.fillRatio = var_298_9
			end

			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 then
				arg_295_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_298_11 = 0
			local var_298_12 = 0.925

			if var_298_11 < arg_295_1.time_ and arg_295_1.time_ <= var_298_11 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_13 = arg_295_1:FormatText(StoryNameCfg[327].name)

				arg_295_1.leftNameTxt_.text = var_298_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_14 = arg_295_1:GetWordFromCfg(116292071)
				local var_298_15 = arg_295_1:FormatText(var_298_14.content)

				arg_295_1.text_.text = var_298_15

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_16 = 37
				local var_298_17 = utf8.len(var_298_15)
				local var_298_18 = var_298_16 <= 0 and var_298_12 or var_298_12 * (var_298_17 / var_298_16)

				if var_298_18 > 0 and var_298_12 < var_298_18 then
					arg_295_1.talkMaxDuration = var_298_18

					if var_298_18 + var_298_11 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_18 + var_298_11
					end
				end

				arg_295_1.text_.text = var_298_15
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292071", "story_v_out_116292.awb") ~= 0 then
					local var_298_19 = manager.audio:GetVoiceLength("story_v_out_116292", "116292071", "story_v_out_116292.awb") / 1000

					if var_298_19 + var_298_11 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_19 + var_298_11
					end

					if var_298_14.prefab_name ~= "" and arg_295_1.actors_[var_298_14.prefab_name] ~= nil then
						local var_298_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_14.prefab_name].transform, "story_v_out_116292", "116292071", "story_v_out_116292.awb")

						arg_295_1:RecordAudio("116292071", var_298_20)
						arg_295_1:RecordAudio("116292071", var_298_20)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_116292", "116292071", "story_v_out_116292.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_116292", "116292071", "story_v_out_116292.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_21 = math.max(var_298_12, arg_295_1.talkMaxDuration)

			if var_298_11 <= arg_295_1.time_ and arg_295_1.time_ < var_298_11 + var_298_21 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_11) / var_298_21

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_11 + var_298_21 and arg_295_1.time_ < var_298_11 + var_298_21 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play116292072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 116292072
		arg_299_1.duration_ = 7.07

		local var_299_0 = {
			zh = 4.1,
			ja = 7.066
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play116292073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1059ui_story"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos1059ui_story = var_302_0.localPosition
			end

			local var_302_2 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2
				local var_302_4 = Vector3.New(-0.7, -1.05, -6)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1059ui_story, var_302_4, var_302_3)

				local var_302_5 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_5.x, var_302_5.y, var_302_5.z)

				local var_302_6 = var_302_0.localEulerAngles

				var_302_6.z = 0
				var_302_6.x = 0
				var_302_0.localEulerAngles = var_302_6
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_302_7 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_7.x, var_302_7.y, var_302_7.z)

				local var_302_8 = var_302_0.localEulerAngles

				var_302_8.z = 0
				var_302_8.x = 0
				var_302_0.localEulerAngles = var_302_8
			end

			local var_302_9 = arg_299_1.actors_["1028ui_story"].transform
			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 then
				arg_299_1.var_.moveOldPos1028ui_story = var_302_9.localPosition
			end

			local var_302_11 = 0.001

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_11 then
				local var_302_12 = (arg_299_1.time_ - var_302_10) / var_302_11
				local var_302_13 = Vector3.New(0, 100, 0)

				var_302_9.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1028ui_story, var_302_13, var_302_12)

				local var_302_14 = manager.ui.mainCamera.transform.position - var_302_9.position

				var_302_9.forward = Vector3.New(var_302_14.x, var_302_14.y, var_302_14.z)

				local var_302_15 = var_302_9.localEulerAngles

				var_302_15.z = 0
				var_302_15.x = 0
				var_302_9.localEulerAngles = var_302_15
			end

			if arg_299_1.time_ >= var_302_10 + var_302_11 and arg_299_1.time_ < var_302_10 + var_302_11 + arg_302_0 then
				var_302_9.localPosition = Vector3.New(0, 100, 0)

				local var_302_16 = manager.ui.mainCamera.transform.position - var_302_9.position

				var_302_9.forward = Vector3.New(var_302_16.x, var_302_16.y, var_302_16.z)

				local var_302_17 = var_302_9.localEulerAngles

				var_302_17.z = 0
				var_302_17.x = 0
				var_302_9.localEulerAngles = var_302_17
			end

			local var_302_18 = arg_299_1.actors_["1184ui_story"].transform
			local var_302_19 = 0

			if var_302_19 < arg_299_1.time_ and arg_299_1.time_ <= var_302_19 + arg_302_0 then
				arg_299_1.var_.moveOldPos1184ui_story = var_302_18.localPosition
			end

			local var_302_20 = 0.001

			if var_302_19 <= arg_299_1.time_ and arg_299_1.time_ < var_302_19 + var_302_20 then
				local var_302_21 = (arg_299_1.time_ - var_302_19) / var_302_20
				local var_302_22 = Vector3.New(0, 100, 0)

				var_302_18.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1184ui_story, var_302_22, var_302_21)

				local var_302_23 = manager.ui.mainCamera.transform.position - var_302_18.position

				var_302_18.forward = Vector3.New(var_302_23.x, var_302_23.y, var_302_23.z)

				local var_302_24 = var_302_18.localEulerAngles

				var_302_24.z = 0
				var_302_24.x = 0
				var_302_18.localEulerAngles = var_302_24
			end

			if arg_299_1.time_ >= var_302_19 + var_302_20 and arg_299_1.time_ < var_302_19 + var_302_20 + arg_302_0 then
				var_302_18.localPosition = Vector3.New(0, 100, 0)

				local var_302_25 = manager.ui.mainCamera.transform.position - var_302_18.position

				var_302_18.forward = Vector3.New(var_302_25.x, var_302_25.y, var_302_25.z)

				local var_302_26 = var_302_18.localEulerAngles

				var_302_26.z = 0
				var_302_26.x = 0
				var_302_18.localEulerAngles = var_302_26
			end

			local var_302_27 = arg_299_1.actors_["1059ui_story"]
			local var_302_28 = 0

			if var_302_28 < arg_299_1.time_ and arg_299_1.time_ <= var_302_28 + arg_302_0 and not isNil(var_302_27) and arg_299_1.var_.characterEffect1059ui_story == nil then
				arg_299_1.var_.characterEffect1059ui_story = var_302_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_29 = 0.2

			if var_302_28 <= arg_299_1.time_ and arg_299_1.time_ < var_302_28 + var_302_29 and not isNil(var_302_27) then
				local var_302_30 = (arg_299_1.time_ - var_302_28) / var_302_29

				if arg_299_1.var_.characterEffect1059ui_story and not isNil(var_302_27) then
					arg_299_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_28 + var_302_29 and arg_299_1.time_ < var_302_28 + var_302_29 + arg_302_0 and not isNil(var_302_27) and arg_299_1.var_.characterEffect1059ui_story then
				arg_299_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_302_31 = 0

			if var_302_31 < arg_299_1.time_ and arg_299_1.time_ <= var_302_31 + arg_302_0 then
				arg_299_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_302_32 = 0

			if var_302_32 < arg_299_1.time_ and arg_299_1.time_ <= var_302_32 + arg_302_0 then
				arg_299_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_302_33 = 0
			local var_302_34 = 0.475

			if var_302_33 < arg_299_1.time_ and arg_299_1.time_ <= var_302_33 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_35 = arg_299_1:FormatText(StoryNameCfg[28].name)

				arg_299_1.leftNameTxt_.text = var_302_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_36 = arg_299_1:GetWordFromCfg(116292072)
				local var_302_37 = arg_299_1:FormatText(var_302_36.content)

				arg_299_1.text_.text = var_302_37

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_38 = 19
				local var_302_39 = utf8.len(var_302_37)
				local var_302_40 = var_302_38 <= 0 and var_302_34 or var_302_34 * (var_302_39 / var_302_38)

				if var_302_40 > 0 and var_302_34 < var_302_40 then
					arg_299_1.talkMaxDuration = var_302_40

					if var_302_40 + var_302_33 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_40 + var_302_33
					end
				end

				arg_299_1.text_.text = var_302_37
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292072", "story_v_out_116292.awb") ~= 0 then
					local var_302_41 = manager.audio:GetVoiceLength("story_v_out_116292", "116292072", "story_v_out_116292.awb") / 1000

					if var_302_41 + var_302_33 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_41 + var_302_33
					end

					if var_302_36.prefab_name ~= "" and arg_299_1.actors_[var_302_36.prefab_name] ~= nil then
						local var_302_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_36.prefab_name].transform, "story_v_out_116292", "116292072", "story_v_out_116292.awb")

						arg_299_1:RecordAudio("116292072", var_302_42)
						arg_299_1:RecordAudio("116292072", var_302_42)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_116292", "116292072", "story_v_out_116292.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_116292", "116292072", "story_v_out_116292.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_43 = math.max(var_302_34, arg_299_1.talkMaxDuration)

			if var_302_33 <= arg_299_1.time_ and arg_299_1.time_ < var_302_33 + var_302_43 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_33) / var_302_43

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_33 + var_302_43 and arg_299_1.time_ < var_302_33 + var_302_43 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
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

		arg_299_1:InitPlayNodeList()
	end,
	Play116292073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 116292073
		arg_303_1.duration_ = 3.93

		local var_303_0 = {
			zh = 3.733,
			ja = 3.933
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
			arg_303_1.auto_ = false
		end

		function arg_303_1.playNext_(arg_305_0)
			arg_303_1.onStoryFinished_()
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1059ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1059ui_story == nil then
				arg_303_1.var_.characterEffect1059ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1059ui_story and not isNil(var_306_0) then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1059ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1059ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1059ui_story.fillRatio = var_306_5
			end

			local var_306_6 = arg_303_1.actors_["1148ui_story"]
			local var_306_7 = 0

			if var_306_7 < arg_303_1.time_ and arg_303_1.time_ <= var_306_7 + arg_306_0 and not isNil(var_306_6) and arg_303_1.var_.characterEffect1148ui_story == nil then
				arg_303_1.var_.characterEffect1148ui_story = var_306_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_8 = 0.2

			if var_306_7 <= arg_303_1.time_ and arg_303_1.time_ < var_306_7 + var_306_8 and not isNil(var_306_6) then
				local var_306_9 = (arg_303_1.time_ - var_306_7) / var_306_8

				if arg_303_1.var_.characterEffect1148ui_story and not isNil(var_306_6) then
					arg_303_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_7 + var_306_8 and arg_303_1.time_ < var_306_7 + var_306_8 + arg_306_0 and not isNil(var_306_6) and arg_303_1.var_.characterEffect1148ui_story then
				arg_303_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 then
				arg_303_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_1")
			end

			local var_306_11 = 0

			if var_306_11 < arg_303_1.time_ and arg_303_1.time_ <= var_306_11 + arg_306_0 then
				arg_303_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_306_12 = arg_303_1.actors_["1148ui_story"].transform
			local var_306_13 = 0

			if var_306_13 < arg_303_1.time_ and arg_303_1.time_ <= var_306_13 + arg_306_0 then
				arg_303_1.var_.moveOldPos1148ui_story = var_306_12.localPosition
			end

			local var_306_14 = 0.001

			if var_306_13 <= arg_303_1.time_ and arg_303_1.time_ < var_306_13 + var_306_14 then
				local var_306_15 = (arg_303_1.time_ - var_306_13) / var_306_14
				local var_306_16 = Vector3.New(0.7, -0.8, -6.2)

				var_306_12.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1148ui_story, var_306_16, var_306_15)

				local var_306_17 = manager.ui.mainCamera.transform.position - var_306_12.position

				var_306_12.forward = Vector3.New(var_306_17.x, var_306_17.y, var_306_17.z)

				local var_306_18 = var_306_12.localEulerAngles

				var_306_18.z = 0
				var_306_18.x = 0
				var_306_12.localEulerAngles = var_306_18
			end

			if arg_303_1.time_ >= var_306_13 + var_306_14 and arg_303_1.time_ < var_306_13 + var_306_14 + arg_306_0 then
				var_306_12.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_306_19 = manager.ui.mainCamera.transform.position - var_306_12.position

				var_306_12.forward = Vector3.New(var_306_19.x, var_306_19.y, var_306_19.z)

				local var_306_20 = var_306_12.localEulerAngles

				var_306_20.z = 0
				var_306_20.x = 0
				var_306_12.localEulerAngles = var_306_20
			end

			local var_306_21 = 0
			local var_306_22 = 0.575

			if var_306_21 < arg_303_1.time_ and arg_303_1.time_ <= var_306_21 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_23 = arg_303_1:FormatText(StoryNameCfg[8].name)

				arg_303_1.leftNameTxt_.text = var_306_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_24 = arg_303_1:GetWordFromCfg(116292073)
				local var_306_25 = arg_303_1:FormatText(var_306_24.content)

				arg_303_1.text_.text = var_306_25

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_26 = 23
				local var_306_27 = utf8.len(var_306_25)
				local var_306_28 = var_306_26 <= 0 and var_306_22 or var_306_22 * (var_306_27 / var_306_26)

				if var_306_28 > 0 and var_306_22 < var_306_28 then
					arg_303_1.talkMaxDuration = var_306_28

					if var_306_28 + var_306_21 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_28 + var_306_21
					end
				end

				arg_303_1.text_.text = var_306_25
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116292", "116292073", "story_v_out_116292.awb") ~= 0 then
					local var_306_29 = manager.audio:GetVoiceLength("story_v_out_116292", "116292073", "story_v_out_116292.awb") / 1000

					if var_306_29 + var_306_21 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_29 + var_306_21
					end

					if var_306_24.prefab_name ~= "" and arg_303_1.actors_[var_306_24.prefab_name] ~= nil then
						local var_306_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_24.prefab_name].transform, "story_v_out_116292", "116292073", "story_v_out_116292.awb")

						arg_303_1:RecordAudio("116292073", var_306_30)
						arg_303_1:RecordAudio("116292073", var_306_30)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_116292", "116292073", "story_v_out_116292.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_116292", "116292073", "story_v_out_116292.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_31 = math.max(var_306_22, arg_303_1.talkMaxDuration)

			if var_306_21 <= arg_303_1.time_ and arg_303_1.time_ < var_306_21 + var_306_31 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_21) / var_306_31

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_21 + var_306_31 and arg_303_1.time_ < var_306_21 + var_306_31 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13c",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SK0204",
		"TextureConfig/Background/SK0204a"
	},
	voices = {
		"story_v_out_116292.awb"
	}
}
