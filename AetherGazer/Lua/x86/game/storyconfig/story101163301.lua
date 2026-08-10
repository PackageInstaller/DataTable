return {
	Play116331001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116331001
		arg_1_1.duration_ = 5.77

		local var_1_0 = {
			zh = 4.6,
			ja = 5.766
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
				arg_1_0:Play116331002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I07a"

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
				local var_4_5 = arg_1_1.bgs_.I07a

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
					if iter_4_0 ~= "I07a" then
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
			local var_4_23 = 0.266666666666667

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

			local var_4_28 = 0.4
			local var_4_29 = 0.6

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_4_32 = ""

				if var_4_32 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_32 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_32

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_32
						arg_1_1.bgmTxt2_.text = var_4_32
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

			local var_4_33 = 0.575
			local var_4_34 = 0.425

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "bgm_activity_1_6_story_story", "corg", "bgm_activity_1_6_story_story.awb")

				local var_4_37 = ""
				local var_4_38 = MusicRecordCfg[96].musicName

				if var_4_38 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
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

			local var_4_39 = 2
			local var_4_40 = 0.3

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_41 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_41:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_42 = arg_1_1:FormatText(StoryNameCfg[337].name)

				arg_1_1.leftNameTxt_.text = var_4_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_43 = arg_1_1:GetWordFromCfg(116331001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 12
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_40 or var_4_40 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_40 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_39 = var_4_39 + 0.3

					if var_4_47 + var_4_39 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_39
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331001", "story_v_out_116331.awb") ~= 0 then
					local var_4_48 = manager.audio:GetVoiceLength("story_v_out_116331", "116331001", "story_v_out_116331.awb") / 1000

					if var_4_48 + var_4_39 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_48 + var_4_39
					end

					if var_4_43.prefab_name ~= "" and arg_1_1.actors_[var_4_43.prefab_name] ~= nil then
						local var_4_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_43.prefab_name].transform, "story_v_out_116331", "116331001", "story_v_out_116331.awb")

						arg_1_1:RecordAudio("116331001", var_4_49)
						arg_1_1:RecordAudio("116331001", var_4_49)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116331", "116331001", "story_v_out_116331.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116331", "116331001", "story_v_out_116331.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_50 = var_4_39 + 0.3
			local var_4_51 = math.max(var_4_40, arg_1_1.talkMaxDuration)

			if var_4_50 <= arg_1_1.time_ and arg_1_1.time_ < var_4_50 + var_4_51 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_50) / var_4_51

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_50 + var_4_51 and arg_1_1.time_ < var_4_50 + var_4_51 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116331002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116331002
		arg_10_1.duration_ = 13.77

		local var_10_0 = {
			zh = 11.8,
			ja = 13.766
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116331003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "10032ui_story"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Char/" .. "10032ui_story")

				if not isNil(var_13_1) then
					local var_13_2 = Object.Instantiate(Asset.Load("Char/" .. "10032ui_story"), arg_10_1.stage_.transform)

					var_13_2.name = var_13_0
					var_13_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_10_1.actors_[var_13_0] = var_13_2

					local var_13_3 = var_13_2:GetComponentInChildren(typeof(CharacterEffect))

					var_13_3.enabled = true

					local var_13_4 = GameObjectTools.GetOrAddComponent(var_13_2, typeof(DynamicBoneHelper))

					if var_13_4 then
						var_13_4:EnableDynamicBone(false)
					end

					arg_10_1:ShowWeapon(var_13_3.transform, false)

					arg_10_1.var_[var_13_0 .. "Animator"] = var_13_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_10_1.var_[var_13_0 .. "Animator"].applyRootMotion = true
					arg_10_1.var_[var_13_0 .. "LipSync"] = var_13_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_13_5 = arg_10_1.actors_["10032ui_story"].transform
			local var_13_6 = 0

			if var_13_6 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1.var_.moveOldPos10032ui_story = var_13_5.localPosition
			end

			local var_13_7 = 0.001

			if var_13_6 <= arg_10_1.time_ and arg_10_1.time_ < var_13_6 + var_13_7 then
				local var_13_8 = (arg_10_1.time_ - var_13_6) / var_13_7
				local var_13_9 = Vector3.New(0, -1.1, -5.9)

				var_13_5.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10032ui_story, var_13_9, var_13_8)

				local var_13_10 = manager.ui.mainCamera.transform.position - var_13_5.position

				var_13_5.forward = Vector3.New(var_13_10.x, var_13_10.y, var_13_10.z)

				local var_13_11 = var_13_5.localEulerAngles

				var_13_11.z = 0
				var_13_11.x = 0
				var_13_5.localEulerAngles = var_13_11
			end

			if arg_10_1.time_ >= var_13_6 + var_13_7 and arg_10_1.time_ < var_13_6 + var_13_7 + arg_13_0 then
				var_13_5.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_13_12 = manager.ui.mainCamera.transform.position - var_13_5.position

				var_13_5.forward = Vector3.New(var_13_12.x, var_13_12.y, var_13_12.z)

				local var_13_13 = var_13_5.localEulerAngles

				var_13_13.z = 0
				var_13_13.x = 0
				var_13_5.localEulerAngles = var_13_13
			end

			local var_13_14 = 0

			if var_13_14 < arg_10_1.time_ and arg_10_1.time_ <= var_13_14 + arg_13_0 then
				arg_10_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_13_15 = 0

			if var_13_15 < arg_10_1.time_ and arg_10_1.time_ <= var_13_15 + arg_13_0 then
				arg_10_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_13_16 = arg_10_1.actors_["10032ui_story"]
			local var_13_17 = 0

			if var_13_17 < arg_10_1.time_ and arg_10_1.time_ <= var_13_17 + arg_13_0 and not isNil(var_13_16) and arg_10_1.var_.characterEffect10032ui_story == nil then
				arg_10_1.var_.characterEffect10032ui_story = var_13_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_18 = 0.2

			if var_13_17 <= arg_10_1.time_ and arg_10_1.time_ < var_13_17 + var_13_18 and not isNil(var_13_16) then
				local var_13_19 = (arg_10_1.time_ - var_13_17) / var_13_18

				if arg_10_1.var_.characterEffect10032ui_story and not isNil(var_13_16) then
					arg_10_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= var_13_17 + var_13_18 and arg_10_1.time_ < var_13_17 + var_13_18 + arg_13_0 and not isNil(var_13_16) and arg_10_1.var_.characterEffect10032ui_story then
				arg_10_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_13_20 = 0
			local var_13_21 = 0.975

			if var_13_20 < arg_10_1.time_ and arg_10_1.time_ <= var_13_20 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_22 = arg_10_1:FormatText(StoryNameCfg[328].name)

				arg_10_1.leftNameTxt_.text = var_13_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_23 = arg_10_1:GetWordFromCfg(116331002)
				local var_13_24 = arg_10_1:FormatText(var_13_23.content)

				arg_10_1.text_.text = var_13_24

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_25 = 39
				local var_13_26 = utf8.len(var_13_24)
				local var_13_27 = var_13_25 <= 0 and var_13_21 or var_13_21 * (var_13_26 / var_13_25)

				if var_13_27 > 0 and var_13_21 < var_13_27 then
					arg_10_1.talkMaxDuration = var_13_27

					if var_13_27 + var_13_20 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_27 + var_13_20
					end
				end

				arg_10_1.text_.text = var_13_24
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331002", "story_v_out_116331.awb") ~= 0 then
					local var_13_28 = manager.audio:GetVoiceLength("story_v_out_116331", "116331002", "story_v_out_116331.awb") / 1000

					if var_13_28 + var_13_20 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_28 + var_13_20
					end

					if var_13_23.prefab_name ~= "" and arg_10_1.actors_[var_13_23.prefab_name] ~= nil then
						local var_13_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_23.prefab_name].transform, "story_v_out_116331", "116331002", "story_v_out_116331.awb")

						arg_10_1:RecordAudio("116331002", var_13_29)
						arg_10_1:RecordAudio("116331002", var_13_29)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_116331", "116331002", "story_v_out_116331.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_116331", "116331002", "story_v_out_116331.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_30 = math.max(var_13_21, arg_10_1.talkMaxDuration)

			if var_13_20 <= arg_10_1.time_ and arg_10_1.time_ < var_13_20 + var_13_30 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_20) / var_13_30

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_20 + var_13_30 and arg_10_1.time_ < var_13_20 + var_13_30 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play116331003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116331003
		arg_14_1.duration_ = 1.9

		local var_14_0 = {
			zh = 1.9,
			ja = 1.433
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116331004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["10032ui_story"]
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.characterEffect10032ui_story == nil then
				arg_14_1.var_.characterEffect10032ui_story = var_17_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_2 = 0.2

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 and not isNil(var_17_0) then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2

				if arg_14_1.var_.characterEffect10032ui_story and not isNil(var_17_0) then
					local var_17_4 = Mathf.Lerp(0, 0.5, var_17_3)

					arg_14_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_14_1.var_.characterEffect10032ui_story.fillRatio = var_17_4
				end
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.characterEffect10032ui_story then
				local var_17_5 = 0.5

				arg_14_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_14_1.var_.characterEffect10032ui_story.fillRatio = var_17_5
			end

			local var_17_6 = 0
			local var_17_7 = 0.25

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_8 = arg_14_1:FormatText(StoryNameCfg[337].name)

				arg_14_1.leftNameTxt_.text = var_17_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_9 = arg_14_1:GetWordFromCfg(116331003)
				local var_17_10 = arg_14_1:FormatText(var_17_9.content)

				arg_14_1.text_.text = var_17_10

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_11 = 10
				local var_17_12 = utf8.len(var_17_10)
				local var_17_13 = var_17_11 <= 0 and var_17_7 or var_17_7 * (var_17_12 / var_17_11)

				if var_17_13 > 0 and var_17_7 < var_17_13 then
					arg_14_1.talkMaxDuration = var_17_13

					if var_17_13 + var_17_6 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_13 + var_17_6
					end
				end

				arg_14_1.text_.text = var_17_10
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331003", "story_v_out_116331.awb") ~= 0 then
					local var_17_14 = manager.audio:GetVoiceLength("story_v_out_116331", "116331003", "story_v_out_116331.awb") / 1000

					if var_17_14 + var_17_6 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_14 + var_17_6
					end

					if var_17_9.prefab_name ~= "" and arg_14_1.actors_[var_17_9.prefab_name] ~= nil then
						local var_17_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_9.prefab_name].transform, "story_v_out_116331", "116331003", "story_v_out_116331.awb")

						arg_14_1:RecordAudio("116331003", var_17_15)
						arg_14_1:RecordAudio("116331003", var_17_15)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_116331", "116331003", "story_v_out_116331.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_116331", "116331003", "story_v_out_116331.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_16 = math.max(var_17_7, arg_14_1.talkMaxDuration)

			if var_17_6 <= arg_14_1.time_ and arg_14_1.time_ < var_17_6 + var_17_16 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_6) / var_17_16

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_6 + var_17_16 and arg_14_1.time_ < var_17_6 + var_17_16 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play116331004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116331004
		arg_18_1.duration_ = 2.97

		local var_18_0 = {
			zh = 2.966,
			ja = 2.666
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play116331005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["10032ui_story"].transform
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.var_.moveOldPos10032ui_story = var_21_0.localPosition
			end

			local var_21_2 = 0.001

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2
				local var_21_4 = Vector3.New(0, -1.1, -5.9)

				var_21_0.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10032ui_story, var_21_4, var_21_3)

				local var_21_5 = manager.ui.mainCamera.transform.position - var_21_0.position

				var_21_0.forward = Vector3.New(var_21_5.x, var_21_5.y, var_21_5.z)

				local var_21_6 = var_21_0.localEulerAngles

				var_21_6.z = 0
				var_21_6.x = 0
				var_21_0.localEulerAngles = var_21_6
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 then
				var_21_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_21_7 = manager.ui.mainCamera.transform.position - var_21_0.position

				var_21_0.forward = Vector3.New(var_21_7.x, var_21_7.y, var_21_7.z)

				local var_21_8 = var_21_0.localEulerAngles

				var_21_8.z = 0
				var_21_8.x = 0
				var_21_0.localEulerAngles = var_21_8
			end

			local var_21_9 = 0

			if var_21_9 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 then
				arg_18_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_21_10 = 0

			if var_21_10 < arg_18_1.time_ and arg_18_1.time_ <= var_21_10 + arg_21_0 then
				arg_18_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_21_11 = arg_18_1.actors_["10032ui_story"]
			local var_21_12 = 0

			if var_21_12 < arg_18_1.time_ and arg_18_1.time_ <= var_21_12 + arg_21_0 and not isNil(var_21_11) and arg_18_1.var_.characterEffect10032ui_story == nil then
				arg_18_1.var_.characterEffect10032ui_story = var_21_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_13 = 0.2

			if var_21_12 <= arg_18_1.time_ and arg_18_1.time_ < var_21_12 + var_21_13 and not isNil(var_21_11) then
				local var_21_14 = (arg_18_1.time_ - var_21_12) / var_21_13

				if arg_18_1.var_.characterEffect10032ui_story and not isNil(var_21_11) then
					arg_18_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_12 + var_21_13 and arg_18_1.time_ < var_21_12 + var_21_13 + arg_21_0 and not isNil(var_21_11) and arg_18_1.var_.characterEffect10032ui_story then
				arg_18_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_21_15 = 0
			local var_21_16 = 0.2

			if var_21_15 < arg_18_1.time_ and arg_18_1.time_ <= var_21_15 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_17 = arg_18_1:FormatText(StoryNameCfg[328].name)

				arg_18_1.leftNameTxt_.text = var_21_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_18 = arg_18_1:GetWordFromCfg(116331004)
				local var_21_19 = arg_18_1:FormatText(var_21_18.content)

				arg_18_1.text_.text = var_21_19

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_20 = 8
				local var_21_21 = utf8.len(var_21_19)
				local var_21_22 = var_21_20 <= 0 and var_21_16 or var_21_16 * (var_21_21 / var_21_20)

				if var_21_22 > 0 and var_21_16 < var_21_22 then
					arg_18_1.talkMaxDuration = var_21_22

					if var_21_22 + var_21_15 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_22 + var_21_15
					end
				end

				arg_18_1.text_.text = var_21_19
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331004", "story_v_out_116331.awb") ~= 0 then
					local var_21_23 = manager.audio:GetVoiceLength("story_v_out_116331", "116331004", "story_v_out_116331.awb") / 1000

					if var_21_23 + var_21_15 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_23 + var_21_15
					end

					if var_21_18.prefab_name ~= "" and arg_18_1.actors_[var_21_18.prefab_name] ~= nil then
						local var_21_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_18.prefab_name].transform, "story_v_out_116331", "116331004", "story_v_out_116331.awb")

						arg_18_1:RecordAudio("116331004", var_21_24)
						arg_18_1:RecordAudio("116331004", var_21_24)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_116331", "116331004", "story_v_out_116331.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_116331", "116331004", "story_v_out_116331.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_25 = math.max(var_21_16, arg_18_1.talkMaxDuration)

			if var_21_15 <= arg_18_1.time_ and arg_18_1.time_ < var_21_15 + var_21_25 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_15) / var_21_25

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_15 + var_21_25 and arg_18_1.time_ < var_21_15 + var_21_25 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play116331005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116331005
		arg_22_1.duration_ = 8.7

		local var_22_0 = {
			zh = 5.333,
			ja = 8.7
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play116331006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["10032ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect10032ui_story == nil then
				arg_22_1.var_.characterEffect10032ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect10032ui_story and not isNil(var_25_0) then
					local var_25_4 = Mathf.Lerp(0, 0.5, var_25_3)

					arg_22_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_22_1.var_.characterEffect10032ui_story.fillRatio = var_25_4
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect10032ui_story then
				local var_25_5 = 0.5

				arg_22_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_22_1.var_.characterEffect10032ui_story.fillRatio = var_25_5
			end

			local var_25_6 = 0
			local var_25_7 = 0.725

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_8 = arg_22_1:FormatText(StoryNameCfg[337].name)

				arg_22_1.leftNameTxt_.text = var_25_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_9 = arg_22_1:GetWordFromCfg(116331005)
				local var_25_10 = arg_22_1:FormatText(var_25_9.content)

				arg_22_1.text_.text = var_25_10

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_11 = 29
				local var_25_12 = utf8.len(var_25_10)
				local var_25_13 = var_25_11 <= 0 and var_25_7 or var_25_7 * (var_25_12 / var_25_11)

				if var_25_13 > 0 and var_25_7 < var_25_13 then
					arg_22_1.talkMaxDuration = var_25_13

					if var_25_13 + var_25_6 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_13 + var_25_6
					end
				end

				arg_22_1.text_.text = var_25_10
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331005", "story_v_out_116331.awb") ~= 0 then
					local var_25_14 = manager.audio:GetVoiceLength("story_v_out_116331", "116331005", "story_v_out_116331.awb") / 1000

					if var_25_14 + var_25_6 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_14 + var_25_6
					end

					if var_25_9.prefab_name ~= "" and arg_22_1.actors_[var_25_9.prefab_name] ~= nil then
						local var_25_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_9.prefab_name].transform, "story_v_out_116331", "116331005", "story_v_out_116331.awb")

						arg_22_1:RecordAudio("116331005", var_25_15)
						arg_22_1:RecordAudio("116331005", var_25_15)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_116331", "116331005", "story_v_out_116331.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_116331", "116331005", "story_v_out_116331.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_16 = math.max(var_25_7, arg_22_1.talkMaxDuration)

			if var_25_6 <= arg_22_1.time_ and arg_22_1.time_ < var_25_6 + var_25_16 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_6) / var_25_16

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_6 + var_25_16 and arg_22_1.time_ < var_25_6 + var_25_16 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play116331006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116331006
		arg_26_1.duration_ = 11.6

		local var_26_0 = {
			zh = 11.6,
			ja = 7.066
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play116331007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 1.2

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[337].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_3 = arg_26_1:GetWordFromCfg(116331006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 48
				local var_29_6 = utf8.len(var_29_4)
				local var_29_7 = var_29_5 <= 0 and var_29_1 or var_29_1 * (var_29_6 / var_29_5)

				if var_29_7 > 0 and var_29_1 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331006", "story_v_out_116331.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331006", "story_v_out_116331.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_116331", "116331006", "story_v_out_116331.awb")

						arg_26_1:RecordAudio("116331006", var_29_9)
						arg_26_1:RecordAudio("116331006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_116331", "116331006", "story_v_out_116331.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_116331", "116331006", "story_v_out_116331.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_10 and arg_26_1.time_ < var_29_0 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play116331007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 116331007
		arg_30_1.duration_ = 7.63

		local var_30_0 = {
			zh = 7.633,
			ja = 6.7
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play116331008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10032ui_story"].transform
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.var_.moveOldPos10032ui_story = var_33_0.localPosition
			end

			local var_33_2 = 0.001

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2
				local var_33_4 = Vector3.New(0, -1.1, -5.9)

				var_33_0.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10032ui_story, var_33_4, var_33_3)

				local var_33_5 = manager.ui.mainCamera.transform.position - var_33_0.position

				var_33_0.forward = Vector3.New(var_33_5.x, var_33_5.y, var_33_5.z)

				local var_33_6 = var_33_0.localEulerAngles

				var_33_6.z = 0
				var_33_6.x = 0
				var_33_0.localEulerAngles = var_33_6
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 then
				var_33_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_33_7 = manager.ui.mainCamera.transform.position - var_33_0.position

				var_33_0.forward = Vector3.New(var_33_7.x, var_33_7.y, var_33_7.z)

				local var_33_8 = var_33_0.localEulerAngles

				var_33_8.z = 0
				var_33_8.x = 0
				var_33_0.localEulerAngles = var_33_8
			end

			local var_33_9 = 0

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 then
				arg_30_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_33_10 = 0

			if var_33_10 < arg_30_1.time_ and arg_30_1.time_ <= var_33_10 + arg_33_0 then
				arg_30_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_33_11 = arg_30_1.actors_["10032ui_story"]
			local var_33_12 = 0

			if var_33_12 < arg_30_1.time_ and arg_30_1.time_ <= var_33_12 + arg_33_0 and not isNil(var_33_11) and arg_30_1.var_.characterEffect10032ui_story == nil then
				arg_30_1.var_.characterEffect10032ui_story = var_33_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_13 = 0.2

			if var_33_12 <= arg_30_1.time_ and arg_30_1.time_ < var_33_12 + var_33_13 and not isNil(var_33_11) then
				local var_33_14 = (arg_30_1.time_ - var_33_12) / var_33_13

				if arg_30_1.var_.characterEffect10032ui_story and not isNil(var_33_11) then
					arg_30_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_12 + var_33_13 and arg_30_1.time_ < var_33_12 + var_33_13 + arg_33_0 and not isNil(var_33_11) and arg_30_1.var_.characterEffect10032ui_story then
				arg_30_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_33_15 = 0
			local var_33_16 = 0.65

			if var_33_15 < arg_30_1.time_ and arg_30_1.time_ <= var_33_15 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_17 = arg_30_1:FormatText(StoryNameCfg[328].name)

				arg_30_1.leftNameTxt_.text = var_33_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_18 = arg_30_1:GetWordFromCfg(116331007)
				local var_33_19 = arg_30_1:FormatText(var_33_18.content)

				arg_30_1.text_.text = var_33_19

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_20 = 26
				local var_33_21 = utf8.len(var_33_19)
				local var_33_22 = var_33_20 <= 0 and var_33_16 or var_33_16 * (var_33_21 / var_33_20)

				if var_33_22 > 0 and var_33_16 < var_33_22 then
					arg_30_1.talkMaxDuration = var_33_22

					if var_33_22 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_22 + var_33_15
					end
				end

				arg_30_1.text_.text = var_33_19
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331007", "story_v_out_116331.awb") ~= 0 then
					local var_33_23 = manager.audio:GetVoiceLength("story_v_out_116331", "116331007", "story_v_out_116331.awb") / 1000

					if var_33_23 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_23 + var_33_15
					end

					if var_33_18.prefab_name ~= "" and arg_30_1.actors_[var_33_18.prefab_name] ~= nil then
						local var_33_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_18.prefab_name].transform, "story_v_out_116331", "116331007", "story_v_out_116331.awb")

						arg_30_1:RecordAudio("116331007", var_33_24)
						arg_30_1:RecordAudio("116331007", var_33_24)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_116331", "116331007", "story_v_out_116331.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_116331", "116331007", "story_v_out_116331.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_25 = math.max(var_33_16, arg_30_1.talkMaxDuration)

			if var_33_15 <= arg_30_1.time_ and arg_30_1.time_ < var_33_15 + var_33_25 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_15) / var_33_25

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_15 + var_33_25 and arg_30_1.time_ < var_33_15 + var_33_25 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play116331008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 116331008
		arg_34_1.duration_ = 8.5

		local var_34_0 = {
			zh = 8.5,
			ja = 8.1
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play116331009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["10032ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect10032ui_story == nil then
				arg_34_1.var_.characterEffect10032ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect10032ui_story and not isNil(var_37_0) then
					local var_37_4 = Mathf.Lerp(0, 0.5, var_37_3)

					arg_34_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_34_1.var_.characterEffect10032ui_story.fillRatio = var_37_4
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect10032ui_story then
				local var_37_5 = 0.5

				arg_34_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_34_1.var_.characterEffect10032ui_story.fillRatio = var_37_5
			end

			local var_37_6 = 0
			local var_37_7 = 1.025

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_8 = arg_34_1:FormatText(StoryNameCfg[337].name)

				arg_34_1.leftNameTxt_.text = var_37_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_9 = arg_34_1:GetWordFromCfg(116331008)
				local var_37_10 = arg_34_1:FormatText(var_37_9.content)

				arg_34_1.text_.text = var_37_10

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 41
				local var_37_12 = utf8.len(var_37_10)
				local var_37_13 = var_37_11 <= 0 and var_37_7 or var_37_7 * (var_37_12 / var_37_11)

				if var_37_13 > 0 and var_37_7 < var_37_13 then
					arg_34_1.talkMaxDuration = var_37_13

					if var_37_13 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_6
					end
				end

				arg_34_1.text_.text = var_37_10
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331008", "story_v_out_116331.awb") ~= 0 then
					local var_37_14 = manager.audio:GetVoiceLength("story_v_out_116331", "116331008", "story_v_out_116331.awb") / 1000

					if var_37_14 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_14 + var_37_6
					end

					if var_37_9.prefab_name ~= "" and arg_34_1.actors_[var_37_9.prefab_name] ~= nil then
						local var_37_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_9.prefab_name].transform, "story_v_out_116331", "116331008", "story_v_out_116331.awb")

						arg_34_1:RecordAudio("116331008", var_37_15)
						arg_34_1:RecordAudio("116331008", var_37_15)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_116331", "116331008", "story_v_out_116331.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_116331", "116331008", "story_v_out_116331.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_16 = math.max(var_37_7, arg_34_1.talkMaxDuration)

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_16 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_6) / var_37_16

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_6 + var_37_16 and arg_34_1.time_ < var_37_6 + var_37_16 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play116331009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 116331009
		arg_38_1.duration_ = 3.33

		local var_38_0 = {
			zh = 3.333,
			ja = 2.866
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play116331010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10032ui_story"].transform
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.var_.moveOldPos10032ui_story = var_41_0.localPosition
			end

			local var_41_2 = 0.001

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2
				local var_41_4 = Vector3.New(0, -1.1, -5.9)

				var_41_0.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10032ui_story, var_41_4, var_41_3)

				local var_41_5 = manager.ui.mainCamera.transform.position - var_41_0.position

				var_41_0.forward = Vector3.New(var_41_5.x, var_41_5.y, var_41_5.z)

				local var_41_6 = var_41_0.localEulerAngles

				var_41_6.z = 0
				var_41_6.x = 0
				var_41_0.localEulerAngles = var_41_6
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 then
				var_41_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_41_7 = manager.ui.mainCamera.transform.position - var_41_0.position

				var_41_0.forward = Vector3.New(var_41_7.x, var_41_7.y, var_41_7.z)

				local var_41_8 = var_41_0.localEulerAngles

				var_41_8.z = 0
				var_41_8.x = 0
				var_41_0.localEulerAngles = var_41_8
			end

			local var_41_9 = 0

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 then
				arg_38_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_41_10 = 0

			if var_41_10 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 then
				arg_38_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_41_11 = arg_38_1.actors_["10032ui_story"]
			local var_41_12 = 0

			if var_41_12 < arg_38_1.time_ and arg_38_1.time_ <= var_41_12 + arg_41_0 and not isNil(var_41_11) and arg_38_1.var_.characterEffect10032ui_story == nil then
				arg_38_1.var_.characterEffect10032ui_story = var_41_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_13 = 0.2

			if var_41_12 <= arg_38_1.time_ and arg_38_1.time_ < var_41_12 + var_41_13 and not isNil(var_41_11) then
				local var_41_14 = (arg_38_1.time_ - var_41_12) / var_41_13

				if arg_38_1.var_.characterEffect10032ui_story and not isNil(var_41_11) then
					arg_38_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_12 + var_41_13 and arg_38_1.time_ < var_41_12 + var_41_13 + arg_41_0 and not isNil(var_41_11) and arg_38_1.var_.characterEffect10032ui_story then
				arg_38_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_41_15 = 0
			local var_41_16 = 0.175

			if var_41_15 < arg_38_1.time_ and arg_38_1.time_ <= var_41_15 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_17 = arg_38_1:FormatText(StoryNameCfg[328].name)

				arg_38_1.leftNameTxt_.text = var_41_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_18 = arg_38_1:GetWordFromCfg(116331009)
				local var_41_19 = arg_38_1:FormatText(var_41_18.content)

				arg_38_1.text_.text = var_41_19

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_20 = 7
				local var_41_21 = utf8.len(var_41_19)
				local var_41_22 = var_41_20 <= 0 and var_41_16 or var_41_16 * (var_41_21 / var_41_20)

				if var_41_22 > 0 and var_41_16 < var_41_22 then
					arg_38_1.talkMaxDuration = var_41_22

					if var_41_22 + var_41_15 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_22 + var_41_15
					end
				end

				arg_38_1.text_.text = var_41_19
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331009", "story_v_out_116331.awb") ~= 0 then
					local var_41_23 = manager.audio:GetVoiceLength("story_v_out_116331", "116331009", "story_v_out_116331.awb") / 1000

					if var_41_23 + var_41_15 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_23 + var_41_15
					end

					if var_41_18.prefab_name ~= "" and arg_38_1.actors_[var_41_18.prefab_name] ~= nil then
						local var_41_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_18.prefab_name].transform, "story_v_out_116331", "116331009", "story_v_out_116331.awb")

						arg_38_1:RecordAudio("116331009", var_41_24)
						arg_38_1:RecordAudio("116331009", var_41_24)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_116331", "116331009", "story_v_out_116331.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_116331", "116331009", "story_v_out_116331.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_25 = math.max(var_41_16, arg_38_1.talkMaxDuration)

			if var_41_15 <= arg_38_1.time_ and arg_38_1.time_ < var_41_15 + var_41_25 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_15) / var_41_25

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_15 + var_41_25 and arg_38_1.time_ < var_41_15 + var_41_25 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play116331010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116331010
		arg_42_1.duration_ = 14.53

		local var_42_0 = {
			zh = 6.3,
			ja = 14.533
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play116331011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["10032ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10032ui_story == nil then
				arg_42_1.var_.characterEffect10032ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect10032ui_story and not isNil(var_45_0) then
					local var_45_4 = Mathf.Lerp(0, 0.5, var_45_3)

					arg_42_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10032ui_story.fillRatio = var_45_4
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10032ui_story then
				local var_45_5 = 0.5

				arg_42_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10032ui_story.fillRatio = var_45_5
			end

			local var_45_6 = 0
			local var_45_7 = 0.725

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_8 = arg_42_1:FormatText(StoryNameCfg[337].name)

				arg_42_1.leftNameTxt_.text = var_45_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_9 = arg_42_1:GetWordFromCfg(116331010)
				local var_45_10 = arg_42_1:FormatText(var_45_9.content)

				arg_42_1.text_.text = var_45_10

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 29
				local var_45_12 = utf8.len(var_45_10)
				local var_45_13 = var_45_11 <= 0 and var_45_7 or var_45_7 * (var_45_12 / var_45_11)

				if var_45_13 > 0 and var_45_7 < var_45_13 then
					arg_42_1.talkMaxDuration = var_45_13

					if var_45_13 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_13 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_10
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331010", "story_v_out_116331.awb") ~= 0 then
					local var_45_14 = manager.audio:GetVoiceLength("story_v_out_116331", "116331010", "story_v_out_116331.awb") / 1000

					if var_45_14 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_6
					end

					if var_45_9.prefab_name ~= "" and arg_42_1.actors_[var_45_9.prefab_name] ~= nil then
						local var_45_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_9.prefab_name].transform, "story_v_out_116331", "116331010", "story_v_out_116331.awb")

						arg_42_1:RecordAudio("116331010", var_45_15)
						arg_42_1:RecordAudio("116331010", var_45_15)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_116331", "116331010", "story_v_out_116331.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_116331", "116331010", "story_v_out_116331.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_16 and arg_42_1.time_ < var_45_6 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116331011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 116331011
		arg_46_1.duration_ = 8.37

		local var_46_0 = {
			zh = 6.566,
			ja = 8.366
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play116331012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 0.775

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_2 = arg_46_1:FormatText(StoryNameCfg[337].name)

				arg_46_1.leftNameTxt_.text = var_49_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_3 = arg_46_1:GetWordFromCfg(116331011)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 31
				local var_49_6 = utf8.len(var_49_4)
				local var_49_7 = var_49_5 <= 0 and var_49_1 or var_49_1 * (var_49_6 / var_49_5)

				if var_49_7 > 0 and var_49_1 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331011", "story_v_out_116331.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331011", "story_v_out_116331.awb") / 1000

					if var_49_8 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_0
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_116331", "116331011", "story_v_out_116331.awb")

						arg_46_1:RecordAudio("116331011", var_49_9)
						arg_46_1:RecordAudio("116331011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_116331", "116331011", "story_v_out_116331.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_116331", "116331011", "story_v_out_116331.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_10 and arg_46_1.time_ < var_49_0 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play116331012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 116331012
		arg_50_1.duration_ = 9.7

		local var_50_0 = {
			zh = 9.7,
			ja = 8.266
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play116331013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = "I07"

			if arg_50_1.bgs_[var_53_0] == nil then
				local var_53_1 = Object.Instantiate(arg_50_1.paintGo_)

				var_53_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_53_0)
				var_53_1.name = var_53_0
				var_53_1.transform.parent = arg_50_1.stage_.transform
				var_53_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.bgs_[var_53_0] = var_53_1
			end

			local var_53_2 = 2

			if var_53_2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_2 + arg_53_0 then
				local var_53_3 = manager.ui.mainCamera.transform.localPosition
				local var_53_4 = Vector3.New(0, 0, 10) + Vector3.New(var_53_3.x, var_53_3.y, 0)
				local var_53_5 = arg_50_1.bgs_.I07

				var_53_5.transform.localPosition = var_53_4
				var_53_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_6 = var_53_5:GetComponent("SpriteRenderer")

				if var_53_6 and var_53_6.sprite then
					local var_53_7 = (var_53_5.transform.localPosition - var_53_3).z
					local var_53_8 = manager.ui.mainCameraCom_
					local var_53_9 = 2 * var_53_7 * Mathf.Tan(var_53_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_53_10 = var_53_9 * var_53_8.aspect
					local var_53_11 = var_53_6.sprite.bounds.size.x
					local var_53_12 = var_53_6.sprite.bounds.size.y
					local var_53_13 = var_53_10 / var_53_11
					local var_53_14 = var_53_9 / var_53_12
					local var_53_15 = var_53_14 < var_53_13 and var_53_13 or var_53_14

					var_53_5.transform.localScale = Vector3.New(var_53_15, var_53_15, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "I07" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_16 = 0

			if var_53_16 < arg_50_1.time_ and arg_50_1.time_ <= var_53_16 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_17 = 2

			if var_53_16 <= arg_50_1.time_ and arg_50_1.time_ < var_53_16 + var_53_17 then
				local var_53_18 = (arg_50_1.time_ - var_53_16) / var_53_17
				local var_53_19 = Color.New(0, 0, 0)

				var_53_19.a = Mathf.Lerp(0, 1, var_53_18)
				arg_50_1.mask_.color = var_53_19
			end

			if arg_50_1.time_ >= var_53_16 + var_53_17 and arg_50_1.time_ < var_53_16 + var_53_17 + arg_53_0 then
				local var_53_20 = Color.New(0, 0, 0)

				var_53_20.a = 1
				arg_50_1.mask_.color = var_53_20
			end

			local var_53_21 = 2

			if var_53_21 < arg_50_1.time_ and arg_50_1.time_ <= var_53_21 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_22 = 2

			if var_53_21 <= arg_50_1.time_ and arg_50_1.time_ < var_53_21 + var_53_22 then
				local var_53_23 = (arg_50_1.time_ - var_53_21) / var_53_22
				local var_53_24 = Color.New(0, 0, 0)

				var_53_24.a = Mathf.Lerp(1, 0, var_53_23)
				arg_50_1.mask_.color = var_53_24
			end

			if arg_50_1.time_ >= var_53_21 + var_53_22 and arg_50_1.time_ < var_53_21 + var_53_22 + arg_53_0 then
				local var_53_25 = Color.New(0, 0, 0)
				local var_53_26 = 0

				arg_50_1.mask_.enabled = false
				var_53_25.a = var_53_26
				arg_50_1.mask_.color = var_53_25
			end

			local var_53_27 = arg_50_1.actors_["10032ui_story"].transform
			local var_53_28 = 2

			if var_53_28 < arg_50_1.time_ and arg_50_1.time_ <= var_53_28 + arg_53_0 then
				arg_50_1.var_.moveOldPos10032ui_story = var_53_27.localPosition
			end

			local var_53_29 = 0.001

			if var_53_28 <= arg_50_1.time_ and arg_50_1.time_ < var_53_28 + var_53_29 then
				local var_53_30 = (arg_50_1.time_ - var_53_28) / var_53_29
				local var_53_31 = Vector3.New(0, 100, 0)

				var_53_27.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10032ui_story, var_53_31, var_53_30)

				local var_53_32 = manager.ui.mainCamera.transform.position - var_53_27.position

				var_53_27.forward = Vector3.New(var_53_32.x, var_53_32.y, var_53_32.z)

				local var_53_33 = var_53_27.localEulerAngles

				var_53_33.z = 0
				var_53_33.x = 0
				var_53_27.localEulerAngles = var_53_33
			end

			if arg_50_1.time_ >= var_53_28 + var_53_29 and arg_50_1.time_ < var_53_28 + var_53_29 + arg_53_0 then
				var_53_27.localPosition = Vector3.New(0, 100, 0)

				local var_53_34 = manager.ui.mainCamera.transform.position - var_53_27.position

				var_53_27.forward = Vector3.New(var_53_34.x, var_53_34.y, var_53_34.z)

				local var_53_35 = var_53_27.localEulerAngles

				var_53_35.z = 0
				var_53_35.x = 0
				var_53_27.localEulerAngles = var_53_35
			end

			local var_53_36 = 2
			local var_53_37 = 1

			if var_53_36 < arg_50_1.time_ and arg_50_1.time_ <= var_53_36 + arg_53_0 then
				local var_53_38 = "play"
				local var_53_39 = "music"

				arg_50_1:AudioAction(var_53_38, var_53_39, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_53_40 = ""
				local var_53_41 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_53_41 ~= "" then
					if arg_50_1.bgmTxt_.text ~= var_53_41 and arg_50_1.bgmTxt_.text ~= "" then
						if arg_50_1.bgmTxt2_.text ~= "" then
							arg_50_1.bgmTxt_.text = arg_50_1.bgmTxt2_.text
						end

						arg_50_1.bgmTxt2_.text = var_53_41

						arg_50_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_50_1.bgmTxt_.text = var_53_41
						arg_50_1.bgmTxt2_.text = var_53_41
					end

					if arg_50_1.bgmTimer then
						arg_50_1.bgmTimer:Stop()

						arg_50_1.bgmTimer = nil
					end

					if arg_50_1.settingData.show_music_name == 1 then
						arg_50_1.musicController:SetSelectedState("show")
						arg_50_1.musicAnimator_:Play("open", 0, 0)

						if arg_50_1.settingData.music_time ~= 0 then
							arg_50_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_50_1.settingData.music_time), function()
								if arg_50_1 == nil or isNil(arg_50_1.bgmTxt_) then
									return
								end

								arg_50_1.musicController:SetSelectedState("hide")
								arg_50_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_42 = 4
			local var_53_43 = 0.25

			if var_53_42 < arg_50_1.time_ and arg_50_1.time_ <= var_53_42 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_44 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_44:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_50_1.dialogCg_.alpha = arg_55_0
				end))
				var_53_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_45 = arg_50_1:FormatText(StoryNameCfg[332].name)

				arg_50_1.leftNameTxt_.text = var_53_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_46 = arg_50_1:GetWordFromCfg(116331012)
				local var_53_47 = arg_50_1:FormatText(var_53_46.content)

				arg_50_1.text_.text = var_53_47

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_48 = 10
				local var_53_49 = utf8.len(var_53_47)
				local var_53_50 = var_53_48 <= 0 and var_53_43 or var_53_43 * (var_53_49 / var_53_48)

				if var_53_50 > 0 and var_53_43 < var_53_50 then
					arg_50_1.talkMaxDuration = var_53_50
					var_53_42 = var_53_42 + 0.3

					if var_53_50 + var_53_42 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_50 + var_53_42
					end
				end

				arg_50_1.text_.text = var_53_47
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331012", "story_v_out_116331.awb") ~= 0 then
					local var_53_51 = manager.audio:GetVoiceLength("story_v_out_116331", "116331012", "story_v_out_116331.awb") / 1000

					if var_53_51 + var_53_42 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_51 + var_53_42
					end

					if var_53_46.prefab_name ~= "" and arg_50_1.actors_[var_53_46.prefab_name] ~= nil then
						local var_53_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_46.prefab_name].transform, "story_v_out_116331", "116331012", "story_v_out_116331.awb")

						arg_50_1:RecordAudio("116331012", var_53_52)
						arg_50_1:RecordAudio("116331012", var_53_52)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_116331", "116331012", "story_v_out_116331.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_116331", "116331012", "story_v_out_116331.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_53 = var_53_42 + 0.3
			local var_53_54 = math.max(var_53_43, arg_50_1.talkMaxDuration)

			if var_53_53 <= arg_50_1.time_ and arg_50_1.time_ < var_53_53 + var_53_54 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_53) / var_53_54

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_53 + var_53_54 and arg_50_1.time_ < var_53_53 + var_53_54 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play116331013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116331013
		arg_57_1.duration_ = 5.13

		local var_57_0 = {
			zh = 4.6,
			ja = 5.133
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
				arg_57_0:Play116331014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.575

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[338].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(116331013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 23
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331013", "story_v_out_116331.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331013", "story_v_out_116331.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_116331", "116331013", "story_v_out_116331.awb")

						arg_57_1:RecordAudio("116331013", var_60_9)
						arg_57_1:RecordAudio("116331013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116331", "116331013", "story_v_out_116331.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116331", "116331013", "story_v_out_116331.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play116331014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116331014
		arg_61_1.duration_ = 6.77

		local var_61_0 = {
			zh = 6.766,
			ja = 6.4
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
				arg_61_0:Play116331015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.75

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[338].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(116331014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 30
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331014", "story_v_out_116331.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331014", "story_v_out_116331.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_116331", "116331014", "story_v_out_116331.awb")

						arg_61_1:RecordAudio("116331014", var_64_9)
						arg_61_1:RecordAudio("116331014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_116331", "116331014", "story_v_out_116331.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_116331", "116331014", "story_v_out_116331.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play116331015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116331015
		arg_65_1.duration_ = 3.4

		local var_65_0 = {
			zh = 2.566,
			ja = 3.4
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
				arg_65_0:Play116331016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.325

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[332].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(116331015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331015", "story_v_out_116331.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331015", "story_v_out_116331.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_116331", "116331015", "story_v_out_116331.awb")

						arg_65_1:RecordAudio("116331015", var_68_9)
						arg_65_1:RecordAudio("116331015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_116331", "116331015", "story_v_out_116331.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_116331", "116331015", "story_v_out_116331.awb")
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
	Play116331016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116331016
		arg_69_1.duration_ = 8.8

		local var_69_0 = {
			zh = 8.733,
			ja = 8.8
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
				arg_69_0:Play116331017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.2

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[339].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(116331016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 48
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331016", "story_v_out_116331.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331016", "story_v_out_116331.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_116331", "116331016", "story_v_out_116331.awb")

						arg_69_1:RecordAudio("116331016", var_72_9)
						arg_69_1:RecordAudio("116331016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_116331", "116331016", "story_v_out_116331.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_116331", "116331016", "story_v_out_116331.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play116331017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 116331017
		arg_73_1.duration_ = 7.03

		local var_73_0 = {
			zh = 7.033,
			ja = 6.9
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
				arg_73_0:Play116331018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.8

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[339].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(116331017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 32
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331017", "story_v_out_116331.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331017", "story_v_out_116331.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_116331", "116331017", "story_v_out_116331.awb")

						arg_73_1:RecordAudio("116331017", var_76_9)
						arg_73_1:RecordAudio("116331017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_116331", "116331017", "story_v_out_116331.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_116331", "116331017", "story_v_out_116331.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play116331018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 116331018
		arg_77_1.duration_ = 5.03

		local var_77_0 = {
			zh = 3.9,
			ja = 5.033
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
				arg_77_0:Play116331019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.25

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[338].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(116331018)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331018", "story_v_out_116331.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331018", "story_v_out_116331.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_116331", "116331018", "story_v_out_116331.awb")

						arg_77_1:RecordAudio("116331018", var_80_9)
						arg_77_1:RecordAudio("116331018", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_116331", "116331018", "story_v_out_116331.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_116331", "116331018", "story_v_out_116331.awb")
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
	Play116331019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 116331019
		arg_81_1.duration_ = 6.8

		local var_81_0 = {
			zh = 6.8,
			ja = 6.233
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
				arg_81_0:Play116331020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.8

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[338].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(116331019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331019", "story_v_out_116331.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331019", "story_v_out_116331.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_116331", "116331019", "story_v_out_116331.awb")

						arg_81_1:RecordAudio("116331019", var_84_9)
						arg_81_1:RecordAudio("116331019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_116331", "116331019", "story_v_out_116331.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_116331", "116331019", "story_v_out_116331.awb")
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
	Play116331020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 116331020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play116331021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 1

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				local var_88_2 = "play"
				local var_88_3 = "effect"

				arg_85_1:AudioAction(var_88_2, var_88_3, "se_story_16", "se_story_16_thunder", "")
			end

			local var_88_4 = 0
			local var_88_5 = 0.175

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(116331020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_8 = 7
				local var_88_9 = utf8.len(var_88_7)
				local var_88_10 = var_88_8 <= 0 and var_88_5 or var_88_5 * (var_88_9 / var_88_8)

				if var_88_10 > 0 and var_88_5 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_11 and arg_85_1.time_ < var_88_4 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play116331021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 116331021
		arg_89_1.duration_ = 9.5

		local var_89_0 = {
			zh = 9.5,
			ja = 7.4
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
				arg_89_0:Play116331022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 2

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				local var_92_1 = manager.ui.mainCamera.transform.localPosition
				local var_92_2 = Vector3.New(0, 0, 10) + Vector3.New(var_92_1.x, var_92_1.y, 0)
				local var_92_3 = arg_89_1.bgs_.I07

				var_92_3.transform.localPosition = var_92_2
				var_92_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_4 = var_92_3:GetComponent("SpriteRenderer")

				if var_92_4 and var_92_4.sprite then
					local var_92_5 = (var_92_3.transform.localPosition - var_92_1).z
					local var_92_6 = manager.ui.mainCameraCom_
					local var_92_7 = 2 * var_92_5 * Mathf.Tan(var_92_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_92_8 = var_92_7 * var_92_6.aspect
					local var_92_9 = var_92_4.sprite.bounds.size.x
					local var_92_10 = var_92_4.sprite.bounds.size.y
					local var_92_11 = var_92_8 / var_92_9
					local var_92_12 = var_92_7 / var_92_10
					local var_92_13 = var_92_12 < var_92_11 and var_92_11 or var_92_12

					var_92_3.transform.localScale = Vector3.New(var_92_13, var_92_13, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "I07" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_15 = 2

			if var_92_14 <= arg_89_1.time_ and arg_89_1.time_ < var_92_14 + var_92_15 then
				local var_92_16 = (arg_89_1.time_ - var_92_14) / var_92_15
				local var_92_17 = Color.New(0, 0, 0)

				var_92_17.a = Mathf.Lerp(0, 1, var_92_16)
				arg_89_1.mask_.color = var_92_17
			end

			if arg_89_1.time_ >= var_92_14 + var_92_15 and arg_89_1.time_ < var_92_14 + var_92_15 + arg_92_0 then
				local var_92_18 = Color.New(0, 0, 0)

				var_92_18.a = 1
				arg_89_1.mask_.color = var_92_18
			end

			local var_92_19 = 2

			if var_92_19 < arg_89_1.time_ and arg_89_1.time_ <= var_92_19 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_20 = 2

			if var_92_19 <= arg_89_1.time_ and arg_89_1.time_ < var_92_19 + var_92_20 then
				local var_92_21 = (arg_89_1.time_ - var_92_19) / var_92_20
				local var_92_22 = Color.New(0, 0, 0)

				var_92_22.a = Mathf.Lerp(1, 0, var_92_21)
				arg_89_1.mask_.color = var_92_22
			end

			if arg_89_1.time_ >= var_92_19 + var_92_20 and arg_89_1.time_ < var_92_19 + var_92_20 + arg_92_0 then
				local var_92_23 = Color.New(0, 0, 0)
				local var_92_24 = 0

				arg_89_1.mask_.enabled = false
				var_92_23.a = var_92_24
				arg_89_1.mask_.color = var_92_23
			end

			local var_92_25 = 2

			arg_89_1.isInRecall_ = false

			if var_92_25 < arg_89_1.time_ and arg_89_1.time_ <= var_92_25 + arg_92_0 then
				arg_89_1.screenFilterGo_:SetActive(true)

				arg_89_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_92_2, iter_92_3 in pairs(arg_89_1.actors_) do
					local var_92_26 = iter_92_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_92_4, iter_92_5 in ipairs(var_92_26) do
						if iter_92_5.color.r > 0.51 then
							iter_92_5.color = Color.New(1, 1, 1)
						else
							iter_92_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_92_27 = 0.0166666666666667

			if var_92_25 <= arg_89_1.time_ and arg_89_1.time_ < var_92_25 + var_92_27 then
				local var_92_28 = (arg_89_1.time_ - var_92_25) / var_92_27

				arg_89_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_92_28)
			end

			if arg_89_1.time_ >= var_92_25 + var_92_27 and arg_89_1.time_ < var_92_25 + var_92_27 + arg_92_0 then
				arg_89_1.screenFilterEffect_.weight = 1
			end

			local var_92_29 = "10014ui_story"

			if arg_89_1.actors_[var_92_29] == nil then
				local var_92_30 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_92_30) then
					local var_92_31 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_89_1.stage_.transform)

					var_92_31.name = var_92_29
					var_92_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_89_1.actors_[var_92_29] = var_92_31

					local var_92_32 = var_92_31:GetComponentInChildren(typeof(CharacterEffect))

					var_92_32.enabled = true

					local var_92_33 = GameObjectTools.GetOrAddComponent(var_92_31, typeof(DynamicBoneHelper))

					if var_92_33 then
						var_92_33:EnableDynamicBone(false)
					end

					arg_89_1:ShowWeapon(var_92_32.transform, false)

					arg_89_1.var_[var_92_29 .. "Animator"] = var_92_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_89_1.var_[var_92_29 .. "Animator"].applyRootMotion = true
					arg_89_1.var_[var_92_29 .. "LipSync"] = var_92_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_92_34 = arg_89_1.actors_["10014ui_story"].transform
			local var_92_35 = 4

			if var_92_35 < arg_89_1.time_ and arg_89_1.time_ <= var_92_35 + arg_92_0 then
				arg_89_1.var_.moveOldPos10014ui_story = var_92_34.localPosition
			end

			local var_92_36 = 0.001

			if var_92_35 <= arg_89_1.time_ and arg_89_1.time_ < var_92_35 + var_92_36 then
				local var_92_37 = (arg_89_1.time_ - var_92_35) / var_92_36
				local var_92_38 = Vector3.New(0, -1.06, -6.2)

				var_92_34.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10014ui_story, var_92_38, var_92_37)

				local var_92_39 = manager.ui.mainCamera.transform.position - var_92_34.position

				var_92_34.forward = Vector3.New(var_92_39.x, var_92_39.y, var_92_39.z)

				local var_92_40 = var_92_34.localEulerAngles

				var_92_40.z = 0
				var_92_40.x = 0
				var_92_34.localEulerAngles = var_92_40
			end

			if arg_89_1.time_ >= var_92_35 + var_92_36 and arg_89_1.time_ < var_92_35 + var_92_36 + arg_92_0 then
				var_92_34.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_92_41 = manager.ui.mainCamera.transform.position - var_92_34.position

				var_92_34.forward = Vector3.New(var_92_41.x, var_92_41.y, var_92_41.z)

				local var_92_42 = var_92_34.localEulerAngles

				var_92_42.z = 0
				var_92_42.x = 0
				var_92_34.localEulerAngles = var_92_42
			end

			local var_92_43 = arg_89_1.actors_["10014ui_story"]
			local var_92_44 = 4

			if var_92_44 < arg_89_1.time_ and arg_89_1.time_ <= var_92_44 + arg_92_0 and not isNil(var_92_43) and arg_89_1.var_.characterEffect10014ui_story == nil then
				arg_89_1.var_.characterEffect10014ui_story = var_92_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_45 = 0.2

			if var_92_44 <= arg_89_1.time_ and arg_89_1.time_ < var_92_44 + var_92_45 and not isNil(var_92_43) then
				local var_92_46 = (arg_89_1.time_ - var_92_44) / var_92_45

				if arg_89_1.var_.characterEffect10014ui_story and not isNil(var_92_43) then
					arg_89_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_44 + var_92_45 and arg_89_1.time_ < var_92_44 + var_92_45 + arg_92_0 and not isNil(var_92_43) and arg_89_1.var_.characterEffect10014ui_story then
				arg_89_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_92_47 = 4

			if var_92_47 < arg_89_1.time_ and arg_89_1.time_ <= var_92_47 + arg_92_0 then
				arg_89_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_92_48 = 4

			if var_92_48 < arg_89_1.time_ and arg_89_1.time_ <= var_92_48 + arg_92_0 then
				arg_89_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_49 = 4
			local var_92_50 = 0.575

			if var_92_49 < arg_89_1.time_ and arg_89_1.time_ <= var_92_49 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_51 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_51:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_52 = arg_89_1:FormatText(StoryNameCfg[264].name)

				arg_89_1.leftNameTxt_.text = var_92_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_53 = arg_89_1:GetWordFromCfg(116331021)
				local var_92_54 = arg_89_1:FormatText(var_92_53.content)

				arg_89_1.text_.text = var_92_54

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_55 = 23
				local var_92_56 = utf8.len(var_92_54)
				local var_92_57 = var_92_55 <= 0 and var_92_50 or var_92_50 * (var_92_56 / var_92_55)

				if var_92_57 > 0 and var_92_50 < var_92_57 then
					arg_89_1.talkMaxDuration = var_92_57
					var_92_49 = var_92_49 + 0.3

					if var_92_57 + var_92_49 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_57 + var_92_49
					end
				end

				arg_89_1.text_.text = var_92_54
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331021", "story_v_out_116331.awb") ~= 0 then
					local var_92_58 = manager.audio:GetVoiceLength("story_v_out_116331", "116331021", "story_v_out_116331.awb") / 1000

					if var_92_58 + var_92_49 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_58 + var_92_49
					end

					if var_92_53.prefab_name ~= "" and arg_89_1.actors_[var_92_53.prefab_name] ~= nil then
						local var_92_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_53.prefab_name].transform, "story_v_out_116331", "116331021", "story_v_out_116331.awb")

						arg_89_1:RecordAudio("116331021", var_92_59)
						arg_89_1:RecordAudio("116331021", var_92_59)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_116331", "116331021", "story_v_out_116331.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_116331", "116331021", "story_v_out_116331.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_60 = var_92_49 + 0.3
			local var_92_61 = math.max(var_92_50, arg_89_1.talkMaxDuration)

			if var_92_60 <= arg_89_1.time_ and arg_89_1.time_ < var_92_60 + var_92_61 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_60) / var_92_61

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_60 + var_92_61 and arg_89_1.time_ < var_92_60 + var_92_61 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play116331022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116331022
		arg_95_1.duration_ = 11.33

		local var_95_0 = {
			zh = 7.733,
			ja = 11.333
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
				arg_95_0:Play116331023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_98_1 = 0
			local var_98_2 = 0.95

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_3 = arg_95_1:FormatText(StoryNameCfg[264].name)

				arg_95_1.leftNameTxt_.text = var_98_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:GetWordFromCfg(116331022)
				local var_98_5 = arg_95_1:FormatText(var_98_4.content)

				arg_95_1.text_.text = var_98_5

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_6 = 38
				local var_98_7 = utf8.len(var_98_5)
				local var_98_8 = var_98_6 <= 0 and var_98_2 or var_98_2 * (var_98_7 / var_98_6)

				if var_98_8 > 0 and var_98_2 < var_98_8 then
					arg_95_1.talkMaxDuration = var_98_8

					if var_98_8 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_5
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331022", "story_v_out_116331.awb") ~= 0 then
					local var_98_9 = manager.audio:GetVoiceLength("story_v_out_116331", "116331022", "story_v_out_116331.awb") / 1000

					if var_98_9 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_1
					end

					if var_98_4.prefab_name ~= "" and arg_95_1.actors_[var_98_4.prefab_name] ~= nil then
						local var_98_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_4.prefab_name].transform, "story_v_out_116331", "116331022", "story_v_out_116331.awb")

						arg_95_1:RecordAudio("116331022", var_98_10)
						arg_95_1:RecordAudio("116331022", var_98_10)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_116331", "116331022", "story_v_out_116331.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_116331", "116331022", "story_v_out_116331.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_11 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_11 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_11

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_11 and arg_95_1.time_ < var_98_1 + var_98_11 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play116331023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116331023
		arg_99_1.duration_ = 10.77

		local var_99_0 = {
			zh = 10.4,
			ja = 10.766
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play116331024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 2

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				local var_102_1 = manager.ui.mainCamera.transform.localPosition
				local var_102_2 = Vector3.New(0, 0, 10) + Vector3.New(var_102_1.x, var_102_1.y, 0)
				local var_102_3 = arg_99_1.bgs_.I07a

				var_102_3.transform.localPosition = var_102_2
				var_102_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_4 = var_102_3:GetComponent("SpriteRenderer")

				if var_102_4 and var_102_4.sprite then
					local var_102_5 = (var_102_3.transform.localPosition - var_102_1).z
					local var_102_6 = manager.ui.mainCameraCom_
					local var_102_7 = 2 * var_102_5 * Mathf.Tan(var_102_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_102_8 = var_102_7 * var_102_6.aspect
					local var_102_9 = var_102_4.sprite.bounds.size.x
					local var_102_10 = var_102_4.sprite.bounds.size.y
					local var_102_11 = var_102_8 / var_102_9
					local var_102_12 = var_102_7 / var_102_10
					local var_102_13 = var_102_12 < var_102_11 and var_102_11 or var_102_12

					var_102_3.transform.localScale = Vector3.New(var_102_13, var_102_13, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "I07a" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_15 = 2

			if var_102_14 <= arg_99_1.time_ and arg_99_1.time_ < var_102_14 + var_102_15 then
				local var_102_16 = (arg_99_1.time_ - var_102_14) / var_102_15
				local var_102_17 = Color.New(0, 0, 0)

				var_102_17.a = Mathf.Lerp(0, 1, var_102_16)
				arg_99_1.mask_.color = var_102_17
			end

			if arg_99_1.time_ >= var_102_14 + var_102_15 and arg_99_1.time_ < var_102_14 + var_102_15 + arg_102_0 then
				local var_102_18 = Color.New(0, 0, 0)

				var_102_18.a = 1
				arg_99_1.mask_.color = var_102_18
			end

			local var_102_19 = 2

			if var_102_19 < arg_99_1.time_ and arg_99_1.time_ <= var_102_19 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_20 = 2

			if var_102_19 <= arg_99_1.time_ and arg_99_1.time_ < var_102_19 + var_102_20 then
				local var_102_21 = (arg_99_1.time_ - var_102_19) / var_102_20
				local var_102_22 = Color.New(0, 0, 0)

				var_102_22.a = Mathf.Lerp(1, 0, var_102_21)
				arg_99_1.mask_.color = var_102_22
			end

			if arg_99_1.time_ >= var_102_19 + var_102_20 and arg_99_1.time_ < var_102_19 + var_102_20 + arg_102_0 then
				local var_102_23 = Color.New(0, 0, 0)
				local var_102_24 = 0

				arg_99_1.mask_.enabled = false
				var_102_23.a = var_102_24
				arg_99_1.mask_.color = var_102_23
			end

			local var_102_25 = arg_99_1.actors_["10014ui_story"].transform
			local var_102_26 = 2

			if var_102_26 < arg_99_1.time_ and arg_99_1.time_ <= var_102_26 + arg_102_0 then
				arg_99_1.var_.moveOldPos10014ui_story = var_102_25.localPosition
			end

			local var_102_27 = 0.001

			if var_102_26 <= arg_99_1.time_ and arg_99_1.time_ < var_102_26 + var_102_27 then
				local var_102_28 = (arg_99_1.time_ - var_102_26) / var_102_27
				local var_102_29 = Vector3.New(0, 100, 0)

				var_102_25.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10014ui_story, var_102_29, var_102_28)

				local var_102_30 = manager.ui.mainCamera.transform.position - var_102_25.position

				var_102_25.forward = Vector3.New(var_102_30.x, var_102_30.y, var_102_30.z)

				local var_102_31 = var_102_25.localEulerAngles

				var_102_31.z = 0
				var_102_31.x = 0
				var_102_25.localEulerAngles = var_102_31
			end

			if arg_99_1.time_ >= var_102_26 + var_102_27 and arg_99_1.time_ < var_102_26 + var_102_27 + arg_102_0 then
				var_102_25.localPosition = Vector3.New(0, 100, 0)

				local var_102_32 = manager.ui.mainCamera.transform.position - var_102_25.position

				var_102_25.forward = Vector3.New(var_102_32.x, var_102_32.y, var_102_32.z)

				local var_102_33 = var_102_25.localEulerAngles

				var_102_33.z = 0
				var_102_33.x = 0
				var_102_25.localEulerAngles = var_102_33
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_34 = 4
			local var_102_35 = 0.85

			if var_102_34 < arg_99_1.time_ and arg_99_1.time_ <= var_102_34 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_36 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_36:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_37 = arg_99_1:FormatText(StoryNameCfg[337].name)

				arg_99_1.leftNameTxt_.text = var_102_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_38 = arg_99_1:GetWordFromCfg(116331023)
				local var_102_39 = arg_99_1:FormatText(var_102_38.content)

				arg_99_1.text_.text = var_102_39

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_40 = 34
				local var_102_41 = utf8.len(var_102_39)
				local var_102_42 = var_102_40 <= 0 and var_102_35 or var_102_35 * (var_102_41 / var_102_40)

				if var_102_42 > 0 and var_102_35 < var_102_42 then
					arg_99_1.talkMaxDuration = var_102_42
					var_102_34 = var_102_34 + 0.3

					if var_102_42 + var_102_34 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_42 + var_102_34
					end
				end

				arg_99_1.text_.text = var_102_39
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331023", "story_v_out_116331.awb") ~= 0 then
					local var_102_43 = manager.audio:GetVoiceLength("story_v_out_116331", "116331023", "story_v_out_116331.awb") / 1000

					if var_102_43 + var_102_34 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_43 + var_102_34
					end

					if var_102_38.prefab_name ~= "" and arg_99_1.actors_[var_102_38.prefab_name] ~= nil then
						local var_102_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_38.prefab_name].transform, "story_v_out_116331", "116331023", "story_v_out_116331.awb")

						arg_99_1:RecordAudio("116331023", var_102_44)
						arg_99_1:RecordAudio("116331023", var_102_44)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_116331", "116331023", "story_v_out_116331.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_116331", "116331023", "story_v_out_116331.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_45 = var_102_34 + 0.3
			local var_102_46 = math.max(var_102_35, arg_99_1.talkMaxDuration)

			if var_102_45 <= arg_99_1.time_ and arg_99_1.time_ < var_102_45 + var_102_46 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_45) / var_102_46

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_45 + var_102_46 and arg_99_1.time_ < var_102_45 + var_102_46 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play116331024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 116331024
		arg_105_1.duration_ = 5.97

		local var_105_0 = {
			zh = 3.666,
			ja = 5.966
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
				arg_105_0:Play116331025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.475

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[337].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(116331024)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331024", "story_v_out_116331.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331024", "story_v_out_116331.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_116331", "116331024", "story_v_out_116331.awb")

						arg_105_1:RecordAudio("116331024", var_108_9)
						arg_105_1:RecordAudio("116331024", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_116331", "116331024", "story_v_out_116331.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_116331", "116331024", "story_v_out_116331.awb")
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
	Play116331025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 116331025
		arg_109_1.duration_ = 9

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play116331026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 2

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				local var_112_1 = manager.ui.mainCamera.transform.localPosition
				local var_112_2 = Vector3.New(0, 0, 10) + Vector3.New(var_112_1.x, var_112_1.y, 0)
				local var_112_3 = arg_109_1.bgs_.I07a

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
					if iter_112_0 ~= "I07a" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_15 = 2

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

			local var_112_19 = 2

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_20 = 2

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

			local var_112_25 = 0
			local var_112_26 = 0.266666666666667

			if var_112_25 < arg_109_1.time_ and arg_109_1.time_ <= var_112_25 + arg_112_0 then
				local var_112_27 = "play"
				local var_112_28 = "music"

				arg_109_1:AudioAction(var_112_27, var_112_28, "ui_battle", "ui_battle_stopbgm", "")

				local var_112_29 = ""
				local var_112_30 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_112_30 ~= "" then
					if arg_109_1.bgmTxt_.text ~= var_112_30 and arg_109_1.bgmTxt_.text ~= "" then
						if arg_109_1.bgmTxt2_.text ~= "" then
							arg_109_1.bgmTxt_.text = arg_109_1.bgmTxt2_.text
						end

						arg_109_1.bgmTxt2_.text = var_112_30

						arg_109_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_109_1.bgmTxt_.text = var_112_30
						arg_109_1.bgmTxt2_.text = var_112_30
					end

					if arg_109_1.bgmTimer then
						arg_109_1.bgmTimer:Stop()

						arg_109_1.bgmTimer = nil
					end

					if arg_109_1.settingData.show_music_name == 1 then
						arg_109_1.musicController:SetSelectedState("show")
						arg_109_1.musicAnimator_:Play("open", 0, 0)

						if arg_109_1.settingData.music_time ~= 0 then
							arg_109_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_109_1.settingData.music_time), function()
								if arg_109_1 == nil or isNil(arg_109_1.bgmTxt_) then
									return
								end

								arg_109_1.musicController:SetSelectedState("hide")
								arg_109_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_112_31 = 2

			arg_109_1.isInRecall_ = false

			if var_112_31 < arg_109_1.time_ and arg_109_1.time_ <= var_112_31 + arg_112_0 then
				arg_109_1.screenFilterGo_:SetActive(false)

				for iter_112_2, iter_112_3 in pairs(arg_109_1.actors_) do
					local var_112_32 = iter_112_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_112_4, iter_112_5 in ipairs(var_112_32) do
						if iter_112_5.color.r > 0.51 then
							iter_112_5.color = Color.New(1, 1, 1)
						else
							iter_112_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_112_33 = 0.0166666666666667

			if var_112_31 <= arg_109_1.time_ and arg_109_1.time_ < var_112_31 + var_112_33 then
				local var_112_34 = (arg_109_1.time_ - var_112_31) / var_112_33

				arg_109_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_112_34)
			end

			if arg_109_1.time_ >= var_112_31 + var_112_33 and arg_109_1.time_ < var_112_31 + var_112_33 + arg_112_0 then
				arg_109_1.screenFilterEffect_.weight = 0
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_35 = 4
			local var_112_36 = 0.925

			if var_112_35 < arg_109_1.time_ and arg_109_1.time_ <= var_112_35 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_37 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_37:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_109_1.dialogCg_.alpha = arg_114_0
				end))
				var_112_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_38 = arg_109_1:GetWordFromCfg(116331025)
				local var_112_39 = arg_109_1:FormatText(var_112_38.content)

				arg_109_1.text_.text = var_112_39

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_40 = 37
				local var_112_41 = utf8.len(var_112_39)
				local var_112_42 = var_112_40 <= 0 and var_112_36 or var_112_36 * (var_112_41 / var_112_40)

				if var_112_42 > 0 and var_112_36 < var_112_42 then
					arg_109_1.talkMaxDuration = var_112_42
					var_112_35 = var_112_35 + 0.3

					if var_112_42 + var_112_35 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_42 + var_112_35
					end
				end

				arg_109_1.text_.text = var_112_39
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_43 = var_112_35 + 0.3
			local var_112_44 = math.max(var_112_36, arg_109_1.talkMaxDuration)

			if var_112_43 <= arg_109_1.time_ and arg_109_1.time_ < var_112_43 + var_112_44 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_43) / var_112_44

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_43 + var_112_44 and arg_109_1.time_ < var_112_43 + var_112_44 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play116331026 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 116331026
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play116331027(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.875

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_2 = arg_116_1:GetWordFromCfg(116331026)
				local var_119_3 = arg_116_1:FormatText(var_119_2.content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 35
				local var_119_5 = utf8.len(var_119_3)
				local var_119_6 = var_119_4 <= 0 and var_119_1 or var_119_1 * (var_119_5 / var_119_4)

				if var_119_6 > 0 and var_119_1 < var_119_6 then
					arg_116_1.talkMaxDuration = var_119_6

					if var_119_6 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_7 and arg_116_1.time_ < var_119_0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play116331027 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 116331027
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play116331028(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.85

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_2 = arg_120_1:GetWordFromCfg(116331027)
				local var_123_3 = arg_120_1:FormatText(var_123_2.content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 34
				local var_123_5 = utf8.len(var_123_3)
				local var_123_6 = var_123_4 <= 0 and var_123_1 or var_123_1 * (var_123_5 / var_123_4)

				if var_123_6 > 0 and var_123_1 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_7 and arg_120_1.time_ < var_123_0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play116331028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 116331028
		arg_124_1.duration_ = 6.8

		local var_124_0 = {
			zh = 4.7,
			ja = 6.8
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play116331029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10032ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos10032ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, -1.1, -5.9)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10032ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_127_11 = arg_124_1.actors_["10032ui_story"]
			local var_127_12 = 0

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect10032ui_story == nil then
				arg_124_1.var_.characterEffect10032ui_story = var_127_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_13 = 0.2

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_13 and not isNil(var_127_11) then
				local var_127_14 = (arg_124_1.time_ - var_127_12) / var_127_13

				if arg_124_1.var_.characterEffect10032ui_story and not isNil(var_127_11) then
					arg_124_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_12 + var_127_13 and arg_124_1.time_ < var_127_12 + var_127_13 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect10032ui_story then
				arg_124_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_127_15 = 0
			local var_127_16 = 0.475

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_17 = arg_124_1:FormatText(StoryNameCfg[328].name)

				arg_124_1.leftNameTxt_.text = var_127_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_18 = arg_124_1:GetWordFromCfg(116331028)
				local var_127_19 = arg_124_1:FormatText(var_127_18.content)

				arg_124_1.text_.text = var_127_19

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_20 = 19
				local var_127_21 = utf8.len(var_127_19)
				local var_127_22 = var_127_20 <= 0 and var_127_16 or var_127_16 * (var_127_21 / var_127_20)

				if var_127_22 > 0 and var_127_16 < var_127_22 then
					arg_124_1.talkMaxDuration = var_127_22

					if var_127_22 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_22 + var_127_15
					end
				end

				arg_124_1.text_.text = var_127_19
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331028", "story_v_out_116331.awb") ~= 0 then
					local var_127_23 = manager.audio:GetVoiceLength("story_v_out_116331", "116331028", "story_v_out_116331.awb") / 1000

					if var_127_23 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_23 + var_127_15
					end

					if var_127_18.prefab_name ~= "" and arg_124_1.actors_[var_127_18.prefab_name] ~= nil then
						local var_127_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_18.prefab_name].transform, "story_v_out_116331", "116331028", "story_v_out_116331.awb")

						arg_124_1:RecordAudio("116331028", var_127_24)
						arg_124_1:RecordAudio("116331028", var_127_24)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_116331", "116331028", "story_v_out_116331.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_116331", "116331028", "story_v_out_116331.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_25 = math.max(var_127_16, arg_124_1.talkMaxDuration)

			if var_127_15 <= arg_124_1.time_ and arg_124_1.time_ < var_127_15 + var_127_25 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_15) / var_127_25

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_15 + var_127_25 and arg_124_1.time_ < var_127_15 + var_127_25 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
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
	Play116331029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 116331029
		arg_128_1.duration_ = 16.25

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play116331030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = "STwhite"

			if arg_128_1.bgs_[var_131_0] == nil then
				local var_131_1 = Object.Instantiate(arg_128_1.paintGo_)

				var_131_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_131_0)
				var_131_1.name = var_131_0
				var_131_1.transform.parent = arg_128_1.stage_.transform
				var_131_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.bgs_[var_131_0] = var_131_1
			end

			local var_131_2 = 2

			if var_131_2 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				local var_131_3 = manager.ui.mainCamera.transform.localPosition
				local var_131_4 = Vector3.New(0, 0, 10) + Vector3.New(var_131_3.x, var_131_3.y, 0)
				local var_131_5 = arg_128_1.bgs_.STwhite

				var_131_5.transform.localPosition = var_131_4
				var_131_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_6 = var_131_5:GetComponent("SpriteRenderer")

				if var_131_6 and var_131_6.sprite then
					local var_131_7 = (var_131_5.transform.localPosition - var_131_3).z
					local var_131_8 = manager.ui.mainCameraCom_
					local var_131_9 = 2 * var_131_7 * Mathf.Tan(var_131_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_131_10 = var_131_9 * var_131_8.aspect
					local var_131_11 = var_131_6.sprite.bounds.size.x
					local var_131_12 = var_131_6.sprite.bounds.size.y
					local var_131_13 = var_131_10 / var_131_11
					local var_131_14 = var_131_9 / var_131_12
					local var_131_15 = var_131_14 < var_131_13 and var_131_13 or var_131_14

					var_131_5.transform.localScale = Vector3.New(var_131_15, var_131_15, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "STwhite" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_131_16 = 2

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1.fswbg_:SetActive(true)
				arg_128_1.dialog_:SetActive(false)

				arg_128_1.fswtw_.percent = 0

				local var_131_17 = arg_128_1:GetWordFromCfg(116331029)
				local var_131_18 = arg_128_1:FormatText(var_131_17.content)

				arg_128_1.fswt_.text = var_131_18

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.fswt_)

				arg_128_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_128_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_128_1.fswtw_:SetDirty()

				arg_128_1.typewritterCharCountI18N = 0

				SetActive(arg_128_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_128_1:ShowNextGo(false)
			end

			local var_131_19 = 4

			if var_131_19 < arg_128_1.time_ and arg_128_1.time_ <= var_131_19 + arg_131_0 then
				arg_128_1.var_.oldValueTypewriter = arg_128_1.fswtw_.percent

				SetActive(arg_128_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_128_1:ShowNextGo(false)
			end

			local var_131_20 = 59
			local var_131_21 = 2.95
			local var_131_22 = arg_128_1:GetWordFromCfg(116331029)
			local var_131_23 = arg_128_1:FormatText(var_131_22.content)
			local var_131_24, var_131_25 = arg_128_1:GetPercentByPara(var_131_23, 1)

			if var_131_19 < arg_128_1.time_ and arg_128_1.time_ <= var_131_19 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				local var_131_26 = var_131_20 <= 0 and var_131_21 or var_131_21 * ((var_131_25 - arg_128_1.typewritterCharCountI18N) / var_131_20)

				if var_131_26 > 0 and var_131_21 < var_131_26 then
					arg_128_1.talkMaxDuration = var_131_26

					if var_131_26 + var_131_19 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_26 + var_131_19
					end
				end
			end

			local var_131_27 = 2.95
			local var_131_28 = math.max(var_131_27, arg_128_1.talkMaxDuration)

			if var_131_19 <= arg_128_1.time_ and arg_128_1.time_ < var_131_19 + var_131_28 then
				local var_131_29 = (arg_128_1.time_ - var_131_19) / var_131_28

				arg_128_1.fswtw_.percent = Mathf.Lerp(arg_128_1.var_.oldValueTypewriter, var_131_24, var_131_29)
				arg_128_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_128_1.fswtw_:SetDirty()
			end

			if arg_128_1.time_ >= var_131_19 + var_131_28 and arg_128_1.time_ < var_131_19 + var_131_28 + arg_131_0 then
				arg_128_1.fswtw_.percent = var_131_24

				arg_128_1.fswtw_:SetDirty()
				arg_128_1:ShowNextGo(true)

				arg_128_1.typewritterCharCountI18N = var_131_25
			end

			local var_131_30 = 4
			local var_131_31 = 12.251
			local var_131_32 = manager.audio:GetVoiceLength("story_v_out_116331", "116331029", "story_v_out_116331.awb") / 1000

			if var_131_32 > 0 and var_131_31 < var_131_32 and var_131_32 + var_131_30 > arg_128_1.duration_ then
				local var_131_33 = var_131_32

				arg_128_1.duration_ = var_131_32 + var_131_30
			end

			if var_131_30 < arg_128_1.time_ and arg_128_1.time_ <= var_131_30 + arg_131_0 then
				local var_131_34 = "play"
				local var_131_35 = "voice"

				arg_128_1:AudioAction(var_131_34, var_131_35, "story_v_out_116331", "116331029", "story_v_out_116331.awb")
			end

			local var_131_36 = arg_128_1.actors_["10032ui_story"].transform
			local var_131_37 = 2

			if var_131_37 < arg_128_1.time_ and arg_128_1.time_ <= var_131_37 + arg_131_0 then
				arg_128_1.var_.moveOldPos10032ui_story = var_131_36.localPosition
			end

			local var_131_38 = 0.001

			if var_131_37 <= arg_128_1.time_ and arg_128_1.time_ < var_131_37 + var_131_38 then
				local var_131_39 = (arg_128_1.time_ - var_131_37) / var_131_38
				local var_131_40 = Vector3.New(0, 100, 0)

				var_131_36.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10032ui_story, var_131_40, var_131_39)

				local var_131_41 = manager.ui.mainCamera.transform.position - var_131_36.position

				var_131_36.forward = Vector3.New(var_131_41.x, var_131_41.y, var_131_41.z)

				local var_131_42 = var_131_36.localEulerAngles

				var_131_42.z = 0
				var_131_42.x = 0
				var_131_36.localEulerAngles = var_131_42
			end

			if arg_128_1.time_ >= var_131_37 + var_131_38 and arg_128_1.time_ < var_131_37 + var_131_38 + arg_131_0 then
				var_131_36.localPosition = Vector3.New(0, 100, 0)

				local var_131_43 = manager.ui.mainCamera.transform.position - var_131_36.position

				var_131_36.forward = Vector3.New(var_131_43.x, var_131_43.y, var_131_43.z)

				local var_131_44 = var_131_36.localEulerAngles

				var_131_44.z = 0
				var_131_44.x = 0
				var_131_36.localEulerAngles = var_131_44
			end

			local var_131_45 = 4
			local var_131_46 = 0.266666666666667

			if var_131_45 < arg_128_1.time_ and arg_128_1.time_ <= var_131_45 + arg_131_0 then
				local var_131_47 = "play"
				local var_131_48 = "music"

				arg_128_1:AudioAction(var_131_47, var_131_48, "ui_battle", "ui_battle_stopbgm", "")

				local var_131_49 = ""
				local var_131_50 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_131_50 ~= "" then
					if arg_128_1.bgmTxt_.text ~= var_131_50 and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = var_131_50

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = var_131_50
						arg_128_1.bgmTxt2_.text = var_131_50
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_131_51 = 4.4
			local var_131_52 = 0.6

			if var_131_51 < arg_128_1.time_ and arg_128_1.time_ <= var_131_51 + arg_131_0 then
				local var_131_53 = "play"
				local var_131_54 = "music"

				arg_128_1:AudioAction(var_131_53, var_131_54, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_131_55 = ""

				if var_131_55 ~= "" then
					if arg_128_1.bgmTxt_.text ~= var_131_55 and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = var_131_55

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = var_131_55
						arg_128_1.bgmTxt2_.text = var_131_55
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_131_56 = 4.575
			local var_131_57 = 0.425

			if var_131_56 < arg_128_1.time_ and arg_128_1.time_ <= var_131_56 + arg_131_0 then
				local var_131_58 = "play"
				local var_131_59 = "music"

				arg_128_1:AudioAction(var_131_58, var_131_59, "bgm_activity_1_6_story_story", "story", "bgm_activity_1_6_story_story.awb")

				local var_131_60 = ""
				local var_131_61 = MusicRecordCfg[97].musicName

				if var_131_61 ~= "" then
					if arg_128_1.bgmTxt_.text ~= var_131_61 and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = var_131_61

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = var_131_61
						arg_128_1.bgmTxt2_.text = var_131_61
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_131_62 = 0

			if var_131_62 < arg_128_1.time_ and arg_128_1.time_ <= var_131_62 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_63 = 2

			if var_131_62 <= arg_128_1.time_ and arg_128_1.time_ < var_131_62 + var_131_63 then
				local var_131_64 = (arg_128_1.time_ - var_131_62) / var_131_63
				local var_131_65 = Color.New(0, 0, 0)

				var_131_65.a = Mathf.Lerp(0, 1, var_131_64)
				arg_128_1.mask_.color = var_131_65
			end

			if arg_128_1.time_ >= var_131_62 + var_131_63 and arg_128_1.time_ < var_131_62 + var_131_63 + arg_131_0 then
				local var_131_66 = Color.New(0, 0, 0)

				var_131_66.a = 1
				arg_128_1.mask_.color = var_131_66
			end

			local var_131_67 = 2

			if var_131_67 < arg_128_1.time_ and arg_128_1.time_ <= var_131_67 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_68 = 2

			if var_131_67 <= arg_128_1.time_ and arg_128_1.time_ < var_131_67 + var_131_68 then
				local var_131_69 = (arg_128_1.time_ - var_131_67) / var_131_68
				local var_131_70 = Color.New(0, 0, 0)

				var_131_70.a = Mathf.Lerp(1, 0, var_131_69)
				arg_128_1.mask_.color = var_131_70
			end

			if arg_128_1.time_ >= var_131_67 + var_131_68 and arg_128_1.time_ < var_131_67 + var_131_68 + arg_131_0 then
				local var_131_71 = Color.New(0, 0, 0)
				local var_131_72 = 0

				arg_128_1.mask_.enabled = false
				var_131_71.a = var_131_72
				arg_128_1.mask_.color = var_131_71
			end

			local var_131_73 = 4

			if var_131_73 < arg_128_1.time_ and arg_128_1.time_ <= var_131_73 + arg_131_0 then
				arg_128_1.allBtn_.enabled = false
			end

			local var_131_74 = 2.95

			if arg_128_1.time_ >= var_131_73 + var_131_74 and arg_128_1.time_ < var_131_73 + var_131_74 + arg_131_0 then
				arg_128_1.allBtn_.enabled = true
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play116331030 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116331030
		arg_135_1.duration_ = 11.48

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play116331031(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.var_.oldValueTypewriter = arg_135_1.fswtw_.percent

				SetActive(arg_135_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_135_1:ShowNextGo(false)
			end

			local var_138_1 = 0
			local var_138_2 = -1
			local var_138_3 = arg_135_1:GetWordFromCfg(116331029)
			local var_138_4 = arg_135_1:FormatText(var_138_3.content)
			local var_138_5, var_138_6 = arg_135_1:GetPercentByPara(var_138_4, 1)

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				local var_138_7 = var_138_1 <= 0 and var_138_2 or var_138_2 * ((var_138_6 - arg_135_1.typewritterCharCountI18N) / var_138_1)

				if var_138_7 > 0 and var_138_2 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end
			end

			local var_138_8 = -1
			local var_138_9 = math.max(var_138_8, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_9 then
				local var_138_10 = (arg_135_1.time_ - var_138_0) / var_138_9

				arg_135_1.fswtw_.percent = Mathf.Lerp(arg_135_1.var_.oldValueTypewriter, var_138_5, var_138_10)
				arg_135_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_135_1.fswtw_:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_9 and arg_135_1.time_ < var_138_0 + var_138_9 + arg_138_0 then
				arg_135_1.fswtw_.percent = var_138_5

				arg_135_1.fswtw_:SetDirty()
				arg_135_1:ShowNextGo(true)

				arg_135_1.typewritterCharCountI18N = var_138_6
			end

			local var_138_11 = 0

			if var_138_11 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.var_.oldValueTypewriter = arg_135_1.fswtw_.percent

				SetActive(arg_135_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_135_1:ShowNextGo(false)
			end

			local var_138_12 = 47
			local var_138_13 = 2.35
			local var_138_14 = arg_135_1:GetWordFromCfg(116331029)
			local var_138_15 = arg_135_1:FormatText(var_138_14.content)
			local var_138_16, var_138_17 = arg_135_1:GetPercentByPara(var_138_15, 2)

			if var_138_11 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				local var_138_18 = var_138_12 <= 0 and var_138_13 or var_138_13 * ((var_138_17 - arg_135_1.typewritterCharCountI18N) / var_138_12)

				if var_138_18 > 0 and var_138_13 < var_138_18 then
					arg_135_1.talkMaxDuration = var_138_18

					if var_138_18 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_11
					end
				end
			end

			local var_138_19 = 2.35
			local var_138_20 = math.max(var_138_19, arg_135_1.talkMaxDuration)

			if var_138_11 <= arg_135_1.time_ and arg_135_1.time_ < var_138_11 + var_138_20 then
				local var_138_21 = (arg_135_1.time_ - var_138_11) / var_138_20

				arg_135_1.fswtw_.percent = Mathf.Lerp(arg_135_1.var_.oldValueTypewriter, var_138_16, var_138_21)
				arg_135_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_135_1.fswtw_:SetDirty()
			end

			if arg_135_1.time_ >= var_138_11 + var_138_20 and arg_135_1.time_ < var_138_11 + var_138_20 + arg_138_0 then
				arg_135_1.fswtw_.percent = var_138_16

				arg_135_1.fswtw_:SetDirty()
				arg_135_1:ShowNextGo(true)

				arg_135_1.typewritterCharCountI18N = var_138_17
			end

			local var_138_22 = 0
			local var_138_23 = 11.482
			local var_138_24 = manager.audio:GetVoiceLength("story_v_out_116331", "116331030", "story_v_out_116331.awb") / 1000

			if var_138_24 > 0 and var_138_23 < var_138_24 and var_138_24 + var_138_22 > arg_135_1.duration_ then
				local var_138_25 = var_138_24

				arg_135_1.duration_ = var_138_24 + var_138_22
			end

			if var_138_22 < arg_135_1.time_ and arg_135_1.time_ <= var_138_22 + arg_138_0 then
				local var_138_26 = "play"
				local var_138_27 = "voice"

				arg_135_1:AudioAction(var_138_26, var_138_27, "story_v_out_116331", "116331030", "story_v_out_116331.awb")
			end

			local var_138_28 = 0

			if var_138_28 < arg_135_1.time_ and arg_135_1.time_ <= var_138_28 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			local var_138_29 = 2.35

			if arg_135_1.time_ >= var_138_28 + var_138_29 and arg_135_1.time_ < var_138_28 + var_138_29 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play116331031 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 116331031
		arg_139_1.duration_ = 12.41

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play116331032(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.var_.oldValueTypewriter = arg_139_1.fswtw_.percent

				SetActive(arg_139_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_139_1:ShowNextGo(false)
			end

			local var_142_1 = 0
			local var_142_2 = -2.53333333333333
			local var_142_3 = arg_139_1:GetWordFromCfg(116331029)
			local var_142_4 = arg_139_1:FormatText(var_142_3.content)
			local var_142_5, var_142_6 = arg_139_1:GetPercentByPara(var_142_4, 1)

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				local var_142_7 = var_142_1 <= 0 and var_142_2 or var_142_2 * ((var_142_6 - arg_139_1.typewritterCharCountI18N) / var_142_1)

				if var_142_7 > 0 and var_142_2 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end
			end

			local var_142_8 = -2.53333333333333
			local var_142_9 = math.max(var_142_8, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_9 then
				local var_142_10 = (arg_139_1.time_ - var_142_0) / var_142_9

				arg_139_1.fswtw_.percent = Mathf.Lerp(arg_139_1.var_.oldValueTypewriter, var_142_5, var_142_10)
				arg_139_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_139_1.fswtw_:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_9 and arg_139_1.time_ < var_142_0 + var_142_9 + arg_142_0 then
				arg_139_1.fswtw_.percent = var_142_5

				arg_139_1.fswtw_:SetDirty()
				arg_139_1:ShowNextGo(true)

				arg_139_1.typewritterCharCountI18N = var_142_6
			end

			local var_142_11 = 0

			if var_142_11 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
				arg_139_1.var_.oldValueTypewriter = arg_139_1.fswtw_.percent

				SetActive(arg_139_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_139_1:ShowNextGo(false)
			end

			local var_142_12 = 53
			local var_142_13 = 2.65
			local var_142_14 = arg_139_1:GetWordFromCfg(116331029)
			local var_142_15 = arg_139_1:FormatText(var_142_14.content)
			local var_142_16, var_142_17 = arg_139_1:GetPercentByPara(var_142_15, 3)

			if var_142_11 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				local var_142_18 = var_142_12 <= 0 and var_142_13 or var_142_13 * ((var_142_17 - arg_139_1.typewritterCharCountI18N) / var_142_12)

				if var_142_18 > 0 and var_142_13 < var_142_18 then
					arg_139_1.talkMaxDuration = var_142_18

					if var_142_18 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_11
					end
				end
			end

			local var_142_19 = 2.65
			local var_142_20 = math.max(var_142_19, arg_139_1.talkMaxDuration)

			if var_142_11 <= arg_139_1.time_ and arg_139_1.time_ < var_142_11 + var_142_20 then
				local var_142_21 = (arg_139_1.time_ - var_142_11) / var_142_20

				arg_139_1.fswtw_.percent = Mathf.Lerp(arg_139_1.var_.oldValueTypewriter, var_142_16, var_142_21)
				arg_139_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_139_1.fswtw_:SetDirty()
			end

			if arg_139_1.time_ >= var_142_11 + var_142_20 and arg_139_1.time_ < var_142_11 + var_142_20 + arg_142_0 then
				arg_139_1.fswtw_.percent = var_142_16

				arg_139_1.fswtw_:SetDirty()
				arg_139_1:ShowNextGo(true)

				arg_139_1.typewritterCharCountI18N = var_142_17
			end

			local var_142_22 = 0
			local var_142_23 = 12.414
			local var_142_24 = manager.audio:GetVoiceLength("story_v_out_116331", "116331031", "story_v_out_116331.awb") / 1000

			if var_142_24 > 0 and var_142_23 < var_142_24 and var_142_24 + var_142_22 > arg_139_1.duration_ then
				local var_142_25 = var_142_24

				arg_139_1.duration_ = var_142_24 + var_142_22
			end

			if var_142_22 < arg_139_1.time_ and arg_139_1.time_ <= var_142_22 + arg_142_0 then
				local var_142_26 = "play"
				local var_142_27 = "voice"

				arg_139_1:AudioAction(var_142_26, var_142_27, "story_v_out_116331", "116331031", "story_v_out_116331.awb")
			end

			local var_142_28 = 0

			if var_142_28 < arg_139_1.time_ and arg_139_1.time_ <= var_142_28 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			local var_142_29 = 2.65

			if arg_139_1.time_ >= var_142_28 + var_142_29 and arg_139_1.time_ < var_142_28 + var_142_29 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play116331032 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 116331032
		arg_143_1.duration_ = 4.23

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play116331033(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.var_.oldValueTypewriter = arg_143_1.fswtw_.percent

				SetActive(arg_143_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_143_1:ShowNextGo(false)
			end

			local var_146_1 = 0
			local var_146_2 = -5.26666666666667
			local var_146_3 = arg_143_1:GetWordFromCfg(116331029)
			local var_146_4 = arg_143_1:FormatText(var_146_3.content)
			local var_146_5, var_146_6 = arg_143_1:GetPercentByPara(var_146_4, 2)

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				local var_146_7 = var_146_1 <= 0 and var_146_2 or var_146_2 * ((var_146_6 - arg_143_1.typewritterCharCountI18N) / var_146_1)

				if var_146_7 > 0 and var_146_2 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end
			end

			local var_146_8 = -5.26666666666667
			local var_146_9 = math.max(var_146_8, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_9 then
				local var_146_10 = (arg_143_1.time_ - var_146_0) / var_146_9

				arg_143_1.fswtw_.percent = Mathf.Lerp(arg_143_1.var_.oldValueTypewriter, var_146_5, var_146_10)
				arg_143_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_143_1.fswtw_:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_9 and arg_143_1.time_ < var_146_0 + var_146_9 + arg_146_0 then
				arg_143_1.fswtw_.percent = var_146_5

				arg_143_1.fswtw_:SetDirty()
				arg_143_1:ShowNextGo(true)

				arg_143_1.typewritterCharCountI18N = var_146_6
			end

			local var_146_11 = 0

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.var_.oldValueTypewriter = arg_143_1.fswtw_.percent

				SetActive(arg_143_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_143_1:ShowNextGo(false)
			end

			local var_146_12 = 25
			local var_146_13 = 1.25
			local var_146_14 = arg_143_1:GetWordFromCfg(116331029)
			local var_146_15 = arg_143_1:FormatText(var_146_14.content)
			local var_146_16, var_146_17 = arg_143_1:GetPercentByPara(var_146_15, 4)

			if var_146_11 < arg_143_1.time_ and arg_143_1.time_ <= var_146_11 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				local var_146_18 = var_146_12 <= 0 and var_146_13 or var_146_13 * ((var_146_17 - arg_143_1.typewritterCharCountI18N) / var_146_12)

				if var_146_18 > 0 and var_146_13 < var_146_18 then
					arg_143_1.talkMaxDuration = var_146_18

					if var_146_18 + var_146_11 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_11
					end
				end
			end

			local var_146_19 = 1.25
			local var_146_20 = math.max(var_146_19, arg_143_1.talkMaxDuration)

			if var_146_11 <= arg_143_1.time_ and arg_143_1.time_ < var_146_11 + var_146_20 then
				local var_146_21 = (arg_143_1.time_ - var_146_11) / var_146_20

				arg_143_1.fswtw_.percent = Mathf.Lerp(arg_143_1.var_.oldValueTypewriter, var_146_16, var_146_21)
				arg_143_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_143_1.fswtw_:SetDirty()
			end

			if arg_143_1.time_ >= var_146_11 + var_146_20 and arg_143_1.time_ < var_146_11 + var_146_20 + arg_146_0 then
				arg_143_1.fswtw_.percent = var_146_16

				arg_143_1.fswtw_:SetDirty()
				arg_143_1:ShowNextGo(true)

				arg_143_1.typewritterCharCountI18N = var_146_17
			end

			local var_146_22 = 0
			local var_146_23 = 4.23
			local var_146_24 = manager.audio:GetVoiceLength("story_v_out_116331", "116331032", "story_v_out_116331.awb") / 1000

			if var_146_24 > 0 and var_146_23 < var_146_24 and var_146_24 + var_146_22 > arg_143_1.duration_ then
				local var_146_25 = var_146_24

				arg_143_1.duration_ = var_146_24 + var_146_22
			end

			if var_146_22 < arg_143_1.time_ and arg_143_1.time_ <= var_146_22 + arg_146_0 then
				local var_146_26 = "play"
				local var_146_27 = "voice"

				arg_143_1:AudioAction(var_146_26, var_146_27, "story_v_out_116331", "116331032", "story_v_out_116331.awb")
			end

			local var_146_28 = 0

			if var_146_28 < arg_143_1.time_ and arg_143_1.time_ <= var_146_28 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			local var_146_29 = 1.25

			if arg_143_1.time_ >= var_146_28 + var_146_29 and arg_143_1.time_ < var_146_28 + var_146_29 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play116331033 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 116331033
		arg_147_1.duration_ = 11.89

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play116331034(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.var_.oldValueTypewriter = arg_147_1.fswtw_.percent

				SetActive(arg_147_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_147_1:ShowNextGo(false)
			end

			local var_150_1 = 0
			local var_150_2 = -5.33333333333333
			local var_150_3 = arg_147_1:GetWordFromCfg(116331029)
			local var_150_4 = arg_147_1:FormatText(var_150_3.content)
			local var_150_5, var_150_6 = arg_147_1:GetPercentByPara(var_150_4, 2)

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				local var_150_7 = var_150_1 <= 0 and var_150_2 or var_150_2 * ((var_150_6 - arg_147_1.typewritterCharCountI18N) / var_150_1)

				if var_150_7 > 0 and var_150_2 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end
			end

			local var_150_8 = -5.33333333333333
			local var_150_9 = math.max(var_150_8, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_9 then
				local var_150_10 = (arg_147_1.time_ - var_150_0) / var_150_9

				arg_147_1.fswtw_.percent = Mathf.Lerp(arg_147_1.var_.oldValueTypewriter, var_150_5, var_150_10)
				arg_147_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_147_1.fswtw_:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_9 and arg_147_1.time_ < var_150_0 + var_150_9 + arg_150_0 then
				arg_147_1.fswtw_.percent = var_150_5

				arg_147_1.fswtw_:SetDirty()
				arg_147_1:ShowNextGo(true)

				arg_147_1.typewritterCharCountI18N = var_150_6
			end

			local var_150_11 = 0

			if var_150_11 < arg_147_1.time_ and arg_147_1.time_ <= var_150_11 + arg_150_0 then
				arg_147_1.var_.oldValueTypewriter = arg_147_1.fswtw_.percent

				SetActive(arg_147_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_147_1:ShowNextGo(false)
			end

			local var_150_12 = 52
			local var_150_13 = 2.6
			local var_150_14 = arg_147_1:GetWordFromCfg(116331029)
			local var_150_15 = arg_147_1:FormatText(var_150_14.content)
			local var_150_16, var_150_17 = arg_147_1:GetPercentByPara(var_150_15, 5)

			if var_150_11 < arg_147_1.time_ and arg_147_1.time_ <= var_150_11 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				local var_150_18 = var_150_12 <= 0 and var_150_13 or var_150_13 * ((var_150_17 - arg_147_1.typewritterCharCountI18N) / var_150_12)

				if var_150_18 > 0 and var_150_13 < var_150_18 then
					arg_147_1.talkMaxDuration = var_150_18

					if var_150_18 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_18 + var_150_11
					end
				end
			end

			local var_150_19 = 2.6
			local var_150_20 = math.max(var_150_19, arg_147_1.talkMaxDuration)

			if var_150_11 <= arg_147_1.time_ and arg_147_1.time_ < var_150_11 + var_150_20 then
				local var_150_21 = (arg_147_1.time_ - var_150_11) / var_150_20

				arg_147_1.fswtw_.percent = Mathf.Lerp(arg_147_1.var_.oldValueTypewriter, var_150_16, var_150_21)
				arg_147_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_147_1.fswtw_:SetDirty()
			end

			if arg_147_1.time_ >= var_150_11 + var_150_20 and arg_147_1.time_ < var_150_11 + var_150_20 + arg_150_0 then
				arg_147_1.fswtw_.percent = var_150_16

				arg_147_1.fswtw_:SetDirty()
				arg_147_1:ShowNextGo(true)

				arg_147_1.typewritterCharCountI18N = var_150_17
			end

			local var_150_22 = 0
			local var_150_23 = 11.89
			local var_150_24 = manager.audio:GetVoiceLength("story_v_out_116331", "116331033", "story_v_out_116331.awb") / 1000

			if var_150_24 > 0 and var_150_23 < var_150_24 and var_150_24 + var_150_22 > arg_147_1.duration_ then
				local var_150_25 = var_150_24

				arg_147_1.duration_ = var_150_24 + var_150_22
			end

			if var_150_22 < arg_147_1.time_ and arg_147_1.time_ <= var_150_22 + arg_150_0 then
				local var_150_26 = "play"
				local var_150_27 = "voice"

				arg_147_1:AudioAction(var_150_26, var_150_27, "story_v_out_116331", "116331033", "story_v_out_116331.awb")
			end

			local var_150_28 = 0

			if var_150_28 < arg_147_1.time_ and arg_147_1.time_ <= var_150_28 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			local var_150_29 = 2.6

			if arg_147_1.time_ >= var_150_28 + var_150_29 and arg_147_1.time_ < var_150_28 + var_150_29 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play116331034 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 116331034
		arg_151_1.duration_ = 3.06

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play116331035(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.var_.oldValueTypewriter = arg_151_1.fswtw_.percent

				SetActive(arg_151_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_151_1:ShowNextGo(false)
			end

			local var_154_1 = 0
			local var_154_2 = -8.13333333333333
			local var_154_3 = arg_151_1:GetWordFromCfg(116331029)
			local var_154_4 = arg_151_1:FormatText(var_154_3.content)
			local var_154_5, var_154_6 = arg_151_1:GetPercentByPara(var_154_4, 2)

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				local var_154_7 = var_154_1 <= 0 and var_154_2 or var_154_2 * ((var_154_6 - arg_151_1.typewritterCharCountI18N) / var_154_1)

				if var_154_7 > 0 and var_154_2 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end
			end

			local var_154_8 = -8.13333333333333
			local var_154_9 = math.max(var_154_8, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_9 then
				local var_154_10 = (arg_151_1.time_ - var_154_0) / var_154_9

				arg_151_1.fswtw_.percent = Mathf.Lerp(arg_151_1.var_.oldValueTypewriter, var_154_5, var_154_10)
				arg_151_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_151_1.fswtw_:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_9 and arg_151_1.time_ < var_154_0 + var_154_9 + arg_154_0 then
				arg_151_1.fswtw_.percent = var_154_5

				arg_151_1.fswtw_:SetDirty()
				arg_151_1:ShowNextGo(true)

				arg_151_1.typewritterCharCountI18N = var_154_6
			end

			local var_154_11 = 0

			if var_154_11 < arg_151_1.time_ and arg_151_1.time_ <= var_154_11 + arg_154_0 then
				arg_151_1.var_.oldValueTypewriter = arg_151_1.fswtw_.percent

				SetActive(arg_151_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_151_1:ShowNextGo(false)
			end

			local var_154_12 = 21
			local var_154_13 = 1.05
			local var_154_14 = arg_151_1:GetWordFromCfg(116331029)
			local var_154_15 = arg_151_1:FormatText(var_154_14.content)
			local var_154_16, var_154_17 = arg_151_1:GetPercentByPara(var_154_15, 6)

			if var_154_11 < arg_151_1.time_ and arg_151_1.time_ <= var_154_11 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				local var_154_18 = var_154_12 <= 0 and var_154_13 or var_154_13 * ((var_154_17 - arg_151_1.typewritterCharCountI18N) / var_154_12)

				if var_154_18 > 0 and var_154_13 < var_154_18 then
					arg_151_1.talkMaxDuration = var_154_18

					if var_154_18 + var_154_11 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_18 + var_154_11
					end
				end
			end

			local var_154_19 = 1.05
			local var_154_20 = math.max(var_154_19, arg_151_1.talkMaxDuration)

			if var_154_11 <= arg_151_1.time_ and arg_151_1.time_ < var_154_11 + var_154_20 then
				local var_154_21 = (arg_151_1.time_ - var_154_11) / var_154_20

				arg_151_1.fswtw_.percent = Mathf.Lerp(arg_151_1.var_.oldValueTypewriter, var_154_16, var_154_21)
				arg_151_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_151_1.fswtw_:SetDirty()
			end

			if arg_151_1.time_ >= var_154_11 + var_154_20 and arg_151_1.time_ < var_154_11 + var_154_20 + arg_154_0 then
				arg_151_1.fswtw_.percent = var_154_16

				arg_151_1.fswtw_:SetDirty()
				arg_151_1:ShowNextGo(true)

				arg_151_1.typewritterCharCountI18N = var_154_17
			end

			local var_154_22 = 0
			local var_154_23 = 3.059
			local var_154_24 = manager.audio:GetVoiceLength("story_v_out_116331", "116331034", "story_v_out_116331.awb") / 1000

			if var_154_24 > 0 and var_154_23 < var_154_24 and var_154_24 + var_154_22 > arg_151_1.duration_ then
				local var_154_25 = var_154_24

				arg_151_1.duration_ = var_154_24 + var_154_22
			end

			if var_154_22 < arg_151_1.time_ and arg_151_1.time_ <= var_154_22 + arg_154_0 then
				local var_154_26 = "play"
				local var_154_27 = "voice"

				arg_151_1:AudioAction(var_154_26, var_154_27, "story_v_out_116331", "116331034", "story_v_out_116331.awb")
			end

			local var_154_28 = 0

			if var_154_28 < arg_151_1.time_ and arg_151_1.time_ <= var_154_28 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			local var_154_29 = 1.05

			if arg_151_1.time_ >= var_154_28 + var_154_29 and arg_151_1.time_ < var_154_28 + var_154_29 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play116331035 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 116331035
		arg_155_1.duration_ = 4.57

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play116331036(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.fswbg_:SetActive(true)
				arg_155_1.dialog_:SetActive(false)

				arg_155_1.fswtw_.percent = 0

				local var_158_1 = arg_155_1:GetWordFromCfg(116331035)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.fswt_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.fswt_)

				arg_155_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_155_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_155_1.fswtw_:SetDirty()

				arg_155_1.typewritterCharCountI18N = 0

				SetActive(arg_155_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_155_1:ShowNextGo(false)
			end

			local var_158_3 = 0.0166666666666667

			if var_158_3 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.var_.oldValueTypewriter = arg_155_1.fswtw_.percent

				SetActive(arg_155_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_155_1:ShowNextGo(false)
			end

			local var_158_4 = 22
			local var_158_5 = 1.46666666666667
			local var_158_6 = arg_155_1:GetWordFromCfg(116331035)
			local var_158_7 = arg_155_1:FormatText(var_158_6.content)
			local var_158_8, var_158_9 = arg_155_1:GetPercentByPara(var_158_7, 1)

			if var_158_3 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				local var_158_10 = var_158_4 <= 0 and var_158_5 or var_158_5 * ((var_158_9 - arg_155_1.typewritterCharCountI18N) / var_158_4)

				if var_158_10 > 0 and var_158_5 < var_158_10 then
					arg_155_1.talkMaxDuration = var_158_10

					if var_158_10 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_3
					end
				end
			end

			local var_158_11 = 1.46666666666667
			local var_158_12 = math.max(var_158_11, arg_155_1.talkMaxDuration)

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_12 then
				local var_158_13 = (arg_155_1.time_ - var_158_3) / var_158_12

				arg_155_1.fswtw_.percent = Mathf.Lerp(arg_155_1.var_.oldValueTypewriter, var_158_8, var_158_13)
				arg_155_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_155_1.fswtw_:SetDirty()
			end

			if arg_155_1.time_ >= var_158_3 + var_158_12 and arg_155_1.time_ < var_158_3 + var_158_12 + arg_158_0 then
				arg_155_1.fswtw_.percent = var_158_8

				arg_155_1.fswtw_:SetDirty()
				arg_155_1:ShowNextGo(true)

				arg_155_1.typewritterCharCountI18N = var_158_9
			end

			local var_158_14 = 0
			local var_158_15 = 4.567
			local var_158_16 = manager.audio:GetVoiceLength("story_v_out_116331", "116331035", "story_v_out_116331.awb") / 1000

			if var_158_16 > 0 and var_158_15 < var_158_16 and var_158_16 + var_158_14 > arg_155_1.duration_ then
				local var_158_17 = var_158_16

				arg_155_1.duration_ = var_158_16 + var_158_14
			end

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				local var_158_18 = "play"
				local var_158_19 = "voice"

				arg_155_1:AudioAction(var_158_18, var_158_19, "story_v_out_116331", "116331035", "story_v_out_116331.awb")
			end

			local var_158_20 = 0

			if var_158_20 < arg_155_1.time_ and arg_155_1.time_ <= var_158_20 + arg_158_0 then
				arg_155_1.allBtn_.enabled = false
			end

			local var_158_21 = 1.48333333333333

			if arg_155_1.time_ >= var_158_20 + var_158_21 and arg_155_1.time_ < var_158_20 + var_158_21 + arg_158_0 then
				arg_155_1.allBtn_.enabled = true
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play116331036 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 116331036
		arg_159_1.duration_ = 1.18

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play116331037(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.var_.oldValueTypewriter = arg_159_1.fswtw_.percent

				SetActive(arg_159_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_159_1:ShowNextGo(false)
			end

			local var_162_1 = 11
			local var_162_2 = 0.733333333333333
			local var_162_3 = arg_159_1:GetWordFromCfg(116331035)
			local var_162_4 = arg_159_1:FormatText(var_162_3.content)
			local var_162_5, var_162_6 = arg_159_1:GetPercentByPara(var_162_4, 2)

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				local var_162_7 = var_162_1 <= 0 and var_162_2 or var_162_2 * ((var_162_6 - arg_159_1.typewritterCharCountI18N) / var_162_1)

				if var_162_7 > 0 and var_162_2 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end
			end

			local var_162_8 = 0.733333333333333
			local var_162_9 = math.max(var_162_8, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_9 then
				local var_162_10 = (arg_159_1.time_ - var_162_0) / var_162_9

				arg_159_1.fswtw_.percent = Mathf.Lerp(arg_159_1.var_.oldValueTypewriter, var_162_5, var_162_10)
				arg_159_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_159_1.fswtw_:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_9 and arg_159_1.time_ < var_162_0 + var_162_9 + arg_162_0 then
				arg_159_1.fswtw_.percent = var_162_5

				arg_159_1.fswtw_:SetDirty()
				arg_159_1:ShowNextGo(true)

				arg_159_1.typewritterCharCountI18N = var_162_6
			end

			local var_162_11 = 0
			local var_162_12 = 1.176
			local var_162_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331036", "story_v_out_116331.awb") / 1000

			if var_162_13 > 0 and var_162_12 < var_162_13 and var_162_13 + var_162_11 > arg_159_1.duration_ then
				local var_162_14 = var_162_13

				arg_159_1.duration_ = var_162_13 + var_162_11
			end

			if var_162_11 < arg_159_1.time_ and arg_159_1.time_ <= var_162_11 + arg_162_0 then
				local var_162_15 = "play"
				local var_162_16 = "voice"

				arg_159_1:AudioAction(var_162_15, var_162_16, "story_v_out_116331", "116331036", "story_v_out_116331.awb")
			end

			local var_162_17 = 0

			if var_162_17 < arg_159_1.time_ and arg_159_1.time_ <= var_162_17 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			local var_162_18 = 0.733333333333333

			if arg_159_1.time_ >= var_162_17 + var_162_18 and arg_159_1.time_ < var_162_17 + var_162_18 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play116331037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 116331037
		arg_163_1.duration_ = 3.89

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play116331038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.var_.oldValueTypewriter = arg_163_1.fswtw_.percent

				SetActive(arg_163_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_163_1:ShowNextGo(false)
			end

			local var_166_1 = 30
			local var_166_2 = 2
			local var_166_3 = arg_163_1:GetWordFromCfg(116331035)
			local var_166_4 = arg_163_1:FormatText(var_166_3.content)
			local var_166_5, var_166_6 = arg_163_1:GetPercentByPara(var_166_4, 3)

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				local var_166_7 = var_166_1 <= 0 and var_166_2 or var_166_2 * ((var_166_6 - arg_163_1.typewritterCharCountI18N) / var_166_1)

				if var_166_7 > 0 and var_166_2 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end
			end

			local var_166_8 = 2
			local var_166_9 = math.max(var_166_8, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_9 then
				local var_166_10 = (arg_163_1.time_ - var_166_0) / var_166_9

				arg_163_1.fswtw_.percent = Mathf.Lerp(arg_163_1.var_.oldValueTypewriter, var_166_5, var_166_10)
				arg_163_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_163_1.fswtw_:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_9 and arg_163_1.time_ < var_166_0 + var_166_9 + arg_166_0 then
				arg_163_1.fswtw_.percent = var_166_5

				arg_163_1.fswtw_:SetDirty()
				arg_163_1:ShowNextGo(true)

				arg_163_1.typewritterCharCountI18N = var_166_6
			end

			local var_166_11 = 0
			local var_166_12 = 3.893
			local var_166_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331037", "story_v_out_116331.awb") / 1000

			if var_166_13 > 0 and var_166_12 < var_166_13 and var_166_13 + var_166_11 > arg_163_1.duration_ then
				local var_166_14 = var_166_13

				arg_163_1.duration_ = var_166_13 + var_166_11
			end

			if var_166_11 < arg_163_1.time_ and arg_163_1.time_ <= var_166_11 + arg_166_0 then
				local var_166_15 = "play"
				local var_166_16 = "voice"

				arg_163_1:AudioAction(var_166_15, var_166_16, "story_v_out_116331", "116331037", "story_v_out_116331.awb")
			end

			local var_166_17 = 0

			if var_166_17 < arg_163_1.time_ and arg_163_1.time_ <= var_166_17 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			local var_166_18 = 2

			if arg_163_1.time_ >= var_166_17 + var_166_18 and arg_163_1.time_ < var_166_17 + var_166_18 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play116331038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 116331038
		arg_167_1.duration_ = 6.07

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play116331039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.var_.oldValueTypewriter = arg_167_1.fswtw_.percent

				SetActive(arg_167_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_167_1:ShowNextGo(false)
			end

			local var_170_1 = 29
			local var_170_2 = 1.93333333333333
			local var_170_3 = arg_167_1:GetWordFromCfg(116331035)
			local var_170_4 = arg_167_1:FormatText(var_170_3.content)
			local var_170_5, var_170_6 = arg_167_1:GetPercentByPara(var_170_4, 4)

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				local var_170_7 = var_170_1 <= 0 and var_170_2 or var_170_2 * ((var_170_6 - arg_167_1.typewritterCharCountI18N) / var_170_1)

				if var_170_7 > 0 and var_170_2 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end
			end

			local var_170_8 = 1.93333333333333
			local var_170_9 = math.max(var_170_8, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_9 then
				local var_170_10 = (arg_167_1.time_ - var_170_0) / var_170_9

				arg_167_1.fswtw_.percent = Mathf.Lerp(arg_167_1.var_.oldValueTypewriter, var_170_5, var_170_10)
				arg_167_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_167_1.fswtw_:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_9 and arg_167_1.time_ < var_170_0 + var_170_9 + arg_170_0 then
				arg_167_1.fswtw_.percent = var_170_5

				arg_167_1.fswtw_:SetDirty()
				arg_167_1:ShowNextGo(true)

				arg_167_1.typewritterCharCountI18N = var_170_6
			end

			local var_170_11 = 0
			local var_170_12 = 6.072
			local var_170_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331038", "story_v_out_116331.awb") / 1000

			if var_170_13 > 0 and var_170_12 < var_170_13 and var_170_13 + var_170_11 > arg_167_1.duration_ then
				local var_170_14 = var_170_13

				arg_167_1.duration_ = var_170_13 + var_170_11
			end

			if var_170_11 < arg_167_1.time_ and arg_167_1.time_ <= var_170_11 + arg_170_0 then
				local var_170_15 = "play"
				local var_170_16 = "voice"

				arg_167_1:AudioAction(var_170_15, var_170_16, "story_v_out_116331", "116331038", "story_v_out_116331.awb")
			end

			local var_170_17 = 0

			if var_170_17 < arg_167_1.time_ and arg_167_1.time_ <= var_170_17 + arg_170_0 then
				arg_167_1.allBtn_.enabled = false
			end

			local var_170_18 = 1.93333333333333

			if arg_167_1.time_ >= var_170_17 + var_170_18 and arg_167_1.time_ < var_170_17 + var_170_18 + arg_170_0 then
				arg_167_1.allBtn_.enabled = true
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play116331039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 116331039
		arg_171_1.duration_ = 6.24

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play116331040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.var_.oldValueTypewriter = arg_171_1.fswtw_.percent

				SetActive(arg_171_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_171_1:ShowNextGo(false)
			end

			local var_174_1 = 29
			local var_174_2 = 1.93333333333333
			local var_174_3 = arg_171_1:GetWordFromCfg(116331035)
			local var_174_4 = arg_171_1:FormatText(var_174_3.content)
			local var_174_5, var_174_6 = arg_171_1:GetPercentByPara(var_174_4, 5)

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				local var_174_7 = var_174_1 <= 0 and var_174_2 or var_174_2 * ((var_174_6 - arg_171_1.typewritterCharCountI18N) / var_174_1)

				if var_174_7 > 0 and var_174_2 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end
			end

			local var_174_8 = 1.93333333333333
			local var_174_9 = math.max(var_174_8, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_9 then
				local var_174_10 = (arg_171_1.time_ - var_174_0) / var_174_9

				arg_171_1.fswtw_.percent = Mathf.Lerp(arg_171_1.var_.oldValueTypewriter, var_174_5, var_174_10)
				arg_171_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_171_1.fswtw_:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_9 and arg_171_1.time_ < var_174_0 + var_174_9 + arg_174_0 then
				arg_171_1.fswtw_.percent = var_174_5

				arg_171_1.fswtw_:SetDirty()
				arg_171_1:ShowNextGo(true)

				arg_171_1.typewritterCharCountI18N = var_174_6
			end

			local var_174_11 = 0
			local var_174_12 = 6.24
			local var_174_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331039", "story_v_out_116331.awb") / 1000

			if var_174_13 > 0 and var_174_12 < var_174_13 and var_174_13 + var_174_11 > arg_171_1.duration_ then
				local var_174_14 = var_174_13

				arg_171_1.duration_ = var_174_13 + var_174_11
			end

			if var_174_11 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				local var_174_15 = "play"
				local var_174_16 = "voice"

				arg_171_1:AudioAction(var_174_15, var_174_16, "story_v_out_116331", "116331039", "story_v_out_116331.awb")
			end

			local var_174_17 = 0

			if var_174_17 < arg_171_1.time_ and arg_171_1.time_ <= var_174_17 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			local var_174_18 = 1.93333333333333

			if arg_171_1.time_ >= var_174_17 + var_174_18 and arg_171_1.time_ < var_174_17 + var_174_18 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play116331040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 116331040
		arg_175_1.duration_ = 14.15

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play116331041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.var_.oldValueTypewriter = arg_175_1.fswtw_.percent

				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_175_1:ShowNextGo(false)
			end

			local var_178_1 = 60
			local var_178_2 = 4
			local var_178_3 = arg_175_1:GetWordFromCfg(116331035)
			local var_178_4 = arg_175_1:FormatText(var_178_3.content)
			local var_178_5, var_178_6 = arg_175_1:GetPercentByPara(var_178_4, 6)

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				local var_178_7 = var_178_1 <= 0 and var_178_2 or var_178_2 * ((var_178_6 - arg_175_1.typewritterCharCountI18N) / var_178_1)

				if var_178_7 > 0 and var_178_2 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end
			end

			local var_178_8 = 4
			local var_178_9 = math.max(var_178_8, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_9 then
				local var_178_10 = (arg_175_1.time_ - var_178_0) / var_178_9

				arg_175_1.fswtw_.percent = Mathf.Lerp(arg_175_1.var_.oldValueTypewriter, var_178_5, var_178_10)
				arg_175_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_175_1.fswtw_:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_9 and arg_175_1.time_ < var_178_0 + var_178_9 + arg_178_0 then
				arg_175_1.fswtw_.percent = var_178_5

				arg_175_1.fswtw_:SetDirty()
				arg_175_1:ShowNextGo(true)

				arg_175_1.typewritterCharCountI18N = var_178_6
			end

			local var_178_11 = 0
			local var_178_12 = 14.153
			local var_178_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331040", "story_v_out_116331.awb") / 1000

			if var_178_13 > 0 and var_178_12 < var_178_13 and var_178_13 + var_178_11 > arg_175_1.duration_ then
				local var_178_14 = var_178_13

				arg_175_1.duration_ = var_178_13 + var_178_11
			end

			if var_178_11 < arg_175_1.time_ and arg_175_1.time_ <= var_178_11 + arg_178_0 then
				local var_178_15 = "play"
				local var_178_16 = "voice"

				arg_175_1:AudioAction(var_178_15, var_178_16, "story_v_out_116331", "116331040", "story_v_out_116331.awb")
			end

			local var_178_17 = 0

			if var_178_17 < arg_175_1.time_ and arg_175_1.time_ <= var_178_17 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_18 = 4

			if arg_175_1.time_ >= var_178_17 + var_178_18 and arg_175_1.time_ < var_178_17 + var_178_18 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play116331041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 116331041
		arg_179_1.duration_ = 6.59

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play116331042(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.var_.oldValueTypewriter = arg_179_1.fswtw_.percent

				SetActive(arg_179_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_179_1:ShowNextGo(false)
			end

			local var_182_1 = 31
			local var_182_2 = 2.06666666666667
			local var_182_3 = arg_179_1:GetWordFromCfg(116331035)
			local var_182_4 = arg_179_1:FormatText(var_182_3.content)
			local var_182_5, var_182_6 = arg_179_1:GetPercentByPara(var_182_4, 7)

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				local var_182_7 = var_182_1 <= 0 and var_182_2 or var_182_2 * ((var_182_6 - arg_179_1.typewritterCharCountI18N) / var_182_1)

				if var_182_7 > 0 and var_182_2 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end
			end

			local var_182_8 = 2.06666666666667
			local var_182_9 = math.max(var_182_8, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_9 then
				local var_182_10 = (arg_179_1.time_ - var_182_0) / var_182_9

				arg_179_1.fswtw_.percent = Mathf.Lerp(arg_179_1.var_.oldValueTypewriter, var_182_5, var_182_10)
				arg_179_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_179_1.fswtw_:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_9 and arg_179_1.time_ < var_182_0 + var_182_9 + arg_182_0 then
				arg_179_1.fswtw_.percent = var_182_5

				arg_179_1.fswtw_:SetDirty()
				arg_179_1:ShowNextGo(true)

				arg_179_1.typewritterCharCountI18N = var_182_6
			end

			local var_182_11 = 0
			local var_182_12 = 6.594
			local var_182_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331041", "story_v_out_116331.awb") / 1000

			if var_182_13 > 0 and var_182_12 < var_182_13 and var_182_13 + var_182_11 > arg_179_1.duration_ then
				local var_182_14 = var_182_13

				arg_179_1.duration_ = var_182_13 + var_182_11
			end

			if var_182_11 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				local var_182_15 = "play"
				local var_182_16 = "voice"

				arg_179_1:AudioAction(var_182_15, var_182_16, "story_v_out_116331", "116331041", "story_v_out_116331.awb")
			end

			local var_182_17 = 0

			if var_182_17 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.allBtn_.enabled = false
			end

			local var_182_18 = 2.06666666666667

			if arg_179_1.time_ >= var_182_17 + var_182_18 and arg_179_1.time_ < var_182_17 + var_182_18 + arg_182_0 then
				arg_179_1.allBtn_.enabled = true
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play116331042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 116331042
		arg_183_1.duration_ = 2.97

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play116331043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.fswbg_:SetActive(true)
				arg_183_1.dialog_:SetActive(false)

				arg_183_1.fswtw_.percent = 0

				local var_186_1 = arg_183_1:GetWordFromCfg(116331042)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.fswt_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.fswt_)

				arg_183_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_183_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_183_1.fswtw_:SetDirty()

				arg_183_1.typewritterCharCountI18N = 0

				SetActive(arg_183_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_183_1:ShowNextGo(false)
			end

			local var_186_3 = 0.0166666666666667

			if var_186_3 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.var_.oldValueTypewriter = arg_183_1.fswtw_.percent

				SetActive(arg_183_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_183_1:ShowNextGo(false)
			end

			local var_186_4 = 14
			local var_186_5 = 0.933333333333333
			local var_186_6 = arg_183_1:GetWordFromCfg(116331042)
			local var_186_7 = arg_183_1:FormatText(var_186_6.content)
			local var_186_8, var_186_9 = arg_183_1:GetPercentByPara(var_186_7, 1)

			if var_186_3 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				local var_186_10 = var_186_4 <= 0 and var_186_5 or var_186_5 * ((var_186_9 - arg_183_1.typewritterCharCountI18N) / var_186_4)

				if var_186_10 > 0 and var_186_5 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10

					if var_186_10 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_3
					end
				end
			end

			local var_186_11 = 0.933333333333333
			local var_186_12 = math.max(var_186_11, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_12 then
				local var_186_13 = (arg_183_1.time_ - var_186_3) / var_186_12

				arg_183_1.fswtw_.percent = Mathf.Lerp(arg_183_1.var_.oldValueTypewriter, var_186_8, var_186_13)
				arg_183_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_183_1.fswtw_:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_12 and arg_183_1.time_ < var_186_3 + var_186_12 + arg_186_0 then
				arg_183_1.fswtw_.percent = var_186_8

				arg_183_1.fswtw_:SetDirty()
				arg_183_1:ShowNextGo(true)

				arg_183_1.typewritterCharCountI18N = var_186_9
			end

			local var_186_14 = 0
			local var_186_15 = 2.969
			local var_186_16 = manager.audio:GetVoiceLength("story_v_out_116331", "116331042", "story_v_out_116331.awb") / 1000

			if var_186_16 > 0 and var_186_15 < var_186_16 and var_186_16 + var_186_14 > arg_183_1.duration_ then
				local var_186_17 = var_186_16

				arg_183_1.duration_ = var_186_16 + var_186_14
			end

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				local var_186_18 = "play"
				local var_186_19 = "voice"

				arg_183_1:AudioAction(var_186_18, var_186_19, "story_v_out_116331", "116331042", "story_v_out_116331.awb")
			end

			local var_186_20 = 0

			if var_186_20 < arg_183_1.time_ and arg_183_1.time_ <= var_186_20 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			local var_186_21 = 0.95

			if arg_183_1.time_ >= var_186_20 + var_186_21 and arg_183_1.time_ < var_186_20 + var_186_21 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play116331043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 116331043
		arg_187_1.duration_ = 2.53

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play116331044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.var_.oldValueTypewriter = arg_187_1.fswtw_.percent

				SetActive(arg_187_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_187_1:ShowNextGo(false)
			end

			local var_190_1 = 19
			local var_190_2 = 1.26666666666667
			local var_190_3 = arg_187_1:GetWordFromCfg(116331042)
			local var_190_4 = arg_187_1:FormatText(var_190_3.content)
			local var_190_5, var_190_6 = arg_187_1:GetPercentByPara(var_190_4, 2)

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				local var_190_7 = var_190_1 <= 0 and var_190_2 or var_190_2 * ((var_190_6 - arg_187_1.typewritterCharCountI18N) / var_190_1)

				if var_190_7 > 0 and var_190_2 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end
			end

			local var_190_8 = 1.26666666666667
			local var_190_9 = math.max(var_190_8, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_9 then
				local var_190_10 = (arg_187_1.time_ - var_190_0) / var_190_9

				arg_187_1.fswtw_.percent = Mathf.Lerp(arg_187_1.var_.oldValueTypewriter, var_190_5, var_190_10)
				arg_187_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_187_1.fswtw_:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_9 and arg_187_1.time_ < var_190_0 + var_190_9 + arg_190_0 then
				arg_187_1.fswtw_.percent = var_190_5

				arg_187_1.fswtw_:SetDirty()
				arg_187_1:ShowNextGo(true)

				arg_187_1.typewritterCharCountI18N = var_190_6
			end

			local var_190_11 = 0
			local var_190_12 = 2.534
			local var_190_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331043", "story_v_out_116331.awb") / 1000

			if var_190_13 > 0 and var_190_12 < var_190_13 and var_190_13 + var_190_11 > arg_187_1.duration_ then
				local var_190_14 = var_190_13

				arg_187_1.duration_ = var_190_13 + var_190_11
			end

			if var_190_11 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				local var_190_15 = "play"
				local var_190_16 = "voice"

				arg_187_1:AudioAction(var_190_15, var_190_16, "story_v_out_116331", "116331043", "story_v_out_116331.awb")
			end

			local var_190_17 = 0

			if var_190_17 < arg_187_1.time_ and arg_187_1.time_ <= var_190_17 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_18 = 1.26666666666667

			if arg_187_1.time_ >= var_190_17 + var_190_18 and arg_187_1.time_ < var_190_17 + var_190_18 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play116331044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 116331044
		arg_191_1.duration_ = 2

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play116331045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.var_.oldValueTypewriter = arg_191_1.fswtw_.percent

				SetActive(arg_191_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_191_1:ShowNextGo(false)
			end

			local var_194_1 = 17
			local var_194_2 = 1.13333333333333
			local var_194_3 = arg_191_1:GetWordFromCfg(116331042)
			local var_194_4 = arg_191_1:FormatText(var_194_3.content)
			local var_194_5, var_194_6 = arg_191_1:GetPercentByPara(var_194_4, 3)

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				local var_194_7 = var_194_1 <= 0 and var_194_2 or var_194_2 * ((var_194_6 - arg_191_1.typewritterCharCountI18N) / var_194_1)

				if var_194_7 > 0 and var_194_2 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end
			end

			local var_194_8 = 1.13333333333333
			local var_194_9 = math.max(var_194_8, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_9 then
				local var_194_10 = (arg_191_1.time_ - var_194_0) / var_194_9

				arg_191_1.fswtw_.percent = Mathf.Lerp(arg_191_1.var_.oldValueTypewriter, var_194_5, var_194_10)
				arg_191_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_191_1.fswtw_:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_9 and arg_191_1.time_ < var_194_0 + var_194_9 + arg_194_0 then
				arg_191_1.fswtw_.percent = var_194_5

				arg_191_1.fswtw_:SetDirty()
				arg_191_1:ShowNextGo(true)

				arg_191_1.typewritterCharCountI18N = var_194_6
			end

			local var_194_11 = 0
			local var_194_12 = 2.003
			local var_194_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331044", "story_v_out_116331.awb") / 1000

			if var_194_13 > 0 and var_194_12 < var_194_13 and var_194_13 + var_194_11 > arg_191_1.duration_ then
				local var_194_14 = var_194_13

				arg_191_1.duration_ = var_194_13 + var_194_11
			end

			if var_194_11 < arg_191_1.time_ and arg_191_1.time_ <= var_194_11 + arg_194_0 then
				local var_194_15 = "play"
				local var_194_16 = "voice"

				arg_191_1:AudioAction(var_194_15, var_194_16, "story_v_out_116331", "116331044", "story_v_out_116331.awb")
			end

			local var_194_17 = 0

			if var_194_17 < arg_191_1.time_ and arg_191_1.time_ <= var_194_17 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			local var_194_18 = 1.13333333333333

			if arg_191_1.time_ >= var_194_17 + var_194_18 and arg_191_1.time_ < var_194_17 + var_194_18 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play116331045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 116331045
		arg_195_1.duration_ = 6.9

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play116331046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.var_.oldValueTypewriter = arg_195_1.fswtw_.percent

				SetActive(arg_195_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_195_1:ShowNextGo(false)
			end

			local var_198_1 = 33
			local var_198_2 = 2.2
			local var_198_3 = arg_195_1:GetWordFromCfg(116331042)
			local var_198_4 = arg_195_1:FormatText(var_198_3.content)
			local var_198_5, var_198_6 = arg_195_1:GetPercentByPara(var_198_4, 4)

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				local var_198_7 = var_198_1 <= 0 and var_198_2 or var_198_2 * ((var_198_6 - arg_195_1.typewritterCharCountI18N) / var_198_1)

				if var_198_7 > 0 and var_198_2 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end
			end

			local var_198_8 = 2.2
			local var_198_9 = math.max(var_198_8, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_9 then
				local var_198_10 = (arg_195_1.time_ - var_198_0) / var_198_9

				arg_195_1.fswtw_.percent = Mathf.Lerp(arg_195_1.var_.oldValueTypewriter, var_198_5, var_198_10)
				arg_195_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_195_1.fswtw_:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_9 and arg_195_1.time_ < var_198_0 + var_198_9 + arg_198_0 then
				arg_195_1.fswtw_.percent = var_198_5

				arg_195_1.fswtw_:SetDirty()
				arg_195_1:ShowNextGo(true)

				arg_195_1.typewritterCharCountI18N = var_198_6
			end

			local var_198_11 = 0
			local var_198_12 = 6.898
			local var_198_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331045", "story_v_out_116331.awb") / 1000

			if var_198_13 > 0 and var_198_12 < var_198_13 and var_198_13 + var_198_11 > arg_195_1.duration_ then
				local var_198_14 = var_198_13

				arg_195_1.duration_ = var_198_13 + var_198_11
			end

			if var_198_11 < arg_195_1.time_ and arg_195_1.time_ <= var_198_11 + arg_198_0 then
				local var_198_15 = "play"
				local var_198_16 = "voice"

				arg_195_1:AudioAction(var_198_15, var_198_16, "story_v_out_116331", "116331045", "story_v_out_116331.awb")
			end

			local var_198_17 = 0

			if var_198_17 < arg_195_1.time_ and arg_195_1.time_ <= var_198_17 + arg_198_0 then
				arg_195_1.allBtn_.enabled = false
			end

			local var_198_18 = 2.2

			if arg_195_1.time_ >= var_198_17 + var_198_18 and arg_195_1.time_ < var_198_17 + var_198_18 + arg_198_0 then
				arg_195_1.allBtn_.enabled = true
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play116331046 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 116331046
		arg_199_1.duration_ = 4.76

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play116331047(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.var_.oldValueTypewriter = arg_199_1.fswtw_.percent

				SetActive(arg_199_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_199_1:ShowNextGo(false)
			end

			local var_202_1 = 30
			local var_202_2 = 2
			local var_202_3 = arg_199_1:GetWordFromCfg(116331042)
			local var_202_4 = arg_199_1:FormatText(var_202_3.content)
			local var_202_5, var_202_6 = arg_199_1:GetPercentByPara(var_202_4, 5)

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				local var_202_7 = var_202_1 <= 0 and var_202_2 or var_202_2 * ((var_202_6 - arg_199_1.typewritterCharCountI18N) / var_202_1)

				if var_202_7 > 0 and var_202_2 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end
			end

			local var_202_8 = 2
			local var_202_9 = math.max(var_202_8, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_9 then
				local var_202_10 = (arg_199_1.time_ - var_202_0) / var_202_9

				arg_199_1.fswtw_.percent = Mathf.Lerp(arg_199_1.var_.oldValueTypewriter, var_202_5, var_202_10)
				arg_199_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_199_1.fswtw_:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_9 and arg_199_1.time_ < var_202_0 + var_202_9 + arg_202_0 then
				arg_199_1.fswtw_.percent = var_202_5

				arg_199_1.fswtw_:SetDirty()
				arg_199_1:ShowNextGo(true)

				arg_199_1.typewritterCharCountI18N = var_202_6
			end

			local var_202_11 = 0
			local var_202_12 = 4.763
			local var_202_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331046", "story_v_out_116331.awb") / 1000

			if var_202_13 > 0 and var_202_12 < var_202_13 and var_202_13 + var_202_11 > arg_199_1.duration_ then
				local var_202_14 = var_202_13

				arg_199_1.duration_ = var_202_13 + var_202_11
			end

			if var_202_11 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 then
				local var_202_15 = "play"
				local var_202_16 = "voice"

				arg_199_1:AudioAction(var_202_15, var_202_16, "story_v_out_116331", "116331046", "story_v_out_116331.awb")
			end

			local var_202_17 = 0

			if var_202_17 < arg_199_1.time_ and arg_199_1.time_ <= var_202_17 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			local var_202_18 = 2

			if arg_199_1.time_ >= var_202_17 + var_202_18 and arg_199_1.time_ < var_202_17 + var_202_18 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play116331047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 116331047
		arg_203_1.duration_ = 3.6

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play116331048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.var_.oldValueTypewriter = arg_203_1.fswtw_.percent

				SetActive(arg_203_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_203_1:ShowNextGo(false)
			end

			local var_206_1 = 12
			local var_206_2 = 0.8
			local var_206_3 = arg_203_1:GetWordFromCfg(116331042)
			local var_206_4 = arg_203_1:FormatText(var_206_3.content)
			local var_206_5, var_206_6 = arg_203_1:GetPercentByPara(var_206_4, 6)

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				local var_206_7 = var_206_1 <= 0 and var_206_2 or var_206_2 * ((var_206_6 - arg_203_1.typewritterCharCountI18N) / var_206_1)

				if var_206_7 > 0 and var_206_2 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end
			end

			local var_206_8 = 0.8
			local var_206_9 = math.max(var_206_8, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_9 then
				local var_206_10 = (arg_203_1.time_ - var_206_0) / var_206_9

				arg_203_1.fswtw_.percent = Mathf.Lerp(arg_203_1.var_.oldValueTypewriter, var_206_5, var_206_10)
				arg_203_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_203_1.fswtw_:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_9 and arg_203_1.time_ < var_206_0 + var_206_9 + arg_206_0 then
				arg_203_1.fswtw_.percent = var_206_5

				arg_203_1.fswtw_:SetDirty()
				arg_203_1:ShowNextGo(true)

				arg_203_1.typewritterCharCountI18N = var_206_6
			end

			local var_206_11 = 0
			local var_206_12 = 3.599
			local var_206_13 = manager.audio:GetVoiceLength("story_v_out_116331", "116331047", "story_v_out_116331.awb") / 1000

			if var_206_13 > 0 and var_206_12 < var_206_13 and var_206_13 + var_206_11 > arg_203_1.duration_ then
				local var_206_14 = var_206_13

				arg_203_1.duration_ = var_206_13 + var_206_11
			end

			if var_206_11 < arg_203_1.time_ and arg_203_1.time_ <= var_206_11 + arg_206_0 then
				local var_206_15 = "play"
				local var_206_16 = "voice"

				arg_203_1:AudioAction(var_206_15, var_206_16, "story_v_out_116331", "116331047", "story_v_out_116331.awb")
			end

			local var_206_17 = 0

			if var_206_17 < arg_203_1.time_ and arg_203_1.time_ <= var_206_17 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			local var_206_18 = 0.8

			if arg_203_1.time_ >= var_206_17 + var_206_18 and arg_203_1.time_ < var_206_17 + var_206_18 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play116331048 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 116331048
		arg_207_1.duration_ = 9.92

		local var_207_0 = {
			zh = 9.383,
			ja = 9.916
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
				arg_207_0:Play116331049(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = "STblack"

			if arg_207_1.bgs_[var_210_0] == nil then
				local var_210_1 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_210_0)
				var_210_1.name = var_210_0
				var_210_1.transform.parent = arg_207_1.stage_.transform
				var_210_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_[var_210_0] = var_210_1
			end

			local var_210_2 = 2

			if var_210_2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				local var_210_3 = manager.ui.mainCamera.transform.localPosition
				local var_210_4 = Vector3.New(0, 0, 10) + Vector3.New(var_210_3.x, var_210_3.y, 0)
				local var_210_5 = arg_207_1.bgs_.STblack

				var_210_5.transform.localPosition = var_210_4
				var_210_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_6 = var_210_5:GetComponent("SpriteRenderer")

				if var_210_6 and var_210_6.sprite then
					local var_210_7 = (var_210_5.transform.localPosition - var_210_3).z
					local var_210_8 = manager.ui.mainCameraCom_
					local var_210_9 = 2 * var_210_7 * Mathf.Tan(var_210_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_210_10 = var_210_9 * var_210_8.aspect
					local var_210_11 = var_210_6.sprite.bounds.size.x
					local var_210_12 = var_210_6.sprite.bounds.size.y
					local var_210_13 = var_210_10 / var_210_11
					local var_210_14 = var_210_9 / var_210_12
					local var_210_15 = var_210_14 < var_210_13 and var_210_13 or var_210_14

					var_210_5.transform.localScale = Vector3.New(var_210_15, var_210_15, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "STblack" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_16 = 2

			if var_210_16 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(false)
				arg_207_1.dialog_:SetActive(false)
				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_17 = 0

			if var_210_17 < arg_207_1.time_ and arg_207_1.time_ <= var_210_17 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_18 = 2

			if var_210_17 <= arg_207_1.time_ and arg_207_1.time_ < var_210_17 + var_210_18 then
				local var_210_19 = (arg_207_1.time_ - var_210_17) / var_210_18
				local var_210_20 = Color.New(0, 0, 0)

				var_210_20.a = Mathf.Lerp(0, 1, var_210_19)
				arg_207_1.mask_.color = var_210_20
			end

			if arg_207_1.time_ >= var_210_17 + var_210_18 and arg_207_1.time_ < var_210_17 + var_210_18 + arg_210_0 then
				local var_210_21 = Color.New(0, 0, 0)

				var_210_21.a = 1
				arg_207_1.mask_.color = var_210_21
			end

			local var_210_22 = 2

			if var_210_22 < arg_207_1.time_ and arg_207_1.time_ <= var_210_22 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_23 = 2

			if var_210_22 <= arg_207_1.time_ and arg_207_1.time_ < var_210_22 + var_210_23 then
				local var_210_24 = (arg_207_1.time_ - var_210_22) / var_210_23
				local var_210_25 = Color.New(0, 0, 0)

				var_210_25.a = Mathf.Lerp(1, 0, var_210_24)
				arg_207_1.mask_.color = var_210_25
			end

			if arg_207_1.time_ >= var_210_22 + var_210_23 and arg_207_1.time_ < var_210_22 + var_210_23 + arg_210_0 then
				local var_210_26 = Color.New(0, 0, 0)
				local var_210_27 = 0

				arg_207_1.mask_.enabled = false
				var_210_26.a = var_210_27
				arg_207_1.mask_.color = var_210_26
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_28 = 3.55
			local var_210_29 = 0.45

			if var_210_28 < arg_207_1.time_ and arg_207_1.time_ <= var_210_28 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_30 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_30:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_31 = arg_207_1:FormatText(StoryNameCfg[328].name)

				arg_207_1.leftNameTxt_.text = var_210_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_32 = arg_207_1:GetWordFromCfg(116331048)
				local var_210_33 = arg_207_1:FormatText(var_210_32.content)

				arg_207_1.text_.text = var_210_33

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_34 = 18
				local var_210_35 = utf8.len(var_210_33)
				local var_210_36 = var_210_34 <= 0 and var_210_29 or var_210_29 * (var_210_35 / var_210_34)

				if var_210_36 > 0 and var_210_29 < var_210_36 then
					arg_207_1.talkMaxDuration = var_210_36
					var_210_28 = var_210_28 + 0.3

					if var_210_36 + var_210_28 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_36 + var_210_28
					end
				end

				arg_207_1.text_.text = var_210_33
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331048", "story_v_out_116331.awb") ~= 0 then
					local var_210_37 = manager.audio:GetVoiceLength("story_v_out_116331", "116331048", "story_v_out_116331.awb") / 1000

					if var_210_37 + var_210_28 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_37 + var_210_28
					end

					if var_210_32.prefab_name ~= "" and arg_207_1.actors_[var_210_32.prefab_name] ~= nil then
						local var_210_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_32.prefab_name].transform, "story_v_out_116331", "116331048", "story_v_out_116331.awb")

						arg_207_1:RecordAudio("116331048", var_210_38)
						arg_207_1:RecordAudio("116331048", var_210_38)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_116331", "116331048", "story_v_out_116331.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_116331", "116331048", "story_v_out_116331.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_39 = var_210_28 + 0.3
			local var_210_40 = math.max(var_210_29, arg_207_1.talkMaxDuration)

			if var_210_39 <= arg_207_1.time_ and arg_207_1.time_ < var_210_39 + var_210_40 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_39) / var_210_40

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_39 + var_210_40 and arg_207_1.time_ < var_210_39 + var_210_40 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play116331049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 116331049
		arg_213_1.duration_ = 10.2

		local var_213_0 = {
			zh = 10.2,
			ja = 7.866
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
				arg_213_0:Play116331050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.575

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[328].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(116331049)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331049", "story_v_out_116331.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_116331", "116331049", "story_v_out_116331.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_116331", "116331049", "story_v_out_116331.awb")

						arg_213_1:RecordAudio("116331049", var_216_9)
						arg_213_1:RecordAudio("116331049", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_116331", "116331049", "story_v_out_116331.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_116331", "116331049", "story_v_out_116331.awb")
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
	Play116331050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 116331050
		arg_217_1.duration_ = 10

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play116331051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = "ST03a"

			if arg_217_1.bgs_[var_220_0] == nil then
				local var_220_1 = Object.Instantiate(arg_217_1.paintGo_)

				var_220_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_220_0)
				var_220_1.name = var_220_0
				var_220_1.transform.parent = arg_217_1.stage_.transform
				var_220_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.bgs_[var_220_0] = var_220_1
			end

			local var_220_2 = 0

			if var_220_2 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				local var_220_3 = manager.ui.mainCamera.transform.localPosition
				local var_220_4 = Vector3.New(0, 0, 10) + Vector3.New(var_220_3.x, var_220_3.y, 0)
				local var_220_5 = arg_217_1.bgs_.ST03a

				var_220_5.transform.localPosition = var_220_4
				var_220_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_220_6 = var_220_5:GetComponent("SpriteRenderer")

				if var_220_6 and var_220_6.sprite then
					local var_220_7 = (var_220_5.transform.localPosition - var_220_3).z
					local var_220_8 = manager.ui.mainCameraCom_
					local var_220_9 = 2 * var_220_7 * Mathf.Tan(var_220_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_220_10 = var_220_9 * var_220_8.aspect
					local var_220_11 = var_220_6.sprite.bounds.size.x
					local var_220_12 = var_220_6.sprite.bounds.size.y
					local var_220_13 = var_220_10 / var_220_11
					local var_220_14 = var_220_9 / var_220_12
					local var_220_15 = var_220_14 < var_220_13 and var_220_13 or var_220_14

					var_220_5.transform.localScale = Vector3.New(var_220_15, var_220_15, 0)
				end

				for iter_220_0, iter_220_1 in pairs(arg_217_1.bgs_) do
					if iter_220_0 ~= "ST03a" then
						iter_220_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_220_16 = 0

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_17 = 5

			if var_220_16 <= arg_217_1.time_ and arg_217_1.time_ < var_220_16 + var_220_17 then
				local var_220_18 = (arg_217_1.time_ - var_220_16) / var_220_17
				local var_220_19 = Color.New(0, 0, 0)

				var_220_19.a = Mathf.Lerp(1, 0, var_220_18)
				arg_217_1.mask_.color = var_220_19
			end

			if arg_217_1.time_ >= var_220_16 + var_220_17 and arg_217_1.time_ < var_220_16 + var_220_17 + arg_220_0 then
				local var_220_20 = Color.New(0, 0, 0)
				local var_220_21 = 0

				arg_217_1.mask_.enabled = false
				var_220_20.a = var_220_21
				arg_217_1.mask_.color = var_220_20
			end

			local var_220_22 = arg_217_1.bgs_.ST03a.transform
			local var_220_23 = 0

			if var_220_23 < arg_217_1.time_ and arg_217_1.time_ <= var_220_23 + arg_220_0 then
				arg_217_1.var_.moveOldPosST03a = var_220_22.localPosition
			end

			local var_220_24 = 0.001

			if var_220_23 <= arg_217_1.time_ and arg_217_1.time_ < var_220_23 + var_220_24 then
				local var_220_25 = (arg_217_1.time_ - var_220_23) / var_220_24
				local var_220_26 = Vector3.New(0, 1, 9)

				var_220_22.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPosST03a, var_220_26, var_220_25)
			end

			if arg_217_1.time_ >= var_220_23 + var_220_24 and arg_217_1.time_ < var_220_23 + var_220_24 + arg_220_0 then
				var_220_22.localPosition = Vector3.New(0, 1, 9)
			end

			local var_220_27 = arg_217_1.bgs_.ST03a.transform
			local var_220_28 = 0.016666666666667

			if var_220_28 < arg_217_1.time_ and arg_217_1.time_ <= var_220_28 + arg_220_0 then
				arg_217_1.var_.moveOldPosST03a = var_220_27.localPosition
			end

			local var_220_29 = 6

			if var_220_28 <= arg_217_1.time_ and arg_217_1.time_ < var_220_28 + var_220_29 then
				local var_220_30 = (arg_217_1.time_ - var_220_28) / var_220_29
				local var_220_31 = Vector3.New(0, 1, 10)

				var_220_27.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPosST03a, var_220_31, var_220_30)
			end

			if arg_217_1.time_ >= var_220_28 + var_220_29 and arg_217_1.time_ < var_220_28 + var_220_29 + arg_220_0 then
				var_220_27.localPosition = Vector3.New(0, 1, 10)
			end

			local var_220_32 = 5

			if var_220_32 < arg_217_1.time_ and arg_217_1.time_ <= var_220_32 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			local var_220_33 = 1.01666666666667

			if arg_217_1.time_ >= var_220_32 + var_220_33 and arg_217_1.time_ < var_220_32 + var_220_33 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_34 = 5
			local var_220_35 = 0.95

			if var_220_34 < arg_217_1.time_ and arg_217_1.time_ <= var_220_34 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_36 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_36:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_37 = arg_217_1:GetWordFromCfg(116331050)
				local var_220_38 = arg_217_1:FormatText(var_220_37.content)

				arg_217_1.text_.text = var_220_38

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_39 = 38
				local var_220_40 = utf8.len(var_220_38)
				local var_220_41 = var_220_39 <= 0 and var_220_35 or var_220_35 * (var_220_40 / var_220_39)

				if var_220_41 > 0 and var_220_35 < var_220_41 then
					arg_217_1.talkMaxDuration = var_220_41
					var_220_34 = var_220_34 + 0.3

					if var_220_41 + var_220_34 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_41 + var_220_34
					end
				end

				arg_217_1.text_.text = var_220_38
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_42 = var_220_34 + 0.3
			local var_220_43 = math.max(var_220_35, arg_217_1.talkMaxDuration)

			if var_220_42 <= arg_217_1.time_ and arg_217_1.time_ < var_220_42 + var_220_43 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_42) / var_220_43

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_42 + var_220_43 and arg_217_1.time_ < var_220_42 + var_220_43 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST03a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6,
				className = "StoryMoveNode",
				startTime = 0.016666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play116331051 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 116331051
		arg_223_1.duration_ = 6.97

		local var_223_0 = {
			zh = 4.266,
			ja = 6.966
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
			local var_226_0 = arg_223_1.actors_["10032ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos10032ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0, -1.1, -5.9)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10032ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 then
				arg_223_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_11 = arg_223_1.actors_["10032ui_story"]
			local var_226_12 = 0

			if var_226_12 < arg_223_1.time_ and arg_223_1.time_ <= var_226_12 + arg_226_0 and not isNil(var_226_11) and arg_223_1.var_.characterEffect10032ui_story == nil then
				arg_223_1.var_.characterEffect10032ui_story = var_226_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_13 = 0.2

			if var_226_12 <= arg_223_1.time_ and arg_223_1.time_ < var_226_12 + var_226_13 and not isNil(var_226_11) then
				local var_226_14 = (arg_223_1.time_ - var_226_12) / var_226_13

				if arg_223_1.var_.characterEffect10032ui_story and not isNil(var_226_11) then
					arg_223_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_12 + var_226_13 and arg_223_1.time_ < var_226_12 + var_226_13 + arg_226_0 and not isNil(var_226_11) and arg_223_1.var_.characterEffect10032ui_story then
				arg_223_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_226_15 = 0
			local var_226_16 = 0.325

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[328].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(116331051)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 13
				local var_226_21 = utf8.len(var_226_19)
				local var_226_22 = var_226_20 <= 0 and var_226_16 or var_226_16 * (var_226_21 / var_226_20)

				if var_226_22 > 0 and var_226_16 < var_226_22 then
					arg_223_1.talkMaxDuration = var_226_22

					if var_226_22 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_22 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116331", "116331051", "story_v_out_116331.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_116331", "116331051", "story_v_out_116331.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_116331", "116331051", "story_v_out_116331.awb")

						arg_223_1:RecordAudio("116331051", var_226_24)
						arg_223_1:RecordAudio("116331051", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_116331", "116331051", "story_v_out_116331.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_116331", "116331051", "story_v_out_116331.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_25 and arg_223_1.time_ < var_226_15 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST03a"
	},
	voices = {
		"story_v_out_116331.awb"
	}
}
